report 52020 "Creacion de Facturas"
{
    ProcessingOnly = true;
    Caption = 'Creacion de Facturas';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            var
                locrec_purchheader: Record 38;
                locrec_purchline: Record 39;
                locrec_vendor: Record 23;
                numlinea: Integer;
            begin
                fil:=2;
                locrec_purchheader.Reset();
                IF ExcelBuf.GET(fil, 1)THEN REPEAT locrec_vendor.SETRANGE("VAT Registration No.", ExcelBuf."Cell Value as Text");
                        locrec_vendor.FindFirst();
                        //    IF locrec_purchheader."Buy-from Vendor No."<>locrec_vendor."No." THEN BEGIN
                        CLEAR(locrec_purchheader);
                        locrec_purchheader.Init();
                        locrec_purchheader."Document Type":=locrec_purchheader."Document Type"::Invoice;
                        locrec_purchheader.INSERT(TRUE);
                        locrec_purchheader.VALIDATE("Buy-from Vendor No.", locrec_vendor."No.");
                        IF ExcelBuf.GET(fil, 2)THEN BEGIN
                            EVALUATE(locrec_purchheader."Posting Date", ExcelBuf."Cell Value as Text");
                            locrec_purchheader.VALIDATE("Posting Date");
                        END;
                        IF ExcelBuf.GET(fil, 3)THEN locrec_purchheader.VALIDATE("Vendor Invoice No.", ExcelBuf."Cell Value as Text");
                        locrec_purchheader."Facturas de Gastos":=TRUE;
                        locrec_purchheader.Modify();
                        //  numlinea:=10000;
                        //  END;
                        locrec_purchline.Init();
                        locrec_purchline."Document Type":=locrec_purchheader."Document Type";
                        locrec_purchline."Document No.":=locrec_purchheader."No.";
                        //locrec_purchline."Line No.":=numlinea;
                        locrec_purchline."Line No.":=10000;
                        locrec_purchline.Insert();
                        locrec_purchline.Type:=locrec_purchline.Type::"G/L Account";
                        IF ExcelBuf.GET(fil, 5)THEN locrec_purchline.VALIDATE("No.", DELCHR(ExcelBuf."Cell Value as Text", '=', '.'));
                        locrec_purchline.VALIDATE(Quantity, 1);
                        IF ExcelBuf.GET(fil, 8)THEN BEGIN
                            EVALUATE(locrec_purchline."Direct Unit Cost", ExcelBuf."Cell Value as Text");
                            locrec_purchline.VALIDATE("Direct Unit Cost");
                        END;
                        IF ExcelBuf.GET(fil, 6)THEN locrec_purchline.VALIDATE("VAT Prod. Posting Group", ExcelBuf."Cell Value as Text");
                        IF ExcelBuf.GET(fil, 7)THEN locrec_purchline.VALIDATE(Description, ExcelBuf."Cell Value as Text");
                        IF ExcelBuf.GET(fil, 9)THEN locrec_purchline.VALIDATE("Job No.", ExcelBuf."Cell Value as Text");
                        IF ExcelBuf.GET(fil, 10)THEN locrec_purchline.VALIDATE("Job Task No.", ExcelBuf."Cell Value as Text");
                        //numlinea+=10000;
                        locrec_purchline.Modify();
                        fil+=1;
                    UNTIL NOT ExcelBuf.GET(fil, 1);
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
        begin
            /* Old code
            IF CloseAction = ACTION::OK THEN BEGIN
                IF ServerFileName = '' THEN
                    //ServerFileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                IF ServerFileName = '' THEN
                    EXIT(FALSE);
            END;
            */
            //3729  -  JX
            IF CloseAction = ACTION::OK THEN ReadExcelSheet();
        //3729  -  JX END
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
    //3729  -  JX
    //IF SheetName = '' THEN
    //    SheetName := ExcelBuf.SelectSheetsNameFrom(ServerFileName);
    //ExcelBuf.OpenBookFromStream(SheetName);
    //ExcelBuf.ReadSheet;
    //3729  -  JX END
    end;
    //3729  -  JX
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
    //3729  -  JX END
    var ExcelBuf: Record "Excel Buffer" temporary;
    TempBlob: Codeunit "Temp Blob";
    fil: Integer;
    col: Integer;
    ServerFileName: Text;
    SheetName: Text[250];
    Text006: Label 'Import Excel File';
    ExcelFileExtensionTok: Label '.xlsx', Locked = true;
    //3729  -  JX
    BatchName: Code[10];
    FileName: Text[100];
    UploadExcelMsg: Label 'Please Choose the Excel file.';
    NoFileFoundMsg: Label 'No funciona el archivo Excel';
    BatchISBlankMsg: Label 'Batch name is blank';
    ExcelImportSucess: Label 'Excel is successfully imported.';
//3729  -  JX END
}
