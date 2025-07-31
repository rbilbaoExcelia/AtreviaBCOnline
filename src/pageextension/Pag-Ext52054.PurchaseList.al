pageextension 52054 "PurchaseList" extends "Purchase List"
{
    Editable = false;

    layout
    {
        addafter("Vendor Authorization No.")
        {
            field("Account No."; NoCuenta)
            {
                Caption = 'No. cuenta';
                ToolTip = 'No. cuenta';
                ApplicationArea = All;
            }
        }
    }
    var NoCuenta: Code[20];
    LinCompra: Record 39;
    trigger OnAfterGetRecord()
    begin
        //
        LinCompra.Reset();
        LinCompra.SETRANGE("Document Type", Rec."Document Type");
        LinCompra.SETRANGE("Document No.", Rec."No.");
        LinCompra.SETRANGE(Type, LinCompra.Type::"G/L Account");
        NoCuenta:='';
        IF LinCompra.FIND('-')THEN NoCuenta:=LinCompra."No.";
    //
    end;
}
