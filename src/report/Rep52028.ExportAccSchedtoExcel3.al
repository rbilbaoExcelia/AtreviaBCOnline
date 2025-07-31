report 52028 "Export Acc. Sched. to Excel 3"
{
    // 040 OS.SPG  28/10/2016  FIN.020   Exportación a Excel esquema de cuentas con todas las combinaciones de dimensiones.
    Caption = 'Export Acc. Sched. to Excel';
    ProcessingOnly = true;
    UseRequestPage = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DimensionValue1;349)
        {
            DataItemTableView = SORTING("Dimension Code", Code)WHERE(Blocked=FILTER(false), "Dimension Value Type"=FILTER(Standard));

            dataitem(DimensionValue2;349)
            {
                DataItemTableView = SORTING("Dimension Code", Code)WHERE(Blocked=FILTER(false), "Dimension Value Type"=FILTER(Standard), "Dim Estructura"=FILTER(false));

                trigger OnAfterGetRecord()
                var
                    Window: Dialog;
                    RecNo: Integer;
                    TotalRecNo: Integer;
                    RowNo: Integer;
                    ColumnNo: Integer;
                    ClientFileName: Text;
                    "----------": Integer;
                    SheetNameTmp: Text[30];
                begin
                    d.UPDATE(1, FORMAT(DimensionValue1.Code) + '-' + FORMAT(DimensionValue2.Code));
                    AcumColumnValue:=0; //270317
                    //IF DoUpdateExistingWorksheet THEN
                    //  IF NOT UploadClientFile(ClientFileName,ServerFileName) THEN
                    //    EXIT;
                    Window.OPEN(Text000 + '@1@@@@@@@@@@@@@@@@@@@@@\');
                    Window.UPDATE(1, 0);
                    AccSchedLine.SETFILTER(Show, '<>%1', AccSchedLine.Show::No);
                    TotalRecNo:=AccSchedLine.COUNT;
                    RecNo:=0;
                    SheetNameTmp:=COPYSTR(FORMAT(DimensionValue1.Code), 1, 12) + '_' + COPYSTR(FORMAT(DimensionValue2.Code), 1, 17);
                    if not FileCreated then begin
                        TempExcelBuffer.DeleteAll();
                        CLEAR(TempExcelBuffer);
                    end
                    else
                    begin
                        TempExcelBuffer.DeleteAll();
                        TempExcelBuffer.SetCurrent(0, 0);
                    //TempExcelBuffer.SelectOrAddSheet(SheetNameTmp);
                    end;
                    AccSchedName.GET(AccSchedLine.GETRANGEMIN("Schedule Name"));
                    AccSchedManagement.CheckAnalysisView(AccSchedName.Name, ColumnLayout.GETRANGEMIN("Column Layout Name"), TRUE);
                    IF AccSchedName."Analysis View Name" <> '' THEN AnalysisView.GET(AccSchedName."Analysis View Name");
                    GLSetup.Get();
                    if RowNo = 0 then RowNo:=1
                    else
                        RowNo+=1;
                    EnterCell(RowNo, 1, Text001, FALSE, FALSE, TRUE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    IF AccSchedLine.GETFILTER("Date Filter") <> '' THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Date Filter"), AccSchedLine.FIELDCAPTION("Date Filter"), '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    IF AccSchedLine.GETFILTER("G/L Budget Filter") <> '' THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("G/L Budget Filter"), AccSchedLine.FIELDCAPTION("G/L Budget Filter"), '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    IF AccSchedLine.GETFILTER("Cost Budget Filter") <> '' THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Cost Budget Filter"), AccSchedLine.FIELDCAPTION("Cost Budget Filter"), '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    /*
                    //310118
                    
                    AccSchedLine.SETFILTER("Dimension 1 Filter", DimensionValue1.Code);
                    IF (AccSchedLine.GETFILTER("Dimension 1 Filter") <> '') THEN BEGIN
                      RowNo := RowNo + 1;
                      EnterFilterInCell(
                        RowNo,
                        AccSchedLine.GETFILTER("Dimension 1 Filter"),
                        GetDimFilterCaption(1),
                        '',
                        TempExcelBuffer."Cell Type"::Text);
                    END;
                    
                    AccSchedLine.SETFILTER("Dimension 2 Filter", DimensionValue2.Code);
                    IF AccSchedLine.GETFILTER("Dimension 2 Filter") <> '' THEN BEGIN
                      RowNo := RowNo + 1;
                      EnterFilterInCell(
                        RowNo,
                        AccSchedLine.GETFILTER("Dimension 2 Filter"),
                        GetDimFilterCaption(2),
                        '',
                        TempExcelBuffer."Cell Type"::Text);
                    END;
                    */
                    AccSchedLine.SETFILTER("Dimension 1 Filter", DimensionValue1.Code);
                    IF(AccSchedLine.GETFILTER("Dimension 1 Filter") <> '')THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterCell(RowNo, 1, AccSchedLine.GETFILTER("Dimension 1 Filter"), FALSE, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    AccSchedLine.SETFILTER("Dimension 2 Filter", DimensionValue2.Code);
                    IF AccSchedLine.GETFILTER("Dimension 2 Filter") <> '' THEN BEGIN
                        EnterCell(RowNo, 2, AccSchedLine.GETFILTER("Dimension 2 Filter"), FALSE, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    //310118
                    IF AccSchedLine.GETFILTER("Dimension 3 Filter") <> '' THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Dimension 3 Filter"), GetDimFilterCaption(3), '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    IF AccSchedLine.GETFILTER("Dimension 4 Filter") <> '' THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Dimension 4 Filter"), GetDimFilterCaption(4), '', TempExcelBuffer."Cell Type"::Text);
                    END;
                    RowNo:=RowNo + 1;
                    IF UseAmtsInAddCurr THEN BEGIN
                        IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
                            RowNo:=RowNo + 1;
                            EnterFilterInCell(RowNo, GLSetup."Additional Reporting Currency", Currency.TABLECAPTION, '', TempExcelBuffer."Cell Type"::Text)END;
                    END
                    ELSE IF GLSetup."LCY Code" <> '' THEN BEGIN
                            RowNo:=RowNo + 1;
                            EnterFilterInCell(RowNo, GLSetup."LCY Code", Currency.TABLECAPTION, '', TempExcelBuffer."Cell Type"::Text);
                        END;
                    RowNo:=RowNo + 1;
                    IF AccSchedLine.FIND('-')THEN BEGIN
                        IF ColumnLayout.FIND('-')THEN BEGIN
                            RowNo:=RowNo + 1;
                            ColumnNo:=2; // Skip the "Row No." column.
                            REPEAT ColumnNo:=ColumnNo + 1;
                                EnterCell(RowNo, ColumnNo, ColumnLayout."Column Header", FALSE, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                            UNTIL ColumnLayout.Next() = 0;
                        END;
                        REPEAT RecNo:=RecNo + 1;
                            Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                            RowNo:=RowNo + 1;
                            ColumnNo:=1;
                            EnterCell(RowNo, ColumnNo, AccSchedLine."Row No.", AccSchedLine.Bold, AccSchedLine.Italic, AccSchedLine.Underline, AccSchedLine."Double Underline", '0', TempExcelBuffer."Cell Type"::Number);
                            ColumnNo:=2;
                            EnterCell(RowNo, ColumnNo, AccSchedLine.Description, AccSchedLine.Bold, AccSchedLine.Italic, AccSchedLine.Underline, AccSchedLine."Double Underline", '', TempExcelBuffer."Cell Type"::Text);
                            IF ColumnLayout.FIND('-')THEN BEGIN
                                REPEAT IF AccSchedLine.Totaling = '' THEN ColumnValue:=0
                                    ELSE
                                    BEGIN
                                        ColumnValue:=AccSchedManagement.CalcCell(AccSchedLine, ColumnLayout, UseAmtsInAddCurr);
                                        IF AccSchedManagement.GetDivisionError THEN ColumnValue:=0 END;
                                    //270317
                                    AcumColumnValue:=AcumColumnValue + ColumnValue;
                                    //270317
                                    ColumnNo:=ColumnNo + 1;
                                    EnterCell(RowNo, ColumnNo, MatrixMgt.FormatAmount(ColumnValue, ColumnLayout."Rounding Factor", UseAmtsInAddCurr), AccSchedLine.Bold, AccSchedLine.Italic, AccSchedLine.Underline, AccSchedLine."Double Underline", //'', //SPG
 '#,##0.00', TempExcelBuffer."Cell Type"::Number)UNTIL ColumnLayout.Next() = 0;
                            END;
                        UNTIL AccSchedLine.Next() = 0;
                    END;
                    Window.Close();
                    IF(NOT FileCreated)THEN BEGIN
                        TempExcelBuffer.CreateNewBookWithoutOpen(FORMAT(AccSchedName.Name));
                        FileCreated:=TRUE;
                        TempExcelBuffer.WriteSheet(FORMAT(AccSchedName.Name), COMPANYNAME, USERID);
                    //TempExcelBuffer.CloseBook();
                    END;
                    if FileCreated then IF(AcumColumnValue <> 0) OR (MostrarHojasBlanco)THEN BEGIN //270317                                                        
                            //SheetNameTmp := COPYSTR(FORMAT(DimensionValue1.Code), 1, 12) + '_' + COPYSTR(FORMAT(DimensionValue2.Code), 1, 17);
                            TempExcelBuffer.SelectOrAddSheet(SheetNameTmp);
                            //TempExcelBuffer.ActiveNewSheet(TRUE, SheetNameTmp);
                            TempExcelBuffer.WriteSheet(SheetNameTmp, COMPANYNAME, USERID);
                        //TempExcelBuffer.CloseBook();
                        END;
                //TempExcelBuffer.CloseBook();
                end;
                trigger OnPreDataItem()
                begin
                    DimensionValue2.SETFILTER("Dimension Code", GLSetup."Global Dimension 2 Code");
                    IF AccSchedLineFilterDim2 <> '' THEN DimensionValue2.SETFILTER(Code, AccSchedLineFilterDim2);
                end;
            }
            trigger OnPreDataItem()
            begin
                DimensionValue1.SETFILTER("Dimension Code", GLSetup."Global Dimension 1 Code");
                IF AccSchedLineFilterDim1 <> '' THEN DimensionValue1.SETFILTER(Code, AccSchedLineFilterDim1);
            end;
        }
        dataitem(DimensionValue2Estr;349)
        {
            DataItemTableView = SORTING("Dimension Code", Code)WHERE(Blocked=FILTER(false), "Dimension Value Type"=FILTER(Standard), "Dim Estructura"=FILTER(true));

            trigger OnAfterGetRecord()
            var
                Window: Dialog;
                RecNo: Integer;
                TotalRecNo: Integer;
                RowNo: Integer;
                ColumnNo: Integer;
                ClientFileName: Text;
                "----------": Integer;
            begin
                d.UPDATE(1, FORMAT(DimensionValue2Estr.Code));
                AcumColumnValue:=0; //270317
                IF DoUpdateExistingWorksheet THEN IF NOT UploadClientFile(ClientFileName, ServerFileName)THEN EXIT;
                Window.OPEN(Text000 + '@1@@@@@@@@@@@@@@@@@@@@@\');
                Window.UPDATE(1, 0);
                AccSchedLine.SETFILTER(Show, '<>%1', AccSchedLine.Show::No);
                TotalRecNo:=AccSchedLine.COUNT;
                RecNo:=0;
                if not FileCreated then begin
                    TempExcelBuffer.DeleteAll();
                    CLEAR(TempExcelBuffer);
                end
                else
                begin
                    TempExcelBuffer.DeleteAll();
                    TempExcelBuffer.SetCurrent(0, 0);
                //TempExcelBuffer.SelectOrAddSheet(FORMAT(DimensionValue2Estr.Code));
                end;
                AccSchedName.GET(AccSchedLine.GETRANGEMIN("Schedule Name"));
                AccSchedManagement.CheckAnalysisView(AccSchedName.Name, ColumnLayout.GETRANGEMIN("Column Layout Name"), TRUE);
                IF AccSchedName."Analysis View Name" <> '' THEN AnalysisView.GET(AccSchedName."Analysis View Name");
                GLSetup.Get();
                if RowNo = 0 then RowNo:=1
                else
                    RowNo+=1;
                EnterCell(RowNo, 1, Text001, FALSE, FALSE, TRUE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                IF AccSchedLine.GETFILTER("Date Filter") <> '' THEN BEGIN
                    RowNo:=RowNo + 1;
                    EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Date Filter"), AccSchedLine.FIELDCAPTION("Date Filter"), '', TempExcelBuffer."Cell Type"::Text);
                END;
                IF AccSchedLine.GETFILTER("G/L Budget Filter") <> '' THEN BEGIN
                    RowNo:=RowNo + 1;
                    EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("G/L Budget Filter"), AccSchedLine.FIELDCAPTION("G/L Budget Filter"), '', TempExcelBuffer."Cell Type"::Text);
                END;
                IF AccSchedLine.GETFILTER("Cost Budget Filter") <> '' THEN BEGIN
                    RowNo:=RowNo + 1;
                    EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Cost Budget Filter"), AccSchedLine.FIELDCAPTION("Cost Budget Filter"), '', TempExcelBuffer."Cell Type"::Text);
                END;
                /*
                AccSchedLine.SETFILTER("Dimension 1 Filter", DimensionValue1.Code);
                IF (AccSchedLine.GETFILTER("Dimension 1 Filter") <> '') THEN BEGIN
                  RowNo := RowNo + 1;
                  EnterFilterInCell(
                    RowNo,
                    AccSchedLine.GETFILTER("Dimension 1 Filter"),
                    GetDimFilterCaption(1),
                    '',
                    TempExcelBuffer."Cell Type"::Text);
                END;
                */
                AccSchedLine.SETFILTER("Dimension 2 Filter", DimensionValue2Estr.Code);
                IF AccSchedLine.GETFILTER("Dimension 2 Filter") <> '' THEN BEGIN
                    RowNo:=RowNo + 1;
                    EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Dimension 2 Filter"), GetDimFilterCaption(2), '', TempExcelBuffer."Cell Type"::Text);
                END;
                IF AccSchedLine.GETFILTER("Dimension 3 Filter") <> '' THEN BEGIN
                    RowNo:=RowNo + 1;
                    EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Dimension 3 Filter"), GetDimFilterCaption(3), '', TempExcelBuffer."Cell Type"::Text);
                END;
                IF AccSchedLine.GETFILTER("Dimension 4 Filter") <> '' THEN BEGIN
                    RowNo:=RowNo + 1;
                    EnterFilterInCell(RowNo, AccSchedLine.GETFILTER("Dimension 4 Filter"), GetDimFilterCaption(4), '', TempExcelBuffer."Cell Type"::Text);
                END;
                RowNo:=RowNo + 1;
                IF UseAmtsInAddCurr THEN BEGIN
                    IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterFilterInCell(RowNo, GLSetup."Additional Reporting Currency", Currency.TABLECAPTION, '', TempExcelBuffer."Cell Type"::Text)END;
                END
                ELSE IF GLSetup."LCY Code" <> '' THEN BEGIN
                        RowNo:=RowNo + 1;
                        EnterFilterInCell(RowNo, GLSetup."LCY Code", Currency.TABLECAPTION, '', TempExcelBuffer."Cell Type"::Text);
                    END;
                RowNo:=RowNo + 1;
                IF AccSchedLine.FIND('-')THEN BEGIN
                    IF ColumnLayout.FIND('-')THEN BEGIN
                        RowNo:=RowNo + 1;
                        ColumnNo:=2; // Skip the "Row No." column.
                        REPEAT ColumnNo:=ColumnNo + 1;
                            EnterCell(RowNo, ColumnNo, ColumnLayout."Column Header", FALSE, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        UNTIL ColumnLayout.Next() = 0;
                    END;
                    REPEAT RecNo:=RecNo + 1;
                        Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                        RowNo:=RowNo + 1;
                        ColumnNo:=1;
                        EnterCell(RowNo, ColumnNo, AccSchedLine."Row No.", AccSchedLine.Bold, AccSchedLine.Italic, AccSchedLine.Underline, AccSchedLine."Double Underline", '0', TempExcelBuffer."Cell Type"::Number);
                        ColumnNo:=2;
                        EnterCell(RowNo, ColumnNo, AccSchedLine.Description, AccSchedLine.Bold, AccSchedLine.Italic, AccSchedLine.Underline, AccSchedLine."Double Underline", '', TempExcelBuffer."Cell Type"::Text);
                        IF ColumnLayout.FIND('-')THEN BEGIN
                            REPEAT IF AccSchedLine.Totaling = '' THEN ColumnValue:=0
                                ELSE
                                BEGIN
                                    ColumnValue:=AccSchedManagement.CalcCell(AccSchedLine, ColumnLayout, UseAmtsInAddCurr);
                                    IF AccSchedManagement.GetDivisionError THEN ColumnValue:=0 END;
                                //270317
                                AcumColumnValue:=AcumColumnValue + ColumnValue;
                                //270317
                                ColumnNo:=ColumnNo + 1;
                                EnterCell(RowNo, ColumnNo, MatrixMgt.FormatAmount(ColumnValue, ColumnLayout."Rounding Factor", UseAmtsInAddCurr), AccSchedLine.Bold, AccSchedLine.Italic, AccSchedLine.Underline, AccSchedLine."Double Underline", //'', //SPG
 '#,##0.00', TempExcelBuffer."Cell Type"::Number)UNTIL ColumnLayout.Next() = 0;
                        END;
                    UNTIL AccSchedLine.Next() = 0;
                END;
                Window.Close();
                /*if FileCreated then begin
                    TempExcelBuffer.ActiveNewSheet(TRUE, ServerFileName);
                    TempExcelBuffer.WriteSheet(FORMAT(DimensionValue2Estr.Code), COMPANYNAME, USERID);
                    //TempExcelBuffer.CloseBook();
                end;*/
                IF(NOT FileCreated)THEN BEGIN
                    TempExcelBuffer.CreateNewBookWithoutOpen(FORMAT(AccSchedName.Name));
                    FileCreated:=TRUE;
                    TempExcelBuffer.WriteSheet(FORMAT(AccSchedName.Name), COMPANYNAME, USERID);
                //TempExcelBuffer.CloseBook();
                END;
                if FileCreated then begin
                    //IF (AcumColumnValue <> 0) OR (MostrarHojasBlanco) THEN BEGIN //270317                                                        
                    //TempExcelBuffer.ActiveNewSheet(TRUE, ServerFileName);
                    //TempExcelBuffer.WriteSheet(FORMAT(DimensionValue2Estr.Code), COMPANYNAME, USERID);
                    //TempExcelBuffer.CloseBook();
                    TempExcelBuffer.SelectOrAddSheet(FORMAT(DimensionValue2Estr.Code));
                    //TempExcelBuffer.ActiveNewSheet(TRUE, SheetNameTmp);
                    TempExcelBuffer.WriteSheet(FORMAT(DimensionValue2Estr.Code), COMPANYNAME, USERID);
                //TempExcelBuffer.CloseBook();
                //END;
                end;
            //TempExcelBuffer.CloseBook();
            end;
            trigger OnPreDataItem()
            begin
                AccSchedLine.SETRANGE("Dimension 1 Filter");
                AccSchedLine.SETRANGE("Dimension 2 Filter");
                DimensionValue2Estr.SETFILTER("Dimension Code", GLSetup."Global Dimension 2 Code");
                IF AccSchedLineFilterDim2 <> '' THEN DimensionValue2Estr.SETFILTER(Code, AccSchedLineFilterDim2);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Hojas)
                {
                    field(MostrarHojasBlanco; MostrarHojasBlanco)
                    {
                        ToolTip = 'Mostrar Hojas en Blanco';
                        ApplicationArea = All;
                        Caption = 'Show Blank Sheets';
                    }
                }
            }
        }
        actions
        {
        }
    }
    trigger OnPostReport()
    begin
        //TempExcelBuffer.CloseBook();
        //IF NOT TestMode THEN
        //    TempExcelBuffer.OpenExcel;
        //IF NOT TestMode THEN
        //    TempExcelBuffer.GiveUserControl;
        if not TempExcelBuffer.IsEmpty()then TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel;
    end;
    trigger OnPreReport()
    begin
        GLSetup.Get();
        IF AccSchedLine.GETFILTER("Dimension 1 Filter") <> '' THEN AccSchedLineFilterDim1:=AccSchedLine.GETFILTER("Dimension 1 Filter");
        IF AccSchedLine.GETFILTER("Dimension 2 Filter") <> '' THEN AccSchedLineFilterDim2:=AccSchedLine.GETFILTER("Dimension 2 Filter");
        d.OPEN(txt5000);
        ;
    //IF (AccSchedLine.GETFILTER("Dimension 1 Filter") ='') AND (AccSchedLine.GETFILTER("Dimension 2 Filter") = '') THEN
    //   ERROR(Text008);
    end;
    var Text000: Label 'Analyzing Data...\\';
    Text001: Label 'Filters';
    Text002: Label 'Update Workbook';
    AccSchedName: Record 84;
    AccSchedLine: Record 85;
    ColumnLayout: Record 334;
    TempExcelBuffer: Record 370 temporary;
    GLSetup: Record 98;
    AnalysisView: Record 363;
    Currency: Record 4;
    AccSchedManagement: Codeunit 8;
    MatrixMgt: Codeunit 9200;
    FileMgt: Codeunit "File Management";
    UseAmtsInAddCurr: Boolean;
    ColumnValue: Decimal;
    ServerFileName: Text;
    SheetName: Text[250];
    DoUpdateExistingWorksheet: Boolean;
    ExcelFileExtensionTok: Label '.xlsx', Locked = true;
    TestMode: Boolean;
    "-------------------": Integer;
    FileCreated: Boolean;
    AcumColumnValue: Decimal;
    AccSchedLineFilterDim1: Text;
    AccSchedLineFilterDim2: Text;
    d: Dialog;
    txt5000: Label 'Progreso: #1#### #2 ###### 3######';
    MostrarHojasBlanco: Boolean;
    procedure SetOptions(var AccSchedLine2: Record 85; ColumnLayoutName2: Code[10]; UseAmtsInAddCurr2: Boolean)
    begin
        AccSchedLine.COPYFILTERS(AccSchedLine2);
        ColumnLayout.SETRANGE("Column Layout Name", ColumnLayoutName2);
        UseAmtsInAddCurr:=UseAmtsInAddCurr2;
    end;
    local procedure EnterFilterInCell(RowNo: Integer; "Filter": Text[250]; FieldName: Text[100]; Format: Text[30]; CellType: Option)
    begin
        IF Filter <> '' THEN BEGIN
            EnterCell(RowNo, 1, FieldName, FALSE, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            EnterCell(RowNo, 2, Filter, FALSE, FALSE, FALSE, FALSE, Format, CellType);
        END;
    end;
    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; DoubleUnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text":=CellValue;
        TempExcelBuffer.Formula:='';
        TempExcelBuffer.Bold:=Bold;
        TempExcelBuffer.Italic:=Italic;
        IF DoubleUnderLine = TRUE THEN BEGIN
            TempExcelBuffer."Double Underline":=TRUE;
            TempExcelBuffer.Underline:=FALSE;
        END
        ELSE
        BEGIN
            TempExcelBuffer."Double Underline":=FALSE;
            TempExcelBuffer.Underline:=UnderLine;
        END;
        TempExcelBuffer.NumberFormat:=Format; ////////
        TempExcelBuffer."Cell Type":=CellType;
        TempExcelBuffer.Insert();
    end;
    local procedure GetDimFilterCaption(DimFilterNo: Integer): Text[80]var
        Dimension: Record 348;
    begin
        IF AccSchedName."Analysis View Name" = '' THEN CASE DimFilterNo OF 1: Dimension.GET(GLSetup."Global Dimension 1 Code");
            2: Dimension.GET(GLSetup."Global Dimension 2 Code");
            END
        ELSE
            CASE DimFilterNo OF 1: Dimension.GET(AnalysisView."Dimension 1 Code");
            2: Dimension.GET(AnalysisView."Dimension 2 Code");
            3: Dimension.GET(AnalysisView."Dimension 3 Code");
            4: Dimension.GET(AnalysisView."Dimension 4 Code");
            END;
        EXIT(COPYSTR(Dimension.GetMLFilterCaption(GLOBALLANGUAGE), 1, 80));
    end;
    procedure SetUpdateExistingWorksheet(UpdateExistingWorksheet: Boolean)
    begin
        DoUpdateExistingWorksheet:=UpdateExistingWorksheet;
    end;
    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName:=NewFileName;
    end;
    procedure SetTestMode(NewTestMode: Boolean)
    begin
        TestMode:=NewTestMode;
    end;
    local procedure UploadClientFile(var ClientFileName: Text; var ServerFileName: Text): Boolean var
        TempBlob: Codeunit "Temp Blob";
    begin
        //IF FileMgt.IsWebClient THEN
        //    ServerFileName := FileMgt.UploadFile(Text002, ExcelFileExtensionTok)
        //ELSE BEGIN
        ServerFileName:=FileMgt.BLOBImportWithFilter(TempBlob, Text002, 'Excel.xls', ExcelFileExtensionTok, '');
        //ServerFileName := FileMgt.OpenFileDialog(Text002, ExcelFileExtensionTok, '');
        IF ServerFileName = '' THEN EXIT(FALSE);
        //ServerFileName := FileMgt.UploadFileSilent(ClientFileName);
        //END;
        IF ServerFileName = '' THEN EXIT(FALSE);
        SheetName:=TempExcelBuffer.SelectSheetsNameFrom(ServerFileName);
        IF SheetName = '' THEN EXIT(FALSE);
        EXIT(TRUE);
    end;
}
