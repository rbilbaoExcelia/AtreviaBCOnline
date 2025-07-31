codeunit 52010 "Lib. Compra ATREVIA"
{
    Permissions = TableData 120=rimd,
        TableData 121=rimd,
        TableData 6660=rimd,
        TableData 6661=rimd;

    trigger OnRun()
    begin
    end;
    var SOURCECODE: Label 'PRORRATA';
    Text7078636: Label 'El campo nº contenedor del proyecto %1 no puede estar en blanco.';
    GLSetup: Record 98;
    cPostItemJnlLine: Codeunit 22;
    procedure Antes90SinNo(var Cab: Record 38)
    begin
    end;
    procedure Antes90(var Cab: Record 38)
    begin
    end;
    procedure Despues90(var Cab: Record 38)
    begin
    end;
    procedure AddIRPF(PurchHeader: Record 38)
    var
        PurchLne: Record 39;
        vAmount: Decimal;
        PurchSetup: Record 312;
        Vendor: Record 23;
        NextEntryNo: Integer;
        rIRPF: Record "IRPF Atrevia";
    begin
        //Facturación desde pedido
        /*
        IF NOT (PurchHeader."Document Type" IN
                 [PurchHeader."Document Type"::Invoice, PurchHeader."Document Type"::"Credit Memo"]) THEN
          ERROR('Solo puede ejecutarse desde facturas o abonos');
        */
        //PurchHeader.TESTFIELD( Status, PurchHeader.Status::Released);
        //<ANE.005
        Vendor.GET(PurchHeader."Pay-to Vendor No.");
        //Vendor.TESTFIELD( Vendor."IRPF Code");
        Vendor.TESTFIELD(Vendor."IRPF Codigo");
        //rIRPF.GET( Vendor."IRPF Code");
        rIRPF.GET(Vendor."IRPF Codigo");
        rIRPF.TESTFIELD(rIRPF."Account No.");
        //ANE.005>
        //Vendor.TESTFIELD( Vendor."IRPF %");
        Vendor.TESTFIELD(Vendor."IRPF Pctg");
        PurchSetup.Get();
        PurchLne.SETRANGE(PurchLne."Document Type", PurchHeader."Document Type");
        PurchLne.SETRANGE(PurchLne."Document No.", PurchHeader."No.");
        PurchLne.FIND('+');
        NextEntryNo:=PurchLne."Line No.";
        PurchLne.SETRANGE(PurchLne.Type, PurchLne.Type::"G/L Account");
        PurchLne.SETRANGE(PurchLne."No.", rIRPF."Account No.");
        IF NOT PurchLne.ISEMPTY THEN BEGIN
            PurchLne.FIND('-');
            PurchLne.DELETE(TRUE);
        END;
        PurchHeader.CALCFIELDS(Amount);
        PurchLne.Init();
        PurchLne."Document Type":=PurchHeader."Document Type";
        PurchLne."Document No.":=PurchHeader."No.";
        PurchLne."Line No.":=NextEntryNo + 10000;
        PurchLne.VALIDATE(PurchLne.Type, PurchLne.Type::"G/L Account");
        PurchLne.VALIDATE(PurchLne."No.", rIRPF."Account No.");
        //PurchLne.VALIDATE( PurchLne.Quantity, -Vendor."IRPF %" /100);
        PurchLne.VALIDATE(PurchLne.Quantity, -Vendor."IRPF Pctg" / 100);
        PurchLne.VALIDATE(PurchLne."Direct Unit Cost", PurchHeader.Amount);
        PurchLne.Insert();
    end;
}
