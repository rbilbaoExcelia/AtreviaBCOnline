pageextension 52072 "SalesCrMemoSubform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        //3616 - ED
        modify("Job No.")
        {
            Editable = true;
            Visible = true;
        }
        modify("Job Task No.")
        {
            Editable = true;
            Visible = true;
        }
        //3616 - ED END
        addafter("Shortcut Dimension 2 Code")
        {
            field("Line Type"; Rec."Line Type")
            {
                ToolTip = 'Line Type';
                ApplicationArea = All;
            }
        }
    }
}
