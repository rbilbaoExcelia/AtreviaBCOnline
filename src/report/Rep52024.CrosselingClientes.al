report 52024 "Crosseling Clientes"
{
    // 151 OS.RM 07/06/2017 Crosseling Clientes
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/CrosselingClientes.rdlc';
    Caption = 'Crosseling Clientes';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Job;167)
        {
            DataItemTableView = SORTING("Bill-to Customer No.");
            RequestFilterFields = "Bill-to Customer No.", "Posting Date Filter", "Starting Date";

            trigger OnAfterGetRecord()
            begin
                W.UPDATE(1, "No.");
                DevuelveImporte;
            end;
            trigger OnPostDataItem()
            begin
                W.Close();
            end;
            trigger OnPreDataItem()
            begin
                MemInt.Reset();
                MemInt.DeleteAll();
                W.OPEN('Procesando proyecto #1#############');
                JobSetup.Get();
                JobSetup.TESTFIELD("G/L Accounts Rep. Filter AT");
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

            column(InformeCaption; InformeCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(CustomerCaptionLbl; CustomerCaptionLbl)
            {
            }
            column(NameCaptionLbl; NameCaptionLbl)
            {
            }
            column(JobCaptionLbl; JobCaptionLbl)
            {
            }
            column(DescriptionCaptionLbl; DescriptionCaptionLbl)
            {
            }
            column(DeptCaptionLbl; DeptCaptionLbl)
            {
            }
            column(OfficeCaptionLbl; OfficeCaptionLbl)
            {
            }
            column(DepFactCaptionLbl; DepFactCaptionLbl)
            {
            }
            column(CountryCaptionLbl; CountryCaptionLbl)
            {
            }
            column(AmountCaptionLbl; AmountCaptionLbl)
            {
            }
            column(Filtros; Filtros)
            {
            }
            column(Companyname; COMPANYNAME)
            {
            }
            column(Customer; MemInt."Cod 1")
            {
            }
            column(Nombre; MemInt.Descripción)
            {
            }
            column(Proyecto; MemInt."Cod 2")
            {
            }
            column("Descripción"; MemInt."Description 1")
            {
            }
            column(Departamento; MemInt."Cod 10")
            {
            }
            column(Oficina; MemInt."Cod 9")
            {
            }
            column(DeptFact; MemInt."Cod 3")
            {
            }
            column(Pais; MemInt."Description 2")
            {
            }
            column(ImporteFac; MemInt.Importe1)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number > 1 THEN IF MemInt.Next() = 0 THEN CurrReport.Break();
                IF CreateExcel THEN BEGIN
                    EnterCell(Row, 1, MemInt."Cod 1", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 2, MemInt.Descripción, FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 3, MemInt."Cod 2", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 4, MemInt."Description 1", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 5, MemInt."Cod 10", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 6, MemInt."Cod 9", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 7, MemInt."Cod 3", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 8, MemInt."Description 2", FALSE, FALSE, FALSE, '', 1);
                    EnterCell(Row, 9, FORMAT(MemInt.Importe1), FALSE, FALSE, FALSE, '#.#0,00', 0);
                    Row+=1;
                END;
            end;
            trigger OnPostDataItem()
            begin
                IF CreateExcel THEN BEGIN
                    TempExcelBuffer.CreateNewBookAndOpenExcel('', InformeCaptionLbl, InformeCaptionLbl, FORMAT(WorkDate()), USERID);
                END;
            end;
            trigger OnPreDataItem()
            begin
                MemInt.SETCURRENTKEY("Cod 1");
                IF NOT MemInt.FIND('-')THEN CurrReport.Break();
                TempExcelBuffer.DeleteAll();
                CLEAR(TempExcelBuffer);
                CLEAR(Row);
                IF CreateExcel THEN BEGIN
                    EnterCell(1, 1, InformeCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(2, 1, Filtros, FALSE, FALSE, FALSE, '', 1);
                    EnterCell(4, 1, CustomerCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 2, NameCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 3, JobCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 4, DescriptionCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 5, DeptCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 6, OfficeCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 7, DepFactCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 8, CountryCaptionLbl, TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 9, AmountCaptionLbl, TRUE, FALSE, FALSE, '', 1);
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
                        ToolTip = 'Export to Excel';
                        ApplicationArea = All;
                        Caption = 'Export to Excel';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        Filtros:=Job.TABLECAPTION + ': ' + Job.GETFILTERS;
    end;
    var MemInt: Record "MemIntAcumulados AT" temporary;
    Cust: Record 18;
    Country: Record 9;
    xJob: Record Job;
    W: Dialog;
    Excel: Boolean;
    JobSetup: Record 315;
    InformeCaptionLbl: Label 'Customer Crosseling Report';
    PageCaptionLbl: Label 'Page %1';
    CustomerCaptionLbl: Label 'Customer';
    TempExcelBuffer: Record 370 temporary;
    Filtros: Text;
    NameCaptionLbl: Label 'Name';
    JobCaptionLbl: Label 'Job';
    DescriptionCaptionLbl: Label 'Description';
    DeptCaptionLbl: Label 'Depart';
    OfficeCaptionLbl: Label 'Office';
    DepFactCaptionLbl: Label 'Dept. Fact.';
    CountryCaptionLbl: Label 'Country';
    AmountCaptionLbl: Label 'Importe Fact.';
    CreateExcel: Boolean;
    Row: Integer;
    procedure DevuelveImporte()
    var
        xMovCont: Record 17;
        Company: Record Company;
    begin
        Company.Reset();
        IF Company.FindFirst()then REPEAT xMovCont.Reset();
                xMovCont.SETCURRENTKEY(xMovCont."Job No.", "G/L Account No.", "Posting Date");
                xMovCont.SETRANGE("Job No.", Job."No.");
                xMovCont.SETFILTER(xMovCont."G/L Account No.", JobSetup."G/L Accounts Rep. Filter AT");
                xMovCont.SETFILTER(xMovCont."Posting Date", Job.GETFILTER("Posting Date Filter"));
                xMovCont.CHANGECOMPANY(Company.Name);
                IF xMovCont.FindFirst()then BEGIN
                    REPEAT MemInt.Init();
                        MemInt."Cod 1":=Job."Bill-to Customer No.";
                        MemInt."Cod 2":=Job."No.";
                        MemInt."Cod 3":=xMovCont."Global Dimension 1 Code";
                        IF NOT MemInt.Find()then MemInt.Insert();
                        MemInt."Cod 10":=Job."Global Dimension 1 Code";
                        MemInt."Cod 9":=Job."Global Dimension 2 Code";
                        //MemInt."Cod 9" := Job."Business Office Code AT";
                        IF NOT Cust.GET(Job."Bill-to Customer No.")THEN CLEAR(Cust);
                        MemInt.Descripción:=Cust.Name;
                        IF NOT Country.GET(Cust."Country/Region Code")THEN CLEAR(Country);
                        MemInt."Description 1":=Job.Description; //INF.XXX
                        MemInt."Description 2":=Country.Name;
                        MemInt.Importe1-=xMovCont.Amount;
                        MemInt.Modify();
                    UNTIL xMovCont.Next() = 0;
                END;
            UNTIL Company.Next() = 0;
    end;
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
}
