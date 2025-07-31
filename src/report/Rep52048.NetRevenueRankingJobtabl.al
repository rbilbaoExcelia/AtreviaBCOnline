report 52048 "Net Revenue Ranking(Job tabl)"
{
    // 018 OS  28/02/2017 FIN.011   Informe Ranking Facturación Neta
    // 019 OS.EG  08/05/2017   Aplicar código departamento a Barcelona, Madrid o Lisboa.
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/NetRevenueRankingJobtabl.rdlc';
    Caption = 'Net Revenue Ranking by Department';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Dimension Value";349)
        {
            DataItemTableView = SORTING("Dimension Code", Code)ORDER(Ascending)WHERE("Global Dimension No."=CONST(1));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";

            dataitem("Dimension Value 2";349)
            {
                //DataItemLink = '';
                DataItemTableView = SORTING("Dimension Code", Code)ORDER(Ascending)WHERE("Global Dimension No."=CONST(2));
                PrintOnlyIfDetail = true;

                dataitem(Job;167)
                {
                    DataItemLink = "Global Dimension 1 Code"=FIELD(Code);
                    DataItemLinkReference = "Dimension Value";
                    DataItemTableView = SORTING("Bill-to Customer No.")ORDER(Ascending)WHERE("Job Type AT"=FILTER(Periodical|"One Off"));
                    RequestFilterFields = "No.", "Global Dimension 1 Code", "Posting Date Filter";

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT CustPriceGroup.GET(Job."Customer Price Group")THEN CLEAR(CustPriceGroup);
                        //Un año.
                        MemInt.Init();
                        MemInt."Cod 1":=Job."Global Dimension 1 Code";
                        IF Job."Customer Price Group" <> '' THEN MemInt."Cod 2":=Job."Customer Price Group"
                        ELSE
                            MemInt."Cod 2":=Job."Bill-to Customer No.";
                        //<019
                        IF "Dimension Value"."Split Dimension" THEN MemInt."Cod 3":=Job."Global Dimension 2 Code"
                        ELSE
                            MemInt."Cod 3":=''; //019>
                        W.UPDATE(2, Job."Bill-to Customer No.");
                        IF NOT MemInt.Find()then BEGIN
                            IF Job."Customer Price Group" <> '' THEN MemInt.Txt1:=CustPriceGroup.Description
                            ELSE
                                MemInt.Txt1:=Job."Bill-to Name";
                            MemInt."Value 3":=0;
                            //"Value 1" --> Periodical
                            //"Value 2" --> One Off
                            //"Value 3" --> Net Revenue
                            MemInt."Value 1":=0;
                            MemInt."Value 2":=0;
                            MemInt.Insert();
                        END;
                        IF Job."Job Type AT" = Job."Job Type AT"::Periodical THEN MemInt."Value 1"+=1;
                        IF Job."Job Type AT" = Job."Job Type AT"::"One Off" THEN MemInt."Value 2"+=1;
                        MemInt."Value 3"+=ReturnsTotalAmount(DateFilter1, DateFilter2);
                        MemInt.Modify();
                        //Año pasado
                        IF MoreYears THEN BEGIN
                            PastMemInt.Init();
                            PastMemInt."Cod 1":=Job."Global Dimension 1 Code";
                            IF Job."Customer Price Group" <> '' THEN PastMemInt."Cod 2":=Job."Customer Price Group"
                            ELSE
                                PastMemInt."Cod 2":=Job."Bill-to Customer No.";
                            //<019
                            IF "Dimension Value"."Split Dimension" THEN PastMemInt."Cod 3":=Job."Global Dimension 2 Code"
                            ELSE
                                PastMemInt."Cod 3":=''; //019>
                            IF NOT PastMemInt.Find()then BEGIN
                                IF Job."Customer Price Group" <> '' THEN PastMemInt.Txt1:=CustPriceGroup.Description
                                ELSE
                                    PastMemInt.Txt1:=Job."Bill-to Name";
                                //"Value 1" --> Periodical
                                //"Value 2" --> One Off
                                //"Value 3" --> Net Revenue
                                PastMemInt."Value 1":=0;
                                PastMemInt."Value 2":=0;
                                PastMemInt."Value 3":=0;
                                PastMemInt.Insert();
                            END;
                            IF Job."Job Type AT" = Job."Job Type AT"::Periodical THEN PastMemInt."Value 1"+=1;
                            IF Job."Job Type AT" = Job."Job Type AT"::"One Off" THEN PastMemInt."Value 2"+=1;
                            PastMemInt."Value 3"+=ReturnsTotalAmount(PastDateFilter1, PastDateFilter2);
                            PastMemInt.Modify();
                        END;
                    end;
                    trigger OnPreDataItem()
                    begin
                        //<019
                        IF "Dimension Value"."Split Dimension" THEN Job.SETRANGE("Global Dimension 2 Code", "Dimension Value 2".Code); //019>
                        //019>
                        JobSetup.Get();
                    end;
                }
                dataitem("Integer"; Integer)
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                    column(COMPANYNAME; COMPANYNAME)
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PAGENO)
                    {
                    }
                    column(JobFilter; JobFilter)
                    {
                    }
                    column(ReportDate; ReportDate)
                    {
                    }
                    column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                    {
                    }
                    column(USERID; USERID)
                    {
                    }
                    column(JobCodeCaption; Text001)
                    {
                    }
                    column(JobDescriptionCaption; Text002)
                    {
                    }
                    column(CustomerCodeCaption; Text003)
                    {
                    }
                    column(CustomerDescriptionCaption; Text004)
                    {
                    }
                    column(NetRevenueCaption; Text005)
                    {
                    }
                    column(TextTotal; TextTotal)
                    {
                    }
                    column(OneOffCaption; OneOffCaptionLbl)
                    {
                    }
                    column(ContinuoCaption; ContinuoCaptionLbl)
                    {
                    }
                    column(CodOfficeCaption; CodOfficeCaptionLbl)
                    {
                    }
                    column(RepName; CurrentRep)
                    {
                    }
                    column(OfficeCode; MemInt."Cod 1")
                    {
                    }
                    column(JobDescription; MemInt.Txt1)
                    {
                    }
                    column(CustomerCode; MemInt."Cod 2")
                    {
                    }
                    column(NetRevenue; MemInt."Value 3")
                    {
                    }
                    column(CodDepart; MemInt."Cod 3")
                    {
                    }
                    column("Año"; Year)
                    {
                    }
                    column(JobsTotal; Total)
                    {
                    }
                    column(PastOfficeCode; PastMemInt."Cod 1")
                    {
                    }
                    column(PastJobDescription; PastMemInt.Txt1)
                    {
                    }
                    column(PastCustomerCode; PastMemInt."Cod 2")
                    {
                    }
                    column(PastNetRevenue; PastMemInt."Value 3")
                    {
                    }
                    column(PastCodDepart; PastMemInt."Cod 3")
                    {
                    }
                    column("PastAño"; PastYear)
                    {
                    }
                    column(PastJobsTotal; PastTotal)
                    {
                    }
                    column(MoreYears; MoreYears)
                    {
                    }
                    column(PcjeContinuousNum; ROUND(PcjeContinuousNum, 1))
                    {
                    }
                    column(PcjeOneOffNum; ROUND(PcjeOneOffNum, 1))
                    {
                    }
                    column(PcjePastContinuousNum; ROUND(PcjePastContinuousNum, 1))
                    {
                    }
                    column(PcjePastOneOffNum; ROUND(PcjePastOneOffNum, 1))
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF Number > 1 THEN IF(MemInt.Next() = 0)THEN BEGIN
                                MemInt.Init();
                                BooleanPresent:=FALSE;
                            END;
                        IF MoreYears THEN BEGIN
                            IF Number > 1 THEN IF(PastMemInt.Next() = 0)THEN BEGIN
                                    PastMemInt.Init();
                                    BooleanPast:=FALSE;
                                END;
                        END;
                        IF(BooleanPast = FALSE) AND (BooleanPresent = FALSE)THEN CurrReport.Break();
                        ContadorRegistros+=1;
                        IF ContadorRegistros > RankingNo THEN CurrReport.Break();
                        Total+=MemInt."Value 3";
                        TotalNum+=MemInt."Value 2" + MemInt."Value 1";
                        ContinuousNum+=MemInt."Value 1";
                        OneOffNum+=MemInt."Value 2";
                        IF TotalNum <> 0 THEN BEGIN
                            PcjeOneOffNum:=(OneOffNum / TotalNum) * 100;
                            PcjeContinuousNum:=(ContinuousNum / TotalNum) * 100;
                        END;
                        IF MoreYears THEN BEGIN
                            PastTotal+=PastMemInt."Value 3";
                            PastTotalNum+=PastMemInt."Value 2" + PastMemInt."Value 1";
                            PastContinuousNum+=PastMemInt."Value 1";
                            PastOneOffNum+=PastMemInt."Value 2";
                            IF PastTotalNum <> 0 THEN BEGIN
                                PcjePastOneOffNum:=(PastOneOffNum / PastTotalNum) * 100;
                                PcjePastContinuousNum:=(PastContinuousNum / PastTotalNum) * 100;
                            END;
                        END;
                        //Rellenamos Excel
                        IF CreateExcel THEN BEGIN
                            Fila+=1;
                            CreateExcelLines;
                        END;
                    end;
                    trigger OnPostDataItem()
                    begin
                        MemInt.DeleteAll();
                        MemInt.Reset();
                        PastMemInt.DeleteAll();
                        PastMemInt.Reset();
                        //Rellenamos Excel
                        IF(CreateExcel = TRUE) AND (HayDatos = TRUE)THEN BEGIN
                            Fila+=1;
                            CreateExcelTotals;
                        END;
                    end;
                    trigger OnPreDataItem()
                    begin
                        Fila:=6;
                        BooleanPresent:=TRUE;
                        IF MoreYears THEN BooleanPast:=TRUE
                        ELSE
                            BooleanPast:=FALSE;
                        RankingNo:="Dimension Value"."No. of Ranking Entries";
                        ContadorRegistros:=0;
                        OneOffNum:=0;
                        ContinuousNum:=0;
                        TotalNum:=0;
                        PastOneOffNum:=0;
                        PastContinuousNum:=0;
                        PastTotalNum:=0;
                        PcjeContinuousNum:=0;
                        PcjeOneOffNum:=0;
                        PcjePastContinuousNum:=0;
                        PcjePastOneOffNum:=0;
                        Total:=0;
                        PastTotal:=0;
                        //Año
                        MemInt.Reset();
                        MemInt.SETCURRENTKEY(MemInt."Value 3");
                        MemInt.SETFILTER("Value 3", '>0');
                        MemInt.ASCENDING(FALSE);
                        IF NOT MemInt.FindFirst()then BEGIN
                            BooleanPresent:=FALSE;
                            MemInt.Init();
                        END;
                        //Año Pasado
                        IF MoreYears THEN BEGIN
                            PastMemInt.Reset();
                            PastMemInt.SETCURRENTKEY(PastMemInt."Value 3");
                            PastMemInt.SETFILTER("Value 3", '>0');
                            PastMemInt.ASCENDING(FALSE);
                            IF NOT PastMemInt.FindFirst()then BEGIN
                                BooleanPast:=FALSE;
                                PastMemInt.Init();
                            END;
                        END;
                        HayDatos:=TRUE;
                        IF(BooleanPast = FALSE) AND (BooleanPresent = FALSE)THEN BEGIN
                            HayDatos:=FALSE;
                            CurrReport.Break();
                        END;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    //<019
                    IF "Dimension Value"."Split Dimension" = FALSE THEN IF counter > 1 THEN CurrReport.Break();
                    counter+=1;
                    //019>
                    //<019
                    //W.UPDATE(1, "Business Office AT".Code);
                    W.UPDATE(1, "Dimension Value".Code);
                    //Excel
                    IF CreateExcel THEN BEGIN
                        TempExcelBuffer.DeleteAll();
                        EnterCell(1, 1, CurrentRep, TRUE, FALSE, FALSE);
                        EnterCell(2, 1, CodOfficeCaptionLbl, FALSE, FALSE, FALSE);
                        //EnterCell(2, 2, "Business Office AT".Code, TRUE, FALSE, FALSE);
                        //<019
                        IF "Dimension Value"."Split Dimension" THEN EnterCell(2, 2, "Dimension Value".Code + ' ' + "Dimension Value 2".Name, TRUE, FALSE, FALSE)
                        ELSE
                            EnterCell(2, 2, "Dimension Value".Code, TRUE, FALSE, FALSE);
                        //019>
                        EnterCell(3, 1, JobFilter, FALSE, FALSE, FALSE);
                        EnterCell(5, 2, YearCaptionLbl, TRUE, FALSE, FALSE);
                        EnterCell(5, 3, UPPERCASE(FORMAT(Year)), TRUE, FALSE, FALSE);
                        EnterCell(6, 1, Text003, TRUE, FALSE, FALSE);
                        EnterCell(6, 2, Text004, TRUE, FALSE, FALSE);
                        EnterCell(6, 3, Text005, TRUE, FALSE, FALSE);
                        IF MoreYears THEN BEGIN
                            EnterCell(5, 6, YearCaptionLbl, TRUE, FALSE, FALSE);
                            EnterCell(5, 7, UPPERCASE(FORMAT(PastYear)), TRUE, FALSE, FALSE);
                            EnterCell(6, 5, Text003, TRUE, FALSE, FALSE);
                            EnterCell(6, 6, Text004, TRUE, FALSE, FALSE);
                            EnterCell(6, 7, Text005, TRUE, FALSE, FALSE);
                        END;
                    END;
                //019>
                end;
                trigger OnPreDataItem()
                begin
                    //<019
                    MemInt.DeleteAll();
                    PastMemInt.DeleteAll();
                    counter:=1;
                //019>
                end;
            }
            trigger OnAfterGetRecord()
            begin
                W.UPDATE(1, "Dimension Value".Code);
            end;
            trigger OnPreDataItem()
            begin
                IF CreateExcel THEN BEGIN
                    TempExcelBuffer.DeleteAll();
                    CLEAR(TempExcelBuffer);
                //TempExcelBuffer.CreateBookWOSheets;
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
                group(Options)
                {
                    Caption = 'Options';

                    field(CreateExcel; CreateExcel)
                    {
                        ToolTip = 'Export to Excel';
                        ApplicationArea = All;
                        Caption = 'Export to Excel';
                    }
                    field(MoreYears; MoreYears)
                    {
                        ToolTip = 'Calculate previous year';
                        ApplicationArea = All;
                        Caption = 'Calculate previous year';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            RankingNo:=10;
            MoreYears:=FALSE;
        end;
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        W.Close();
        IF CreateExcel THEN BEGIN
            TempExcelBuffer.OpenExcel;
        //TempExcelBuffer.GiveUserControl;
        END;
    end;
    trigger OnPreReport()
    begin
        //Comprovamos que las fechas introducidas sean correctas con la función checkDate
        CheckDate;
        CalcFilters;
        JobFilter:=Job.GETFILTERS;
        ReportDate:=STRSUBSTNO(Text006, WorkDate());
        W.OPEN('Oficina #1######################\' + 'Cliente #2###########');
    end;
    var JobSetup: Record 315;
    Company: Record Company;
    MemInt: Record MemIntFra temporary;
    PastMemInt: Record MemIntFra temporary;
    Total: Decimal;
    PastTotal: Decimal;
    Text001: Label 'No.';
    Text002: Label 'Description';
    Text003: Label 'Customer';
    Text004: Label 'Name';
    Text005: Label 'Net Revenue';
    JobFilter: Text[1024];
    Text006: Label 'Report Date %1';
    CurrReport_TitleLbl: Label 'Net Revenue Ranking';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    ReportDate: Text[50];
    TextTotal: Label 'Total';
    CurrentRep: Label 'Net Revenue Ranking by Dept.';
    SumaYSigueH: Label 'Transheader:';
    SumaYSigueF: Label 'Transfooter:';
    Error001: Label 'Rank must be greater than 0.';
    RankingNo: Integer;
    ContadorRegistros: Integer;
    W: Dialog;
    Error002: Label 'The date filter can only include two different years.';
    Error003: Label 'Date filter is requiered!';
    Filter1: Text[100];
    Filter2: Text[100];
    Date1: Date;
    Date2: Date;
    pos: Integer;
    Error004: Label 'The filter must be of type "Date1..Date2"';
    SecondYear: Integer;
    FirstYear: Integer;
    MoreYears: Boolean;
    DateFilter1: Date;
    DateFilter2: Date;
    PastDateFilter1: Date;
    PastDateFilter2: Date;
    PastYear: Integer;
    Year: Integer;
    BooleanPast: Boolean;
    BooleanPresent: Boolean;
    ContinuousNum: Decimal;
    OneOffNum: Decimal;
    TotalNum: Decimal;
    PcjeContinuousNum: Decimal;
    PcjeOneOffNum: Decimal;
    PastContinuousNum: Decimal;
    PastOneOffNum: Decimal;
    PastTotalNum: Decimal;
    PcjePastContinuousNum: Decimal;
    PcjePastOneOffNum: Decimal;
    CreateExcel: Boolean;
    TempExcelBuffer: Record 370 temporary;
    Fila: Integer;
    FileCreated: Boolean;
    FileName: Text;
    FileManagement: Codeunit "File Management";
    FileNameServer: Text;
    HayDatos: Boolean;
    OneOffCaptionLbl: Label 'One Off';
    ContinuoCaptionLbl: Label 'Continuous';
    CodOfficeCaptionLbl: Label 'Office Code';
    YearCaptionLbl: Label 'Year';
    Error005: Label 'You can only enter dates of the same year (Ex: 01012016..31012016).';
    counter: Integer;
    CustPriceGroup: Record 6;
    procedure ReturnsTotalAmount(FromDateP: Date; ToDateP: Date)Valor: Decimal var
        xGLEntry: Record 17;
        data: Text;
    begin
        CLEAR(Valor);
        Company.Reset();
        IF Company.FindFirst()then REPEAT xGLEntry.Reset();
                xGLEntry.SETCURRENTKEY("G/L Account No.", "Job No.", "Posting Date");
                xGLEntry.SETRANGE("Job No.", Job."No.");
                xGLEntry.SETFILTER("G/L Account No.", JobSetup."G/L Accounts Rep. Filter AT");
                xGLEntry.SETRANGE(xGLEntry."Posting Date", FromDateP, ToDateP);
                xGLEntry.CHANGECOMPANY(Company.Name);
                xGLEntry.CALCSUMS(Amount);
                Valor-=xGLEntry.Amount;
            UNTIL Company.Next() = 0;
        EXIT(Valor);
    end;
    local procedure CheckDate()
    begin
        CLEAR(Filter1);
        CLEAR(Filter2);
        CLEAR(pos);
        //COMPROVEM QUE HI HAGI FILTRE
        IF Job.GETFILTER("Posting Date Filter") = '' THEN ERROR(Error003);
        //SEPAREM EL FILTRE EN ELS DOS ANYS.
        Filter1:=Job.GETFILTER("Posting Date Filter");
        pos:=STRPOS(Filter1, '..');
        IF pos = 0 THEN ERROR(Error004);
        IF pos > 0 THEN BEGIN
            Filter2:=COPYSTR(Filter1, pos + 2);
            Filter1:=COPYSTR(Filter1, 1, pos - 1);
        END;
        EVALUATE(Date2, Filter2);
        EVALUATE(Date1, Filter1);
        //Comprovem que solament pertanyi a DOS anys diferents.
        FirstYear:=DATE2DMY(Date1, 3);
        SecondYear:=DATE2DMY(Date2, 3);
        IF NOT((FirstYear - SecondYear) = 0)THEN ERROR(Error005);
    end;
    local procedure CalcFilters()
    begin
        CLEAR(DateFilter1);
        CLEAR(DateFilter2);
        CLEAR(PastDateFilter1);
        CLEAR(PastDateFilter2);
        IF Date1 < Date2 THEN BEGIN
            DateFilter1:=Date1;
            DateFilter2:=Date2;
            IF MoreYears THEN BEGIN
                PastDateFilter1:=CALCDATE('<-1Y>', Date1);
                PastDateFilter2:=CALCDATE('<-1Y>', Date2);
            END;
        END
        ELSE
        BEGIN
            DateFilter1:=Date2;
            DateFilter2:=Date1;
            IF MoreYears THEN BEGIN
                PastDateFilter1:=CALCDATE('<-1Y>', Date2);
                PastDateFilter2:=CALCDATE('<-1Y>', Date1);
            END;
        END;
        Year:=FirstYear;
        IF MoreYears THEN PastYear:=FirstYear - 1;
    end;
    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text":=CellValue;
        TempExcelBuffer.Formula:='';
        TempExcelBuffer.Bold:=Bold;
        TempExcelBuffer.Italic:=Italic;
        TempExcelBuffer.Underline:=UnderLine;
        TempExcelBuffer.Insert();
    end;
    local procedure CreateExcelLines()
    begin
        IF CreateExcel THEN BEGIN
            // Año Actual - Cust. Code
            IF MemInt.Txt1 <> '' THEN EnterCell(Fila, 1, MemInt."Cod 2", FALSE, FALSE, FALSE)
            ELSE
                EnterCell(Fila, 1, '', FALSE, FALSE, FALSE);
            // Año Actual - Name
            EnterCell(Fila, 2, MemInt.Txt1, FALSE, FALSE, FALSE);
            // Año Actual - Name
            EnterCell(Fila, 3, FormatNumber(MemInt."Value 3", 2), FALSE, FALSE, FALSE);
            IF MoreYears THEN BEGIN
                // Año Anterior - Cust. Code
                IF PastMemInt.Txt1 <> '' THEN EnterCell(Fila, 5, PastMemInt."Cod 2", FALSE, FALSE, FALSE)
                ELSE
                    EnterCell(Fila, 5, '', FALSE, FALSE, FALSE);
                // Año Anterior - Name
                EnterCell(Fila, 6, PastMemInt.Txt1, FALSE, FALSE, FALSE);
                // Año Anterior - Name
                EnterCell(Fila, 7, FormatNumber(PastMemInt."Value 3", 2), FALSE, FALSE, FALSE);
            END;
        END;
    end;
    local procedure CreateExcelTotals()
    begin
        IF CreateExcel THEN BEGIN
            // Año Actual - Total
            EnterCell(Fila + 1, 2, TextTotal, TRUE, FALSE, FALSE);
            EnterCell(Fila + 1, 3, FormatNumber(Total, 2), TRUE, FALSE, FALSE);
            // Año Actual - Continuados
            EnterCell(Fila + 2, 2, ContinuoCaptionLbl, TRUE, FALSE, FALSE);
            EnterCell(Fila + 2, 3, FormatNumber(PcjeContinuousNum, 0) + '%', TRUE, FALSE, FALSE);
            // Año Actual - Puntuales
            EnterCell(Fila + 3, 2, OneOffCaptionLbl, TRUE, FALSE, FALSE);
            EnterCell(Fila + 3, 3, FormatNumber(PcjeOneOffNum, 0) + '%', FALSE, FALSE, FALSE);
            IF MoreYears THEN BEGIN
                // Año Actual - Total
                EnterCell(Fila + 1, 6, TextTotal, TRUE, FALSE, FALSE);
                EnterCell(Fila + 1, 7, FormatNumber(PastTotal, 2), TRUE, FALSE, FALSE);
                // Año Actual - Continuados
                EnterCell(Fila + 2, 6, ContinuoCaptionLbl, TRUE, FALSE, FALSE);
                EnterCell(Fila + 2, 7, FormatNumber(PcjePastContinuousNum, 0) + '%', TRUE, FALSE, FALSE);
                // Año Actual - Puntuales
                EnterCell(Fila + 3, 6, OneOffCaptionLbl, TRUE, FALSE, FALSE);
                EnterCell(Fila + 3, 7, FormatNumber(PcjePastOneOffNum, 0) + '%', FALSE, FALSE, FALSE);
            END;
            //Crear excel o sheet.
            IF NOT FileCreated THEN BEGIN
                //FileName := FileManagement.ServerTempFileName('xlsx');
                IF "Dimension Value"."Split Dimension" THEN TempExcelBuffer.CreateNewBook("Dimension Value".Code + ' ' + "Dimension Value 2".Code)
                ELSE
                    TempExcelBuffer.CreateNewBook("Dimension Value".Code);
                FileCreated:=TRUE;
                IF "Dimension Value"."Split Dimension" THEN TempExcelBuffer.WriteSheet("Dimension Value".Code + ' ' + "Dimension Value 2".Code, COMPANYNAME, USERID)
                ELSE
                    TempExcelBuffer.WriteSheet("Dimension Value".Code, COMPANYNAME, USERID);
                TempExcelBuffer.CloseBook();
            END
            ELSE
            BEGIN
                TempExcelBuffer.ActiveNewSheet(TRUE, FileName);
                IF "Dimension Value"."Split Dimension" THEN TempExcelBuffer.WriteSheet("Dimension Value".Code + ' ' + "Dimension Value 2".Code, COMPANYNAME, USERID)
                ELSE
                    TempExcelBuffer.WriteSheet("Dimension Value".Code, COMPANYNAME, USERID);
                TempExcelBuffer.CloseBook();
            END;
        END;
    end;
    local procedure FormatNumber(Q: Decimal; Decim: Integer)T: Text var
        Text012: Label '<Precision,%1><Standard Format,0>';
    begin
        //Función para dar formato a las Quantitys
        T:=FORMAT(Q, 0, STRSUBSTNO(Text012, FORMAT(Decim)));
        IF Q = 0 THEN T:='';
    end;
}
