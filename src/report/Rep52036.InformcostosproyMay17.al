report 52036 "Inform costos proy May17"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Permissions = TableData 169=rm,
        TableData 203=rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Job Ledger Entry";169)
        {
            DataItemTableView = SORTING("Type", "Entry Type", "Country/Region Code", "Source Code", "Posting Date")WHERE("Posting Date"=FILTER(>='01-05-17'), Type=FILTER("G/L Account"), "Unit Cost"=FILTER(<>0), "Total Cost"=FILTER(0));

            trigger OnAfterGetRecord()
            begin
            /*
                IF GLEntry.GET("Job Ledger Entry"."Ledger Entry No.") THEN BEGIN
                  JobLedgerEntry := "Job Ledger Entry";
                  JobLedgerEntry."Unit Cost":= GLEntry.Amount;
                  JobLedgerEntry."Unit Cost (LCY)":=GLEntry.Amount;
                  JobLedgerEntry.Modify();
                END;
                */
            /*
                JobLedgerEntry := "Job Ledger Entry";
                JobLedgerEntry."Total Cost":= JobLedgerEntry.Quantity*JobLedgerEntry."Unit Cost";
                JobLedgerEntry."Total Cost (LCY)":= JobLedgerEntry.Quantity*JobLedgerEntry."Unit Cost (LCY)";
                JobLedgerEntry.Modify();
                */
            end;
        }
        dataitem("Job Ledger Entry2";169)
        {
            DataItemTableView = SORTING(Type, "Entry Type", "Country/Region Code", "Source Code", "Posting Date")WHERE("Posting Date"=FILTER(>='01-01-17'), Type=FILTER(Resource), "Unit Cost"=FILTER(>90));

            trigger OnAfterGetRecord()
            begin
            /*
                JobLedgerEntry := "Job Ledger Entry2";
                IF Resource.GET("Job Ledger Entry2"."No.") THEN BEGIN
                  JobLedgerEntry."Unit Cost":=Resource."Unit Cost";
                  JobLedgerEntry."Unit Cost (LCY)":=Resource."Unit Cost";
                  JobLedgerEntry."Direct Unit Cost (LCY)":=Resource."Unit Cost";
                  JobLedgerEntry."Original Total Cost":= JobLedgerEntry.Quantity * Resource."Unit Cost";
                  JobLedgerEntry."Original Total Cost (LCY)" := JobLedgerEntry.Quantity * Resource."Unit Cost";
                  JobLedgerEntry."Total Cost":= JobLedgerEntry.Quantity * Resource."Unit Cost";
                  JobLedgerEntry."Total Cost (LCY)":= JobLedgerEntry.Quantity*Resource."Unit Cost";
                  JobLedgerEntry.Modify();
                END;
                */
            end;
        }
        dataitem("Res. Ledger Entry";203)
        {
            DataItemTableView = SORTING("Resource No.", "Posting Date")WHERE("Posting Date"=FILTER(>='01-01-17'));

            trigger OnAfterGetRecord()
            begin
                ResLedgerEntry:="Res. Ledger Entry";
                IF Resource.GET("Res. Ledger Entry"."Resource No.")THEN BEGIN
                    ResLedgerEntry."Unit Cost":=Resource."Unit Cost";
                    ResLedgerEntry."Direct Unit Cost":=Resource."Unit Cost";
                    ResLedgerEntry."Total Cost":=ResLedgerEntry.Quantity * Resource."Unit Cost";
                    ResLedgerEntry.Modify();
                END;
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
    trigger OnPostReport()
    begin
        MESSAGE('Fin');
    end;
    var GLEntry: Record 17;
    JobLedgerEntry: Record 169;
    Resource: Record 156;
    ResLedgerEntry: Record 203;
}
