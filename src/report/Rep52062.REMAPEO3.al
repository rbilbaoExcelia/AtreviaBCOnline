report 52062 "REMAPEO 3"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry";17)
        {
            DataItemTableView = SORTING("Entry No.")WHERE("Job No."=FILTER(<>''), "Posting Date"=FILTER(>='01-06-17'), "G/L Account No."=FILTER('64*'));
            RequestFilterFields = "Posting Date", "Entry No.";

            trigger OnAfterGetRecord()
            begin
                IF GUIALLOWED THEN Window.UPDATE(2, FORMAT("Entry No.") + ' ' + "Job No.");
                CLEAR(Dim1Value);
                CLEAR(Dim2Value);
                CLEAR(Dim3Value);
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
                /*
                IF Job.GET("Job No.") THEN BEGIN
                  Dim1Value := Job."Global Dimension 1 Code";
                  Dim2Value := Job."Global Dimension 2 Code";
                END;
                */
                Dim1Value:="G/L Entry"."Global Dimension 1 Code";
                Dim2Value:="G/L Entry"."Global Dimension 2 Code";
                //Calcular dim set ID a partir de temporal
                CLEAR(TempDimSetEntry);
                //IF "G/L Entry"."Global Dimension 1 Code"<>'' THEN BEGIN
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
                //END;
                //IF "G/L Entry"."Global Dimension 2 Code"<>'' THEN BEGIN
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
                //END;
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
                //VALIDATE("Global Dimension 1 Code" , Dim1Value);
                //VALIDATE("Global Dimension 2 Code" , Dim2Value);
                Modify();
            end;
            trigger OnPreDataItem()
            begin
                CurrentDimSetID:=0;
                IF GUIALLOWED THEN Window.UPDATE(1, "G/L Entry".TABLECAPTION);
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
        IF GUIALLOWED THEN Window.OPEN('#1##############################\#2##############################\#3##############################\#4##############################');
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
    Job: Record Job;
}
