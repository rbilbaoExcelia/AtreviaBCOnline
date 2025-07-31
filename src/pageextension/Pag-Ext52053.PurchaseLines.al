pageextension 52053 "PurchaseLines" extends "Purchase Lines"
{
    Editable = false;

    layout
    {
        addafter("Job No.")
        {
            field("Job Name"; Rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
            }
        }
    }
}
