report 52035 "Importacion Proveedores"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            var
                locrec_vendor: Record 23;
                locrec_Bank: Record "Vendor Bank Account";
            begin
                fil:=2;
                IF ExcelBuf.GET(fil, 2)THEN REPEAT locrec_vendor.SETRANGE("VAT Registration No.", ExcelBuf."Cell Value as Text");
                        IF locrec_vendor.FindFirst()then BEGIN
                            IF ExcelBuf.GET(fil, 1)THEN locrec_vendor.VALIDATE(Name, ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 3)THEN locrec_vendor.VALIDATE(Address, ExcelBuf."Cell Value as Text");
                        END
                        ELSE
                        BEGIN
                            CLEAR(locrec_vendor);
                            locrec_vendor.Init();
                            locrec_vendor.INSERT(TRUE);
                            locrec_vendor.VALIDATE("VAT Registration No.", DELCHR(ExcelBuf."Cell Value as Text", '=', '.'));
                            IF ExcelBuf.GET(fil, 1)THEN locrec_vendor.VALIDATE(Name, ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 3)THEN locrec_vendor.VALIDATE(Address, ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 7)THEN locrec_vendor.City:=ExcelBuf."Cell Value as Text";
                            IF ExcelBuf.GET(fil, 4)THEN locrec_vendor.VALIDATE("Post Code", DELCHR(ExcelBuf."Cell Value as Text", '=', '.'));
                            IF ExcelBuf.GET(fil, 5)THEN locrec_vendor.VALIDATE(County, ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 6)THEN locrec_vendor.VALIDATE("Country/Region Code", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 8)THEN locrec_vendor.VALIDATE("Search Name", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 9)THEN locrec_vendor.VALIDATE("Gen. Bus. Posting Group", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 10)THEN locrec_vendor.VALIDATE("VAT Bus. Posting Group", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 11)THEN locrec_vendor.VALIDATE("Vendor Posting Group", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 12)THEN locrec_vendor.VALIDATE("Payment Terms Code", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 13)THEN locrec_vendor.VALIDATE("Payment Method Code", ExcelBuf."Cell Value as Text");
                            //EX-RBF 171022 Inicio
                            IF ExcelBuf.GET(fil, 14)THEN locrec_vendor.VALIDATE("Codigo IAE", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 15)THEN locrec_vendor.VALIDATE("Sector AT", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 16)THEN locrec_vendor.VALIDATE("Phone No.", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 17)THEN locrec_vendor.VALIDATE("E-Mail", ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 18)THEN locrec_vendor.VALIDATE(Contact, ExcelBuf."Cell Value as Text");
                            IF ExcelBuf.GET(fil, 19)THEN begin
                                locrec_Bank.Init();
                                locrec_Bank.Validate("Vendor No.", locrec_vendor."No.");
                                locrec_Bank.Validate(Code, ExcelBuf."Cell Value as Text");
                                locrec_Bank."Use For Electronic Payments":=true; //EX-RBF 230223
                                IF ExcelBuf.GET(fil, 20)THEN locrec_Bank.Validate(IBAN, ExcelBuf."Cell Value as Text");
                                if not locrec_Bank.Insert()then locrec_Bank.Modify();
                                IF ExcelBuf.GET(fil, 19)THEN locrec_vendor.VALIDATE("Preferred Bank Account Code", ExcelBuf."Cell Value as Text");
                            end;
                        // IF ExcelBuf.GET(fil, 20) THEN
                        // locrec_vendor.VALIDATE(IBAN, ExcelBuf."Cell Value as Text");
                        //EX-RBF 171022 Fin
                        END;
                        locrec_vendor.Modify();
                        fil+=1;
                    UNTIL NOT ExcelBuf.GET(fil, 2);
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Proceso Finalizado');
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
        trigger OnQueryClosePage(CloseAction: Action): Boolean var
            FileMgt: Codeunit "File Management";
            DialogWindow: Dialog;
        begin
            /* Old code
            IF CloseAction = ACTION::OK THEN BEGIN
                IF ServerFileName = '' THEN
                    ServerFileName := FileMgt.BLOBImportWithFilter(TempBlob, Text006, 'Excel.xls', ExcelFileExtensionTok, '');
                //ServerFileName := FileMgt.OpenFileDialog(Text006, 'Excel.xls', ExcelFileExtensionTok);
                IF ServerFileName = '' THEN
                    EXIT(FALSE);
            END;
            */
            //3729 - APR - 22 06 2022
            IF CloseAction = ACTION::OK THEN ReadExcelSheet();
        //3729 - APR - 22 06 2022 END
        end;
    }
    trigger OnPreReport()
    begin
    //3729 - APR - 22 06 2022
    /*
        IF SheetName = '' THEN
            SheetName := ExcelBuf.SelectSheetsNameFrom(ServerFileName);
        ExcelBuf.OpenBookFromStream(SheetName);
        ExcelBuf.ReadSheet;
        */
    //3729 - APR - 22 06 2022 END
    end;
    //3729 - APR - 22 06 2022
    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName:=FileMgt.GetFileName(FromFile);
            SheetName:=ExcelBuf.SelectSheetsNameStream(IStream);
        end
        else
            Error(NoFileFoundMsg);
        ExcelBuf.Reset();
        ExcelBuf.DeleteAll();
        ExcelBuf.OpenBookStream(IStream, SheetName);
        ExcelBuf.ReadSheet();
    end;
    //3729 - APR - 22 06 2022 END
    var ExcelBuf: Record "Excel Buffer" temporary;
    TempBlob: Codeunit "Temp Blob";
    fil: Integer;
    col: Integer;
    ServerFileName: Text;
    SheetName: Text[250];
    Text006: Label 'Import Excel File';
    ExcelFileExtensionTok: Label '.xlsx', Locked = true;
    //3729 - APR - 22 06 2022
    BatchName: Code[10];
    FileName: Text[100];
    UploadExcelMsg: Label 'Please Choose the Excel file.';
    NoFileFoundMsg: Label 'No funciona el archivo Excel';
    BatchISBlankMsg: Label 'Batch name is blank';
    ExcelImportSucess: Label 'Excel is successfully imported.';
//3729 - APR - 22 06 2022 END
}
