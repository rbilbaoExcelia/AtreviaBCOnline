pageextension 52060 "PurchCrMemoSubform" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Job Line Disc. Amount (LCY)")
        {
            field("Job Line Account No."; Rec."Job Line Account No.")
            {
                ToolTip = 'Job Line Account No.';
                ApplicationArea = All;
            }
        }
        //3526 MEP 2022 02 04 START
        modify("Job No.")
        {
            Visible = true;
        }
        modify("Job Task No.")
        {
            Visible = true;
        }
        addafter("Job No.")
        {
            field("Job Name"; rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
                Visible = true;
            }
        }
        modify("Job Line Type")
        {
            Visible = true;
        }
    }
}
