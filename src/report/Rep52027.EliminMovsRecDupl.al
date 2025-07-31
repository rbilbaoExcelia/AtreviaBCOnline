report 52027 "EliminMovsRecDupl"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/EliminMovsRecDupl.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = WHERE(Number=CONST(1));

            trigger OnAfterGetRecord()
            begin
                JobLedgerEntry.SETRANGE("Job No.", '000000000');
                JobLedgerEntry.SETFILTER(JobLedgerEntry."Posting Date", '>=%1', 20170101D);
                JobLedgerEntry.SETRANGE(JobLedgerEntry.Type, JobLedgerEntry.Type::Resource);
                JobLedgerEntry.SETFILTER("Entry No.", '>%1', 617845);
                IF JobLedgerEntry.FIND('-')THEN REPEAT ResLedgerEntry.SETRANGE(ResLedgerEntry."Entry No.", JobLedgerEntry."Ledger Entry No.");
                        IF ResLedgerEntry.Delete()THEN;
                        JobLedgerEntry2:=JobLedgerEntry;
                        JobLedgerEntry2.Delete();
                    UNTIL JobLedgerEntry.Next() = 0;
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
        MESSAGE('FIN');
    end;
    var JobLedgerEntry: Record 169;
    ResLedgerEntry: Record 203;
    JobLedgerEntry2: Record 169;
}
