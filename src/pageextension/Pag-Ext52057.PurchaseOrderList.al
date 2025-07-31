pageextension 52057 "PurchaseOrderList" extends "Purchase Order List"
{
    Editable = false;

    layout
    {
        addafter("Vendor Authorization No.")
        {
            field("Account No."; NoCuenta)
            {
                ToolTip = 'No. Cuenta';
                Caption = 'No. Cuenta';
                ApplicationArea = All;
            }
            field("Web Description"; Rec."Web Description AT")
            {
                ToolTip = 'Web Description';
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ToolTip = 'Order Date';
                ApplicationArea = All;
                Visible = false;
            }
        }
        moveafter(Status; Amount)
        moveafter(Amount; "Amount Including VAT")
        addafter("Payment Method Code")
        {
            field("Job No."; Rec."Job No. AT")
            {
                ToolTip = 'Job No.';
                ApplicationArea = All;
            }
            field("Job Name"; Rec."Job Name AT")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
            }
            field("<Precio Venta Proyecto>"; Rec."precio venta proyecto")
            {
                ToolTip = 'No. Cuenta';
                ApplicationArea = All;
                Caption = 'Precio Venta Proyecto';
            }
        }
    }
    var //"-------------": 
 JobNo: Code[20];
    NoCuenta: Code[20];
    trigger OnAfterGetRecord()
    var
        JobLibr: Codeunit "Job Library";
        RecRef: RecordRef;
        LinCompra: Record 39;
    begin
        //056
        CLEAR(JobNo);
        RecRef.GETTABLE(Rec);
        JobNo:=JobLibr.GetJobNo(RecRef);
        //056
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
