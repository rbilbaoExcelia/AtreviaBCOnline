report 52041 "Job Profitability Design"
{
    // 144 OS.RM  07/06/2017  FIN.011   Rentabilidad por Proyecto Diseño
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/JobProfitabilityDesign.rdlc';
    Caption = 'Job Profitability Design';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Job;167)
        {
            DataItemTableView = SORTING("No.")WHERE("Job Type AT"=FILTER(Periodical|"One Off"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Posting Date Filter", "Global Dimension 1 Code", "Global Dimension 2 Code";

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
            column(JobTypeCaption; Text007)
            {
            }
            column(PersonRespCaption; Text008)
            {
            }
            column(CurrReport_Title; CurrReport_TitleLbl)
            {
            }
            dataitem(JobLedgEntry;169)
            {
                DataItemLink = "Job No."=FIELD("No."), "Posting Date"=FIELD("Posting Date Filter");
                DataItemTableView = SORTING("Job No.", "Posting Date")ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    AccNo:='';
                    IF JobLedgEntry.Type = JobLedgEntry.Type::"G/L Account" THEN BEGIN
                        GLAccount.GET(JobLedgEntry."No.");
                        IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Balance Sheet" THEN EXIT;
                    END;
                    IF(JobLedgEntry.Type = JobLedgEntry.Type::Resource) AND (JobLedgEntry."Entry Type" = JobLedgEntry."Entry Type"::Usage)THEN BEGIN
                        IF NOT ValidateManager(JobLedgEntry."No.")THEN CurrReport.Skip();
                        MemInt.Init();
                        MemInt."Cod 1":='0';
                        MemInt."Cod 2":=JobLedgEntry."No.";
                        AccNo:=JobLedgEntry."No.";
                        IF NOT MemInt.Find()then MemInt.Insert();
                        MemInt."Value 1"+=JobLedgEntry.Quantity;
                        MemInt."Value 2"+=-JobLedgEntry."Total Cost (LCY)";
                        MemInt.Modify();
                        EXIT;
                    END;
                    IF JobLedgEntry.Type = JobLedgEntry.Type::"G/L Account" THEN BEGIN
                        MemInt."Cod 1":='1';
                        IF GLAccount.GET(COPYSTR(JobLedgEntry."No.", 1, 4))THEN //AccNo := GLAccount."Grouping Code";
 AccNo:=COPYSTR(JobLedgEntry."No.", 1, 4)
                        ELSE
                        BEGIN
                            IF GLAccount.GET(COPYSTR(JobLedgEntry."No.", 1, 3))THEN AccNo:=COPYSTR(JobLedgEntry."No.", 1, 3);
                        END;
                        IF NOT ValidateAccount(JobLedgEntry."No.")THEN CurrReport.Skip();
                    END;
                    // IF JobLedgEntry.Type = JobLedgEntry.Type::Item THEN
                    // IF Item.GET(JobLedgEntry."No.") THEN BEGIN
                    //   IF Item."Grouping Code" <> '' THEN
                    //      AccNo:= Item."Grouping Code"
                    //    ELSE
                    //      AccNo := JobLedgEntry."No.";
                    //   END;
                    MemInt.Init();
                    IF JobLedgEntry.Type = JobLedgEntry.Type::Item THEN MemInt."Cod 1":='2';
                    IF AccNo = '' THEN MemInt."Cod 2":=JobLedgEntry."No."
                    ELSE
                    BEGIN
                        MemInt."Cod 2":=AccNo END;
                    IF NOT MemInt.Find()then MemInt.Insert();
                    IF JobLedgEntry."Entry Type" = JobLedgEntry."Entry Type"::Usage THEN MemInt."Value 2"+=-JobLedgEntry."Total Cost (LCY)"
                    ELSE
                        MemInt."Value 3"+=-JobLedgEntry."Total Price";
                    MemInt.Modify();
                end;
            }
            dataitem("Integer"; Integer)
            {
                DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=CONST(1));

                dataitem(AllBuffer; Integer)
                {
                    DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                    column(JobCode; Job."No.")
                    {
                    }
                    column(JobDescr; Job.Description)
                    {
                    }
                    column(JobType; Job."Job Type AT")
                    {
                    }
                    column(JobResponsible; Job."Person Responsible")
                    {
                    }
                    column(JobCust; Job."Bill-to Customer No.")
                    {
                    }
                    column(JobCustDescr; Job."Bill-to Name")
                    {
                    }
                    column(JobNo; MemInt."Cod 2")
                    {
                    }
                    column(ResName; ResName)
                    {
                    }
                    column(MOTime; V[1])
                    {
                    }
                    column(MOCost; V[2])
                    {
                    }
                    column(MOImpCost; V[3])
                    {
                    }
                    column(MOPrice; V[4])
                    {
                    }
                    column(MOSales; V[5])
                    {
                    }
                    column(MOTimeCaption; MOTimeCaptionLbl)
                    {
                    }
                    column(MOCostCaption; MOCostCaptionLbl)
                    {
                    }
                    column(MOImpCostCaption; MOImpCostCaptionLbl)
                    {
                    }
                    column(MOPriceCaption; MOPriceCaptionLbl)
                    {
                    }
                    column(MOSalesCaption; MOSalesCationLbl)
                    {
                    }
                    column(MOResultsCaption; MOResultsCaptionLbl)
                    {
                    }
                    column(MOTotalsCaption; MOTotalsCaptionLbl)
                    {
                    }
                    column(GroupingCode; Job."No.")
                    {
                    }
                    column(GroupingDescr; AccNum)
                    {
                    }
                    column(GroupingCost; T[3])
                    {
                    }
                    column(GroupingSales; T[5])
                    {
                    }
                    column(GLTotalsCaption; GLTotalsCaptionLbl)
                    {
                    }
                    column(NETTotalsCaption; NETTotalsCaptionLbl)
                    {
                    }
                    column(LineType; LineType)
                    {
                    }
                    column(LineTotal; V[6])
                    {
                    }
                    column(HOLA; MemInt."Cod 1")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT MemInt.FindFirst()then CurrReport.Break();
                        END
                        ELSE IF MemInt.Next() = 0 THEN CurrReport.Break();
                        IF MemInt."Cod 1" = '2' THEN CurrReport.Skip();
                        IF MemInt."Cod 1" = '0' THEN BEGIN
                            LineType:=0;
                            IF NOT Resource.GET(MemInt."Cod 2")THEN Resource.Init();
                            ResName:=Resource.Name;
                            ResNum:=MemInt."Cod 2";
                            AccNum:='';
                        END
                        ELSE
                        BEGIN
                            LineType:=1;
                            IF NOT GLAccount.GET(MemInt."Cod 2")THEN CLEAR(GLAccount);
                            ResName:=GLAccount.Name;
                            ResNum:='';
                            AccNum:=MemInt."Cod 2";
                        END;
                        CLEAR(V);
                        V[1]:=MemInt."Value 1";
                        V[3]:=MemInt."Value 2";
                        V[5]:=MemInt."Value 3";
                        IF V[1] <> 0 THEN BEGIN
                            V[2]:=V[3] / V[1];
                            V[4]:=V[5] / V[1];
                        END;
                        V[6]:=V[5] + V[3];
                        MOTotalsCaptionLbl:=STRSUBSTNO(MOTotals, Job."No.");
                        GLTotalsCaptionLbl:=STRSUBSTNO(GLTotals, Job.Description);
                        NETTotalsCaptionLbl:=STRSUBSTNO(NETTotals, Job.Description);
                    end;
                    trigger OnPreDataItem()
                    begin
                        CurrReport.CREATETOTALS(V);
                        CurrReport.CREATETOTALS(T);
                    end;
                }
                trigger OnPreDataItem()
                begin
                    MemInt.Reset();
                    IF NOT MemInt.Find()then CurrReport.Break();
                    No+=1;
                    IF No > 1 THEN CurrReport.NEWPAGE;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                MemInt.Reset();
                MemInt.DeleteAll();
                CLEAR(V);
                CLEAR(T);
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

                    field(AccFilter; AccFilter)
                    {
                        ToolTip = 'Account Filter';
                        ApplicationArea = All;
                        Caption = 'Account Filter';
                    }
                    field(ResponsibleCode; ResponsibleCode)
                    {
                        ToolTip = 'Responsible Code';
                        ApplicationArea = All;
                        Caption = 'Responsible Filter';

                        trigger OnLookup(var Text: Text): Boolean begin
                            /*
                            xRes.Reset();
                            xResource.Reset();
                            xResource.FIND('-');
                            
                            REPEAT
                              IF xResource."Director/Supervisor" <> '' THEN BEGIN
                                IF xRes.GET(xResource."Director/Supervisor") THEN
                                  xRes.MARK(TRUE);
                              END;
                            UNTIL xResource.Next() = 0;
                            
                            xRes.MARKEDONLY(TRUE);
                            */
                            Getsupervisores;
                            IF NOT xRes.FIND('-')THEN EXIT;
                            IF PAGE.RUNMODAL(0, xRes) = ACTION::LookupOK THEN ResponsibleCode:=xRes."No.";
                        end;
                        trigger OnValidate()
                        begin
                            Getsupervisores;
                            xRes.SETFILTER("No.", ResponsibleCode);
                            IF NOT xRes.FIND('-')THEN ERROR('No existe supervisor');
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            AccFilter:='7058000003|6090000002';
            ResponsibleCode:='258';
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
    var Company: Record Company;
    MemInt: Record MemIntFra temporary;
    Item: Record 27;
    GLAccount: Record "G/L Account";
    Resource: Record 156;
    V: array[6]of Decimal;
    TxtName: Text;
    T: array[5]of Decimal;
    No: Integer;
    AccNo: Text;
    Txt50000: Label 'Results';
    ResNum: Code[50];
    AccNum: Text;
    AccFilter: Text[250];
    Resource1: Record 156;
    Resource2: Record 156;
    ResName: Text[50];
    LineType: Integer;
    MOTotalsCaptionLbl: Text[1024];
    GLTotalsCaptionLbl: Text[1024];
    NETTotalsCaptionLbl: Text[1024];
    "--------------": Integer;
    JobFilter: Text[1024];
    ReportDate: Text[50];
    Text001: Label 'No.';
    Text002: Label 'Description';
    Text003: Label 'Customer';
    Text004: Label 'Name';
    Text005: Label 'Net Revenue';
    Text006: Label 'Report Date %1';
    Text007: Label 'Job Type';
    Text008: Label 'Person Responsible';
    CurrReport_TitleLbl: Label 'Net Revenue Ranking';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    MOTimeCaptionLbl: Label 'Hours';
    MOCostCaptionLbl: Label 'P. Cost';
    MOImpCostCaptionLbl: Label 'Cost Amount';
    MOPriceCaptionLbl: Label 'P. Unit';
    MOSalesCationLbl: Label 'Sales Amount';
    MOResultsCaptionLbl: Label 'Result';
    MOTotals: Label 'PROJECT HOURS AND COST %1:';
    GLTotals: Label 'ACCOUNTING RESULT %1';
    NETTotals: Label 'NET RESULT %1:';
    xResource: Record 156;
    xRes: Record 156;
    ResponsibleCode: Code[20];
    local procedure ValidateAccount(AccountNo: Text[20]): Boolean var
        GLAccountL: Record "G/L Account";
    begin
        IF AccFilter = '' THEN EXIT(TRUE);
        GLAccountL.Reset();
        GLAccountL.SETFILTER(GLAccountL."No.", AccFilter);
        IF NOT GLAccountL.FindFirst()then EXIT(FALSE);
        REPEAT IF GLAccountL."No." = AccountNo THEN EXIT(TRUE);
        UNTIL GLAccountL.Next() = 0;
        EXIT(FALSE);
    end;
    local procedure ValidateManager(ResCode: Code[20]): Boolean var
        ResourceL: Record 156;
    begin
        IF ResponsibleCode = '' THEN EXIT(TRUE);
        ResourceL.GET(ResCode);
        IF ResourceL."Director/Supervisor AT" <> ResponsibleCode THEN EXIT(FALSE);
        EXIT(TRUE);
    end;
    local procedure Getsupervisores()
    begin
        xRes.Reset();
        xResource.Reset();
        xResource.FIND('-');
        REPEAT IF xResource."Director/Supervisor AT" <> '' THEN BEGIN
                IF xRes.GET(xResource."Director/Supervisor AT")THEN xRes.MARK(TRUE);
            END;
        UNTIL xResource.Next() = 0;
        xRes.MARKEDONLY(TRUE);
    end;
}
