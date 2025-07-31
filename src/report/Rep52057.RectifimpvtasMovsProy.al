report 52057 "Rectif.imp vtas MovsProy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/RectifimpvtasMovsProy.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("MOVS PROYECTOS"; "MOVS PROYECTOS")
        {
            DataItemTableView = SORTING("Entry Type", Type, "No.", "Posting Date")WHERE(Type=FILTER(Item), "Posting Date"=FILTER(>='01-01-17'), "Dif Vtas"=FILTER(<>0));
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord()
            begin
                "MOVS PROYECTOS".CALCFIELDS("MOVS PROYECTOS"."No.mov JobLedgEntry");
                IF JobLedgerEntry.GET("MOVS PROYECTOS"."No.mov JobLedgEntry")THEN BEGIN
                    JobLedgerEntry."Line Amount":="MOVS PROYECTOS".TotalPrice;
                    JobLedgerEntry."Total Price":="MOVS PROYECTOS".TotalPrice;
                    JobLedgerEntry."Unit Price":="MOVS PROYECTOS".TotalPrice / "MOVS PROYECTOS".Quantity;
                    JobLedgerEntry."Unit Price (LCY)":="MOVS PROYECTOS".TotalPrice / "MOVS PROYECTOS".Quantity;
                    JobLedgerEntry."Line Discount Amount":="MOVS PROYECTOS".TotalPrice - ("MOVS PROYECTOS"."Unit Price" * "MOVS PROYECTOS".Quantity);
                    JobLedgerEntry."Line Discount Amount (LCY)":="MOVS PROYECTOS".TotalPrice - ("MOVS PROYECTOS"."Unit Price" * "MOVS PROYECTOS".Quantity);
                    JobLedgerEntry.Modify();
                    i+=1;
                END;
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE(FORMAT(i));
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var JobLedgerEntry: Record 169;
    i: Integer;
}
