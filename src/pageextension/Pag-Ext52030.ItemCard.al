pageextension 52030 "ItemCard" extends "Item Card"
{
    layout
    {
        addafter("Common Item No.")
        {
            field("Grouping Code"; Rec."Grouping Code")
            {
                ToolTip = 'Grouping Code';
                ApplicationArea = All;
            }
        }
        moveafter("Unit Price"; "Net Invoiced Qty.")
    }
}
