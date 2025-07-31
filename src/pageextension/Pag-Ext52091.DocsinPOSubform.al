pageextension 52091 "Docs. in PO Subform" extends "Docs. in PO Subform"
{
    layout
    {
        // Add changes to page layout here
        modify("Account No.")
        {
            Visible = true;
            Editable = true;
        }
        modify("Payment Method Code")
        {
            Editable = true;
        }
        modify("Document No.")
        {
            Editable = true;
        }
        modify("No.")
        {
            Editable = true;
        }
        modify("Document Type")
        {
            Editable = true;
        }
        modify("Entry No.")
        {
            Editable = true;
        }
    }
    var myInt: Integer;
}
