report 52014 "Cartera Clients"
{
    ProcessingOnly = true;
    Caption = 'Cartera Clientes';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("CARTERA CLIENTS"; "CARTERA CLIENTS")
        {
            DataItemTableView = SORTING(EntryNo);

            trigger OnAfterGetRecord()
            var
                lTxtImporte: Text[30];
            begin
                IF Cust.GET(CustomerNo)THEN "Existe Cliente":=TRUE;
                Modify();
                IF CrearDiario THEN InsertGenJnlLine;
            end;
            trigger OnPostDataItem()
            begin
                MemInt.Reset();
                IF MemInt.FindFirst()then BEGIN
                    REPEAT GenJnlLine.Init();
                        GenJnlLine."Journal Template Name":='GENERAL';
                        GenJnlLine."Journal Batch Name":='CARTERACLI';
                        GenJnlLine."Line No.":=ROUND(MemInt.Importe1, 1);
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("Account No.", MemInt."Cod 1");
                        GenJnlLine.VALIDATE("Posting Date", 20170430D); //Posar paràmetre de data al request del report
                        GenJnlLine.VALIDATE("Document No.", 'CARTERA');
                        GenJnlLine.VALIDATE(Description, 'Compensación cartera viva clientes');
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
    Cust: Record 18;
    MemInt: Record "MemIntAcumulados Inv" temporary;
    CustPostGroup: Record 92;
    local procedure InsertGenJnlLine()
    var
        Mapeo1: Record "MAPEO DIM to 2 DIMs AT";
        Mapeo2: Record "MAPEO PROY TO DIMS";
    begin
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name":='GENERAL';
        GenJnlLine."Journal Batch Name":='CARTERACLI';
        GenJnlLine."Line No.":="CARTERA CLIENTS".EntryNo;
        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
        GenJnlLine.VALIDATE("Account No.", "CARTERA CLIENTS".CustomerNo);
        GenJnlLine.VALIDATE("Posting Date", 20170430D);
        GenJnlLine.VALIDATE("Document Type", "CARTERA CLIENTS".DocType);
        GenJnlLine.VALIDATE("Document No.", "CARTERA CLIENTS".DocumentNo);
        GenJnlLine.VALIDATE(Description, "CARTERA CLIENTS".Description);
        GenJnlLine.VALIDATE(Amount, "CARTERA CLIENTS".RemAmount);
        GenJnlLine.VALIDATE("Due Date", "CARTERA CLIENTS".DueDate);
        GenJnlLine.VALIDATE("Document Date", "CARTERA CLIENTS".DocDate);
        GenJnlLine.VALIDATE("External Document No.", "CARTERA CLIENTS".ExtDocNo);
        IF "CARTERA CLIENTS".BillNo <> '' THEN BEGIN
            GenJnlLine.VALIDATE("Document Type", "CARTERA CLIENTS".DocType::Efecto);
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
        Cust.GET("CARTERA CLIENTS".CustomerNo);
        CustPostGroup.GET(Cust."Customer Posting Group");
        MemInt.Init();
        MemInt."Cod 1":=CustPostGroup."Receivables Account";
        IF NOT MemInt.Find()then MemInt.Insert();
        MemInt.Importe1+="CARTERA CLIENTS".RemAmount;
        MemInt.Modify();
    end;
}
