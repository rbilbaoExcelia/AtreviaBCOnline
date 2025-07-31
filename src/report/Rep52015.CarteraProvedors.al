report 52015 "Cartera Proveïdors"
{
    ProcessingOnly = true;
    Caption = 'Cartera Proveïdors';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("CARTERA CLIENTS"; "CARTERA PROV.")
        {
            DataItemTableView = SORTING(EntryNo);

            trigger OnAfterGetRecord()
            var
                lTxtImporte: Text[30];
            begin
                IF CrearDiario THEN InsertGenJnlLine;
            end;
            trigger OnPostDataItem()
            begin
                MemInt.Reset();
                IF MemInt.FindFirst()then BEGIN
                    REPEAT GenJnlLine.Init();
                        GenJnlLine."Journal Template Name":='GENERAL';
                        GenJnlLine."Journal Batch Name":='CARTERAPRO';
                        GenJnlLine."Line No.":=ROUND(MemInt.Importe1, 1);
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", MemInt."Cod 1");
                        GenJnlLine.VALIDATE("Posting Date", 20170330D); //Posar paràmetre de data al request del report
                        GenJnlLine.VALIDATE("Document No.", 'CARTERA');
                        GenJnlLine.VALIDATE(Description, 'Compensación cartera viva proveedores');
                        GenJnlLine.VALIDATE(Amount, -MemInt.Importe1);
                        GenJnlLine.INSERT(TRUE);
                    UNTIL MemInt.Next() = 0;
                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Crear diario"; CrearDiario)
                {
                    ToolTip = 'Crear diario';
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        MESSAGE('Fin');
    end;
    var CrearDiario: Boolean;
    GenJnlLine: Record 81;
    Cust: Record 23;
    MemInt: Record "MemIntAcumulados Inv" temporary;
    CustPostGroup: Record 93;
    local procedure InsertGenJnlLine()
    var
        Mapeo1: Record "MAPEO DIM to 2 DIMs AT";
        Mapeo2: Record "MAPEO PROY TO DIMS";
    begin
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name":='GENERAL';
        GenJnlLine."Journal Batch Name":='CARTERAPRO';
        GenJnlLine."Line No.":="CARTERA CLIENTS".EntryNo;
        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
        GenJnlLine.VALIDATE("Account No.", "CARTERA CLIENTS".VendorNo);
        GenJnlLine.VALIDATE("Posting Date", 20170430D); //Posar paràmetre de data al request del report
        //GenJnlLine.VALIDATE("Document Type", "CARTERA CLIENTS".DocType);
        GenJnlLine.VALIDATE("Document No.", "CARTERA CLIENTS".DocumentNo);
        GenJnlLine.VALIDATE(Description, "CARTERA CLIENTS".Description);
        IF "CARTERA CLIENTS".RemAmount < 0 THEN BEGIN
            GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
            GenJnlLine."Payment Method Code":='TRANSFER';
        END;
        GenJnlLine.VALIDATE(Amount, "CARTERA CLIENTS".RemAmount);
        GenJnlLine.VALIDATE("Due Date", "CARTERA CLIENTS".DueDate);
        GenJnlLine.VALIDATE("Document Date", "CARTERA CLIENTS".Docdate);
        GenJnlLine.VALIDATE("External Document No.", "CARTERA CLIENTS".ExtDocNo);
        IF "CARTERA CLIENTS".BillNo <> '' THEN BEGIN
            GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Bill);
            GenJnlLine.VALIDATE("Bill No.", "CARTERA CLIENTS".BillNo);
        END;
        //////////////////////////////////////////////
        //Recuperamos los valores de dimension departamento
        Mapeo1.Reset();
        IF NOT Mapeo1.GET('DEPARTAMENTO', "CARTERA CLIENTS"."Old Dimension1")THEN Mapeo1.Init();
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", Mapeo1."Dim Code 1");
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", Mapeo1."Dim Code 2");
        //En caso de n informarse una de las dos recuperamos de la tabla de proyectos
        IF(GenJnlLine."Shortcut Dimension 1 Code" = '') OR (GenJnlLine."Shortcut Dimension 2 Code" = '')THEN BEGIN
            Mapeo2.Reset();
            IF NOT Mapeo2.GET("CARTERA CLIENTS"."Old Dimension2")THEN Mapeo2.Init();
            IF GenJnlLine."Shortcut Dimension 1 Code" = '' THEN GenJnlLine."Shortcut Dimension 1 Code":=Mapeo2.Dim1;
            IF GenJnlLine."Shortcut Dimension 2 Code" = '' THEN GenJnlLine."Shortcut Dimension 2 Code":=Mapeo2.dim2;
        END;
        ////////////////////////////////////////////////////////////
        GenJnlLine.INSERT(TRUE);
        Cust.GET("CARTERA CLIENTS".VendorNo);
        CustPostGroup.GET(Cust."Vendor Posting Group");
        MemInt.Init();
        MemInt."Cod 1":=CustPostGroup."Payables Account";
        IF NOT MemInt.Find()then MemInt.Insert();
        MemInt.Importe1+="CARTERA CLIENTS".RemAmount;
        MemInt.Modify();
    end;
}
