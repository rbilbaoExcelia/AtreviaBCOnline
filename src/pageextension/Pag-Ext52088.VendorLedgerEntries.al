pageextension 52088 "VendorLedgerEntries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter(Open)
        {
            field("Job No."; Rec."Job No.")
            {
                ToolTip = 'Job No.';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
