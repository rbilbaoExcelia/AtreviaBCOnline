pageextension 52061 "PurchInvoiceSubform" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
        /*
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ToolTip = 'VAT Bus. Posting Group';
                ApplicationArea = All;
            }
            */
        }
        addafter("Job No.")
        {
            field("Job Name"; Rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("Job Line Disc. Amount (LCY)")
        {
            field("Job Line Account No."; Rec."Job Line Account No.")
            {
                ToolTip = 'Job Line Account No.';
                ApplicationArea = All;
            }
        }
        //3526 MEP 2022 02 04 START
        modify("Job Total Price")
        {
            Visible = true;
        }
        modify("Job No.")
        {
            Visible = true;
        }
        modify("Job Task No.")
        {
            Visible = true;
        }
        modify("Job Line Type")
        {
            Visible = true;
        }
    }
}
