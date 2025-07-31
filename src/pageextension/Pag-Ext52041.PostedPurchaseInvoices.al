pageextension 52041 "PostedPurchaseInvoices" extends "Posted Purchase Invoices"
{
    Editable = false;

    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ToolTip = 'VAT Registration No.';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Amount Including VAT")
        {
            field("Vendor Order No."; Rec."Vendor Order No.")
            {
                ToolTip = 'Vendor Order No.';
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
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
        moveafter("Vendor Order No."; "Order No.")
        moveafter("Job Name"; "Vendor Invoice No.")
    }
}
