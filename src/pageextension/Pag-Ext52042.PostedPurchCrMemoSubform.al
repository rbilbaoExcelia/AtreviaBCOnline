pageextension 52042 "PostedPurchCrMemoSubform" extends "Posted Purch. Cr. Memo Subform"
{
    Editable = false;

    layout
    {
        addafter("Job No.")
        {
            field("Job Unit Price"; Rec."Job Unit Price")
            {
                ToolTip = 'Job Unit Price';
                ApplicationArea = All;
            }
            field("Job Line Account No."; Rec."Job Line Account No.")
            {
                ToolTip = 'Job Line Account No.';
                ApplicationArea = All;
            }
        }
        moveafter("Job No."; "Job Task No.")
    }
}
