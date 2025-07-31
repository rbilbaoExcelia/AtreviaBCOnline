pageextension 52069 "SalesCommentSheet" extends "Sales Comment Sheet"
{
    layout
    {
        addafter("Code")
        {
            field("Print On Invoices"; Rec."Print On Invoices")
            {
                ToolTip = 'Print On Invoices';
                ApplicationArea = All;
            }
        }
    }
}
