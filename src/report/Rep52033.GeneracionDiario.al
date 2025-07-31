report 52033 "Generacion Diario."
{
    // EX-RBF 240720 - Añadidas validaciones, eliminado filtro factura y añadido tipo pago.
    //        180820 - Añadido filtro para sólo tomar registros con importe pendiente.
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Inv. Header";122)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE("Facturas de Gastos"=FILTER(true));
            RequestFilterFields = "No.", "Posting Date";

            trigger OnAfterGetRecord()
            var
                locrec_purchinvline: Record 123;
            begin
                locrec_purchinvline.GET("No.", 10000);
                "Purch. Inv. Header".CALCFIELDS("Amount Including VAT");
                //Linea Proveedor
                numlinea+=10000;
                locrec_genjnlline.Init();
                locrec_genjnlline.VALIDATE("Journal Template Name", rec_configcontabilidad."Libro generacion diario");
                locrec_genjnlline.VALIDATE("Journal Batch Name", rec_configcontabilidad."Seccion generacion diario");
                locrec_genjnlline.VALIDATE("Line No.", numlinea);
                locrec_genjnlline.Insert();
                locrec_genjnlline.VALIDATE("Posting Date", "Posting Date");
                locrec_genjnlline."Document Type":=locrec_genjnlline."Document Type"::Payment;
                locrec_genjnlline.VALIDATE("Document No.", "No.");
                locrec_genjnlline."Account Type":=locrec_genjnlline."Account Type"::Vendor;
                locrec_genjnlline.VALIDATE("Account No.", "Purch. Inv. Header"."Pay-to Vendor No.");
                locrec_genjnlline.VALIDATE("Debit Amount", "Amount Including VAT");
                //locrec_genjnlline.VALIDATE("Job No.",locrec_purchinvline."Job No.");
                //locrec_genjnlline.VALIDATE("Job Task No.",locrec_genjnlline."Job Task No.");
                //VendLedgEntry.SETRANGE("Document Type",VendLedgEntry."Document Type"::Invoice);//EX-RBF 240720-Comentado
                VendLedgEntry.SETRANGE("Document No.", "No.");
                VendLedgEntry.SETFILTER("Remaining Amount", '<>%1', 0); //EX-RBF 180820
                IF VendLedgEntry.FindFirst()then BEGIN
                    //cod_vendorentryedit.RUN(locrec_vendorledgerentry);
                    //locrec_genjnlline.VALIDATE("Applies-to Doc. No.","No.");
                    //locrec_genjnlline."Applies-to Doc. Type"
                    //locrec_genjnlline."Applies-to Bill No."
                    IF VendLedgEntry."Document Situation" = VendLedgEntry."Document Situation"::"Posted BG/PO" THEN ERROR(Text1100100, VendLedgEntry.Description);
                    SetAmountWithVendLedgEntry;
                    locrec_genjnlline.VALIDATE("Applies-to Doc. Type", VendLedgEntry."Document Type"); //EX-RBF 240720
                    locrec_genjnlline.VALIDATE("Applies-to Doc. No.", VendLedgEntry."Document No."); //EX-RBF 240720
                    locrec_genjnlline.VALIDATE("Applies-to Bill No.", VendLedgEntry."Bill No."); //EX-RBF 240720
                    locrec_genjnlline."Applies-to ID":='';
                END;
                locrec_genjnlline.Modify();
                //Linea Cuenta
                numlinea+=10000;
                locrec_genjnlline.Init();
                locrec_genjnlline.VALIDATE("Journal Template Name", rec_configcontabilidad."Libro generacion diario");
                locrec_genjnlline.VALIDATE("Journal Batch Name", rec_configcontabilidad."Seccion generacion diario");
                locrec_genjnlline.VALIDATE("Line No.", numlinea);
                locrec_genjnlline.Insert();
                locrec_genjnlline.VALIDATE("Posting Date", "Posting Date");
                locrec_genjnlline."Document Type":=locrec_genjnlline."Document Type"::Payment; //EX-RBF 240720
                locrec_genjnlline.VALIDATE("Document No.", "No.");
                locrec_genjnlline."Account Type":=locrec_genjnlline."Account Type"::"G/L Account";
                locrec_genjnlline.VALIDATE("Account No.", locrec_purchinvline."No.");
                locrec_genjnlline.VALIDATE("Credit Amount", "Amount Including VAT");
                locrec_genjnlline.VALIDATE("Job No.", locrec_purchinvline."Job No.");
                locrec_genjnlline.VALIDATE("Job Task No.", locrec_purchinvline."Job Task No.");
                locrec_genjnlline.Modify();
            end;
            trigger OnPreDataItem()
            var
                locrec_genjnlline: Record 81;
            begin
                rec_configcontabilidad.Get();
                locrec_genjnlline.SETRANGE("Journal Template Name", rec_configcontabilidad."Libro generacion diario");
                locrec_genjnlline.SETRANGE("Journal Batch Name", rec_configcontabilidad."Seccion generacion diario");
                IF locrec_genjnlline.FindLast()then numlinea:=locrec_genjnlline."Line No."
                ELSE
                    numlinea:=0;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var rec_configcontabilidad: Record 98;
    locrec_genjnlline: Record 81;
    numlinea: Integer;
    cod_vendorentryedit: Codeunit 113;
    Text1100100: Label '% cannot be applied, since it is included in a payment order.';
    VendLedgEntry: Record 25;
    PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
    local procedure SetAmountWithVendLedgEntry()
    begin
        IF locrec_genjnlline."Currency Code" <> VendLedgEntry."Currency Code" THEN locrec_genjnlline.CheckModifyCurrencyCode(locrec_genjnlline."Account Type"::Vendor, VendLedgEntry."Currency Code");
        IF locrec_genjnlline.Amount = 0 THEN BEGIN
            VendLedgEntry.CALCFIELDS("Remaining Amount");
            SetAmountWithRemaining(PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(locrec_genjnlline, VendLedgEntry, 0, FALSE), VendLedgEntry."Amount to Apply", VendLedgEntry."Remaining Amount", VendLedgEntry."Remaining Pmt. Disc. Possible");
        END;
    end;
    local procedure SetAmountWithRemaining(CalcPmtDisc: Boolean; AmountToApply: Decimal; RemainingAmount: Decimal; RemainingPmtDiscPossible: Decimal)
    begin
        IF AmountToApply <> 0 THEN IF CalcPmtDisc AND (ABS(AmountToApply) >= ABS(RemainingAmount - RemainingPmtDiscPossible))THEN locrec_genjnlline.Amount:=-(RemainingAmount - RemainingPmtDiscPossible)
            ELSE
                locrec_genjnlline.Amount:=-AmountToApply
        ELSE IF CalcPmtDisc THEN locrec_genjnlline.Amount:=-(RemainingAmount - RemainingPmtDiscPossible)
            ELSE
                locrec_genjnlline.Amount:=-RemainingAmount;
        IF locrec_genjnlline."Bal. Account Type" IN[locrec_genjnlline."Bal. Account Type"::Customer, locrec_genjnlline."Bal. Account Type"::Vendor]THEN locrec_genjnlline.Amount:=-locrec_genjnlline.Amount;
        locrec_genjnlline.VALIDATE(Amount);
    end;
}
