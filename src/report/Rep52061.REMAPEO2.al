report 52061 "REMAPEO 2"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry";17)
        {
            DataItemTableView = SORTING("Entry No.")WHERE("Job No."=FILTER(<>''));
            RequestFilterFields = "Posting Date", "Entry No.";

            dataitem("Cust. Ledger Entry";21)
            {
                DataItemLink = "Entry No."=FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    CurrReport.Skip(); ///////////////////////////
                    IF GUIALLOWED THEN Window.UPDATE(4, "Entry No.");
                    /*
                    //DimMgt.UpdateGlobalDimFromDimSetID(CurrentDimSetID,"Global Dimension 1 Code","Global Dimension 2 Code");
                    "Global Dimension 1 Code" := Dim1Value;
                    "Global Dimension 2 Code" := Dim2Value;
                    "Dimension Set ID" := CurrentDimSetID;
                    Modify();
                    */
                    //FASE 2-----------------------
                    "Global Dimension 1 Code":="G/L Entry"."Global Dimension 1 Code";
                    "Global Dimension 2 Code":="G/L Entry"."Global Dimension 2 Code";
                    CurrentDimSetID:="G/L Entry"."Dimension Set ID";
                    Modify();
                //FI FASE2 --------------------
                end;
                trigger OnPostDataItem()
                begin
                    IF GUIALLOWED THEN Window.UPDATE(4, '');
                end;
                trigger OnPreDataItem()
                begin
                    CurrReport.Skip(); ///////////////////////////
                    IF GUIALLOWED THEN Window.UPDATE(3, "Cust. Ledger Entry".TABLECAPTION);
                    SETRANGE("Global Dimension 1 Code", 'REVISAR');
                end;
            }
            dataitem("Vendor Ledger Entry";25)
            {
                DataItemLink = "Entry No."=FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord()
                begin
                    CurrReport.Skip(); ///////////////////////////
                    IF GUIALLOWED THEN Window.UPDATE(4, "Entry No.");
                    /*
                    //DimMgt.UpdateGlobalDimFromDimSetID(CurrentDimSetID,"Global Dimension 1 Code","Global Dimension 2 Code");
                    "Global Dimension 1 Code" := Dim1Value;
                    "Global Dimension 2 Code" := Dim2Value;
                    "Dimension Set ID" := CurrentDimSetID;
                    Modify();
                    */
                    //FASE 2-----------------------
                    "Global Dimension 1 Code":="G/L Entry"."Global Dimension 1 Code";
                    "Global Dimension 2 Code":="G/L Entry"."Global Dimension 2 Code";
                    CurrentDimSetID:="G/L Entry"."Dimension Set ID";
                    Modify();
                //FI FASE2 --------------------
                end;
                trigger OnPostDataItem()
                begin
                    IF GUIALLOWED THEN Window.UPDATE(4, '');
                end;
                trigger OnPreDataItem()
                begin
                    CurrReport.Skip(); ///////////////////////////
                    IF GUIALLOWED THEN Window.UPDATE(3, "Vendor Ledger Entry".TABLECAPTION);
                    SETRANGE("Global Dimension 1 Code", 'REVISAR');
                end;
            }
            trigger OnAfterGetRecord()
            begin
                IF GUIALLOWED THEN Window.UPDATE(2, FORMAT("Entry No.") + ' ' + "Job No.");
                // CLEAR(Dim1Value);
                // CLEAR(Dim2Value);
                // CLEAR(Dim3Value);
                //
                //Crear valor dimensió projecte si no existeix
                IF "Job No." <> '' THEN BEGIN
                    IF NOT DimValue.GET('PROYECTO', "Job No.")THEN BEGIN
                        DimValue.Init();
                        DimValue.VALIDATE("Dimension Code", 'PROYECTO');
                        DimValue.Code:="Job No.";
                        DimValue.INSERT(TRUE);
                        Dim3Value:="Job No.";
                    END
                    ELSE
                        Dim3Value:="Job No.";
                END;
                // MovContab.SETRANGE("G/L Account No.","G/L Entry"."G/L Account No.");
                // MovContab.SETRANGE("Posting Date","G/L Entry"."Posting Date");
                // MovContab.SETRANGE("Document No.","G/L Entry"."Document No.");
                // MovContab.SETRANGE(Amount, "G/L Entry".Amount);
                // MovContab.SETRANGE(MovContab."Global Dimension 2 Code", "G/L Entry"."Job No.");
                // MovContab.SETRANGE(Description, "G/L Entry".Description);
                // MovContab.SETRANGE(MovContab."Usado mapeo",FALSE);
                // IF MovContab.FIND('-') THEN BEGIN
                //
                //     //IF MapeoDim.GET('DEPARTAMENTO',"Old Dimension Value") THEN BEGIN
                //     IF MapeoDim.GET('DEPARTAMENTO',MovContab."Global Dimension 1 Code") THEN BEGIN
                //       Dim1Value := MapeoDim."Dim Code 1";
                //       Dim2Value := MapeoDim."Dim Code 2";
                //     END;
                //     xMovContab := MovContab;
                //     xMovContab."Usado mapeo":= TRUE;
                //     xMovContab.Modify();
                // END;
                //
                //
                // IF Dim1Value = '' THEN
                //   Dim1Value := 'REVISAR';
                //
                // IF Dim2Value = '' THEN
                //   Dim2Value := 'REVISAR';
                //Calcular dim set ID a partir de temporal
                CLEAR(TempDimSetEntry);
                IF "G/L Entry"."Global Dimension 1 Code" <> '' THEN BEGIN
                    TempDimSetEntry.Reset(); //Dim 1
                    TempDimSetEntry.SETRANGE("Dimension Code", 'AREA GEOGRAFICA');
                    IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                        //TempDimSetEntry.VALIDATE("Dimension Value Code",Dim1Value);
                        TempDimSetEntry.VALIDATE("Dimension Value Code", "G/L Entry"."Global Dimension 1 Code");
                        TempDimSetEntry.Modify();
                    END
                    ELSE
                    BEGIN
                        TempDimSetEntry.Init();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'AREA GEOGRAFICA');
                        //TempDimSetEntry.VALIDATE("Dimension Value Code",Dim1Value);
                        TempDimSetEntry.VALIDATE("Dimension Value Code", "G/L Entry"."Global Dimension 1 Code");
                        TempDimSetEntry.Insert();
                    END;
                END;
                IF "G/L Entry"."Global Dimension 2 Code" <> '' THEN BEGIN
                    TempDimSetEntry.Reset(); //Dim 2
                    TempDimSetEntry.SETRANGE("Dimension Code", 'DEPARTAMENTO');
                    IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                        //TempDimSetEntry.VALIDATE("Dimension Value Code",Dim2Value);
                        TempDimSetEntry.VALIDATE("Dimension Value Code", "G/L Entry"."Global Dimension 2 Code");
                        TempDimSetEntry.Modify();
                    END
                    ELSE
                    BEGIN
                        TempDimSetEntry.Init();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'DEPARTAMENTO');
                        //TempDimSetEntry.VALIDATE("Dimension Value Code",Dim2Value);
                        TempDimSetEntry.VALIDATE("Dimension Value Code", "G/L Entry"."Global Dimension 2 Code");
                        TempDimSetEntry.Insert();
                    END;
                END;
                IF Dim3Value <> '' THEN BEGIN
                    TempDimSetEntry.Reset(); //Dim 3
                    TempDimSetEntry.SETRANGE("Dimension Code", 'PROYECTO');
                    IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Dim3Value);
                        TempDimSetEntry.Modify();
                    END
                    ELSE
                    BEGIN
                        TempDimSetEntry.Init();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'PROYECTO');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Dim3Value);
                        TempDimSetEntry.Insert();
                    END;
                END;
                CLEAR(DimMgt);
                CurrentDimSetID:=DimMgt.GetDimensionSetID(TempDimSetEntry);
                "Dimension Set ID":=CurrentDimSetID;
                //"Global Dimension 1 Code" := Dim1Value;
                //"Global Dimension 2 Code" := Dim2Value;
                //IF (Dim1Value<>'REVISAR') AND (Dim2Value<>'REVISAR') THEN
                IF Dim3Value <> '' THEN MODIFY;
            end;
            trigger OnPreDataItem()
            begin
                CurrentDimSetID:=0;
                IF GUIALLOWED THEN Window.UPDATE(1, "G/L Entry".TABLECAPTION);
            //SETRANGE("Global Dimension 1 Code",'REVISAR');
            // IF MovContab.FIND('-') THEN REPEAT
            //     xMovContab := MovContab;
            //     xMovContab."Usado mapeo":= FALSE;
            //     xMovContab.Modify();
            // UNTIL MovContab.Next() = 0;
            // COMMIT;
            end;
        }
        dataitem(Job;167)
        {
            DataItemTableView = SORTING("No.")WHERE("No."=FILTER(<>''));
            RequestFilterFields = "Starting Date", "Posting Date Filter";

            trigger OnAfterGetRecord()
            var
                DefaultDim: Record 352;
            begin
                CurrReport.Skip(); ///////////////////////////
                IF GUIALLOWED THEN Window.UPDATE(2, "No.");
                CurrentDimSetID:=0;
                CLEAR(Dim1Value);
                CLEAR(Dim2Value);
                CLEAR(Dim3Value);
                //Crear valor dimensió projecte si no existeix
                IF NOT DimValue.GET('PROYECTO', Job."No.")THEN BEGIN
                    DimValue.Init();
                    DimValue.VALIDATE("Dimension Code", 'PROYECTO');
                    DimValue.Code:="No.";
                    DimValue.INSERT(TRUE);
                END;
                Dim3Value:="No.";
                /*
                IF MapeoDim.GET('DEPARTAMENTO', Job."Old Dimension 1") THEN BEGIN
                      Dim1Value := MapeoDim."Dim Code 1";
                      Dim2Value := MapeoDim."Dim Code 2";
                END;
                
                IF Dim1Value = '' THEN
                  Dim1Value := 'REVISAR';
                
                IF Dim2Value = '' THEN
                  Dim2Value := 'REVISAR';
                
                "Global Dimension 1 Code" := Dim1Value;
                "Global Dimension 2 Code" := Dim2Value;
                Modify();
                
                //
                IF Dim1Value <> '' THEN BEGIN
                  IF NOT DefaultDim.GET(167,Job."No.",'AREA GEOGRAFICA') THEN BEGIN
                    DefaultDim.Init();
                    DefaultDim.VALIDATE("Table ID",167);
                    DefaultDim.VALIDATE("No.",Job."No.");
                    DefaultDim.VALIDATE("Dimension Code",'AREA GEOGRAFICA');
                    DefaultDim.VALIDATE("Dimension Value Code",Dim1Value);
                    DefaultDim.Insert();
                  END ELSE BEGIN
                    DefaultDim.VALIDATE("Dimension Value Code",Dim1Value);
                    DefaultDim.Modify();
                  END;
                END;
                IF Dim2Value <> '' THEN BEGIN
                  IF NOT DefaultDim.GET(167,Job."No.",'DEPARTAMENTO') THEN BEGIN
                    DefaultDim.Init();
                    DefaultDim.VALIDATE("Table ID",167);
                    DefaultDim.VALIDATE("No.",Job."No.");
                    DefaultDim.VALIDATE("Dimension Code",'DEPARTAMENTO');
                    DefaultDim.VALIDATE("Dimension Value Code",Dim2Value);
                    DefaultDim.Insert();
                  END ELSE BEGIN
                    DefaultDim.VALIDATE("Dimension Value Code",Dim2Value);
                    DefaultDim.Modify();
                  END;
                END;
                //
                */
                IF Dim3Value <> '' THEN BEGIN
                    IF NOT DefaultDim.GET(167, Job."No.", 'PROYECTO')THEN BEGIN
                        DefaultDim.Init();
                        DefaultDim.VALIDATE("Table ID", 167);
                        DefaultDim.VALIDATE("No.", Job."No.");
                        DefaultDim.VALIDATE("Dimension Code", 'PROYECTO');
                        DefaultDim.VALIDATE("Dimension Value Code", Dim3Value);
                        DefaultDim.Insert();
                    END
                    ELSE
                    BEGIN
                        DefaultDim.VALIDATE("Dimension Value Code", Dim3Value);
                        DefaultDim.Modify();
                    END;
                END;
            //
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.Skip(); ///////////////////////////
                CurrentDimSetID:=0;
                IF GUIALLOWED THEN Window.UPDATE(1, Job.TABLECAPTION);
            end;
        }
        dataitem("Job Ledger Entry";169)
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = "Posting Date", "Entry No.";

            trigger OnAfterGetRecord()
            var
                JobLedgerEntry: Record 169;
            begin
                CurrReport.Skip(); ///////////////////////////
                IF GUIALLOWED THEN Window.UPDATE(4, "Entry No.");
                JobLedgerEntry:="Job Ledger Entry";
                JobLedgerEntry.VALIDATE("Unit Cost (LCY)", ROUND("Job Ledger Entry"."Unit Cost (LCY)", 0.01, '='));
                JobLedgerEntry.VALIDATE("Unit Cost", ROUND("Job Ledger Entry"."Unit Cost", 0.01, '='));
                JobLedgerEntry.Modify();
                CLEAR(Dim1Value);
                CLEAR(Dim2Value);
                CLEAR(Dim3Value);
                //Crear valor dimensió projecte si no existeix
                IF NOT DimValue.GET('PROYECTO', "Job No.")THEN BEGIN
                    DimValue.Init();
                    DimValue.VALIDATE("Dimension Code", 'PROYECTO');
                    DimValue.Code:="No.";
                    DimValue.INSERT(TRUE);
                END;
                Dim3Value:="Job No.";
                CALCFIELDS("Job Ledger Entry"."Old Dimension Value");
                IF MapeoDim.GET('DEPARTAMENTO', "Job Ledger Entry"."Old Dimension Value")THEN BEGIN
                    Dim1Value:=MapeoDim."Dim Code 1";
                    Dim2Value:=MapeoDim."Dim Code 2";
                END;
                IF Dim1Value = '' THEN Dim1Value:='REVISAR';
                IF Dim2Value = '' THEN Dim2Value:='REVISAR';
                //Calcular dim set ID a partir de temporal
                CLEAR(TempDimSetEntry);
                TempDimSetEntry.Reset(); //Dim 1
                TempDimSetEntry.SETRANGE("Dimension Code", 'AREA GEOGRAFICA');
                IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                    TempDimSetEntry.VALIDATE("Dimension Value Code", Dim1Value);
                    TempDimSetEntry.Modify();
                END
                ELSE
                BEGIN
                    TempDimSetEntry.Init();
                    TempDimSetEntry.VALIDATE("Dimension Code", 'AREA GEOGRAFICA');
                    TempDimSetEntry.VALIDATE("Dimension Value Code", Dim1Value);
                    TempDimSetEntry.Insert();
                END;
                TempDimSetEntry.Reset(); //Dim 2
                TempDimSetEntry.SETRANGE("Dimension Code", 'DEPARTAMENTO');
                IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                    TempDimSetEntry.VALIDATE("Dimension Value Code", Dim2Value);
                    TempDimSetEntry.Modify();
                END
                ELSE
                BEGIN
                    TempDimSetEntry.Init();
                    TempDimSetEntry.VALIDATE("Dimension Code", 'DEPARTAMENTO');
                    TempDimSetEntry.VALIDATE("Dimension Value Code", Dim2Value);
                    TempDimSetEntry.Insert();
                END;
                IF Dim3Value <> '' THEN BEGIN
                    TempDimSetEntry.Reset(); //Dim 3
                    TempDimSetEntry.SETRANGE("Dimension Code", 'PROYECTO');
                    IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Dim3Value);
                        TempDimSetEntry.Modify();
                    END
                    ELSE
                    BEGIN
                        TempDimSetEntry.Init();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'PROYECTO');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Dim3Value);
                        TempDimSetEntry.Insert();
                    END;
                END;
                CLEAR(DimMgt);
                CurrentDimSetID:=DimMgt.GetDimensionSetID(TempDimSetEntry);
                //DimMgt.UpdateGlobalDimFromDimSetID(CurrentDimSetID,"Global Dimension 1 Code","Global Dimension 2 Code");
                "Global Dimension 1 Code":=Dim1Value;
                "Global Dimension 2 Code":=Dim2Value;
                "Dimension Set ID":=CurrentDimSetID;
                Modify();
            end;
            trigger OnPostDataItem()
            begin
                IF GUIALLOWED THEN Window.UPDATE(4, '');
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.Skip(); ///////////////////////////
                IF GUIALLOWED THEN Window.UPDATE(3, "Job Ledger Entry".TABLECAPTION + '  ' + FORMAT("Job Ledger Entry".COUNT));
                CurrentDimSetID:=0;
                "Job Ledger Entry".SETFILTER("Job Ledger Entry"."Posting Date", '%1..%2', 20160101D, 20161231D);
                "Job Ledger Entry".SETFILTER("Global Dimension 1 Code", 'REVISAR');
            end;
        }
        dataitem("Res. Ledger Entry";203)
        {
            DataItemTableView = SORTING("Resource No.", "Posting Date")WHERE("Global Dimension 1 Code"=FILTER('REVISAR'));

            dataitem("Job Ledger Entry2";169)
            {
                DataItemLink = "Ledger Entry No."=FIELD("Entry No.");
                DataItemTableView = WHERE("Global Dimension 1 Code"=FILTER('REVISAR'), "Global Dimension 2 Code"=FILTER('REVISAR'));

                trigger OnAfterGetRecord()
                begin
                    CurrReport.Skip(); ///////////////////////////
                    //FASE 2-----------------------
                    "Global Dimension 1 Code":="Res. Ledger Entry"."Global Dimension 1 Code";
                    "Global Dimension 2 Code":="Res. Ledger Entry"."Global Dimension 2 Code";
                    CurrentDimSetID:="Res. Ledger Entry"."Dimension Set ID";
                    Modify();
                //FI FASE2 --------------------
                end;
                trigger OnPreDataItem()
                begin
                    CurrReport.Skip(); ///////////////////////////
                end;
            }
            trigger OnAfterGetRecord()
            var
                Resource: Record 156;
            begin
                CurrReport.Skip(); ///////////////////////////
                IF GUIALLOWED THEN Window.UPDATE(4, "Entry No.");
                Resource.GET("Res. Ledger Entry"."Resource No.");
                Job.GET("Res. Ledger Entry"."Job No.");
                //Calcular dim set ID a partir de temporal
                CLEAR(TempDimSetEntry);
                TempDimSetEntry.Reset(); //Dim 1
                TempDimSetEntry.SETRANGE("Dimension Code", 'AREA GEOGRAFICA');
                IF Resource."Global Dimension 1 Code" <> '' THEN BEGIN
                    IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Resource."Global Dimension 1 Code");
                        TempDimSetEntry.Modify();
                    END
                    ELSE
                    BEGIN
                        TempDimSetEntry.Init();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'AREA GEOGRAFICA');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Resource."Global Dimension 1 Code");
                        TempDimSetEntry.Insert();
                    END;
                END;
                TempDimSetEntry.Reset(); //Dim 2
                TempDimSetEntry.SETRANGE("Dimension Code", 'DEPARTAMENTO');
                IF Resource."Global Dimension 2 Code" <> '' THEN BEGIN
                    IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Resource."Global Dimension 2 Code");
                        TempDimSetEntry.Modify();
                    END
                    ELSE
                    BEGIN
                        TempDimSetEntry.Init();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'DEPARTAMENTO');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Resource."Global Dimension 2 Code");
                        TempDimSetEntry.Insert();
                    END;
                END;
                IF Dim3Value <> '' THEN BEGIN
                    TempDimSetEntry.Reset(); //Dim 3
                    TempDimSetEntry.SETRANGE("Dimension Code", 'PROYECTO');
                    IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Job."No.");
                        TempDimSetEntry.Modify();
                    END
                    ELSE
                    BEGIN
                        TempDimSetEntry.Init();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'PROYECTO');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", Job."No.");
                        TempDimSetEntry.Insert();
                    END;
                END;
                CLEAR(DimMgt);
                CurrentDimSetID:=DimMgt.GetDimensionSetID(TempDimSetEntry);
                //DimMgt.UpdateGlobalDimFromDimSetID(CurrentDimSetID,"Global Dimension 1 Code","Global Dimension 2 Code");
                "Global Dimension 1 Code":=Resource."Global Dimension 1 Code";
                "Global Dimension 2 Code":=Resource."Global Dimension 2 Code";
                "Dimension Set ID":=CurrentDimSetID;
                Modify();
            //FASE 2-----------------------
            //"Global Dimension 1 Code" := "Job Ledger Entry"."Global Dimension 1 Code";
            //"Global Dimension 2 Code" := "Job Ledger Entry"."Global Dimension 2 Code";
            //CurrentDimSetID:= "Job Ledger Entry"."Dimension Set ID";
            //MODIFY;
            //FI FASE2 --------------------
            end;
            trigger OnPostDataItem()
            begin
                IF GUIALLOWED THEN Window.UPDATE(4, '');
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.Skip(); ///////////////////////////
                IF GUIALLOWED THEN Window.UPDATE(3, "Res. Ledger Entry".TABLECAPTION);
                SETRANGE("Global Dimension 1 Code", 'REVISAR');
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
    trigger OnPostReport()
    begin
        IF GUIALLOWED THEN Window.Close();
        MESSAGE('FINALIZADO');
    end;
    trigger OnPreReport()
    begin
        //Crear dim PROYECTO si no existeix --> Dim 3
        // IF NOT Dim.GET('PROYECTO') THEN BEGIN
        //   Dim.Init();
        //   Dim.VALIDATE(Code,'PROYECTO');
        //   Dim.Insert();
        //
        //   GLSetup.Get();
        //   GLSetup.VALIDATE("Shortcut Dimension 3 Code",Dim.Code);
        //   GLSetup.Modify();
        // END;
        IF GUIALLOWED THEN Window.OPEN('#1##############################\#2##############################\#3##############################\#4##############################');
    //IF "G/L Entry".GETRANGEMAX("G/L Entry"."Posting Date")> 20170430D THEN ERROR('No se pueden mapear registros posteriores a 30/04/17');
    end;
    var DimMgt: Codeunit DimensionManagement;
    MapeoDim: Record "MAPEO DIM to 2 DIMs AT";
    MapeoProy: Record "MAPEO PROY TO DIMS";
    TempDimSetEntry: Record 480 temporary;
    DimValue: Record 349;
    Dim: Record 348;
    CurrentDimSetID: Integer;
    Dim1Value: Code[20];
    Dim2Value: Code[20];
    Dim3Value: Code[20];
    Window: Dialog;
    GLSetup: Record 98;
    "-----------": Integer;
    GLEntry2: Record 17;
    MovContab: Record "MOV.CONTAB";
    xMovContab: Record "MOV.CONTAB";
}
