pageextension 52078 "SalesOrderSubform" extends "Sales Order Subform"
{
    layout
    {
        addafter("Appl.-to Item Entry")
        {
            field("Job No."; Rec."Job No.")
            {
                ToolTip = 'Job No.';
                ApplicationArea = All;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ToolTip = 'Job Task No.';
                ApplicationArea = All;
            }
        }
        addafter("Total Amount Incl. VAT")
        {
            field(RefreshTotals; RefreshMessageText)
            {
                ToolTip = 'RefreshTotals';
                ApplicationArea = All;
                DrillDown = true;
                Editable = false;
                Enabled = RefreshMessageEnabled;
                ShowCaption = false;
            }
        }
    }
    var RefreshMessageEnabled: Boolean;
    RefreshMessageText: Text;
}
