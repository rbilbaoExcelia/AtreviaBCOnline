pageextension 52039 "PaymentJournal" extends "Payment Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("Due Date"; Rec."Due Date")
            {
                ToolTip = 'Due Date';
                ApplicationArea = All;
            }
        }
    }
}
