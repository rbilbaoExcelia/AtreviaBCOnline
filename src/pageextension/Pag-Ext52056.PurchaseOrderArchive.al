pageextension 52056 "PurchaseOrderArchive" extends "Purchase Order Archive"
{
    Editable = false;

    layout
    {
        moveafter("Buy-from Contact No."; "Buy-from City")
        addafter(Status)
        {
            field("Web Description"; Rec."Web Description")
            {
                ToolTip = 'Web Description';
                ApplicationArea = All;
                MultiLine = true;
            }
        }
        moveafter("Pay-to Contact No."; "Pay-to City")
        moveafter("Ship-to Name"; "Ship-to City")
    }
}
