report 52072 "UPD fechas movs cli"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/UPDfechasmovscli.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("CARTERA CLIENTS"; "CARTERA CLIENTS")
        {
            trigger OnAfterGetRecord()
            begin
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Document No.", "CARTERA CLIENTS".DocumentNo);
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", "CARTERA CLIENTS".CustomerNo);
                CustLedgerEntry.SETRANGE(CustLedgerEntry.Description, "CARTERA CLIENTS".Description);
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Amount (LCY)", "CARTERA CLIENTS".Amount);
                IF CustLedgerEntry.FIND('-')THEN BEGIN
                    CustLedgerEntry."Posting Date":="CARTERA CLIENTS".PostingDate;
                    CustLedgerEntry."Due Date":="CARTERA CLIENTS".DueDate;
                    CustLedgerEntry."Document Date":="CARTERA CLIENTS".DocDate;
                    IF "CARTERA CLIENTS"."Old Dimension2" <> '' THEN Dim3Value:="CARTERA CLIENTS"."Old Dimension2";
                    //IF MapeoDim.GET('DEPARTAMENTO',"Old Dimension Value") THEN BEGIN
                    IF MapeoDim.GET('DEPARTAMENTO', "CARTERA CLIENTS"."Old Dimension1")THEN BEGIN
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
                    CustLedgerEntry."Dimension Set ID":=CurrentDimSetID;
                    CustLedgerEntry."Global Dimension 1 Code":=Dim1Value;
                    CustLedgerEntry."Global Dimension 2 Code":=Dim2Value;
                    CustLedgerEntry.Modify();
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
        MESSAGE('Fin');
    end;
    var CustLedgerEntry: Record 21;
    Dim1Value: Code[20];
    Dim2Value: Code[20];
    Dim3Value: Code[20];
    MapeoDim: Record "MAPEO DIM to 2 DIMs AT";
    DimMgt: Codeunit DimensionManagement;
    TempDimSetEntry: Record 480 temporary;
    CurrentDimSetID: Integer;
}
