report 52044 "Mov. Conta"
{
    Permissions = TableData "MOV.CONTAB"=rimd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("MOV.CONTAB"; "MOV.CONTAB")
        {
            DataItemTableView = SORTING("Entry No.", "Transaction No.")WHERE("Posting Date"=FILTER('31-12-16..01-01-17'));

            trigger OnAfterGetRecord()
            var
                lTxtImporte: Text[30];
            begin
                //Pasamos a decimal el importe inicial de texto (TxtImporte)
                IF CLOSINGDATE("MOV.CONTAB"."Posting Date") <> CLOSINGDATE(20161231D)THEN CurrReport.Skip();
                ///XXXXXXXXXXXXXXX
                 /*
                lTxtImporte := DELCHR(TxtImporte,'=',',');
                lTxtImporte := CONVERTSTR(lTxtImporte,'.',',');
                */
                lTxtImporte:=DELCHR(TxtImporte, '=', '.');
                //lTxtImporte := CONVERTSTR(lTxtImporte,'.',',');
                EVALUATE(Amount, lTxtImporte);
                //Recuperamos los valores de dimension deparatmento
                NewDim1:='';
                NewDim2:='';
                Mapeo1.Reset();
                IF NOT Mapeo1.GET('DEPARTAMENTO', "Global Dimension 1 Code")THEN Mapeo1.Init();
                NewDim1:=Mapeo1."Dim Code 1";
                NewDim2:=Mapeo1."Dim Code 2";
                //En caso de n informarse una de las dos recuperamos de la tabla de proyectos
                IF(NewDim1 = '') OR (NewDim2 = '')THEN BEGIN
                    Mapeo2.Reset();
                    IF NOT Mapeo2.GET("Global Dimension 2 Code")THEN Mapeo2.Init();
                    IF NewDim1 = '' THEN NewDim1:=Mapeo2.Dim1;
                    IF NewDim2 = '' THEN NewDim2:=Mapeo2.dim2;
                END;
                IF NewDim1 = '' THEN NewDim1:='REVISAR';
                IF NewDim2 = '' THEN NewDim2:='REVISAR';
                IF NewDim1 <> '' THEN BEGIN
                    IF DimValue.GET('AREA GEOGRAFICA', NewDim1)THEN "MOV.CONTAB"."Existe NewDim1":=TRUE;
                END;
                IF NewDim2 <> '' THEN BEGIN
                    IF DimValue.GET('DEPARTAMENTO', NewDim2)THEN "MOV.CONTAB"."Existe NewDim2":=TRUE;
                END;
                //Creamos proyecto
                IF NOT Job.GET("MOV.CONTAB"."Job No.")THEN BEGIN
                    Job.Init();
                    Job."No.":="MOV.CONTAB"."Job No.";
                    Job.Status:=Job.Status::Open;
                    Job.Insert(); //(TRUE);
                END;
                IF Job.GET("MOV.CONTAB"."Job No.")THEN "Existe Proyecto":=TRUE;
                //IF "Global Dimension 1 Code" = '' THEN BEGIN
                //  NewDim1 := '';
                //  NewDim2 := '';
                //END;
                Modify();
                IF CrearDiario THEN InsertGenJnlLine;
            end;
            trigger OnPreDataItem()
            begin
            //"MOV.CONTAB".SETRANGE("MOV.CONTAB"."Posting Date",CLOSINGDATE(20161231D));
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
        MESSAGE('Finalizado');
    end;
    var Mapeo1: Record "MAPEO DIM to 2 DIMs AT";
    Mapeo2: Record "MAPEO PROY TO DIMS";
    CrearDiario: Boolean;
    GenJnlLine: Record 81;
    DimValue: Record 349;
    Job: Record Job;
    local procedure InsertGenJnlLine()
    begin
        IF "MOV.CONTAB".Amount = 0 THEN EXIT;
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name":='GENERAL';
        GenJnlLine."Journal Batch Name":='MIGRACION';
        GenJnlLine."Line No.":="MOV.CONTAB"."Entry No.";
        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account"); //
        GenJnlLine.VALIDATE("Account No.", "MOV.CONTAB"."G/L Account No."); //
        GenJnlLine."VAT Bus. Posting Group":='';
        GenJnlLine."VAT Prod. Posting Group":='';
        GenJnlLine.VALIDATE("Posting Date", "MOV.CONTAB"."Posting Date");
        GenJnlLine."Document Type":="MOV.CONTAB"."Document Type"; //
        GenJnlLine."Document No.":="MOV.CONTAB"."Document No."; //
        GenJnlLine.Description:="MOV.CONTAB".Description; //
        GenJnlLine.VALIDATE(Amount, "MOV.CONTAB".Amount);
        IF "MOV.CONTAB"."Job No." <> '' THEN BEGIN
            GenJnlLine.VALIDATE("Job No.", "MOV.CONTAB"."Job No.");
            GenJnlLine.VALIDATE("Job Task No.", "MOV.CONTAB"."Job No.");
            GenJnlLine."Job Quantity":=1;
        END
        ELSE
        BEGIN
            GenJnlLine.VALIDATE("Job No.", "MOV.CONTAB"."Global Dimension 2 Code"); //290317
            GenJnlLine.VALIDATE("Job Task No.", "MOV.CONTAB"."Global Dimension 2 Code");
            GenJnlLine."Job Quantity":=1;
        END;
        GenJnlLine."Job Quantity":=1;
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "MOV.CONTAB".NewDim1);
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "MOV.CONTAB".NewDim2);
        GenJnlLine.Description:="MOV.CONTAB".Description; //300317
        //NOU300417
        GenJnlLine.VALIDATE("VAT Bus. Posting Group", '');
        GenJnlLine.VALIDATE("VAT Prod. Posting Group", '');
        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type", GenJnlLine."Gen. Posting Type"::" ");
        //NOU300417
        GenJnlLine.Insert(); //
    end;
}
