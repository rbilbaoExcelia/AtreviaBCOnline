pageextension 52052 "PurchaseInvoices" extends "Purchase Invoices"
{
    Editable = false;

    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Account No."; NoCuenta)
            {
                ToolTip = 'No. Cuenta';
                ApplicationArea = All;
                Caption = 'No. Cuenta';
            }
        }
        moveafter("Ship-to Contact"; Amount)
        //moveafter(Amount; "Amount Including VAT")
        addafter("Requested Receipt Date")
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
        }
    }
    var //"-------------":
 JobNo: Code[20];
    NoCuenta: Code[20];
    trigger OnAfterGetRecord()
    var
        JobLibr: Codeunit "Job Library";
        RecRef: RecordRef;
        "--------": Integer;
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
