report 52012 "BorrarMovsProyDupl"
{
    ProcessingOnly = true;
    Caption = 'Borrar Movs ProyDupl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

            trigger OnAfterGetRecord()
            begin
                //Company.Reset();
                //IF Company.FindFirst() then REPEAT
                //    GLEntry.CHANGECOMPANY(Company.Name);
                //    i:=0; j:=0;
                //    IF GLEntry.FIND('-') THEN REPEAT
                //      j := j+1;
                //      IF GUIALLOWED THEN
                //         Window.UPDATE(1,FORMAT(j) + ' de ' + FORMAT(GLEntry.COUNT));
                //      JobLedgerEntry.SETRANGE("Job No.",GLEntry."Job No.");
                //      JobLedgerEntry.SETRANGE("Posting Date",GLEntry."Posting Date");
                //      JobLedgerEntry.SETRANGE("Document No.",GLEntry."Document No.");
                //      JobLedgerEntry.SETRANGE(JobLedgerEntry."Ledger Entry No.",GLEntry."Entry No.");
                //JobLedgerEntry.SETFILTER("Posting Date", '%1..%2',20160101D,20170430D);
                JobLedgerEntry.SETFILTER("Posting Date", '>=%1', 20170501D);
                JobLedgerEntry.SETRANGE(JobLedgerEntry."Journal Batch Name", 'MIGRACION');
                JobLedgerEntry.SETRANGE(JobLedgerEntry."Ledger Entry Type", JobLedgerEntry."Ledger Entry Type"::"G/L Account");
                JobLedgerEntry.SETFILTER(JobLedgerEntry."Ledger Entry No.", '<>0');
                JobLedgerEntry.DeleteAll();
            //    UNTIL GLEntry.NEXT=0;
            //UNTIL Company.NEXT=0;
            end;
            trigger OnPreDataItem()
            begin
                GLEntry.SETFILTER(GLEntry."Posting Date", '%1..%2', 20170101D, 20170430D);
                IF GUIALLOWED THEN Window.OPEN('#1##############################\#2##############################');
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
    ResLedgerEntry: Record 203;
    xJobLedgerEntry: Record 169;
    Company: Record Company;
    Window: Dialog;
    i: Integer;
    j: Integer;
}
