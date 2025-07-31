pageextension 52071 "SalesCreditMemos" extends "Sales Credit Memos"
{
    Editable = false;

    layout
    {
        addafter("Job Queue Status")
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
