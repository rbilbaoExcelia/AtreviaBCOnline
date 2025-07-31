report 52053 "Previsión Ventas Netas Agr.RM"
{
    // 152 OS.RM 07/06/2017 Previsión Ventas Netas Agr.
    //     OS.OA 20/09/2017 VEN.001 Modificaciones
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/PrevisiónVentasNetasAgrRM.rdlc';
    Caption = 'Prevision ventas netas';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DimValue1;349)
        {
            DataItemTableView = SORTING("Dimension Code", Code)ORDER(Ascending)WHERE("Global Dimension No."=CONST(1), "Dimension Value Type"=CONST(Standard), Blocked=CONST(false), Alias=FILTER(<>''));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            RequestFilterHeading = 'Código Geográfico';

            column(code1; DimValue1.Code)
            {
            }
            dataitem(DimValue2;349)
            {
                DataItemTableView = SORTING("Dimension Code", Code)ORDER(Ascending)WHERE("Global Dimension No."=CONST(2), "Dimension Value Type"=CONST(Standard), Blocked=CONST(false), Alias=FILTER(<>''));
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Code";
                RequestFilterHeading = 'Código Departamento';

                column(code2; DimValue2.Code)
                {
                }
                column(NombreHoja; DimValue1.Alias + ' ' + DimValue2.Alias)
                {
                }
                column(CompanyName; CompanyInfo.Name)
                {
                }
                column(TXTTittle; TXTTittle)
                {
                }
                column(TXTAccomplished; TXTAccomplished)
                {
                }
                column(TXTPredicted; TXTPredicted)
                {
                }
                column(TXTType; TXTType)
                {
                }
                column(TXTJobName; TXTJobName)
                {
                }
                column(TXTJobNo; TXTJobNo)
                {
                }
                column(TXTTotalGeneral; TXTTotalGeneral)
                {
                }
                column(TXTTotalAccomplished; TXTTotalAccomplished)
                {
                }
                column(TXTTotalPredicted; TXTTotalPredicted)
                {
                }
                column(NoMostrarReal; NoMostrarReal)
                {
                }
                column(NoMostrarPrev; NoMostrarPrev)
                {
                }
                column(Mes1; Mes[1])
                {
                }
                column(Mes2; Mes[2])
                {
                }
                column(Mes3; Mes[3])
                {
                }
                column(Mes4; Mes[4])
                {
                }
                column(Mes5; Mes[5])
                {
                }
                column(Mes6; Mes[6])
                {
                }
                column(Mes7; Mes[7])
                {
                }
                column(Mes8; Mes[8])
                {
                }
                column(Mes9; Mes[9])
                {
                }
                column(Mes10; Mes[10])
                {
                }
                column(Mes11; Mes[11])
                {
                }
                column(Mes12; Mes[12])
                {
                }
                column(Fecha; FORMAT(TODAY, 0, 4))
                {
                }
                dataitem(JobExpected;167)
                {
                    DataItemTableView = SORTING("Global Dimension 1 Code")ORDER(Ascending);
                    RequestFilterFields = "No.", "Global Dimension 1 Code", "Global Dimension 2 Code";

                    dataitem(ExpectedInv;1003)
                    {
                        DataItemLink = "Job No."=FIELD("No.");
                        DataItemTableView = SORTING("Job No.", "Job Task No.", "Line No.")ORDER(Ascending)WHERE("Line Type"=FILTER(Billable|"Both Budget and Billable"), "Qty. to Invoice"=FILTER(<>0));

                        trigger OnAfterGetRecord()
                        begin
                            TmpJobCol.Init();
                            TmpJobCol."Cod 1":=TmpJob."Cod 1";
                            TmpJobCol."Cod 2":=ESPERADO;
                            TmpJobCol."Int 20":=DATE2DMY(ExpectedInv."Planning Date", 2);
                            IF NOT TmpJobCol.Find()then TmpJobCol.Insert();
                            TmpJobCol.Importe1+=ExpectedInv."Line Amount";
                            TmpJobCol.Modify();
                        //3526 - MEP - 2022 03 23 - Nuevos filtros 
                        //Comentado, se resolvio de otra forma
                        /*TmpJobCol.SetRange("Cod 1", TmpJob."Cod 1");
                            TmpJobCol.SetRange("Cod 2", ESPERADO);
                            TmpJobCol.SetRange("Int 20", (DATE2DMY(ExpectedInv."Planning Date", 2)));
                            if not TmpJobCol.FindFirst() then begin
                                TmpJobCol.Init();
                                TmpJobCol."Cod 1" := TmpJob."Cod 1";
                                TmpJobCol."Cod 2" := ESPERADO;
                                TmpJobCol."Int 20" := DATE2DMY(ExpectedInv."Planning Date", 2);
                                TmpJobCol.Importe1 += ExpectedInv."Line Amount";
                                TmpJobCol.Insert()
                            end else begin
                                TmpJobCol.Importe1 += ExpectedInv."Line Amount";
                                TmpJobCol.Modify();
                            end;*/
                        //3526 - MEP - 2022 03 23 END
                        end;
                        trigger OnPreDataItem()
                        begin
                            SETRANGE(ExpectedInv."Planning Date", FechaInicPeriodo[1, 1], FechaInicPeriodo[2, 12]);
                            IF ExpectedInv.ISEMPTY THEN EXIT;
                            ExpectedInv.FindFirst();
                            TmpJob."Cod 1":=JobExpected."No.";
                            IF NOT TmpJob.Find()then TmpJob.Insert();
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        W.UPDATE(2, "No.");
                    end;
                    trigger OnPostDataItem()
                    begin
                        //Afegim dimensió dos perquè ara funcionem amb dues dimensions.
                        //Treiem filtres a global dimension.. per què????
                        SETRANGE("Global Dimension 1 Code");
                        SETRANGE("Global Dimension 2 Code");
                    end;
                    trigger OnPreDataItem()
                    begin
                        //Fixa clau primaria a Global Dimension 2
                        JobExpected.FILTERGROUP(2);
                        SETRANGE("Global Dimension 1 Code", DimValue1.Code);
                        IF DimValue1."Split Dimension" THEN SETRANGE("Global Dimension 2 Code", DimValue2.Code);
                        //Fixa clau primaria a estandard taula!
                        JobExpected.FILTERGROUP(0);
                    end;
                }
                dataitem(CompanyBucle; Company)
                {
                    DataItemTableView = SORTING(Name)ORDER(Ascending);

                    dataitem("G/L Entry";17)
                    {
                        DataItemTableView = SORTING("G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")ORDER(Ascending)WHERE("Job No."=FILTER(<>''));

                        trigger OnAfterGetRecord()
                        begin
                            iCounter+=1;
                            IF iCounter MOD 100 = 0 THEN W.UPDATE(2, "Job No.");
                            TmpJob."Cod 1":="G/L Entry"."Job No.";
                            IF NOT TmpJob.Find()then TmpJob.Insert();
                            TmpJobCol.Init();
                            TmpJobCol."Cod 1":=TmpJob."Cod 1";
                            TmpJobCol."Cod 2":=REAL;
                            TmpJobCol."Int 20":=DATE2DMY("Posting Date", 2);
                            IF NOT TmpJobCol.Find()then TmpJobCol.Insert();
                            TmpJobCol.Importe1-=Amount;
                            TmpJobCol.Modify();
                        //3526 - MEP - 2022 03 23 - Nuevos filtros 
                        //Comentado, se resolvio de otra forma
                        /*TmpJobCol.SetRange("Cod 1", TmpJob."Cod 1");
                            TmpJobCol.SetRange("Cod 2", REAL);
                            TmpJobCol.SetRange("Int 20", (DATE2DMY("G/L Entry"."Posting Date", 2)));
                            if not TmpJobCol.FindFirst() then begin
                                TmpJobCol.Init();
                                TmpJobCol."Cod 1" := TmpJob."Cod 1";
                                TmpJobCol."Cod 2" := REAL;
                                TmpJobCol."Int 20" := DATE2DMY("G/L Entry"."Posting Date", 2);
                                TmpJobCol.Importe1 -= "G/L Entry".Amount;
                                TmpJobCol.Insert()
                            end else begin
                                TmpJobCol.Importe1 -= "G/L Entry".Amount;
                                TmpJobCol.Modify();
                            end;*/
                        //3526 - MEP - 2022 03 23 END
                        end;
                        trigger OnPreDataItem()
                        begin
                            CHANGECOMPANY(CompanyBucle.Name);
                            //SETFILTER("G/L Account No.",JobSetup."Filtro cuentas informe");
                            SETFILTER("G/L Account No.", JobSetup."G/L Accounts Rep. Filter AT");
                            SETRANGE("Posting Date", FechaInicPeriodo[1, 1], FechaInicPeriodo[2, 12]);
                            //Filtro zona
                            SETRANGE("Global Dimension 1 Code", DimValue1.Code);
                            IF DimValue1."Split Dimension" THEN SETRANGE("Global Dimension 2 Code", DimValue2.Code);
                            //OJO CON ESTO
                            IF JobExpected.GETFILTER("No.") <> '' THEN JobExpected.COPYFILTER("No.", "G/L Entry"."Job No.");
                        end;
                    }
                }
                dataitem(ShowJob; Integer)
                {
                    DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                    dataitem(Job;167)
                    {
                        DataItemTableView = SORTING("Search Description")ORDER(Ascending);

                        column(JobNo; Job."No.")
                        {
                        }
                        column(JobDescription; Job.Description)
                        {
                        }
                        column(V11; V[1, 1])
                        {
                        }
                        column(V12; V[1, 2])
                        {
                        }
                        column(V13; V[1, 3])
                        {
                        }
                        column(V14; V[1, 4])
                        {
                        }
                        column(V15; V[1, 5])
                        {
                        }
                        column(V16; V[1, 6])
                        {
                        }
                        column(V17; V[1, 7])
                        {
                        }
                        column(V18; V[1, 8])
                        {
                        }
                        column(V19; V[1, 9])
                        {
                        }
                        column(V110; V[1, 10])
                        {
                        }
                        column(V111; V[1, 11])
                        {
                        }
                        column(V112; V[1, 12])
                        {
                        }
                        column(V113; V[1, 13])
                        {
                        }
                        column(Type; Type)
                        {
                        }
                        dataitem(Realizado; Integer)
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                            column(R11; R[1, 1])
                            {
                            }
                            column(R12; R[1, 2])
                            {
                            }
                            column(R13; R[1, 3])
                            {
                            }
                            column(R14; R[1, 4])
                            {
                            }
                            column(R15; R[1, 5])
                            {
                            }
                            column(R16; R[1, 6])
                            {
                            }
                            column(R17; R[1, 7])
                            {
                            }
                            column(R18; R[1, 8])
                            {
                            }
                            column(R19; R[1, 9])
                            {
                            }
                            column(R110; R[1, 10])
                            {
                            }
                            column(R111; R[1, 11])
                            {
                            }
                            column(R112; R[1, 12])
                            {
                            }
                            column(R113; R[1, 13])
                            {
                            }
                            dataitem(Previsto; Integer)
                            {
                                DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                                column(P11; P[1, 1])
                                {
                                }
                                column(P12; P[1, 2])
                                {
                                }
                                column(P13; P[1, 3])
                                {
                                }
                                column(P14; P[1, 4])
                                {
                                }
                                column(P15; P[1, 5])
                                {
                                }
                                column(P16; P[1, 6])
                                {
                                }
                                column(P17; P[1, 7])
                                {
                                }
                                column(P18; P[1, 8])
                                {
                                }
                                column(P19; P[1, 9])
                                {
                                }
                                column(P110; P[1, 10])
                                {
                                }
                                column(P111; P[1, 11])
                                {
                                }
                                column(P112; P[1, 12])
                                {
                                }
                                column(P113; P[1, 13])
                                {
                                }
                                column(VT1; VTotal[1, 1])
                                {
                                }
                                column(VT2; VTotal[1, 2])
                                {
                                }
                                column(VT3; VTotal[1, 3])
                                {
                                }
                                column(VT4; VTotal[1, 4])
                                {
                                }
                                column(VT5; VTotal[1, 5])
                                {
                                }
                                column(VT6; VTotal[1, 6])
                                {
                                }
                                column(VT7; VTotal[1, 7])
                                {
                                }
                                column(VT8; VTotal[1, 8])
                                {
                                }
                                column(VT9; VTotal[1, 9])
                                {
                                }
                                column(VT10; VTotal[1, 10])
                                {
                                }
                                column(VT11; VTotal[1, 11])
                                {
                                }
                                column(VT12; VTotal[1, 12])
                                {
                                }
                                column(VT13; VTotal[1, 13])
                                {
                                }
                                column(RT1; RTotal[1, 1])
                                {
                                }
                                column(RT2; RTotal[1, 2])
                                {
                                }
                                column(RT3; RTotal[1, 3])
                                {
                                }
                                column(RT4; RTotal[1, 4])
                                {
                                }
                                column(RT5; RTotal[1, 5])
                                {
                                }
                                column(RT6; RTotal[1, 6])
                                {
                                }
                                column(RT7; RTotal[1, 7])
                                {
                                }
                                column(RT8; RTotal[1, 8])
                                {
                                }
                                column(RT9; RTotal[1, 9])
                                {
                                }
                                column(RT10; RTotal[1, 10])
                                {
                                }
                                column(RT11; RTotal[1, 11])
                                {
                                }
                                column(RT12; RTotal[1, 12])
                                {
                                }
                                column(RT13; RTotal[1, 13])
                                {
                                }
                                column(PT1; PTotal[1, 1])
                                {
                                }
                                column(PT2; PTotal[1, 2])
                                {
                                }
                                column(PT3; PTotal[1, 3])
                                {
                                }
                                column(PT4; PTotal[1, 4])
                                {
                                }
                                column(PT5; PTotal[1, 5])
                                {
                                }
                                column(PT6; PTotal[1, 6])
                                {
                                }
                                column(PT7; PTotal[1, 7])
                                {
                                }
                                column(PT8; PTotal[1, 8])
                                {
                                }
                                column(PT9; PTotal[1, 9])
                                {
                                }
                                column(PT10; PTotal[1, 10])
                                {
                                }
                                column(PT11; PTotal[1, 11])
                                {
                                }
                                column(PT12; PTotal[1, 12])
                                {
                                }
                                column(PT13; PTotal[1, 13])
                                {
                                }
                            }
                        }
                        trigger OnAfterGetRecord()
                        begin
                            CLEAR(V);
                            CLEAR(R);
                            CLEAR(P);
                            //<153
                            VT:='=';
                            PT:='=';
                            RT:='=';
                            //General
                            FOR I:=1 TO 12 DO BEGIN
                                VT+=sumExcelPosition(Fila, I + 2); //153
                            END;
                            FOR I:=1 TO 12 DO BEGIN
                                //REAL
                                // IF FechaInicPeriodo[1, I] < WORKDATE THEN BEGIN
                                V[1, I]:=GetAmt("No.", REAL, I);
                                R[1, I]:=GetAmt("No.", REAL, I);
                                //<001
                                V[1, 13]+=V[1, I];
                                R[1, 13]+=R[1, I];
                                //001>
                                RT+=sumExcelPosition(Fila + 1, I + 2); //153
                                RTotal[1, I]+=GetAmt("No.", REAL, I); //152
                                //PREV
                                V[1, I]+=GetAmt("No.", ESPERADO, I);
                                P[1, I]:=GetAmt("No.", ESPERADO, I);
                                //<001
                                P[1, 13]+=P[1, I];
                                //001>
                                PT+=sumExcelPosition(Fila + 2, I + 2); //153
                                PTotal[1, I]+=GetAmt("No.", ESPERADO, I); //152
                                //<001
                                VTotal[1, I]:=PTotal[1, I] + RTotal[1, I];
                                RTotal[1, 13]+=RTotal[1, I];
                                PTotal[1, 13]+=PTotal[1, I];
                                VTotal[1, 13]+=VTotal[1, I];
                            //001>
                            END;
                            NoMostrarReal:=SinValor(R) AND (NOT MostrarTodos);
                            NoMostrarPrev:=SinValor(P) AND (NOT MostrarTodos);
                            //<152
                            Type:='';
                            CASE Job."Job Type AT" OF Job."Job Type AT"::"One Off": Type:='P';
                            Job."Job Type AT"::Periodical: Type:='C';
                            END;
                            //152>
                            //<152
                            IF Job.Status = Job.Status::Completed THEN Type+='F';
                            //152>
                            IF SinValor(V) AND (NOT MostrarSinVta)THEN CurrReport.Skip();
                            FOR I:=1 TO 12 DO BEGIN
                                //<153
                                IF(STRLEN(SumExcelReal[1, I]) + STRLEN(sumExcelPosition(Fila + 1, I + 2))) < 1000 THEN SumExcelReal[1, I]+=sumExcelPosition(Fila + 1, I + 2)
                                ELSE
                                    NoExcelFunction:=TRUE;
                                //<153
                                IF(STRLEN(SumExcelPrev[1, I]) + STRLEN(sumExcelPosition(Fila + 2, I + 2))) < 1000 THEN SumExcelPrev[1, I]+=sumExcelPosition(Fila + 2, I + 2)
                                ELSE
                                    NoExcelFunction:=TRUE;
                            END;
                            //Rellenamos Excel
                            IF CreateExcel THEN CreateExcelLines;
                        end;
                        trigger OnPreDataItem()
                        begin
                            SETRANGE("No.", TmpJob."Cod 1");
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN TmpJob.FINDSET
                        ELSE IF TmpJob.Next() = 0 THEN CurrReport.Break();
                        TmpJobCol.SETRANGE(TmpJobCol."Cod 1", TmpJob."Cod 1");
                        IF TmpJobCol.ISEMPTY THEN CurrReport.Skip();
                        CreadaHoja:=TRUE;
                    end;
                    trigger OnPostDataItem()
                    begin
                        // Rellenamos Excel
                        IF(CreateExcel) AND (CreadaHoja)THEN BEGIN
                            CreateExcelTotals;
                        END;
                    end;
                    trigger OnPreDataItem()
                    begin
                        IF TmpJob.ISEMPTY THEN CurrReport.Break();
                        TmpJob.FindSet();
                        REPEAT IF NOT Job.GET(TmpJob."Cod 1")THEN CLEAR(Job);
                            TmpJob.Cod100:=COPYSTR(Job."Search Description", 1, 20);
                            TmpJob.Modify();
                        UNTIL TmpJob.Next() = 0;
                        TmpJob.SETCURRENTKEY(TmpJob.Cod100);
                        CreadaHoja:=FALSE;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    IF DimValue1."Split Dimension" = FALSE THEN BEGIN
                        //para que salga en blanco en report builder
                        DimValue2.Alias:='';
                        IF counter > 1 THEN CurrReport.Break();
                    END;
                    counter+=1;
                    IF CreateExcel THEN BEGIN
                        TempExcelBuffer.DeleteAll();
                    END;
                    //<152
                    CLEAR(VTotal);
                    CLEAR(RTotal);
                    CLEAR(PTotal);
                    CLEAR(V);
                    CLEAR(R);
                    CLEAR(P);
                    //152>
                    //<153
                    VT:='';
                    PT:='';
                    RT:='';
                    CLEAR(SumExcelPrev);
                    CLEAR(SumExcelReal);
                    NoExcelFunction:=FALSE;
                    //153>
                    CreadaHoja:=FALSE;
                    TmpJob.Reset();
                    TmpJob.DeleteAll();
                    TmpJobCol.Reset();
                    TmpJobCol.DeleteAll();
                    Job.SETRANGE("Global Dimension 1 Code", DimValue1.Code);
                    IF DimValue1."Split Dimension" THEN Job.SETRANGE("Global Dimension 2 Code", DimValue2.Code);
                    W.UPDATE(1, DimValue1.Alias + ' ' + DimValue2.Alias); //152
                    //Excel
                    IF CreateExcel THEN CreateExcelHeader;
                end;
                trigger OnPreDataItem()
                begin
                    counter:=1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                IF CreateExcel THEN BEGIN
                    TempExcelBuffer.DeleteAll();
                END;
            end;
            trigger OnPostDataItem()
            begin
                W.Close();
            end;
            trigger OnPreDataItem()
            begin
                IF CreateExcel THEN BEGIN
                    TempExcelBuffer.DeleteAll();
                    CLEAR(TempExcelBuffer);
                //TempExcelBuffer.CreateBookWOSheets();
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
                group(Opciones)
                {
                    Caption = 'Opciones';

                    field(YearReport; YearReport)
                    {
                        ToolTip = 'Year Filter';
                        ApplicationArea = All;
                        Caption = 'Year Filter';
                    }
                    field(MostrarTodos; MostrarTodos)
                    {
                        ToolTip = 'Mostrar siempre Prev. y Real';
                        ApplicationArea = All;
                        Caption = 'Mostrar siempre Prev. y Real';
                    }
                    field(MostrarSinVta; MostrarSinVta)
                    {
                        ToolTip = 'Mostrar Proy. sin Vtas.';
                        ApplicationArea = All;
                        Caption = 'Mostrar Proy. sin Vtas.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            YearReport:=DATE2DMY(WorkDate(), 3);
            MostrarTodos:=TRUE;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET();
    end;
    trigger OnPostReport()
    begin
        IF CreateExcel THEN BEGIN
            TempExcelBuffer.OpenExcel;
        //TempExcelBuffer.GiveUserControl;
        END;
    end;
    trigger OnPreReport()
    begin
        //Tiene que haber fecha de report
        IF YearReport = 0 THEN ERROR(error001);
        CLEAR(FileCreated);
        W.OPEN('Agrupación #1###############\' + 'Proyecto   #2###############');
        JobSetup.Get();
        FOR I:=1 TO 12 DO BEGIN
            FechaInicPeriodo[1, I]:=DMY2DATE(1, I, YearReport);
            FechaInicPeriodo[2, I]:=CALCDATE('<CM>', FechaInicPeriodo[1, I]);
            Mes[I]:=FORMAT(FechaInicPeriodo[1, I], 0, '<Month Text, 3> <year4>');
        END;
    end;
    var JobSetup: Record 315;
    TmpJob: Record "Tmp MemIntAcumulados Inv" temporary;
    TmpJobCol: Record "Tmp MemIntAcumulados Inv" temporary;
    CompanyInfo: Record 79;
    TempExcelBuffer: Record 370 temporary;
    W: Dialog;
    FechaInicPeriodo: array[2, 12]of Date;
    Mes: array[12]of Text[30];
    Type: Text[30];
    FileName: Text;
    VT: Text;
    RT: Text;
    PT: Text;
    SumExcelReal: array[1, 12]of Text[1000];
    SumExcelPrev: array[1, 12]of Text[1000];
    V: array[1, 13]of Decimal;
    R: array[1, 13]of Decimal;
    P: array[1, 13]of Decimal;
    VTotal: array[1, 13]of Decimal;
    RTotal: array[1, 13]of Decimal;
    PTotal: array[1, 13]of Decimal;
    FileCreated: Boolean;
    CreateExcel: Boolean;
    CreadaHoja: Boolean;
    MostrarTodos: Boolean;
    MostrarSinVta: Boolean;
    PrevistoSinFormula: Boolean;
    RealizadoSinFormula: Boolean;
    NoMostrarReal: Boolean;
    NoMostrarPrev: Boolean;
    NoExcelFunction: Boolean;
    Fila: Integer;
    I: Integer;
    iNo: Integer;
    JobFilters: Integer;
    iCounter: Integer;
    year: Integer;
    ESPERADO: Label 'ESPERADO';
    REAL: Label 'REAL';
    //TXTTittle: Label 'Net Sales Prediction';
    TXTTittle: Label 'Prevision ventas netas';
    //TXTAccomplished: Label 'Accomplished';
    TXTAccomplished: Label 'Cumplido';
    //TXTPredicted: Label 'Predicted';
    TXTPredicted: Label 'Previsto';
    //TXTType: Label 'Type';
    TXTType: Label 'Tipo';
    //TXTJobName: Label 'Name';
    TXTJobName: Label 'Nombre';
    //TXTJobNo: Label 'No';
    TXTJobNo: Label 'N°';
    TXTTotalGeneral: Label 'Total General';
    //TXTTotalAccomplished: Label 'Total Accomplished';
    TXTTotalAccomplished: Label 'Total Cumplido';
    //TXTTotalPredicted: Label 'Total Predicted';
    TXTTotalPredicted: Label 'Total Previsto';
    counter: Integer;
    FileManagement: Codeunit "File Management";
    FileNameServer: Text;
    YearReport: Integer;
    //error001: Label 'The filter date of the report must be informed.';
    error001: label 'Se debe informar de la fecha de filtrado del informe.';
    bHayLineas: Boolean;
    Dim1Filter: Text;
    Dim2Filter: Text;
    procedure SinValor(X: array[1, 12]of Decimal): Boolean begin
        FOR I:=1 TO 12 DO IF X[1, I] <> 0 THEN EXIT(FALSE);
        EXIT(TRUE);
    end;
    procedure "---"()
    begin
    end;
    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; CellFormula: Text[1000]; CellType: Integer; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.Init();
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text":=CellValue;
        TempExcelBuffer."Cell Type":=CellType;
        IF CellType = 0 THEN TempExcelBuffer.NumberFormat:='#,##0.00';
        IF CellFormula <> '' THEN TempExcelBuffer.SetFormula(CellFormula);
        TempExcelBuffer.Bold:=Bold;
        TempExcelBuffer.Italic:=Italic;
        TempExcelBuffer.Underline:=UnderLine;
        TempExcelBuffer.Insert();
    //CEll Type:
    //0 -> Número
    //1 -> Texto
    //2 -> Fecha
    //3 -> Hora
    end;
    local procedure CreateExcelHeader()
    begin
        TempExcelBuffer.DeleteAll();
        EnterCell(1, 1, TXTTittle, '', 1, TRUE, FALSE, FALSE);
        IF DimValue1."Split Dimension" THEN EnterCell(2, 1, DimValue1.Alias + ' ' + DimValue2.Alias, '', 1, TRUE, FALSE, FALSE)
        ELSE
            EnterCell(2, 1, DimValue1.Alias, '', 1, TRUE, FALSE, FALSE);
        EnterCell(4, 1, TXTJobName, '', 1, TRUE, FALSE, FALSE);
        FOR I:=1 TO 12 DO EnterCell(4, I + 2, Mes[I], '', 1, TRUE, FALSE, FALSE);
        EnterCell(4, 15, 'Total', '', 1, TRUE, FALSE, FALSE);
        Fila:=7;
    end;
    local procedure CreateExcelLines()
    begin
        EnterCell(Fila, 1, Job.Description, '', 1, TRUE, FALSE, FALSE);
        EnterCell(Fila, 16, Type, '', 1, TRUE, FALSE, FALSE);
        FOR I:=1 TO 12 DO BEGIN
            EnterCell(Fila, I + 2, FormatNumber(V[1, I], 2), '', 0, TRUE, FALSE, FALSE);
            IF NOT NoMostrarReal THEN EnterCell(Fila + 1, I + 2, FormatNumber(R[1, I], 2), '', 0, FALSE, FALSE, FALSE);
            IF NOT NoMostrarPrev THEN EnterCell(Fila + 2, I + 2, FormatNumber(P[1, I], 2), '', 0, FALSE, FALSE, FALSE);
        END;
        EnterCell(Fila, 15, '', VT, 0, TRUE, FALSE, FALSE);
        IF NOT NoMostrarReal THEN EnterCell(Fila + 1, 15, '', RT, 0, FALSE, FALSE, FALSE);
        IF NOT NoMostrarPrev THEN EnterCell(Fila + 2, 15, '', PT, 0, FALSE, FALSE, FALSE);
        Fila+=1;
        EnterCell(Fila, 1, TXTAccomplished, '', 1, FALSE, FALSE, FALSE);
        Fila+=1;
        EnterCell(Fila, 1, TXTPredicted, '', 1, FALSE, FALSE, FALSE);
        Fila+=1;
    end;
    local procedure CreateExcelTotals()
    var
        textToEnter: Integer;
        PrevTotalFormula: Text[1000];
        RealTotalFormula: Text[1000];
        PrevTotal: Decimal;
        RealTotal: Decimal;
    begin
        Fila+=2;
        EnterCell(Fila, 1, TXTTotalGeneral, '', 1, TRUE, FALSE, FALSE);
        EnterCell(Fila + 1, 1, TXTTotalAccomplished, '', 1, FALSE, FALSE, FALSE);
        EnterCell(Fila + 2, 1, TXTTotalPredicted, '', 1, FALSE, FALSE, FALSE);
        FOR I:=1 TO 12 DO BEGIN
            EnterCell(Fila, I + 2, '', '+' + getExcelPosition(Fila + 1, I + 2) + '+' + getExcelPosition(Fila + 2, I + 2), 0, FALSE, FALSE, FALSE);
            IF NOT NoMostrarReal THEN BEGIN
                IF NoExcelFunction THEN BEGIN
                    EnterCell(Fila + 1, I + 2, FormatNumberExcel(RTotal[1, I], 2), '', 0, FALSE, FALSE, FALSE);
                    RealTotal+=RTotal[1, I];
                END
                ELSE
                BEGIN
                    EnterCell(Fila + 1, I + 2, '', SumExcelReal[1, I], 0, FALSE, FALSE, FALSE);
                    RealTotalFormula+=sumExcelPosition(Fila + 1, I + 2);
                END;
            END;
            IF NOT NoMostrarPrev THEN BEGIN
                IF NoExcelFunction THEN BEGIN
                    EnterCell(Fila + 2, I + 2, FormatNumberExcel(PTotal[1, I], 2), '', 0, FALSE, FALSE, FALSE);
                    PrevTotal+=PTotal[1, I];
                END
                ELSE
                BEGIN
                    EnterCell(Fila + 2, I + 2, '', SumExcelPrev[1, I], 0, FALSE, FALSE, FALSE);
                    PrevTotalFormula+=sumExcelPosition(Fila + 2, I + 2);
                END;
            END;
        END;
        EnterCell(Fila, 15, '', '+' + getExcelPosition(Fila + 1, 15) + '+' + getExcelPosition(Fila + 2, 15), 0, TRUE, FALSE, FALSE);
        IF NoExcelFunction THEN BEGIN
            EnterCell(Fila + 1, 15, FORMAT(RealTotal), '', 0, TRUE, FALSE, FALSE);
            EnterCell(Fila + 2, 15, FORMAT(PrevTotal), '', 0, TRUE, FALSE, FALSE);
        END
        ELSE
        BEGIN
            EnterCell(Fila + 1, 15, '', RealTotalFormula, 0, TRUE, FALSE, FALSE);
            EnterCell(Fila + 2, 15, '', PrevTotalFormula, 0, TRUE, FALSE, FALSE);
        END;
        //Crear excel o sheet.
        IF NOT FileCreated THEN BEGIN
            //FileName := FileManagement.ServerTempFileName('xlsx');
            IF DimValue1."Split Dimension" THEN TempExcelBuffer.CreateNewBook(DimValue1.Alias + ' ' + DimValue2.Alias)
            ELSE
                TempExcelBuffer.CreateNewBook(DimValue1.Alias);
            FileCreated:=TRUE;
            IF DimValue1."Split Dimension" THEN TempExcelBuffer.WriteSheet(DimValue1.Alias + ' ' + DimValue2.Alias, COMPANYNAME, USERID)
            ELSE
                TempExcelBuffer.WriteSheet(DimValue1.Alias, COMPANYNAME, USERID);
            TempExcelBuffer.CloseBook();
        END
        ELSE
        BEGIN
            TempExcelBuffer.ActiveNewSheet(TRUE, FileName);
            IF DimValue1."Split Dimension" THEN TempExcelBuffer.WriteSheet(DimValue1.Alias + ' ' + DimValue2.Alias, COMPANYNAME, USERID)
            ELSE
                TempExcelBuffer.WriteSheet(DimValue1.Alias, COMPANYNAME, USERID);
            TempExcelBuffer.CloseBook();
        END;
    end;
    procedure FmtImp(Importe: Decimal): Text[250]begin
        //Añadido OS 20070906
        IF Importe = 0 THEN EXIT('')
        ELSE
            EXIT(FORMAT(Importe));
    end;
    procedure UpdW(TxtToUpdate: Text[100])
    begin
        iNo+=1;
        IF iNo MOD 25 = 0 THEN W.UPDATE(2, TxtToUpdate);
    end;
    procedure GetAmt(JobNo: Code[20]; Type: Code[10]; Month: Integer): Decimal begin
        TmpJobCol."Cod 1":=JobNo;
        TmpJobCol."Cod 2":=Type;
        TmpJobCol."Int 20":=Month;
        IF TmpJobCol.Find()then EXIT(TmpJobCol.Importe1);
    //3526 - MEP - 2022 03 23 - Nuevos filtros 
    //Comentado, se resolvio de otra forma
    /*TmpJobCol.SetRange("Cod 1", JobNo);
        TmpJobCol.SetRange("Cod 2", Type);
        TmpJobCol.SetRange("Int 20", Month);
        IF TmpJobCol.Findfirst() then
            EXIT(TmpJobCol.Importe1);*/
    //3526 - MEP - 2022 03 23 END
    end;
    local procedure FormatNumber(Q: Decimal; Decim: Integer)T: Text var
        Text012: Label '<Precision,%1><Standard Format,0>';
    begin
        //Función para dar formato a las Quantities
        T:=FORMAT(Q, 0, STRSUBSTNO(Text012, FORMAT(Decim)));
        IF Q = 0 THEN T:='';
    end;
    local procedure sumExcelPosition(RowNo: Integer; ColumnNo: Integer)Position: Text[10]begin
        CASE ColumnNo OF 1: Position:='+' + 'A' + FORMAT(RowNo);
        2: Position:='+' + 'B' + FORMAT(RowNo);
        3: Position:='+' + 'C' + FORMAT(RowNo);
        4: Position:='+' + 'D' + FORMAT(RowNo);
        5: Position:='+' + 'E' + FORMAT(RowNo);
        6: Position:='+' + 'F' + FORMAT(RowNo);
        7: Position:='+' + 'G' + FORMAT(RowNo);
        8: Position:='+' + 'H' + FORMAT(RowNo);
        9: Position:='+' + 'I' + FORMAT(RowNo);
        10: Position:='+' + 'J' + FORMAT(RowNo);
        11: Position:='+' + 'K' + FORMAT(RowNo);
        12: Position:='+' + 'L' + FORMAT(RowNo);
        13: Position:='+' + 'M' + FORMAT(RowNo);
        14: Position:='+' + 'N' + FORMAT(RowNo);
        15: Position:='+' + 'O' + FORMAT(RowNo);
        16: Position:='+' + 'P' + FORMAT(RowNo);
        END;
    end;
    local procedure getExcelPosition(RowNo: Integer; ColumnNo: Integer)Position: Text[10]begin
        CASE ColumnNo OF 1: Position:='A' + FORMAT(RowNo);
        2: Position:='B' + FORMAT(RowNo);
        3: Position:='C' + FORMAT(RowNo);
        4: Position:='D' + FORMAT(RowNo);
        5: Position:='E' + FORMAT(RowNo);
        6: Position:='F' + FORMAT(RowNo);
        7: Position:='G' + FORMAT(RowNo);
        8: Position:='H' + FORMAT(RowNo);
        9: Position:='I' + FORMAT(RowNo);
        10: Position:='J' + FORMAT(RowNo);
        11: Position:='K' + FORMAT(RowNo);
        12: Position:='L' + FORMAT(RowNo);
        13: Position:='M' + FORMAT(RowNo);
        14: Position:='N' + FORMAT(RowNo);
        15: Position:='O' + FORMAT(RowNo);
        16: Position:='P' + FORMAT(RowNo);
        END;
    end;
    local procedure FormatNumberExcel(Q: Decimal; Decim: Integer)T: Text var
        Text012: Label '<Precision,%1><Standard Format,0>';
    begin
        //Función para dar formato a las Quantities
        T:=FORMAT(Q, 0, STRSUBSTNO(Text012, FORMAT(Decim)));
    end;
}
