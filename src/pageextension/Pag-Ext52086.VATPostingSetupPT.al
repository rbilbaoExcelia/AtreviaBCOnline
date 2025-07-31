pageextension 52086 "VATPostingSetupPT" extends "VAT Posting Setup"
{
    layout
    {
        addafter("Tax Category")
        {
            // field("Exempt Legal Precept PT"; Rec."Exempt Legal Precept PT")
            // {
            //     ToolTip = 'Exempt Legal Precept';
            //     ApplicationArea = All;
            // }
            // field("SAF-T PT VAT Type Descr. PT"; Rec."SAF-T PT VAT Type Descr. PT")
            // {
            //     ToolTip = 'SAF-T PT VAT Type Description';
            //     ApplicationArea = All;
            // }
            // field("SAF-T PT VAT Code PT"; Rec."SAF-T PT VAT Code PT")
            // {
            //     ToolTip = 'SAF-T PT VAT Code';
            //     ApplicationArea = All;
            // }
            // field("SAF-T Exempt Code PT"; Rec."SAF-T Exempt Code PT")
            // {
            //     ToolTip = 'SAF-T Exempt Code';
            //     ApplicationArea = All;
            // }
            field("VAT Bus. Posting Group2"; Rec."VAT Bus. Posting Group")
            {
                ToolTip = 'VAT Bus. Posting Group2';
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT Prod. Posting Group2"; Rec."VAT Prod. Posting Group")
            {
                ToolTip = 'VAT Prod. Posting Group2';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
