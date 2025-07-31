report 52032 "Ficha Vacaciones Empleados"
{
    // 149 OS.RM  07/06/2017  FIN.011   Ficha Vacaciones Empleados
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/FichaVacacionesEmpleados.rdlc';
    Caption = 'Ficha Vacaciones Empleados';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Resource;156)
        {
            DataItemTableView = WHERE(Blocked=CONST(false));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Date Filter";

            column(TXTTitol; TXTTitol)
            {
            }
            column(TXTPagina; TXTPagina)
            {
            }
            column(TXTDataAlta; TXTDataAlta)
            {
            }
            column(TXTNo; TXTNo)
            {
            }
            column(TXTNom; TXTNom)
            {
            }
            column(TXTDVacances; TXTDVacances)
            {
            }
            column(TXTDPendents; TXTDPendents)
            {
            }
            column(TXTDExtras; TXTDExtras)
            {
            }
            column(TXTDAcumulats; TXTDAcumulats)
            {
            }
            column(TXTDResta; TXTDResta)
            {
            }
            column(TXTVacances; TXTVacances)
            {
            }
            column(TXTData; TXTData)
            {
            }
            column(TXTHores; TXTHores)
            {
            }
            column(Name_Company; Companyia.Name)
            {
            }
            column(IncorporationDate_Resource; FORMAT(Resource."Incorporation Date AT"))
            {
            }
            column(No_Resource; Resource."No.")
            {
            }
            column(Name_Resource; Resource.Name)
            {
            }
            column(Holidays_Resource; Resource."Holidays AT")
            {
            }
            column(RemainingDays_Resource; Resource."Remaining Days AT")
            {
            }
            column(ExtraDays_Resource; ROUND(Resource."Extra Days AT", 0.01))
            {
            }
            column(AccumulatedDays_Resource; ROUND(Resource."Accumulated Days AT", 0.01))
            {
            }
            column(OtherDays_Resource; ROUND(Resource."Other Days AT", 0.01))
            {
            }
            dataitem("Hours consulting AT"; "Hours consulting AT")
            {
                DataItemLink = "No. consultor"=FIELD("No."), Fecha=FIELD("Date Filter");
                DataItemLinkReference = Resource;
                DataItemTableView = SORTING("No. consultor", "No. proyecto", Fecha)ORDER(Ascending)WHERE("No. proyecto"=FILTER(000000000|000000028));

                trigger OnAfterGetRecord()
                begin
                    //Vacances
                    IF "Hours consulting AT"."No. proyecto" = '000000000' THEN BEGIN
                        MemInt.Init();
                        MemInt."Cod 1":=FORMAT("Hours consulting AT".Fecha);
                        MemInt."Cod 2":=FORMAT("Hours consulting AT".Fecha);
                        IF NOT MemInt.Find()then MemInt.Insert();
                        MemInt."Value 1"+="Hours consulting AT".Horas;
                        MemInt.Modify();
                    END;
                    //Hores Extra
                    IF "Hours consulting AT"."No. proyecto" = '000000028' THEN BEGIN
                        MemIntExtra.Init();
                        MemIntExtra."Cod 1":=FORMAT("Hours consulting AT".Fecha);
                        MemIntExtra."Cod 2":=FORMAT("Hours consulting AT".Fecha);
                        IF NOT MemIntExtra.Find()then MemIntExtra.Insert();
                        MemIntExtra."Value 1"+="Hours consulting AT".Horas;
                        MemIntExtra.Modify();
                    END;
                end;
                trigger OnPreDataItem()
                begin
                    MemInt.DeleteAll();
                    MemIntExtra.DeleteAll();
                end;
            }
            dataitem(ShowVacaciones; Integer)
            {
                DataItemTableView = SORTING(Number)ORDER(Ascending);

                column(Cod1_MemInt; MemInt."Cod 2")
                {
                }
                column(Value1_MemInt; MemInt."Value 1")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN BEGIN
                        IF NOT MemInt.FindFirst()then CurrReport.Break();
                    END
                    ELSE IF MemInt.Next() = 0 THEN CurrReport.Break();
                end;
                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, MemInt.COUNT);
                end;
            }
            dataitem(ShowExtras; Integer)
            {
                DataItemTableView = SORTING(Number)ORDER(Ascending);
                MaxIteration = 1;

                column(Cod1_MemIntExtra; MemIntExtra."Cod 2")
                {
                }
                column(Value1_MemIntExtra; MemIntExtra."Value 1")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN BEGIN
                        IF NOT MemIntExtra.FindFirst()then CurrReport.Break();
                    END
                    ELSE IF MemIntExtra.Next() = 0 THEN CurrReport.Break();
                end;
                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, MemIntExtra.COUNT);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //INF
                CALCFIELDS("Extra Days AT", "Accumulated Days AT");
                "Extra Days AT":="Extra Days AT" / 8;
                "Accumulated Days AT":="Accumulated Days AT" / 8;
                "Other Days AT":="Holidays AT" + "Remaining Days AT" + "Extra Days AT" - "Accumulated Days AT";
            //INF
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
    trigger OnInitReport()
    begin
        Companyia.Get();
    end;
    var Companyia: Record 79;
    MemInt: Record MemIntFra temporary;
    MemIntExtra: Record MemIntFra temporary;
    TXTTitol: Label 'Employee Vacation Card';
    TXTPagina: Label 'Page';
    TXTDataAlta: Label 'Incorporation date:';
    TXTNo: Label 'N.';
    TXTNom: Label 'Name employee';
    TXTDVacances: Label 'Holidays';
    TXTDPendents: Label 'Pending days';
    TXTDExtras: Label 'Extra days';
    TXTDAcumulats: Label 'Accumulated Days';
    TXTDResta: Label 'Remainig days';
    TXTVacances: Label 'Holidays';
    TXTData: Label 'Date';
    TXTHores: Label 'Hours';
}
