pageextension 52018 "FALedgerEntries" extends "FA Ledger Entries"
{
    Editable = false;

    layout
    {
        moveafter(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        addafter("Credit Amount")
        {
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ToolTip = 'Amount (LCY)';
                ApplicationArea = All;
            }
        }
    }
}
