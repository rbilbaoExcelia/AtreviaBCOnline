report 52025 "Dedication report by depart"
{
    // 153 OS.RM 07/06/2017 Informe dedicación recurso por departamento
    Caption = 'Dedication report by depart.';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Resource;156)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE(Type=CONST(Person));
            RequestFilterFields = "Global Dimension 1 Code", "No.";

            dataitem("Res. Ledger Entry";203)
            {
                DataItemLink = "Resource No."=FIELD("No.");
                DataItemTableView = SORTING("Entry Type", Chargeable, "Unit of Measure Code", "Resource No.", "Posting Date")ORDER(Ascending);
                //WHERE("Entry No." = CONST(Usage));
                RequestFilterFields = "Posting Date";

                trigger OnAfterGetRecord()
                begin
                    IF NOT recJob.GET("Res. Ledger Entry"."Job No.")THEN CLEAR(recJob);
                    MemintLin.Init();
                    MemintLin."Cod 1":=Resource."Global Dimension 1 Code";
                    MemintLin."Cod 2":=Resource."Global Dimension 2 Code";
                    MemintLin."Cod 3":=COPYSTR(Resource.Name, 1, MAXSTRLEN(MemintLin."Cod 3"));
                    MemintLin."Cod 4":="Res. Ledger Entry"."Job No.";
                    MemintLin."Cod 5":=Resource."No.";
                    IF NOT MemintLin.Find()then MemintLin.Insert();
                    MemintLin.Descripción:=recJob.Description;
                    //<INF.002
                    IF recJob."Job Type AT" = recJob."Job Type AT"::Internal THEN MemintLin.Importe1+="Res. Ledger Entry".Quantity
                    ELSE
                        MemintLin.Importe2+="Res. Ledger Entry".Quantity;
                    //INF.002>
                    MemintLin.Modify();
                    MemintCap.Init();
                    MemintCap."Cod 1":=Resource."Global Dimension 1 Code";
                    MemintCap."Cod 2":=Resource."Global Dimension 2 Code";
                    MemintCap."Cod 3":=COPYSTR(Resource.Name, 1, MAXSTRLEN(MemintLin."Cod 3"));
                    MemintCap."Cod 5":=Resource."No.";
                    IF NOT MemintCap.Find()then MemintCap.Insert();
                    MemintCap.Descripción:=Resource.Name;
                    //<INF.002
                    IF recJob."Job Type AT" = recJob."Job Type AT"::Internal THEN MemintCap.Importe1+="Res. Ledger Entry".Quantity
                    ELSE
                        MemintCap.Importe2+="Res. Ledger Entry".Quantity;
                    //INF.002>
                    MemintCap.Modify();
                    MemintHojas.Init();
                    MemintHojas."Cod 1":=Resource."Global Dimension 1 Code";
                    MemintHojas."Cod 2":=Resource."Global Dimension 2 Code";
                    IF NOT MemintHojas.Find()then MemintHojas.Insert();
                    //<INF.002
                    IF recJob."Job Type AT" = recJob."Job Type AT"::Internal THEN MemintHojas.Importe1+="Res. Ledger Entry".Quantity
                    ELSE
                        MemintHojas.Importe2+="Res. Ledger Entry".Quantity;
                    MemintHojas.Modify();
                //INF.002>
                end;
            }
            trigger OnAfterGetRecord()
            begin
                d.UPDATE(1, Resource."Global Dimension 1 Code");
                d.UPDATE(2, Resource."Global Dimension 2 Code");
                d.UPDATE(3, Resource.Name);
            end;
            trigger OnPostDataItem()
            begin
                d.Close();
            end;
            trigger OnPreDataItem()
            begin
                d.OPEN('Calculando...\' + 'Area Geográfica #1#####################\' + 'Departamento #2#####################\' + 'Nº Recurso   #3#####################');
            end;
        }
        dataitem(CreaHoja; Integer)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

            dataitem(LoopCabecera; Integer)
            {
                DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                dataitem(LoopLineas; Integer)
                {
                    DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                    trigger OnAfterGetRecord()
                    begin
                        IF LoopLineas.Number > 1 THEN IF MemintLin.Next() = 0 THEN CurrReport.Break();
                        ValorCelda[1]:=MemintLin.Descripción;
                        ValorCelda[2]:=FORMAT(MemintLin.Importe1);
                        ValorCelda[3]:=FORMAT(MemintLin.Importe2); //INF.002
                        RowNumber:=RowNumber + 1;
                        IF primer THEN BEGIN
                            //<INF.002
                            EnterCell(RowNumber, 1, MemintCap."Cod 5", TRUE, FALSE, FALSE);
                            //INF.002>
                            EnterCell(RowNumber, 2, MemintCap.Descripción, TRUE, FALSE, FALSE);
                            //<INF.002
                            EnterCell(RowNumber, 4, 'INTERNOS', TRUE, FALSE, FALSE);
                            EnterCell(RowNumber, 5, 'RESTO', TRUE, FALSE, FALSE);
                            //INF.002>
                            primer:=FALSE;
                            RowNumber:=RowNumber + 1;
                        END;
                        n:=2;
                        REPEAT n:=n + 1;
                            EnterCell(RowNumber, n, ValorCelda[n - 2], FALSE, FALSE, FALSE);
                        //<INF.002
                        UNTIL n = 5;
                    //INF.002>
                    end;
                    trigger OnPostDataItem()
                    begin
                        RowNumber:=RowNumber + 1;
                        EnterCell(RowNumber, 3, 'Total ' + MemintCap.Descripción + ': ', TRUE, FALSE, FALSE);
                        primer:=FALSE;
                        EnterCell(RowNumber, 4, FORMAT(MemintCap.Importe1), TRUE, FALSE, FALSE);
                        //<INF.002
                        EnterCell(RowNumber, 5, FORMAT(MemintCap.Importe2), TRUE, FALSE, FALSE);
                        //INF.002>
                        RowNumber:=RowNumber + 1;
                    end;
                    trigger OnPreDataItem()
                    begin
                        FiltroFecha:="Res. Ledger Entry".GETFILTER("Res. Ledger Entry"."Posting Date");
                        MemintLin.SETRANGE("Cod 1", MemintCap."Cod 1");
                        MemintLin.SETRANGE("Cod 2", MemintCap."Cod 2");
                        MemintLin.SETRANGE("Cod 3", MemintCap."Cod 3");
                        MemintLin.SETRANGE("Cod 5", MemintCap."Cod 5");
                        IF NOT MemintLin.FindFirst()then CurrReport.Break();
                        IF NewPaper THEN BEGIN
                            RowNumber:=2;
                            NewPaper:=FALSE;
                            EnterCell(RowNumber, 3, 'Control de Horas:' + ' ' + MemintCap."Cod 1" + ' ' + MemintCap."Cod 2", TRUE, FALSE, FALSE);
                            primer:=FALSE;
                            RowNumber:=RowNumber + 1;
                            EnterCell(RowNumber, 3, 'Filtro Fecha:' + ' ' + FiltroFecha, TRUE, FALSE, FALSE);
                            primer:=FALSE;
                            RowNumber:=RowNumber + 1;
                        END
                        ELSE
                            RowNumber:=RowNumber + 1;
                        primer:=TRUE;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    IF LoopCabecera.Number > 1 THEN IF MemintCap.Next() = 0 THEN CurrReport.Break();
                    d.UPDATE(1, MemintCap."Cod 1");
                    d.UPDATE(2, MemintCap."Cod 2");
                    d.UPDATE(3, MemintCap."Cod 3");
                end;
                trigger OnPostDataItem()
                begin
                    RowNumber:=RowNumber + 2;
                    EnterCell(RowNumber, 3, 'Total' + ' ' + MemintHojas."Cod 1" + ' ' + MemintHojas."Cod 2" + ': ', TRUE, FALSE, FALSE);
                    primer:=FALSE;
                    EnterCell(RowNumber, 4, FORMAT(MemintHojas.Importe1), TRUE, FALSE, FALSE);
                    //<INF.002
                    EnterCell(RowNumber, 5, FORMAT(MemintHojas.Importe2), TRUE, FALSE, FALSE);
                    //INF.002>
                    TempExcelBuffer.WriteSheet(MemintHojas."Cod 1" + ' ' + MemintHojas."Cod 2", COMPANYNAME, USERID);
                    TempExcelBuffer.CloseBook();
                end;
                trigger OnPreDataItem()
                begin
                    MemintCap.SETRANGE("Cod 1", MemintHojas."Cod 1");
                    MemintCap.SETRANGE("Cod 2", MemintHojas."Cod 2");
                    IF NOT MemintCap.FindFirst()then CurrReport.Break();
                    TempExcelBuffer.DeleteAll();
                end;
            }
            trigger OnAfterGetRecord()
            begin
                IF CreaHoja.Number > 1 THEN IF MemintHojas.Next() = 0 THEN CurrReport.Break();
                NewPaper:=TRUE;
                IF NOT FileCreated THEN BEGIN
                    TempExcelBuffer.DeleteAll();
                    CLEAR(TempExcelBuffer);
                    //TempExcelBuffer.CreateBookWOSheets;
                    TempExcelBuffer.CreateNewBookWithoutOpen(MemintHojas."Cod 1" + ' ' + MemintHojas."Cod 2");
                    FileCreated:=TRUE;
                END
                ELSE
                BEGIN
                    TempExcelBuffer.ActiveNewSheet(TRUE, FileName);
                    TempExcelBuffer.CloseBook();
                END;
            end;
            trigger OnPostDataItem()
            begin
                TempExcelBuffer.OpenExcel();
                d.Close();
            end;
            trigger OnPreDataItem()
            begin
                MemintHojas.ASCENDING(TRUE);
                IF NOT MemintHojas.FindFirst()then CurrReport.Break();
                d.OPEN('Preparando fichero...\' + 'Area Geográfica #1################\' + 'Departamento #2################\' + 'Recurso   #3################', MemintCap."Cod 1", MemintCap."Cod 2", MemintCap."Cod 3");
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
    }
    labels
    {
    }
    var d: Dialog;
    recJob: Record Job;
    MemintCap: Record "MemIntAcumulados Inv" temporary;
    MemintLin: Record "MemIntAcumulados Inv" temporary;
    MemintHojas: Record "MemIntAcumulados Inv" temporary;
    TempExcelBuffer: Record 370 temporary;
    NewPaper: Boolean;
    RowNumber: Integer;
    primer: Boolean;
    FiltroFecha: Text[80];
    ValorCelda: array[3]of Text[80];
    n: Integer;
    FileManagement: Codeunit "File Management";
    FileName: Text;
    FileCreated: Boolean;
    procedure EnterCell(RowNo: Integer; ColumNo: Integer; Cellvalue: Text[250]; Bold: Boolean; Italic: Boolean; Underline: Boolean)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumNo);
        TempExcelBuffer."Cell Value as Text":=Cellvalue;
        TempExcelBuffer.Formula:='';
        TempExcelBuffer.Bold:=Bold;
        TempExcelBuffer.Italic:=Italic;
        TempExcelBuffer.Underline:=Underline;
        TempExcelBuffer.Insert();
    end;
}
