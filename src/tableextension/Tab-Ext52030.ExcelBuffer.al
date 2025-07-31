tableextension 52030 "ExcelBuffer" extends "Excel Buffer"
{
    fields
    {
    }
    procedure ActiveNewSheet(VarActiveSheet: Boolean; FileName: Text)
    begin
        //TODO: Ver - 'FileNameServer' is inaccessible due to its protection level
        Rec.SetActiveReaderSheet(FileName);
        ActiveSheet:=VarActiveSheet;
    end;
    procedure CreateSheetAdditional(SheetName: Text[250]; ReportHeader: Text[80]; CompanyName: Text[30]; UserID2: Text[30])
    var
        XlEdgeBottom: Integer;
        XlContinuous: Integer;
        XlLineStyleNone: Integer;
        XlLandscape: Integer;
        CRLF: Char;
        Window: Dialog;
        RecNo: Integer;
        TotalRecNo: Integer;
    begin
        //<019
        XlEdgeBottom:=9;
        XlContinuous:=1;
        XlLineStyleNone:=-4142;
        XlLandscape:=2;
        CRLF:=10;
        RecNo:=1;
        TotalRecNo:=COUNTAPPROX;
        RecNo:=0;
    //XlWrkSht := XlWrkBk.Worksheets.Add;
    //XlWrkSht := XlWrkBk.Worksheets;
    /*TODO: Ver - no se puede usar por su nivel de proteccion
         IF ActiveSheet THEN BEGIN
            XlWrkBkWriter := XlWrkBkWriter.Open(FileNameServer);
            XlWrkBkWriter.AddWorksheet(SheetName);
            XlWrkShtWriter := XlWrkBkWriter.GetWorksheetByName(ReportHeader);
            ActiveSheetName := SheetName;
        END;

        XlWrkSht.Name := SheetName;
        IF ReportHeader <> '' THEN
            XlWrkSht.PageSetup.LeftHeader :=
              STRSUBSTNO('%1%2%1%3%4', GetExcelReference(1), ReportHeader, CRLF, CompanyName);
        XlWrkSht.PageSetup.RightHeader :=
          STRSUBSTNO(Text006, GetExcelReference(2), GetExcelReference(3), CRLF, UserID2);
        XlWrkSht.PageSetup.Orientation := XlLandscape;
        IF FIND('-') THEN
            REPEAT
                RecNo := RecNo + 1;
                IF NumberFormat <> '' THEN
                    XlWrkSht.Range(xlColID + xlRowID).NumberFormat := NumberFormat;
                IF Formula = '' THEN
                    XlWrkSht.Range(xlColID + xlRowID).Value := "Cell Value as Text"
                ELSE
                    XlWrkSht.Range(xlColID + xlRowID).Formula := GetFormula;
                IF Comment <> '' THEN
                    XlWrkSht.Range(xlColID + xlRowID).AddComment := Comment;
                IF Bold THEN
                    XlWrkSht.Range(xlColID + xlRowID).Font.Bold := Bold;
                IF Italic THEN
                    XlWrkSht.Range(xlColID + xlRowID).Font.Italic := Italic;
                XlWrkSht.Range(xlColID + xlRowID).Borders.LineStyle := XlLineStyleNone;
                IF Underline THEN
                    XlWrkSht.Range(xlColID + xlRowID).Borders.Item(XlEdgeBottom).LineStyle := XlContinuous;
            UNTIL NEXT = 0;
        XlWrkSht.Range(GetExcelReference(5) + ':' + xlColID + xlRowID).Columns.AutoFit; */
    //019>
    end;
    procedure CreateBookWOSheets()
    var
        FileManagement: Codeunit "File Management";
    begin
    /*TODO: ver - no se puede usar. Se modifico el codigo para llamar a CreateNewBook cuando se tenga el SheetName
        //FileNameServer := FileManagement.ServerTempFileName('xlsx');

        XlWrkBkWriter := XlWrkBkWriter.Create(FileNameServer);
        IF ISNULL(XlWrkBkWriter) THEN
            ERROR(Text037); */
    end;
    procedure SelectSheetsNameFrom(FileName: Text): Text[250]var
        TempBlob: Codeunit "Temp Blob";
    begin
        if FileName = '' then Error(Text001);
        FileManagement.IsAllowedPath(FileName, false);
        FileManagement.BLOBImportWithFilter(TempBlob, '', FileName, Tok, '*.*');
        TempBlob.CreateInStream(InStr);
        exit(SelectSheetsNameStream(InStr));
    end;
    procedure OpenBookFromStream(SheetName: Text)
    begin
        OpenBookStream(InStr, SheetName);
    end;
    procedure CreateNewBookWithoutOpen(SheetName: Text[250])
    begin
        Rec.CreateNewBook(SheetName);
    end;
    procedure CreateNewBookAndOpenExcel(FileName: Text; SheetName: Text[250]; ReportHeader: Text; CompanyName2: Text; UserID2: Text)
    begin
        Rec.CreateNewBook(SheetName);
        Rec.WriteSheet(ReportHeader, CompanyName2, UserID2);
        Rec.CloseBook();
        Rec.OpenExcel;
    end;
    var FileManagement: Codeunit "File Management";
    InStr: InStream;
    Tok: Label 'Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*', Comment = '{Split=r''\|\*\..{1,4}\|?''}{Locked="Excel"}';
    Text000: Label 'Excel not found.', Comment = '{Locked="Excel"}';
    Text006: Label '%1%3%4%3Page %2';
    InfoExcelBuf: Record "Excel Buffer" temporary;
    Text001: Label ' ';
    ActiveSheet: Boolean;
}
