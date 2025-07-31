report 52037 "Informe dedicación recurso"
{
    // 153 OS.RM 07/06/2017 Informe Dedicación Recurso
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/Informededicaciónrecurso.rdlc';
    Caption = 'Resource dedication report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Recursos;156)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE(Type=CONST(Person));
            PrintOnlyIfDetail = true;

            dataitem(MovimentsRecursos;203)
            {
                DataItemLink = "Resource No."=FIELD("No.");
                DataItemTableView = SORTING("Entry Type", Chargeable, "Unit of Measure Code", "Resource No.", "Posting Date")ORDER(Ascending);
                //WHERE("Entry No." = CONST(Usage));
                RequestFilterFields = "Posting Date";

                trigger OnAfterGetRecord()
                begin
                    IF NOT TABFeina.GET(MovimentsRecursos."Job No.")THEN CLEAR(TABFeina);
                    MemIntRecurs.Init();
                    MemIntRecurs."Cod 1":=Recursos."No.";
                    MemIntRecurs."Cod 2":=Recursos."Global Dimension 1 Code";
                    MemIntRecurs."Cod 3":=Recursos."Resource Group No.";
                    IF NOT MemIntRecurs.Find()then BEGIN
                        MemIntRecurs.Descripción:=Recursos.Name;
                        MemIntRecurs.Insert();
                    END;
                    IF TABFeina."Job Type AT" = TABFeina."Job Type AT"::Internal THEN MemIntRecurs.Importe1+=MovimentsRecursos.Quantity
                    ELSE
                        MemIntRecurs.Importe2+=MovimentsRecursos.Quantity;
                    MemIntRecurs.Modify();
                end;
                trigger OnPreDataItem()
                begin
                    DataFilterTXT:=TXTData + ' ' + MovimentsRecursos.GETFILTER("Posting Date");
                end;
            }
            trigger OnPreDataItem()
            begin
                MemIntRecurs.DeleteAll();
            end;
        }
        dataitem(MostraMemInt; Integer)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

            column(TXTTitol; TXTTitol)
            {
            }
            column(TXTPagina; TXTPagina)
            {
            }
            column(TXTData; DataFilterTXT)
            {
            }
            column(TXTNo; TXTNo)
            {
            }
            column(TXTNom; TXTNom)
            {
            }
            column(TXTDepartament; TXTDepartament)
            {
            }
            column(TXTCategoria; TXTCategoria)
            {
            }
            column(TXTHoresInternes; TXTHoresInternes)
            {
            }
            column(TXTRestaHores; TXTResteHores)
            {
            }
            column(TXTTotal; TXTTotal)
            {
            }
            column(NomCompanyia; NomCompanyia)
            {
            }
            column(Cod1_MemIntRecurs; MemIntRecurs."Cod 1")
            {
            }
            column(Cod2_MemIntRecurs; MemIntRecurs.Descripción)
            {
            }
            column(Cod3_MemIntRecurs; MemIntRecurs."Cod 2")
            {
            }
            column(Cod4_MemIntRecurs; MemIntRecurs."Cod 3")
            {
            }
            column(Importe1_MemIntRecurs; MemIntRecurs.Importe1)
            {
            }
            column(Importe2_MemIntRecurs; MemIntRecurs.Importe2)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number > 1 THEN BEGIN
                    IF MemIntRecurs.Next() = 0 THEN CurrReport.Break();
                END;
                IF BooleanVolExcel THEN BEGIN
                    EnterCell(ExcelRow, 1, FORMAT(MemIntRecurs."Cod 1"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(ExcelRow, 2, FORMAT(MemIntRecurs.Descripción), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(ExcelRow, 3, FORMAT(MemIntRecurs."Cod 2"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(ExcelRow, 4, FORMAT(MemIntRecurs."Cod 3"), FALSE, FALSE, FALSE, '', 1);
                    EnterCell(ExcelRow, 5, FORMAT(MemIntRecurs.Importe1, 0, '<Integer Thousand><Decimals>'), FALSE, FALSE, FALSE, '0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(ExcelRow, 6, FORMAT(MemIntRecurs.Importe2, 0, '<Integer Thousand><Decimals>'), FALSE, FALSE, FALSE, '0.00', TempExcelBuffer."Cell Type"::Number);
                    ExcelRow+=1;
                END;
            end;
            trigger OnPostDataItem()
            begin
                IF BooleanVolExcel THEN BEGIN
                    //TempExcelBuffer.CreateBookAndOpenExcel('', 'Horas recurso dpto.', 'Horas recurso dpto.', FORMAT(WorkDate()), USERID);
                    CreateBookAndOpenExcel('', 'Horas recurso dpto.', 'Horas recurso dpto.', FORMAT(WorkDate()), USERID);
                END;
            end;
            trigger OnPreDataItem()
            begin
                MostraMemInt.SETRANGE(Number, 1, MemIntRecurs.COUNT);
                IF NOT MemIntRecurs.FindFirst()then CurrReport.Break();
                IF BooleanVolExcel THEN BEGIN
                    EnterCell(1, 1, FORMAT(TXTTitol), TRUE, FALSE, FALSE, '', 1);
                    EnterCell(2, 1, FORMAT(DataFilterTXT), TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 1, FORMAT(TXTNo), TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 2, FORMAT(TXTNom), TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 3, FORMAT(TXTDepartament), TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 4, FORMAT(TXTCategoria), TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 5, FORMAT(TXTHoresInternes), TRUE, FALSE, FALSE, '', 1);
                    EnterCell(4, 6, FORMAT(TXTResteHores), TRUE, FALSE, FALSE, '', 1);
                END;
                ExcelRow:=5;
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

                    field(ExportarExcel; BooleanVolExcel)
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
    trigger OnInitReport()
    begin
        TABCompanyia.GET();
        TABCompanyia.CALCFIELDS(Picture);
        IF TABCompanyia.Name = '' THEN NomCompanyia:=COMPANYNAME
        ELSE
            NomCompanyia:=TABCompanyia.Name;
    end;
    var TXTTitol: Label 'Resource Hours by departments';
    TXTNo: Label 'Resource N.';
    TXTData: Label 'Date Filter';
    TXTNom: Label 'Name';
    TXTPagina: Label 'Page';
    TABCompanyia: Record 79;
    TABFeina: Record Job;
    MemIntRecurs: Record "MemIntAcumulados Inv" temporary;
    TempExcelBuffer: Record 370 temporary;
    MaxLongitutSTR: Integer;
    TXTTotal: Label 'Total';
    TXTDepartament: Label 'Department';
    TXTCategoria: Label 'Category';
    TXTHoresInternes: Label 'Internal Hours';
    TXTResteHores: Label 'Rest Hours';
    DataFilterTXT: Text;
    NomCompanyia: Text;
    BooleanVolExcel: Boolean;
    ExcelRow: Integer;
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
    procedure CreateBookAndOpenExcel(FileName: Text; SheetName: Text[250]; ReportHeader: Text; CompanyName2: Text; UserID2: Text)
    var
        ExcelBuffer: Record "Excel Buffer";
    begin
        ExcelBuffer.CreateNewBook(SheetName);
        ExcelBuffer.WriteSheet(ReportHeader, CompanyName2, UserID2);
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel;
    end;
}
