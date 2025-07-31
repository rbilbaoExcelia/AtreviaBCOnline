pageextension 52010 "CashReceiptJournal" extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Document Date")
        {
            field("Due Date"; Rec."Due Date")
            {
                ToolTip = 'Due Date';
                ApplicationArea = All;
            }
        }
    }
}
