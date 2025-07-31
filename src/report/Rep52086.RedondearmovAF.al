report 52086 "Redondear mov AF"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "FA Ledger Entry"=rimd;

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            DataItemTableView = sorting("entry No.")where("FA Posting Type"=const(Depreciation));
            RequestFilterFields = "Entry No.", "Document No.";

            trigger OnAfterGetRecord()
            begin
                Amount:=ROUND(Amount);
                "Credit Amount":=Round("Credit Amount");
                "Debit Amount":=Round("Debit Amount");
                Modify();
            end;
        }
    }
}
