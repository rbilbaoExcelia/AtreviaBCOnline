report 52045 "Net Revenue Ranking"
{
    // 141 OS.RM 07/06/2017 FIN.011 Informe Ranking Facturación Neta
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/NetRevenueRanking.rdlc';
    Caption = 'Net Revenue Ranking';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Job;167)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Global Dimension 1 Code", "Posting Date Filter";

            trigger OnAfterGetRecord()
            begin
                MemInt.Init();
                MemInt."Cod 1":=Job."No.";
                IF NOT MemInt.Find()then BEGIN
                    MemInt.Txt1:=Job.Description;
                    MemInt."Cod 2":=Job."Bill-to Customer No.";
                    MemInt.Txt2:=Job."Bill-to Name";
                    MemInt."Value 3":=0; //Net Revenue
                    //FOR I:=  1 TO 12 DO
                    //  IF StartingDate[1, I] < WORKDATE THEN
                    //    MemInt."Value 3" += ReturnsAmount(StartingDate[1, I],StartingDate[2, I]);
                    MemInt."Value 3"+=ReturnsTotalAmount;
                    Total+=MemInt."Value 3";
                    IF MemInt."Value 3" <> 0 THEN MemInt.INSERT END;
            end;
            trigger OnPreDataItem()
            begin
                JobSetup.Get();
                //FOR I := 1 TO 12 DO BEGIN
                //  StartingDate[1, I] := DMY2DATE(1,I, DATE2DMY(WorkDate(), 3));
                //  StartingDate[2, I] := CALCDATE('<CM>', StartingDate[1, I]);
                //END;
                MemInt.DeleteAll();
                Total:=0;
            end;
        }
        dataitem("<Integer>"; Integer)
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
            column(JobsTotal; Total)
            {
            }
            column(TextTotal; TextTotal)
            {
            }
            column(RepName; CurrentRep)
            {
            }
            column(JobCode; MemInt."Cod 1")
            {
            }
            column(JobDescription; MemInt.Txt1)
            {
            }
            column(CustomerCode; MemInt."Cod 2")
            {
            }
            column(CustomerDescription; MemInt.Txt2)
            {
            }
            column(NetRevenue; MemInt."Value 3")
            {
            }
            column(sumaysigueh; SumaYSigueH)
            {
            }
            column(sumaysiguef; SumaYSigueF)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number > 1 THEN IF(MemInt.Next() = 0)THEN CurrReport.Break();
                ContadorRegistros+=1;
                IF ContadorRegistros > RankingNo THEN CurrReport.Break();
                MemInt.Find();
            end;
            trigger OnPostDataItem()
            begin
                MemInt.DeleteAll();
                MemInt.Reset();
            end;
            trigger OnPreDataItem()
            begin
                MemInt.Reset();
                MemInt.SETCURRENTKEY(MemInt."Value 3");
                MemInt.ASCENDING(FALSE);
                IF NOT MemInt.FIND('-')THEN CurrReport.Break();
                ContadorRegistros:=0;
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

                    field(Ranking; RankingNo)
                    {
                        ToolTip = 'Ranking';
                        ApplicationArea = All;
                        Caption = 'Ranking No.';

                        trigger OnValidate()
                        begin
                            IF RankingNo < 1 THEN BEGIN
                                MESSAGE(Error001);
                                RankingNo:=10;
                            END;
                        end;
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
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        JobFilter:=Job.GETFILTERS;
        ReportDate:=STRSUBSTNO(Text006, WorkDate());
    end;
    var JobSetup: Record 315;
    Company: Record Company;
    StartingDate: array[2, 12]of Date;
    I: Integer;
    Mes: array[12]of Text[30];
    V: array[1, 12]of Decimal;
    MemInt: Record MemIntFra temporary;
    Total: Decimal;
    "------------": Integer;
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
    CurrentRep: Label 'Net Revenue Ranking';
    SumaYSigueH: Label 'Transheader:';
    SumaYSigueF: Label 'Transfooter:';
    Error001: Label 'Rank must be greater than 0.';
    RankingNo: Integer;
    ContadorRegistros: Integer;
    procedure ReturnsAmount(FromDateP: Date; ToDateP: Date)Valor: Decimal var
        xGLEntry: Record 17;
    begin
        CLEAR(Valor);
        Company.Reset();
        IF Company.FIND('-')THEN REPEAT xGLEntry.Reset();
                xGLEntry.SETCURRENTKEY("G/L Account No.", "Job No.", "Posting Date");
                xGLEntry.SETRANGE(xGLEntry."Job No.", Job."No.");
                xGLEntry.SETFILTER(xGLEntry."G/L Account No.", JobSetup."G/L Accounts Rep. Filter AT");
                xGLEntry.SETRANGE(xGLEntry."Posting Date", FromDateP, ToDateP);
                xGLEntry.CHANGECOMPANY(Company.Name);
                IF xGLEntry.FIND('-')THEN BEGIN
                    //MESSAGE(Company.Name);
                    REPEAT Valor-=xGLEntry.Amount;
                    UNTIL xGLEntry.Next() = 0;
                END;
            UNTIL Company.Next() = 0;
        EXIT(Valor);
    end;
    procedure ReturnsTotalAmount()Valor: Decimal var
        xGLEntry: Record 17;
        data: Text;
    begin
        CLEAR(Valor);
        Company.Reset();
        IF Company.FIND('-')THEN REPEAT xGLEntry.Reset();
                xGLEntry.SETCURRENTKEY("G/L Account No.", "Job No.", "Posting Date");
                xGLEntry.SETRANGE("Job No.", Job."No.");
                Job.COPYFILTER("Global Dimension 1 Code", xGLEntry."Global Dimension 1 Code");
                //xGLEntry.SETRANGE("Global Dimension 1 Code",Job."Global Dimension 1 Code");
                xGLEntry.SETFILTER("G/L Account No.", JobSetup."G/L Accounts Rep. Filter AT");
                data:=Job.GETFILTER("Posting Date Filter");
                xGLEntry.SETFILTER("Posting Date", data);
                xGLEntry.CHANGECOMPANY(Company.Name);
                xGLEntry.CALCSUMS(Amount);
                Valor-=xGLEntry.Amount;
            UNTIL Company.Next() = 0;
        EXIT(Valor);
    end;
}
