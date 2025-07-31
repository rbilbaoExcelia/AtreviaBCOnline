pageextension 52077 "SalesOrderList" extends "Sales Order List"
{
    Editable = false;

    layout
    {
        addafter("Completely Shipped")
        {
            field("Job No."; Rec."Job No.")
            {
                ToolTip = 'Job No.';
                ApplicationArea = All;
            }
            field("Job Name"; Rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
            }
        }
    }
}
