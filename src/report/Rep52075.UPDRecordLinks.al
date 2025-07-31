report 52075 "UPD Record Links"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/UPDRecordLinks.rdlc';
    Permissions = TableData 5601=rm;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Record Link"; "Record Link")
        {
            DataItemTableView = SORTING("Link ID")WHERE("Link ID"=FILTER(>=6));

            trigger OnAfterGetRecord()
            begin
            /*
                IF COPYSTR("Record Link"."Old Record Id",1,3)='Cus' THEN BEGIN
                  No := COPYSTR("Record Link"."Old Record Id",10,STRLEN("Record Link"."Old Record Id"));
                  Cust.GET(No);
                  RecRef.GETTABLE(Cust);
                END ELSE IF COPYSTR("Record Link"."Old Record Id",1,3)='Ven' THEN BEGIN
                  No := COPYSTR("Record Link"."Old Record Id",8,STRLEN("Record Link"."Old Record Id"));
                  Vend.GET(No);
                  RecRef.GETTABLE(Vend);
                
                END;
                
                RecordLink.Init();
                RecordLink.GET("Record Link"."Link ID");
                RecordLink."Record ID" := RecRef.RECORDID;
                RecordLink.Modify();
                */
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.Break();
            end;
        }
        dataitem("FA Ledger Entry";5601)
        {
            DataItemTableView = SORTING("FA No.", "Depreciation Book Code", "FA Posting Date")WHERE("FA No."=FILTER(>='AF1300047'));

            trigger OnAfterGetRecord()
            var
                FALedgerEntry: Record 5601;
            begin
                FALedgerEntry:="FA Ledger Entry";
                FALedgerEntry.Amount:="FA Ledger Entry"."Amount (LCY)";
                FALedgerEntry."Debit Amount":="FA Ledger Entry"."Amount (LCY)";
                FALedgerEntry.Modify();
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
    var Cust: Record 18;
    Vend: Record 23;
    No: Code[20];
    RecRef: RecordRef;
    RecordLink: Record "Record Link";
}
