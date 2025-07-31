report 52046 "Net Revenue Ranking by Job"
{
    // 142 OS.RM  07/06/2017  FIN.011   Informe Ranking Rentabilidad Proyecto
    RDLCLayout = './src/report/layouts/NetRevenueRankingbyJob.rdlc';
    Caption = 'Net Revenue Ranking by Job';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Job;167)
        {
            DataItemTableView = SORTING("No.")WHERE("Job Type AT"=FILTER("One Off"|Periodical));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Global Dimension 1 Code", "Posting Date Filter";

            dataitem(JobLedgEntry;169)
            {
                DataItemLink = "Job No."=FIELD("No."), "Posting Date"=FIELD("Posting Date Filter");
                DataItemTableView = SORTING("Job No.", "Posting Date")ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    AccountNo:='';
                    IF JobLedgEntry.Type = JobLedgEntry.Type::"G/L Account" THEN BEGIN
                        GLAccount.GET(JobLedgEntry."No.");
                        IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Balance Sheet" THEN CurrReport.Skip();
                    END;
                    IF(JobLedgEntry.Type = JobLedgEntry.Type::Resource) AND (JobLedgEntry."Entry Type" = JobLedgEntry."Entry Type"::Usage)THEN BEGIN
                        MemInt."Cod 1":='0';
                        MemInt."Cod 2":=JobLedgEntry."No.";
                        IF NOT MemInt.Find()then MemInt.Init();
                        MemInt."Value 1"+=JobLedgEntry.Quantity;
                        MemInt."Value 2"+=-JobLedgEntry."Total Cost";
                        //MemInt."Value 3" += JobLedgEntry."Total Price";
                        IF NOT MemInt.Insert()then MemInt.Modify();
                        EXIT;
                    END;
                    IF JobLedgEntry.Type = JobLedgEntry.Type::"G/L Account" THEN BEGIN
                        IF GLAccount.GET(COPYSTR(JobLedgEntry."No.", 1, 4))THEN AccountNo:=COPYSTR(JobLedgEntry."No.", 1, 4)
                        ELSE
                        BEGIN
                            IF GLAccount.GET(COPYSTR(JobLedgEntry."No.", 1, 3))THEN AccountNo:=COPYSTR(JobLedgEntry."No.", 1, 3);
                        END;
                    END;
                    MemInt."Cod 1":=FORMAT(JobLedgEntry.Type + 1);
                    IF AccountNo = '' THEN MemInt."Cod 2":=JobLedgEntry."No."
                    ELSE
                        MemInt."Cod 2":=AccountNo;
                    IF NOT MemInt.Find()then MemInt.Init();
                    IF JobLedgEntry."Entry Type" = JobLedgEntry."Entry Type"::Usage THEN MemInt."Value 2"+=-JobLedgEntry."Total Cost"
                    ELSE
                        MemInt."Value 3"+=-JobLedgEntry."Total Price";
                    IF NOT MemInt.Insert()then MemInt.Modify();
                end;
            }
            dataitem("Integer"; Integer)
            {
                DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN IF MemInt.Next() = 0 THEN CurrReport.Break();
                    //IF NOT MemInt.FIND('-') THEN
                    //CurrReport.Break();
                    CLEAR(Resource);
                    CLEAR(Item);
                    CLEAR(GLAccount);
                    IF MemInt."Cod 1" = '0' THEN BEGIN
                        IF NOT Resource.GET(MemInt."Cod 2")THEN CLEAR(Resource);
                        V[1]+=MemInt."Value 1";
                        V[3]+=MemInt."Value 2";
                        V[5]+=MemInt."Value 3";
                        //<021
                        CLEAR(Vaux);
                        Vaux[1]:=MemInt."Value 1";
                        Vaux[3]:=MemInt."Value 2";
                        Vaux[5]:=MemInt."Value 3";
                        //  IF V[1] <> 0 THEN BEGIN
                        //    V[2] := V[3] / V[1];
                        //    V[4] := V[5] / V[1];
                        //  END;
                        IF Vaux[1] <> 0 THEN BEGIN
                            V[2]+=Vaux[3] / Vaux[1];
                            V[4]+=Vaux[5] / Vaux[1];
                        END;
                    //021>
                    END
                    ELSE
                    BEGIN
                        TxtName:='';
                        CASE MemInt."Cod 1" OF '1': IF Resource.GET(MemInt."Cod 2")THEN TxtName:=Resource.Name;
                        '2': IF Item.GET(MemInt."Cod 2")THEN TxtName:=Item.Description;
                        '3': IF GLAccount.GET(MemInt."Cod 2")THEN TxtName:=GLAccount.Name;
                        END;
                        //<021
                        T[1]+=MemInt."Value 1";
                        T[3]+=MemInt."Value 2";
                        T[5]+=MemInt."Value 3";
                        CLEAR(Taux);
                        Taux[1]:=MemInt."Value 1";
                        Taux[3]:=MemInt."Value 2";
                        Taux[5]:=MemInt."Value 3";
                        IF Taux[1] <> 0 THEN BEGIN
                            T[2]+=Taux[3] / Taux[1];
                            T[4]+=Taux[5] / Taux[1];
                        END;
                    //021>
                    END;
                // MemIntRanking.Init();
                // MemIntRanking."Cod.1" := Job."No.";
                //
                // IF NOT MemIntRanking.Find() then
                //   MemIntRanking.Insert();
                //
                // MemIntRanking."Value 3" := T[5] + T[3] + V[5] + V[3];
                // MemIntRanking."Value 4" := T[5]+T[3];
                // MemIntRanking."Value 5" := V[1];
                // MemIntRanking.Txt1 := Job.Description + Job."Description 2";
                // MemIntRanking.Modify();
                end;
                trigger OnPostDataItem()
                begin
                    MemIntRanking.Init();
                    MemIntRanking."Cod 1":=Job."No.";
                    IF NOT MemIntRanking.Find()then MemIntRanking.Insert();
                    MemIntRanking."Value 3":=T[5] + T[3] + V[5] + V[3];
                    MemIntRanking."Value 4":=T[5] + T[3];
                    MemIntRanking."Value 5":=V[1];
                    MemIntRanking.Txt1:=Job.Description + Job."Description 2";
                    MemIntRanking.Modify();
                end;
                trigger OnPreDataItem()
                begin
                    MemInt.Reset();
                    IF NOT MemInt.FindFirst()then CurrReport.Break();
                    No+=1;
                    IF No > 1 THEN CurrReport.NEWPAGE;
                //CurrReport.CREATETOTALS(V);
                //CurrReport.CREATETOTALS(T);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                MemInt.DeleteAll();
                CLEAR(T);
                CLEAR(V);
            end;
        }
        dataitem(Show; Integer)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

            column(Filtros; Job.GETFILTERS)
            {
            }
            column(JobCode; Jobaux."No.")
            {
            }
            column(JobNo; MemIntRanking."Cod 1")
            {
            }
            column(JobDescr; MemIntRanking.Txt1)
            {
            }
            column(JobArea; Jobaux."Global Dimension 1 Code")
            {
            }
            column(JobDept; Jobaux."Global Dimension 2 Code")
            {
            }
            column(JobType; FORMAT(Jobaux."Job Type AT"))
            {
            }
            column(JobResp; Jobaux."Person Responsible")
            {
            }
            column(JobSector; Jobaux."Sector 1 AT")
            {
            }
            column(JobCustName; xCust.Name)
            {
            }
            column(JobCost; MemIntRanking."Value 5")
            {
            }
            column(JobGLResult; MemIntRanking."Value 4")
            {
            }
            column(JobNetResult; MemIntRanking."Value 3")
            {
            }
            column(JobNoCaption; JobNoCaption_Lbl)
            {
            }
            column(JobDescrCaption; JobDescrCaption_Lbl)
            {
            }
            column(JobAreaCaption; JobAreaCaption_Lbl)
            {
            }
            column(JobDeptCaption; JobDeptCaption_Lbl)
            {
            }
            column(JobTypeCaption; JobTypeCaption_Lbl)
            {
            }
            column(JobRespCaption; JobRespCaption_Lbl)
            {
            }
            column(JobSectorCaption; JobSectorCaption_Lbl)
            {
            }
            column(JobCustNameCaption; JobCustNameCaption_Lbl)
            {
            }
            column(JobCostCaption; JobCostCaption_Lbl)
            {
            }
            column(JobGLResultCaption; JobGLResultCaption_Lbl)
            {
            }
            column(JobNetResultCaption; JobNetResultCaption_Lbl)
            {
            }
            column(TitleCaption; TitleCaption)
            {
            }
            column(PageNoCaption; PageNoCaption)
            {
            }
            column(CompanyNameCaption; COMPANYNAME)
            {
            }
            column(TotalCaption; TotalCaption)
            {
            }
            column(SumaYSigueH; SumaYSigueH)
            {
            }
            column(SumaYSigueF; SumaYSigueF)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT MemIntRanking.FindFirst()then CurrReport.Break();
                END
                ELSE
                BEGIN
                    IF(MemIntRanking.Next() = 0)THEN CurrReport.Break();
                END;
                IF(MemIntRanking."Value 3" = 0) AND (MemIntRanking."Value 4" = 0)THEN BEGIN
                    CurrReport.Skip();
                END;
                //<021
                ContadorRegistros+=1;
                IF ContadorRegistros > RankingNo THEN CurrReport.Break();
                //021>
                IF NOT Jobaux.GET(MemIntRanking."Cod 1")THEN CLEAR(Jobaux);
                IF NOT xCust.GET(Jobaux."Bill-to Customer No.")THEN CLEAR(xCust);
                TotalRanking+=MemIntRanking."Value 3";
                IF CreateExcel THEN BEGIN
                    EnterCell(Row, 1, FORMAT(MemIntRanking."Cod 1"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 2, MemIntRanking.Txt1, FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 3, FORMAT(Jobaux."Global Dimension 1 Code"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 4, FORMAT(Jobaux."Global Dimension 2 Code"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 5, FORMAT(Jobaux."Job Type AT"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 6, FORMAT(Jobaux."Person Responsible"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 7, FORMAT(Jobaux."Sector 1 AT"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 8, xCust.Name + xCust."Name 2", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 9, FormatAmt(MemIntRanking."Value 5"), FALSE, FALSE, FALSE, '#.#0,00', 0);
                    EnterCell(Row, 10, FormatAmt(MemIntRanking."Value 4"), FALSE, FALSE, FALSE, '#.#0,00', 0);
                    EnterCell(Row, 11, FormatAmt(MemIntRanking."Value 3"), FALSE, FALSE, FALSE, '#.#0,00', 0);
                    Row+=1;
                END;
            end;
            trigger OnPostDataItem()
            begin
                IF CreateExcel THEN BEGIN
                    TempExcelBuffer.CreateNewBookAndOpenExcel('', 'Ranking Facturación Neta', 'Ranking Facturación Neta', FORMAT(WorkDate()), USERID);
                END;
            end;
            trigger OnPreDataItem()
            begin
                TempExcelBuffer.DeleteAll();
                CLEAR(TempExcelBuffer);
                CLEAR(TotalRanking);
                //TempExcelBuffer.CreateBook(FileName,SheetName);
                //<21
                ContadorRegistros:=0;
                //21>
                MemIntRanking.Reset();
                MemIntRanking.SETCURRENTKEY(MemIntRanking."Value 3");
                MemIntRanking.ASCENDING(FALSE);
                IF CreateExcel THEN BEGIN
                    EnterCell(1, 1, 'Ranking Rentabilidad Proyecto', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(2, 1, FORMAT(Job.GETFILTERS), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(4, 1, 'Nº proyecto', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 2, 'Descripción', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 3, 'Oficina', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 4, 'Departamento', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 5, 'Tipo proyecto', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 6, 'Responsable', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 7, 'Consultor', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 8, 'Nombre cliente', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 9, 'Coste/Horas', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 10, 'Resultado contable', TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 11, 'Resultado neto', TRUE, FALSE, FALSE, '', 1);
                END;
                Row:=5;
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
                        ToolTip = 'CreateExcel';
                        ApplicationArea = All;
                        Caption = 'Export to Excel';
                    }
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
    var MemInt: Record MemIntFra temporary;
    MemIntRanking: Record MemIntFra temporary;
    Item: Record 27;
    GLAccount: Record "G/L Account";
    Resource: Record 156;
    Vaux: array[5]of Decimal;
    V: array[5]of Decimal;
    TxtName: Text[50];
    T: array[5]of Decimal;
    Taux: array[5]of Decimal;
    No: Integer;
    AccountNo: Text[20];
    TotalRanking: Decimal;
    xCust: Record 18;
    Txt000: Label 'Results';
    TempExcelBuffer: Record 370 temporary;
    FileName: Text[250];
    SheetName: Text[250];
    CreateExcel: Boolean;
    Row: Integer;
    JobNoCaption_Lbl: Label 'Job Num.';
    JobDescrCaption_Lbl: Label 'Description';
    JobAreaCaption_Lbl: Label 'Geographic Area';
    JobDeptCaption_Lbl: Label 'Department';
    JobTypeCaption_Lbl: Label 'Job Type';
    JobRespCaption_Lbl: Label 'Person Responsible';
    JobSectorCaption_Lbl: Label 'Consultant';
    JobCustNameCaption_Lbl: Label 'Customer Name';
    JobCostCaption_Lbl: Label 'Cost/Hours';
    JobGLResultCaption_Lbl: Label 'Accounting Result';
    JobNetResultCaption_Lbl: Label 'Net Result';
    Jobaux: Record Job;
    ContadorRegistros: Integer;
    TitleCaption: Label 'Net Revenue Ranking by Job';
    PageNoCaption: Label 'Page No.';
    TotalCaption: Label 'Total';
    RankingNo: Integer;
    Error001: Label 'Rank must be greater than 0.';
    SumaYSigueH: Label 'Transheader:';
    SumaYSigueF: Label 'Transfooter:';
    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text":=CellValue;
        TempExcelBuffer.Formula:='';
        TempExcelBuffer.Bold:=Bold;
        TempExcelBuffer.Italic:=Italic;
        TempExcelBuffer.Underline:=UnderLine;
        TempExcelBuffer.NumberFormat:=NumberFormat;
        TempExcelBuffer."Cell Type":=CellType;
        TempExcelBuffer.Insert();
    end;
    procedure FormatAmt(Amt: Decimal): Text[250]begin
        IF Amt = 0 THEN EXIT('')
        ELSE
            EXIT(FORMAT(Amt));
    end;
}
