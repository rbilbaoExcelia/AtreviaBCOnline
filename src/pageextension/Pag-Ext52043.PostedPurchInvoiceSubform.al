pageextension 52043 "PostedPurchInvoiceSubform" extends "Posted Purch. Invoice Subform"
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
        }
        addafter("Appl.-to Item Entry")
        {
        /*
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ToolTip = 'VAT Bus. Posting Group';
                ApplicationArea = All;
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ToolTip = 'VAT Prod. Posting Group';
                ApplicationArea = All;
            }
            */
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Job Line Account No."; Rec."Job Line Account No.")
            {
                ToolTip = 'Job Line Account No.';
                ApplicationArea = All;
            }
        /*
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ToolTip = 'Gen. Prod. Posting Group';
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ToolTip = 'Gen. Bus. Posting Group';
                ApplicationArea = All;
            }
            */
        }
    }
}
