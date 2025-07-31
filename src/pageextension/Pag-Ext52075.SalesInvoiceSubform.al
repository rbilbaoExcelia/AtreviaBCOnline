pageextension 52075 "SalesInvoiceSubform" extends "Sales Invoice Subform"
{
    layout
    {
        //3616 - ED
        modify("Job No.")
        {
            Editable = true;
        }
        modify("Job Task No.")
        {
            Editable = true;
        }
        //3616 - ED END
        addafter("VAT Prod. Posting Group")
        {
            /*
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ToolTip = 'VAT Bus. Posting Group';
                ApplicationArea = All;
            }
            */
            field("Gen. Prod. Posting Group AT"; Rec."Gen. Prod. Posting Group")
            {
                ToolTip = 'Gen. Prod. Posting Group';
                ApplicationArea = All;
            }
        }
        addafter("Job Task No.")
        {
            field("Job Assistant"; Rec."Job Assistant")
            {
                ToolTip = 'Job Assistant';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                //029
                end;
            }
        }
        addafter("Line No.")
        {
            field("Line Type"; Rec."Line Type")
            {
                ToolTip = 'Line Type';
                ApplicationArea = All;
            }
            field("Cust Order Purch No."; Rec."Cust Order Purch No.")
            {
                ToolTip = 'Cust Order Purch No.';
                ApplicationArea = All;
            }
        }
    }
}
