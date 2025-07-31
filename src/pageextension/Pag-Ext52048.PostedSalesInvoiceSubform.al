pageextension 52048 "PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform"
{
    Editable = true;

    layout
    {
        addafter(Description)
        {
            field("Job Assistant"; Rec."Job Assistant")
            {
                ToolTip = 'Job Assistant';
                ApplicationArea = All;
                Editable = false;
            }
        }
        moveafter("Unit Price"; "Line Amount")
    }
}
