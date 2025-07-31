report 52063 "REMAPEO Recursos"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Resource;156)
        {
            DataItemTableView = SORTING("No.")WHERE("No."=FILTER(>=1620));

            trigger OnAfterGetRecord()
            begin
                CurrentDimSetID:=0;
                CLEAR(Dim1Value);
                CLEAR(Dim2Value);
                IF MapeoDim.GET('DEPARTAMENTO', Resource."Old Dimension 1 Code AT")THEN BEGIN
                    Dim1Value:=MapeoDim."Dim Code 1";
                    Dim2Value:=MapeoDim."Dim Code 2";
                END;
                IF Dim1Value = '' THEN Dim1Value:='REVISAR';
                IF Dim2Value = '' THEN Dim2Value:='REVISAR';
                "Global Dimension 1 Code":=Dim1Value;
                "Global Dimension 2 Code":=Dim2Value;
                Modify();
                IF Dim1Value <> '' THEN BEGIN
                    IF NOT DefaultDim.GET(156, Resource."No.", 'AREA GEOGRAFICA')THEN BEGIN
                        DefaultDim.Init();
                        DefaultDim.VALIDATE("Table ID", 156);
                        DefaultDim.VALIDATE("No.", Resource."No.");
                        DefaultDim.VALIDATE("Dimension Code", 'AREA GEOGRAFICA');
                        DefaultDim.VALIDATE("Dimension Value Code", Dim1Value);
                        DefaultDim.Insert();
                    END
                    ELSE
                    BEGIN
                        DefaultDim.VALIDATE("Dimension Value Code", Dim1Value);
                        DefaultDim.Modify();
                    END;
                END;
                IF Dim2Value <> '' THEN BEGIN
                    IF NOT DefaultDim.GET(156, Resource."No.", 'DEPARTAMENTO')THEN BEGIN
                        DefaultDim.Init();
                        DefaultDim.VALIDATE("Table ID", 156);
                        DefaultDim.VALIDATE("No.", Resource."No.");
                        DefaultDim.VALIDATE("Dimension Code", 'DEPARTAMENTO');
                        DefaultDim.VALIDATE("Dimension Value Code", Dim2Value);
                        DefaultDim.Insert();
                    END
                    ELSE
                    BEGIN
                        DefaultDim.VALIDATE("Dimension Value Code", Dim2Value);
                        DefaultDim.Modify();
                    END;
                END;
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
        MESSAGE('FINALIZADO');
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
    DefaultDim: Record 352;
}
