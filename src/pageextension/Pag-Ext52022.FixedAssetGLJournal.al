pageextension 52022 "FixedAssetGLJournal" extends "Fixed Asset G/L Journal"
{
    layout
    {
        addafter("Document No.")
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
    }
}
