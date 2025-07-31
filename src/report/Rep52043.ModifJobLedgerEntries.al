report 52043 "Modif JobLedgerEntries"
{
    Permissions = TableData 169=rm,
        TableData 203=rm;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Resource;156)
        {
            DataItemTableView = SORTING("No.")WHERE("Direct Unit Cost"=FILTER(>60));

            trigger OnAfterGetRecord()
            var
                Resources: Record 156;
            begin
                Resources:=Resource;
                Resources."Direct Unit Cost":=Resources."Direct Unit Cost" / 100;
                Resources."Holidays AT":=Resources."Holidays AT" / 100;
                Resources."Remaining Days AT":=Resources."Remaining Days AT" / 100;
                Resources."Accumulated Days AT":=Resources."Accumulated Days AT" / 100;
                Resources."Extra Days AT":=Resources."Extra Days AT" / 100;
                Resources."Unit Cost":=Resources."Unit Cost" / 100;
                Resources.Modify();
            end;
        }
        dataitem("Job Ledger Entry";169)
        {
            DataItemTableView = SORTING("Entry Type", Type, "No.", "Posting Date")WHERE(Type=FILTER(Resource), "Unit Cost (LCY)"=FILTER(>60));

            trigger OnAfterGetRecord()
            var
                JobLedgerEntry: Record 169;
            begin
                JobLedgerEntry:="Job Ledger Entry";
                JobLedgerEntry."Unit Cost":=JobLedgerEntry."Unit Cost" / 100;
                JobLedgerEntry."Unit Cost (LCY)":=JobLedgerEntry."Unit Cost (LCY)" / 100;
                JobLedgerEntry."Original Unit Cost":=JobLedgerEntry."Original Unit Cost" / 100;
                JobLedgerEntry."Original Unit Cost (LCY)":=JobLedgerEntry."Original Unit Cost (LCY)" / 100;
                JobLedgerEntry."Total Cost":=JobLedgerEntry."Total Cost" / 100;
                JobLedgerEntry."Total Cost (LCY)":=JobLedgerEntry."Total Cost (LCY)" / 100;
                JobLedgerEntry."Original Total Cost":=JobLedgerEntry."Original Total Cost" / 100;
                JobLedgerEntry."Original Total Cost (LCY)":=JobLedgerEntry."Original Total Cost (LCY)" / 100;
                JobLedgerEntry.Modify();
            end;
        }
        dataitem("Res. Ledger Entry";203)
        {
            DataItemTableView = WHERE("Unit Cost"=FILTER(>60));

            trigger OnAfterGetRecord()
            var
                ResLedgerEntry: Record 203;
            begin
                ResLedgerEntry:="Res. Ledger Entry";
                ResLedgerEntry."Unit Cost":=ResLedgerEntry."Unit Cost" / 100;
                ResLedgerEntry."Total Cost":=ResLedgerEntry."Total Cost" / 100;
                ResLedgerEntry."Direct Unit Cost":=ResLedgerEntry."Direct Unit Cost" / 100;
                ResLedgerEntry.Modify();
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
        MESSAGE('fin');
    end;
}
