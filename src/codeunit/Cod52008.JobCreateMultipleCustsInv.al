codeunit 52008 "Job-Create Multiple Custs. Inv"
{
    // 030 OS.SPG 20/02/2017  PROY.005  Facturación multicliente desde proyecto
    // 029 OS.SPG 14/02/2017  PROY.004  Generar abono de venta desde factura registrada con imputación a proyectos
    // 053 OS.SPG 27/02/2017  CREAR LAS LINEAS DE TEXTO EN FRA (DE LA CABECERA DEL PROYECTO)
    // EX-OMI 041219 Funcion y desarrollo para limite de credito
    // EX-RBF 220922 Modificaciones para crear factura a cliente de JobplanningLine
    trigger OnRun()
    begin
    end;
    var Currency: Record 4;
    SalesHeader: Record 36;
    SalesHeader2: Record 36;
    SalesLine: Record 37;
    TempJobPlanningLine: Record 1003 temporary;
    Text000: Label 'The lines were successfully transferred to an invoice.';
    Text001: Label 'The lines were not transferred to an invoice.';
    Text002: Label 'There was no %1 with a %2 larger than 0. No lines were transferred.';
    Text003: Label '%1 may not be lower than %2 and may not exceed %3.';
    Text004: Label 'You must specify Invoice No. or New Invoice.';
    Text005: Label 'You must specify Credit Memo No. or New Invoice.';
    Text007: Label 'You must specify %1.';
    TransferExtendedText: Codeunit 378;
    JobInvCurrency: Boolean;
    UpdateExchangeRates: Boolean;
    Text008: Label 'The lines were successfully transferred to a credit memo.';
    Text009: Label 'The selected planning lines must have the same %1.';
    Text010: Label 'The currency dates on all planning lines will be updated based on the invoice posting date because there is a difference in currency exchange rates. Recalculations will be based on the Exch. Calculation setup for the Cost and Price values for the job. Do you want to continue?';
    Text011: Label 'The currency exchange rate on all planning lines will be updated based on the exchange rate on the sales invoice. Do you want to continue?';
    Text012: Label 'The %1 %2 does not exist anymore. A printed copy of the document was created before the document was deleted.', Comment = 'The Sales Invoice Header 103001 does not exist in the system anymore. A printed copy of the document was created before deletion.';
    NoOfSalesLinesCreated: Integer;
    "-----------------": Integer;
    TempJobPlanningLine2: Record 1003 temporary;
    Text50003: Label '%1 no puede ser inferior a %2 ni puede superar %3 en proyecto %4 y línea %5';
    Text50001: Label 'No existe cliente para la línea de planificación %1 del proyecto %2';
    "------------": Integer;
    RealizarComprobacion: Boolean;
    cod_custcreditlimit: Codeunit 312;
    procedure CreateSalesInvoice(var JobPlanningLine: Record 1003; CrMemo: Boolean)
    var
        SalesHeader: Record 36;
        // GetSalesInvoiceNo: Report 1094;
        GetSalesInvoiceNo: Report 52081; //EX-RBF 220922
        // GetSalesCrMemoNo: Report 1092;
        GetSalesCrMemoNo: Report 52082; //EX-RBF 220922
        Done: Boolean;
        NewInvoice: Boolean;
        PostingDate: Date;
        InvoiceNo: Code[20];
    begin
        NewInvoice:=TRUE; //Siempre nueva factura
        IF NOT CrMemo THEN BEGIN
            // GetSalesInvoiceNo.SetCustomer(JobPlanningLine."Job No.");
            GetSalesInvoiceNo.SetCustomer(JobPlanningLine."Customer No. AT"); //EX-RBF 220922
            GetSalesInvoiceNo.USEREQUESTPAGE:=FALSE;
            GetSalesInvoiceNo.InitReport;
            GetSalesInvoiceNo.RUNMODAL;
            GetSalesInvoiceNo.GetInvoiceNo(Done, Done, PostingDate, InvoiceNo);
        END
        ELSE
        BEGIN
            // GetSalesCrMemoNo.SetCustomer(JobPlanningLine."Job No.");
            GetSalesCrMemoNo.SetCustomer(JobPlanningLine."Customer No. AT"); //EX-RBF 220922
            GetSalesCrMemoNo.USEREQUESTPAGE:=FALSE;
            GetSalesCrMemoNo.InitReport;
            GetSalesCrMemoNo.RUNMODAL;
            GetSalesCrMemoNo.GetCreditMemoNo(Done, Done, PostingDate, InvoiceNo);
        END;
        IF Done THEN BEGIN
            IF(PostingDate = 0D) AND NewInvoice THEN ERROR(Text007, SalesHeader.FIELDCAPTION("Posting Date"));
            IF(InvoiceNo = '') AND NOT NewInvoice THEN BEGIN
                IF CrMemo THEN ERROR(Text005);
                ERROR(Text004);
            END;
            IF TransferLine(JobPlanningLine)THEN CreateSalesInvoiceLines(JobPlanningLine."Job No.", JobPlanningLine, InvoiceNo, NewInvoice, PostingDate, CrMemo, JobPlanningLine."Customer No. AT");
        END;
    end;
    local procedure CreateSalesInvoiceLines(JobNo: Code[20]; var JobPlanningLine: Record 1003; InvoiceNo: Code[20]; NewInvoice: Boolean; PostingDate: Date; CreditMemo: Boolean; CustNo: Code[20])
    var
        Job: Record Job;
        JobPlanningLineInvoice: Record 1022;
        LineCounter: Integer;
        UpdJobPlanningLine: Record 1003;
    begin
        ClearAll();
        Job.GET(JobNo);
        IF Job.Blocked = Job.Blocked::All THEN Job.TestBlocked;
        IF Job."Currency Code" = '' THEN JobInvCurrency:=Job."Invoice Currency Code" <> '';
        //Job.TESTFIELD("Bill-to Customer No.");
        //Cust.GET(Job."Bill-to Customer No.");
        IF CreditMemo THEN BEGIN
            SalesHeader2."Document Type":=SalesHeader2."Document Type"::"Credit Memo";
            SalesHeader2."Corrected Invoice No.":=JobPlanningLine."Document No."; //029
        END
        ELSE
            SalesHeader2."Document Type":=SalesHeader2."Document Type"::Invoice;
        IF NOT NewInvoice THEN SalesHeader.GET(SalesHeader2."Document Type", InvoiceNo);
        IF JobPlanningLine.FIND('-')THEN REPEAT IF TransferLine(JobPlanningLine)THEN BEGIN
                    LineCounter:=LineCounter + 1;
                    IF JobPlanningLine."Job No." <> JobNo THEN ERROR(Text009, JobPlanningLine.FIELDCAPTION("Job No."));
                    IF NewInvoice THEN TestExchangeRate(JobPlanningLine, PostingDate)
                    ELSE
                        TestExchangeRate(JobPlanningLine, SalesHeader."Posting Date");
                END;
            UNTIL JobPlanningLine.Next() = 0;
        IF LineCounter = 0 THEN ERROR(Text002, JobPlanningLine.TABLECAPTION, JobPlanningLine.FIELDCAPTION("Qty. to Transfer to Invoice"));
        //300517
        IF CustNo = '' THEN ERROR(Text50001, JobPlanningLine."Line No.", JobPlanningLine."Job No.");
        //300517
        IF NewInvoice THEN CreateSalesheader(Job, PostingDate, CustNo, NoOfSalesLinesCreated)
        ELSE
            TestSalesHeader(SalesHeader, Job, CustNo);
        IF JobPlanningLine.FIND('-')THEN REPEAT IF TransferLine(JobPlanningLine)THEN BEGIN
                    IF JobPlanningLine.Type IN[JobPlanningLine.Type::Resource, JobPlanningLine.Type::Item, JobPlanningLine.Type::"G/L Account"]THEN JobPlanningLine.TESTFIELD("No.");
                    CreateSalesLine(JobPlanningLine);
                    JobPlanningLineInvoice."Job No.":=JobPlanningLine."Job No.";
                    JobPlanningLineInvoice."Job Task No.":=JobPlanningLine."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No.":=JobPlanningLine."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No.":=SalesHeader."No.";
                    JobPlanningLineInvoice."Line No.":=SalesLine."Line No.";
                    JobPlanningLineInvoice."Job Assistant":=SalesLine."Job Assistant";
                    JobPlanningLineInvoice."Quantity Transferred":=JobPlanningLine."Qty. to Transfer to Invoice";
                    IF NewInvoice THEN JobPlanningLineInvoice."Transferred Date":=PostingDate
                    ELSE
                        JobPlanningLineInvoice."Transferred Date":=SalesHeader."Posting Date";
                    JobPlanningLineInvoice.Insert();
                    JobPlanningLine.UpdateQtyToTransfer;
                    JobPlanningLine.Modify();
                    //<029. TEMPORARY
                    IF JobPlanningLine.ISTEMPORARY THEN BEGIN
                        UpdJobPlanningLine.GET(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.", JobPlanningLine."Line No.");
                        UpdJobPlanningLine.TRANSFERFIELDS(JobPlanningLine);
                        UpdJobPlanningLine.Modify();
                    END;
                    //029>
                    CreateTextSalesLine2(JobPlanningLine); //053
                END;
            UNTIL JobPlanningLine.Next() = 0;
        //053
        CreateTextSalesLine(JobNo);
        //053
        IF NoOfSalesLinesCreated = 0 THEN ERROR(Text002, JobPlanningLine.TABLECAPTION, JobPlanningLine.FIELDCAPTION("Qty. to Transfer to Invoice"));
        Commit();
        IF CreditMemo THEN MESSAGE(Text008)
        ELSE
            MESSAGE(Text000);
    end;
    procedure DeleteSalesInvoiceBuffer()
    begin
        ClearAll();
        TempJobPlanningLine.DeleteAll();
    end;
    procedure CreateSalesInvoiceJT(var JT2: Record 1001; PostingDate: Date; InvoicePerTask: Boolean; var NoOfInvoices: Integer; var OldJobNo: Code[20]; var OldJTNo: Code[20]; LastJobTask: Boolean; CustNo: Code[20])
    var
        JobCust: Record "Job Customer AT";
        Cust: Record 18;
        Job: Record Job;
        JT: Record 1001;
        JobPlanningLine: Record 1003;
        JobPlanningLineInvoice: Record 1022;
        "---------------": Integer;
    begin
        ClearAll();
        IF NOT LastJobTask THEN BEGIN
            JT:=JT2;
            IF JT."Job No." = '' THEN EXIT;
            IF JT."Job Task No." = '' THEN EXIT;
            JT.Find();
            IF JT."Job Task Type" <> JT."Job Task Type"::Posting THEN EXIT;
            Job.GET(JT."Job No.");
        END;
        IF LastJobTask THEN BEGIN
            IF NOT(TempJobPlanningLine.FIND('-')) //060
 AND NOT(TempJobPlanningLine2.FIND('-'))THEN //060
 EXIT;
            IF NOT Job.GET(TempJobPlanningLine."Job No.")THEN Job.GET(TempJobPlanningLine2."Job No."); //060
            IF NOT JT.GET(TempJobPlanningLine."Job No.", TempJobPlanningLine."Job Task No.")THEN JT.GET(TempJobPlanningLine2."Job No.", TempJobPlanningLine2."Job Task No."); //060
        END;
        //Job.TESTFIELD("Bill-to Customer No.");
        IF Job.Blocked = Job.Blocked::All THEN Job.TestBlocked;
        IF Job."Currency Code" = '' THEN JobInvCurrency:=Job."Invoice Currency Code" <> '';
        //AQUI
        //Cust.GET(Job."Bill-to Customer No.");
        //JobCust.SETRANGE(JobCust."Job No.",Job."No.");
        Cust.GET(CustNo);
        IF CreateNewInvoice(JT, InvoicePerTask, OldJobNo, OldJTNo, LastJobTask)THEN BEGIN
            //IF JobCust.FindFirst() then REPEAT
            IF NOT Job.GET(TempJobPlanningLine."Job No.")THEN Job.GET(TempJobPlanningLine2."Job No."); //060
            IF NOT JT.GET(TempJobPlanningLine."Job No.", TempJobPlanningLine."Job Task No.")THEN JT.GET(TempJobPlanningLine2."Job No.", TempJobPlanningLine2."Job Task No."); //060
            IF Job."Currency Code" = '' THEN JobInvCurrency:=Job."Invoice Currency Code" <> '';
            //Cust.GET(Job."Bill-to Customer No.");n
            //Cust.GET(JobCust."Customer No.");
            TempJobPlanningLine.SetCurrentKey("Customer No. AT");
            IF TempJobPlanningLine.FIND('-')THEN BEGIN
                //NoOfInvoices := NoOfInvoices + 1;
                //SalesHeader2."Document Type" := SalesHeader2."Document Type"::Invoice;
                //CreateSalesheader(Job,PostingDate,JobCust."Customer No.");                                
                REPEAT SalesHeader2."Document Type":=SalesHeader2."Document Type"::Invoice; //EX/RBF 290922                    
                    CreateSalesheader(Job, PostingDate, TempJobPlanningLine."Customer No. AT", NoOfInvoices); //EX-RBF 290922
                    JobPlanningLine:=TempJobPlanningLine;
                    JobPlanningLine.Find();
                    IF JobPlanningLine.Type IN[JobPlanningLine.Type::Resource, JobPlanningLine.Type::Item, JobPlanningLine.Type::"G/L Account"]THEN JobPlanningLine.TESTFIELD("No.");
                    TestExchangeRate(JobPlanningLine, PostingDate);
                    CreateSalesLine(JobPlanningLine);
                    JobPlanningLineInvoice."Job No.":=JobPlanningLine."Job No.";
                    JobPlanningLineInvoice."Job Task No.":=JobPlanningLine."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No.":=JobPlanningLine."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No.":=SalesHeader."No.";
                    JobPlanningLineInvoice."Line No.":=SalesLine."Line No.";
                    JobPlanningLineInvoice."Quantity Transferred":=JobPlanningLine."Qty. to Transfer to Invoice";
                    JobPlanningLineInvoice."Transferred Date":=PostingDate;
                    JobPlanningLineInvoice.Insert();
                    JobPlanningLine.UpdateQtyToTransfer;
                    JobPlanningLine.Modify();
                    CreateTextSalesLine2(JobPlanningLine); //053
                UNTIL TempJobPlanningLine.Next() = 0;
            //UNTIL JobCust.Next() = 0;
            END;
            TempJobPlanningLine.DeleteAll();
            //060 //facturas de gastos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            TempJobPlanningLine2.SetCurrentKey("Customer No. AT");
            IF TempJobPlanningLine2.FIND('-')THEN BEGIN
                // NoOfInvoices := NoOfInvoices + 1;
                // SalesHeader2."Document Type" := SalesHeader2."Document Type"::Invoice;
                // CreateSalesheader(Job, PostingDate, CustNo);
                REPEAT SalesHeader2."Document Type":=SalesHeader2."Document Type"::Invoice; //EX-RBF 290922
                    // CreateSalesheader(Job, PostingDate, CustNo);//EX-RBF 290922
                    CreateSalesheader(Job, PostingDate, TempJobPlanningLine2."Customer No. AT", NoOfInvoices); //EX-RBF 290922
                    JobPlanningLine:=TempJobPlanningLine2;
                    JobPlanningLine.Find();
                    IF JobPlanningLine.Type IN[JobPlanningLine.Type::Resource, JobPlanningLine.Type::Item, JobPlanningLine.Type::"G/L Account"]THEN JobPlanningLine.TESTFIELD("No.");
                    TestExchangeRate(JobPlanningLine, PostingDate);
                    CreateSalesLine(JobPlanningLine);
                    JobPlanningLineInvoice."Job No.":=JobPlanningLine."Job No.";
                    JobPlanningLineInvoice."Job Task No.":=JobPlanningLine."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No.":=JobPlanningLine."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No.":=SalesHeader."No.";
                    JobPlanningLineInvoice."Line No.":=SalesLine."Line No.";
                    JobPlanningLineInvoice."Quantity Transferred":=JobPlanningLine."Qty. to Transfer to Invoice";
                    JobPlanningLineInvoice."Transferred Date":=PostingDate;
                    JobPlanningLineInvoice.Insert();
                    JobPlanningLine.UpdateQtyToTransfer;
                    JobPlanningLine.Modify();
                UNTIL TempJobPlanningLine2.Next() = 0;
                TempJobPlanningLine2.DeleteAll();
            END;
        //060
        END;
        IF LastJobTask THEN BEGIN
            IF NoOfSalesLinesCreated = 0 THEN ERROR(Text002, JobPlanningLine.TABLECAPTION, JobPlanningLine.FIELDCAPTION("Qty. to Transfer to Invoice"));
            EXIT;
        END;
        JobPlanningLine.Reset();
        JobPlanningLine.SETCURRENTKEY("Job No.", "Job Task No.");
        JobPlanningLine.SETRANGE("Job No.", JT2."Job No.");
        JobPlanningLine.SETRANGE("Job Task No.", JT2."Job Task No.");
        JobPlanningLine.SETFILTER("Planning Date", JT2.GETFILTER("Planning Date Filter"));
        //<
        IF JobPlanningLine."Customer No. AT" <> '' THEN JobPlanningLine.SETFILTER("Customer No. AT", CustNo);
        JobPlanningLine.SETRANGE("Confirmed AT", TRUE); //010617
        //>
        IF JobPlanningLine.FIND('-')THEN REPEAT //060
 Job.GET(JobPlanningLine."Job No.");
                IF(NOT Job."Expenses on same Invoice AT") AND ((JobPlanningLine."Direct Unit Cost (LCY)" <> 0) AND (JobPlanningLine."Unit Price" <> 0))THEN BEGIN //línea de gasto
                    IF TransferLine(JobPlanningLine)THEN BEGIN
                        TempJobPlanningLine2:=JobPlanningLine;
                        //TempJobPlanningLine2.Insert();
                        IF NOT TempJobPlanningLine2.Insert()then TempJobPlanningLine2.Modify()END;
                END
                ELSE
                BEGIN
                    //060
                    IF TransferLine(JobPlanningLine)THEN BEGIN
                        TempJobPlanningLine:=JobPlanningLine;
                        //TempJobPlanningLine.Insert();
                        IF NOT TempJobPlanningLine.Insert()then TempJobPlanningLine.Modify();
                    END;
                //060
                END;
            //060
            UNTIL JobPlanningLine.Next() = 0;
    end;
    local procedure CreateNewInvoice(var JT: Record 1001; InvoicePerTask: Boolean; var OldJobNo: Code[20]; var OldJTNo: Code[20]; LastJobTask: Boolean): Boolean var
        NewInvoice: Boolean;
    begin
        IF LastJobTask THEN NewInvoice:=TRUE
        ELSE
        BEGIN
            IF OldJobNo <> '' THEN BEGIN
                IF InvoicePerTask THEN IF(OldJobNo <> JT."Job No.") OR (OldJTNo <> JT."Job Task No.")THEN NewInvoice:=TRUE;
                IF NOT InvoicePerTask THEN IF OldJobNo <> JT."Job No." THEN NewInvoice:=TRUE;
            END;
            OldJobNo:=JT."Job No.";
            OldJTNo:=JT."Job Task No.";
        END;
        //060
        IF NOT(TempJobPlanningLine.FIND('-')) AND NOT(TempJobPlanningLine2.FIND('-'))THEN NewInvoice:=FALSE;
        //060
        EXIT(NewInvoice);
    end;
    local procedure CreateSalesheader(Job: Record Job; PostingDate: Date; CustNo: Code[20]; var NoOfInvoices: integer)
    var
        SalesSetup: Record 311;
        Cust: Record 18;
        JobCust: Record "Job Customer AT";
        lRecSalesHeader: Record 36;
    begin
        lRecSalesHeader.SetRange("Job No.", Job."No.");
        lRecSalesHeader.SETRANGE("Sell-to Customer No.", CustNo);
        lRecSalesHeader.SetRange("Posting Date", PostingDate);
        if not lRecSalesHeader.findfirst()then begin
            CLEAR(SalesHeader);
            NoOfInvoices:=NoOfInvoices + 1;
            SalesHeader."Document Type":=SalesHeader2."Document Type";
            SalesHeader."Corrected Invoice No.":=SalesHeader2."Corrected Invoice No."; //029
            SalesSetup.Get();
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN SalesSetup.TESTFIELD("Invoice Nos.");
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN SalesSetup.TESTFIELD("Credit Memo Nos.");
            SalesHeader."Posting Date":=PostingDate;
            SalesHeader.INSERT(TRUE);
            //Cust.GET(Job."Bill-to Customer No.");
            Cust.GET(CustNo);
            Cust.TESTFIELD("Bill-to Customer No.", '');
            //SalesHeader.VALIDATE("Sell-to Customer No.",Job."Bill-to Customer No.");
            SalesHeader.VALIDATE("Sell-to Customer No.", CustNo);
            IF Job."Currency Code" <> '' THEN SalesHeader.VALIDATE("Currency Code", Job."Currency Code")
            ELSE
                SalesHeader.VALIDATE("Currency Code", Job."Invoice Currency Code");
            IF PostingDate <> 0D THEN SalesHeader.VALIDATE("Posting Date", PostingDate);
            SalesHeader."External Job Document No.":=Job."External Job Document No. AT";
            UpdateSalesHeader(SalesHeader, Job, CustNo);
            //EX-OMI 041219
            //Todo:: implement SalesHeaderCheckPersonalizada
            /* IF RealizarComprobacion THEN
                cod_custcreditlimit.SalesHeaderCheck(SalesHeader); */
            SalesHeader."Job No.":=Job."No."; //EX-RBF 290922
            SalesHeader.MODIFY(TRUE);
        end end;
    local procedure CreateSalesLine(var JobPlanningLine: Record 1003)
    var
        Job: Record Job;
        DimMgt: Codeunit DimensionManagement;
        Factor: Integer;
        DimSetIDArr: array[10]of Integer;
    begin
        Factor:=1;
        IF SalesHeader2."Document Type" = SalesHeader2."Document Type"::"Credit Memo" THEN Factor:=-1;
        TestTransferred(JobPlanningLine);
        JobPlanningLine.TESTFIELD("Planning Date");
        Job.GET(JobPlanningLine."Job No.");
        CLEAR(SalesLine);
        SalesLine."Document Type":=SalesHeader2."Document Type";
        SalesLine."Document No.":=SalesHeader."No.";
        IF(NOT JobInvCurrency) AND (JobPlanningLine.Type <> JobPlanningLine.Type::Text)THEN BEGIN
            SalesHeader.TESTFIELD("Currency Code", JobPlanningLine."Currency Code");
            IF Job."Currency Code" <> '' THEN BEGIN
                IF CONFIRM(Text011)THEN BEGIN
                    JobPlanningLine.VALIDATE("Currency Factor", SalesHeader."Currency Factor");
                    JobPlanningLine.Modify();
                END
                ELSE
                    ERROR(Text001);
            END;
            SalesHeader.TESTFIELD("Currency Code", Job."Currency Code");
        END;
        IF JobPlanningLine.Type = JobPlanningLine.Type::Text THEN SalesLine.VALIDATE(Type, SalesLine.Type::" ");
        IF JobPlanningLine.Type = JobPlanningLine.Type::"G/L Account" THEN SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
        IF JobPlanningLine.Type = JobPlanningLine.Type::Item THEN SalesLine.VALIDATE(Type, SalesLine.Type::Item);
        IF JobPlanningLine.Type = JobPlanningLine.Type::Resource THEN SalesLine.VALIDATE(Type, SalesLine.Type::Resource);
        SalesLine.VALIDATE("No.", JobPlanningLine."No.");
        //SalesLine.VALIDATE("Gen. Prod. Posting Group",JobPlanningLine."Gen. Prod. Posting Group"); //082
        SalesLine.VALIDATE("Location Code", JobPlanningLine."Location Code");
        SalesLine.VALIDATE("Work Type Code", JobPlanningLine."Work Type Code");
        SalesLine.VALIDATE("Variant Code", JobPlanningLine."Variant Code");
        IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
            SalesLine.VALIDATE("Unit of Measure Code", JobPlanningLine."Unit of Measure Code");
            SalesLine.VALIDATE(Quantity, Factor * JobPlanningLine."Qty. to Transfer to Invoice");
            IF JobInvCurrency THEN BEGIN
                Currency.GET(SalesLine."Currency Code");
                SalesLine.VALIDATE("Unit Price", ROUND(JobPlanningLine."Unit Price" * SalesHeader."Currency Factor", Currency."Unit-Amount Rounding Precision"));
            END
            ELSE
                SalesLine.VALIDATE("Unit Price", JobPlanningLine."Unit Price");
            SalesLine.VALIDATE("Unit Cost (LCY)", JobPlanningLine."Unit Cost (LCY)");
            SalesLine.VALIDATE("Line Discount %", JobPlanningLine."Line Discount %");
            SalesLine."Inv. Discount Amount":=0;
            SalesLine."Inv. Disc. Amount to Invoice":=0;
            SalesLine.UpdateAmounts;
        END;
        IF NOT SalesHeader."Prices Including VAT" THEN SalesLine.VALIDATE("Job Contract Entry No.", JobPlanningLine."Job Contract Entry No.");
        //<231117
        //SalesLine."Job No." :"Job No." := JobPlanningLine."Job No.";
        SalesLine.VALIDATE("Job No.", JobPlanningLine."Job No.");
        //231117>
        SalesLine."Job Task No.":=JobPlanningLine."Job Task No.";
        IF SalesLine."Job Task No." <> '' THEN BEGIN
            DimSetIDArr[1]:=SalesLine."Dimension Set ID";
            DimSetIDArr[2]:=DimMgt.CreateDimSetFromJobTaskDim(SalesLine."Job No.", SalesLine."Job Task No.", SalesLine."Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 2 Code");
            DimSetIDArr[3]:=GetLedgEntryDimSetID(JobPlanningLine);
            DimSetIDArr[4]:=GetJobLedgEntryDimSetID(JobPlanningLine);
            SalesLine."Dimension Set ID":=DimMgt.GetCombinedDimensionSetID(DimSetIDArr, SalesLine."Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 2 Code");
        END;
        SalesLine.Description:=JobPlanningLine.Description;
        SalesLine."Description 2":=JobPlanningLine."Description 2";
        SalesLine."Job Assistant":=JobPlanningLine."Job Assistant AT";
        SalesLine."Cust Order Purch No.":=JobPlanningLine."External Job Document No. AT"; //260517
        SalesLine."Line No.":=GetNextLineNo(SalesLine);
        //011
        IF(JobPlanningLine."Direct Unit Cost (LCY)" <> 0) AND (JobPlanningLine."Unit Price" <> 0)THEN SalesLine."Line Type":=SalesLine."Line Type"::Expense;
        //011
        SalesLine.INSERT(TRUE);
        IF SalesLine.Type <> SalesLine.Type::" " THEN NoOfSalesLinesCreated+=1;
        IF SalesHeader."Prices Including VAT" AND (SalesLine.Type <> SalesLine.Type::" ")THEN BEGIN
            IF SalesLine."Currency Code" = '' THEN Currency.InitRoundingPrecision
            ELSE
                Currency.GET(SalesLine."Currency Code");
            SalesLine."Unit Price":=ROUND(SalesLine."Unit Price" * (1 + (SalesLine."VAT %" / 100)), Currency."Unit-Amount Rounding Precision");
            IF SalesLine.Quantity <> 0 THEN BEGIN
                SalesLine."Line Discount Amount":=ROUND(SalesLine.Quantity * SalesLine."Unit Price" * SalesLine."Line Discount %" / 100, Currency."Amount Rounding Precision");
                SalesLine.VALIDATE("Inv. Discount Amount", ROUND(SalesLine."Inv. Discount Amount" * (1 + (SalesLine."VAT %" / 100)), Currency."Amount Rounding Precision"));
            END;
            SalesLine.VALIDATE("Job Contract Entry No.", JobPlanningLine."Job Contract Entry No.");
            SalesLine.Modify();
            JobPlanningLine."VAT Unit Price":=SalesLine."Unit Price";
            JobPlanningLine."VAT Line Discount Amount":=SalesLine."Line Discount Amount";
            JobPlanningLine."VAT Line Amount":=SalesLine."Line Amount";
            JobPlanningLine."VAT %":=SalesLine."VAT %";
        END;
        IF TransferExtendedText.SalesCheckIfAnyExtText(SalesLine, FALSE)THEN TransferExtendedText.InsertSalesExtText(SalesLine);
    end;
    local procedure TransferLine(var JobPlanningLine: Record 1003): Boolean begin
        IF NOT JobPlanningLine."Contract Line" THEN EXIT(FALSE);
        IF JobPlanningLine.Type = JobPlanningLine.Type::Text THEN EXIT(TRUE);
        EXIT(JobPlanningLine."Qty. to Transfer to Invoice" <> 0);
    end;
    local procedure GetNextLineNo(SalesLine: Record 37): Integer var
        NextLineNo: Integer;
    begin
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type");
        SalesLine.SETRANGE("Document No.", SalesLine."Document No.");
        NextLineNo:=10000;
        IF SalesLine.FindLast()then NextLineNo:=SalesLine."Line No." + 10000;
        EXIT(NextLineNo);
    end;
    local procedure TestTransferred(JobPlanningLine: Record 1003)
    begin
        JobPlanningLine.CALCFIELDS("Qty. Transferred to Invoice");
        IF JobPlanningLine.Quantity > 0 THEN BEGIN
            IF(JobPlanningLine."Qty. to Transfer to Invoice" > 0) AND (JobPlanningLine."Qty. to Transfer to Invoice" > (JobPlanningLine.Quantity - JobPlanningLine."Qty. Transferred to Invoice")) OR (JobPlanningLine."Qty. to Transfer to Invoice" < 0)THEN //ERROR(Text003,FIELDCAPTION("Qty. to Transfer to Invoice"),0,Quantity - "Qty. Transferred to Invoice");
 ERROR(Text50003, JobPlanningLine.FIELDCAPTION("Qty. to Transfer to Invoice"), 0, JobPlanningLine.Quantity - JobPlanningLine."Qty. Transferred to Invoice", JobPlanningLine."Job No.", JobPlanningLine."Line No.");
        END
        ELSE
        BEGIN
            IF(JobPlanningLine."Qty. to Transfer to Invoice" > 0) OR (JobPlanningLine."Qty. to Transfer to Invoice" < 0) AND (JobPlanningLine."Qty. to Transfer to Invoice" < (JobPlanningLine.Quantity - JobPlanningLine."Qty. Transferred to Invoice"))THEN ERROR(Text003, JobPlanningLine.FIELDCAPTION("Qty. to Transfer to Invoice"), JobPlanningLine.Quantity - JobPlanningLine."Qty. Transferred to Invoice", 0);
        END;
    end;
    procedure DeleteSalesLine(SalesLine: Record 37)
    var
        JobPlanningLineInvoice: Record 1022;
        JobPlanningLine: Record 1003;
    begin
        CASE SalesLine."Document Type" OF SalesLine."Document Type"::Invoice: JobPlanningLineInvoice.SETRANGE("Document Type", JobPlanningLineInvoice."Document Type"::Invoice);
        SalesLine."Document Type"::"Credit Memo": JobPlanningLineInvoice.SETRANGE("Document Type", JobPlanningLineInvoice."Document Type"::"Credit Memo");
        END;
        JobPlanningLineInvoice.SETRANGE("Document No.", SalesLine."Document No.");
        JobPlanningLineInvoice.SETRANGE("Line No.", SalesLine."Line No.");
        IF JobPlanningLineInvoice.FindSet()THEN REPEAT JobPlanningLine.GET(JobPlanningLineInvoice."Job No.", JobPlanningLineInvoice."Job Task No.", JobPlanningLineInvoice."Job Planning Line No.");
                JobPlanningLineInvoice.DELETE;
                JobPlanningLine.UpdateQtyToTransfer;
                JobPlanningLine.Modify();
            UNTIL JobPlanningLineInvoice.Next() = 0;
    end;
    procedure FindInvoices(var TempJobPlanningLineInvoice: Record 1022 temporary; JobNo: Code[20]; JobTaskNo: Code[20]; JobPlanningLineNo: Integer; DetailLevel: Option All, "Per Job", "Per Job Task", "Per Job Planning Line")
    var
        JobPlanningLineInvoice: Record 1022;
        RecordFound: Boolean;
    begin
        CASE DetailLevel OF DetailLevel::All: BEGIN
            IF JobPlanningLineInvoice.FindSet()then TempJobPlanningLineInvoice:=JobPlanningLineInvoice;
            EXIT;
        END;
        DetailLevel::"Per Job": JobPlanningLineInvoice.SETRANGE("Job No.", JobNo);
        DetailLevel::"Per Job Task": BEGIN
            JobPlanningLineInvoice.SETRANGE("Job No.", JobNo);
            JobPlanningLineInvoice.SETRANGE("Job Task No.", JobTaskNo);
        END;
        DetailLevel::"Per Job Planning Line": BEGIN
            JobPlanningLineInvoice.SETRANGE("Job No.", JobNo);
            JobPlanningLineInvoice.SETRANGE("Job Task No.", JobTaskNo);
            JobPlanningLineInvoice.SETRANGE("Job Planning Line No.", JobPlanningLineNo);
        END;
        END;
        TempJobPlanningLineInvoice.DeleteAll();
        IF JobPlanningLineInvoice.FindSet()then BEGIN
            REPEAT RecordFound:=FALSE;
                CASE DetailLevel OF DetailLevel::"Per Job": IF TempJobPlanningLineInvoice.GET(JobNo, '', 0, JobPlanningLineInvoice."Document Type", JobPlanningLineInvoice."Document No.", 0)THEN RecordFound:=TRUE;
                DetailLevel::"Per Job Task": IF TempJobPlanningLineInvoice.GET(JobNo, JobTaskNo, 0, JobPlanningLineInvoice."Document Type", JobPlanningLineInvoice."Document No.", 0)THEN RecordFound:=TRUE;
                DetailLevel::"Per Job Planning Line": IF TempJobPlanningLineInvoice.GET(JobNo, JobTaskNo, JobPlanningLineNo, JobPlanningLineInvoice."Document Type", JobPlanningLineInvoice."Document No.", 0)THEN RecordFound:=TRUE;
                END;
                IF RecordFound THEN BEGIN
                    TempJobPlanningLineInvoice."Quantity Transferred"+=JobPlanningLineInvoice."Quantity Transferred";
                    TempJobPlanningLineInvoice."Invoiced Amount (LCY)"+=JobPlanningLineInvoice."Invoiced Amount (LCY)";
                    TempJobPlanningLineInvoice."Invoiced Cost Amount (LCY)"+=JobPlanningLineInvoice."Invoiced Cost Amount (LCY)";
                    TempJobPlanningLineInvoice.Modify();
                END
                ELSE
                BEGIN
                    CASE DetailLevel OF DetailLevel::"Per Job": TempJobPlanningLineInvoice."Job No.":=JobNo;
                    DetailLevel::"Per Job Task": BEGIN
                        TempJobPlanningLineInvoice."Job No.":=JobNo;
                        TempJobPlanningLineInvoice."Job Task No.":=JobTaskNo;
                    END;
                    DetailLevel::"Per Job Planning Line": BEGIN
                        TempJobPlanningLineInvoice."Job No.":=JobNo;
                        TempJobPlanningLineInvoice."Job Task No.":=JobTaskNo;
                        TempJobPlanningLineInvoice."Job Planning Line No.":=JobPlanningLineNo;
                    END;
                    END;
                    TempJobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type";
                    TempJobPlanningLineInvoice."Document No.":=JobPlanningLineInvoice."Document No.";
                    TempJobPlanningLineInvoice."Quantity Transferred":=JobPlanningLineInvoice."Quantity Transferred";
                    TempJobPlanningLineInvoice."Invoiced Amount (LCY)":=JobPlanningLineInvoice."Invoiced Amount (LCY)";
                    TempJobPlanningLineInvoice."Invoiced Cost Amount (LCY)":=JobPlanningLineInvoice."Invoiced Cost Amount (LCY)";
                    TempJobPlanningLineInvoice.Insert();
                END;
            UNTIL JobPlanningLineInvoice.Next() = 0;
        END;
    end;
    procedure GetJobPlanningLineInvoices(JobPlanningLine: Record 1003)
    var
        JobPlanningLineInvoice: Record 1022;
    begin
        ClearAll();
        IF JobPlanningLine."Line No." = 0 THEN EXIT;
        JobPlanningLine.TESTFIELD("Job No.");
        JobPlanningLine.TESTFIELD("Job Task No.");
        JobPlanningLineInvoice.SETRANGE("Job No.", JobPlanningLine."Job No.");
        JobPlanningLineInvoice.SETRANGE("Job Task No.", JobPlanningLine."Job Task No.");
        JobPlanningLineInvoice.SETRANGE("Job Planning Line No.", JobPlanningLine."Line No.");
        IF JobPlanningLineInvoice.COUNT = 1 THEN BEGIN
            JobPlanningLineInvoice.FindFirst();
            OpenSalesInvoice(JobPlanningLineInvoice);
        END
        ELSE
            PAGE.RUNMODAL(PAGE::"Job Invoices", JobPlanningLineInvoice);
    end;
    procedure OpenSalesInvoice(JobPlanningLineInvoice: Record 1022)
    var
        SalesHeader: Record 36;
        SalesInvHeader: Record 112;
        SalesCrMemoHeader: Record 114;
    begin
        CASE JobPlanningLineInvoice."Document Type" OF JobPlanningLineInvoice."Document Type"::Invoice: BEGIN
            SalesHeader.GET(SalesHeader."Document Type"::Invoice, JobPlanningLineInvoice."Document No.");
            PAGE.RUNMODAL(PAGE::"Sales Invoice", SalesHeader);
        END;
        JobPlanningLineInvoice."Document Type"::"Credit Memo": BEGIN
            SalesHeader.GET(SalesHeader."Document Type"::"Credit Memo", JobPlanningLineInvoice."Document No.");
            PAGE.RUNMODAL(PAGE::"Sales Credit Memo", SalesHeader);
        END;
        JobPlanningLineInvoice."Document Type"::"Posted Invoice": BEGIN
            IF NOT SalesInvHeader.GET(JobPlanningLineInvoice."Document No.")THEN ERROR(Text012, SalesInvHeader.TABLECAPTION, JobPlanningLineInvoice."Document No.");
            PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", SalesInvHeader);
        END;
        JobPlanningLineInvoice."Document Type"::"Posted Credit Memo": BEGIN
            IF NOT SalesCrMemoHeader.GET(JobPlanningLineInvoice."Document No.")THEN ERROR(Text012, SalesCrMemoHeader.TABLECAPTION, JobPlanningLineInvoice."Document No.");
            PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
        END;
        END;
    end;
    local procedure UpdateSalesHeader(var SalesHeader: Record 36; Job: Record Job; CustNo: Code[20])
    var
        Cust: Record 18;
    begin
        Cust.GET(CustNo);
        SalesHeader."Bill-to Contact No.":=CustNo;
        SalesHeader."Bill-to Contact":=Cust.Contact;
        SalesHeader."Bill-to Name":=Cust.Name;
        SalesHeader."Bill-to Address":=Cust.Address;
        SalesHeader."Bill-to Address 2":=Cust."Address 2";
        SalesHeader."Bill-to City":=Cust.City;
        SalesHeader."Bill-to Post Code":=Cust."Post Code";
        SalesHeader."Sell-to Contact No.":=CustNo;
        SalesHeader."Sell-to Contact":=Cust.Contact;
        SalesHeader."Sell-to Customer Name":=Cust.Name;
        SalesHeader."Sell-to Address":=Cust.Address;
        SalesHeader."Sell-to Address 2":=Cust."Address 2";
        SalesHeader."Sell-to City":=Cust.City;
        SalesHeader."Sell-to Post Code":=Cust."Post Code";
        SalesHeader."Ship-to Contact":=Cust.Contact;
        SalesHeader."Ship-to Name":=Cust.Name;
        SalesHeader."Ship-to Address":=Cust.Address;
        SalesHeader."Ship-to Address 2":=Cust."Address 2";
        SalesHeader."Ship-to City":=Cust.City;
        SalesHeader."Ship-to Post Code":=Cust."Post Code";
        SalesHeader."External Job Document No.":=Job."External Job Document No. AT";
    end;
    local procedure TestSalesHeader(var SalesHeader: Record 36; var Job: Record Job; CustNo: Code[20])
    begin
        SalesHeader.TESTFIELD("Bill-to Customer No.", CustNo);
        SalesHeader.TESTFIELD("Sell-to Customer No.", CustNo);
        IF Job."Currency Code" <> '' THEN SalesHeader.TESTFIELD("Currency Code", Job."Currency Code")
        ELSE
            SalesHeader.TESTFIELD("Currency Code", Job."Invoice Currency Code");
    end;
    local procedure TestExchangeRate(var JobPlanningLine: Record 1003; PostingDate: Date)
    var
        CurrencyExchangeRate: Record 330;
    begin
        IF JobPlanningLine."Currency Code" <> '' THEN IF(CurrencyExchangeRate.ExchangeRate(PostingDate, JobPlanningLine."Currency Code") <> JobPlanningLine."Currency Factor")THEN BEGIN
                IF NOT UpdateExchangeRates THEN UpdateExchangeRates:=CONFIRM(Text010, TRUE);
                IF UpdateExchangeRates THEN BEGIN
                    JobPlanningLine."Currency Date":=PostingDate;
                    JobPlanningLine."Document Date":=PostingDate;
                    JobPlanningLine.VALIDATE("Currency Date");
                    JobPlanningLine."Last Date Modified":=TODAY;
                    JobPlanningLine."User ID":=USERID;
                    JobPlanningLine.MODIFY(TRUE);
                END
                ELSE
                    ERROR('');
            END;
    end;
    local procedure GetLedgEntryDimSetID(JobPlanningLine: Record 1003): Integer var
        ResLedgEntry: Record 203;
        ItemLedgEntry: Record 32;
        GLEntry: Record 17;
    begin
        IF JobPlanningLine."Ledger Entry No." = 0 THEN EXIT(0);
        CASE JobPlanningLine."Ledger Entry Type" OF JobPlanningLine."Ledger Entry Type"::Resource: BEGIN
            ResLedgEntry.GET(JobPlanningLine."Ledger Entry No.");
            EXIT(ResLedgEntry."Dimension Set ID");
        END;
        JobPlanningLine."Ledger Entry Type"::Item: BEGIN
            ItemLedgEntry.GET(JobPlanningLine."Ledger Entry No.");
            EXIT(ItemLedgEntry."Dimension Set ID");
        END;
        JobPlanningLine."Ledger Entry Type"::"G/L Account": BEGIN
            //300517
            IF //300517
 GLEntry.GET(JobPlanningLine."Ledger Entry No.")THEN EXIT(GLEntry."Dimension Set ID");
        END;
        ELSE
            EXIT(0);
        END;
    end;
    local procedure GetJobLedgEntryDimSetID(JobPlanningLine: Record 1003): Integer var
        JobLedgerEntry: Record 169;
    begin
        IF JobPlanningLine."Job Ledger Entry No." = 0 THEN EXIT(0);
        IF JobLedgerEntry.GET(JobPlanningLine."Job Ledger Entry No.")THEN EXIT(JobLedgerEntry."Dimension Set ID");
        EXIT(0);
    end;
    local procedure "------------------"()
    begin
    end;
    local procedure CreateTextSalesLine(JobNumber: Code[20])
    var
        Job: Record Job;
    begin
        IF NOT Job.GET(JobNumber)THEN EXIT;
        IF SalesHeader2."Corrected Invoice No." <> '' THEN //es un abono
 EXIT;
        CLEAR(SalesLine);
        SalesLine."Document Type":=SalesHeader2."Document Type";
        SalesLine."Document No.":=SalesHeader."No.";
        SalesLine.VALIDATE(Type, SalesLine.Type::" ");
        IF Job."Invoice Text 1 AT" <> '' THEN BEGIN
            SalesLine."Line No.":=GetNextLineNo(SalesLine);
            SalesLine.Description:=COPYSTR(Job."Invoice Text 1 AT", 1, 50);
            SalesLine.INSERT(TRUE);
            SalesLine."Line No.":=GetNextLineNo(SalesLine);
            SalesLine.Description:=COPYSTR(Job."Invoice Text 1 AT", 51, 100);
            SalesLine.INSERT(TRUE);
        END;
        IF Job."Invoice Text 2 AT" <> '' THEN BEGIN
            SalesLine."Line No.":=GetNextLineNo(SalesLine);
            SalesLine.Description:=Job."Invoice Text 2 AT";
            SalesLine.INSERT(TRUE);
        END;
        IF Job."Invoice Text 3 AT" <> '' THEN BEGIN
            SalesLine."Line No.":=GetNextLineNo(SalesLine);
            SalesLine.Description:=Job."Invoice Text 3 AT";
            SalesLine.INSERT(TRUE);
        END;
    end;
    local procedure CreateNewInvoiceForExpenses()
    begin
    end;
    local procedure CreateTextSalesLine2(JobPlanningLine: Record 1003)
    var
        JobPlannDescr: Record "Job Concept Descriptions";
        JobPlanningLine2: Record 1003;
    begin
        JobPlannDescr.SETRANGE("Job No.", JobPlanningLine."Job No.");
        JobPlannDescr.SETRANGE(JobPlannDescr."Job Task No.", JobPlanningLine."Job Task No.");
        //190517
        IF SalesHeader2."Corrected Invoice No." <> '' THEN BEGIN //es un abono
            JobPlanningLine2.SETRANGE(JobPlanningLine2."Job Contract Entry No.", JobPlanningLine."Job Cntr. Entry No. to Cred AT");
            IF JobPlanningLine2.FIND('-')THEN JobPlannDescr.SETRANGE(JobPlannDescr."Job Plan. Line No.", JobPlanningLine2."Line No.");
        END
        ELSE
            //190517
            JobPlannDescr.SETRANGE(JobPlannDescr."Job Plan. Line No.", JobPlanningLine."Line No.");
        IF JobPlannDescr.FIND('-')THEN REPEAT CLEAR(SalesLine);
                SalesLine."Document Type":=SalesHeader2."Document Type";
                SalesLine."Document No.":=SalesHeader."No.";
                SalesLine.VALIDATE(Type, SalesLine.Type::" ");
                SalesLine."Line No.":=GetNextLineNo(SalesLine);
                SalesLine.Description:=JobPlannDescr.Description;
                SalesLine.INSERT(TRUE);
            UNTIL JobPlannDescr.Next() = 0;
    end;
    procedure CreateSalesInvoiceJT2(var JT2: Record 1001; PostingDate: Date; InvoicePerTask: Boolean; var NoOfInvoices: Integer; var OldJobNo: Code[20]; var OldJTNo: Code[20]; LastJobTask: Boolean; CustNo: Code[20])
    var
        JobCust: Record "Job Customer AT";
        Cust: Record 18;
        Job: Record Job;
        JT: Record 1001;
        JobPlanningLine: Record 1003;
        JobPlanningLineInvoice: Record 1022;
        "---------------": Integer;
    begin
        ClearAll();
        IF NOT LastJobTask THEN BEGIN
            JT:=JT2;
            IF JT."Job No." = '' THEN EXIT;
            IF JT."Job Task No." = '' THEN EXIT;
            JT.Find();
            IF JT."Job Task Type" <> JT."Job Task Type"::Posting THEN EXIT;
            Job.GET(JT."Job No.");
        END;
        IF LastJobTask THEN BEGIN
            IF NOT(TempJobPlanningLine.FIND('-')) //060
 AND NOT(TempJobPlanningLine2.FIND('-'))THEN //060
 EXIT;
            IF NOT Job.GET(TempJobPlanningLine."Job No.")THEN Job.GET(TempJobPlanningLine2."Job No."); //060
            IF NOT JT.GET(TempJobPlanningLine."Job No.", TempJobPlanningLine."Job Task No.")THEN JT.GET(TempJobPlanningLine2."Job No.", TempJobPlanningLine2."Job Task No."); //060
        END;
        //Job.TESTFIELD("Bill-to Customer No.");
        IF Job.Blocked = Job.Blocked::All THEN Job.TestBlocked;
        IF Job."Currency Code" = '' THEN JobInvCurrency:=Job."Invoice Currency Code" <> '';
        //AQUI
        //Cust.GET(Job."Bill-to Customer No.");
        //JobCust.SETRANGE(JobCust."Job No.",Job."No.");
        Cust.GET(CustNo);
        IF CreateNewInvoice(JT, InvoicePerTask, OldJobNo, OldJTNo, LastJobTask)THEN BEGIN
            //IF JobCust.FindFirst() then REPEAT
            IF NOT Job.GET(TempJobPlanningLine."Job No.")THEN Job.GET(TempJobPlanningLine2."Job No."); //060
            IF NOT JT.GET(TempJobPlanningLine."Job No.", TempJobPlanningLine."Job Task No.")THEN JT.GET(TempJobPlanningLine2."Job No.", TempJobPlanningLine2."Job Task No."); //060
            IF Job."Currency Code" = '' THEN JobInvCurrency:=Job."Invoice Currency Code" <> '';
            //Cust.GET(Job."Bill-to Customer No.");
            //Cust.GET(JobCust."Customer No.");
            IF TempJobPlanningLine.FIND('-')THEN BEGIN
                NoOfInvoices:=NoOfInvoices + 1;
                SalesHeader2."Document Type":=SalesHeader2."Document Type"::Invoice;
                //CreateSalesheader(Job,PostingDate,JobCust."Customer No.");
                CreateSalesheader(Job, PostingDate, CustNo, NoOfInvoices);
                REPEAT JobPlanningLine:=TempJobPlanningLine;
                    JobPlanningLine.Find();
                    IF JobPlanningLine.Type IN[JobPlanningLine.Type::Resource, JobPlanningLine.Type::Item, JobPlanningLine.Type::"G/L Account"]THEN JobPlanningLine.TESTFIELD("No.");
                    TestExchangeRate(JobPlanningLine, PostingDate);
                    CreateSalesLine(JobPlanningLine);
                    JobPlanningLineInvoice."Job No.":=JobPlanningLine."Job No.";
                    JobPlanningLineInvoice."Job Task No.":=JobPlanningLine."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No.":=JobPlanningLine."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No.":=SalesHeader."No.";
                    JobPlanningLineInvoice."Line No.":=SalesLine."Line No.";
                    JobPlanningLineInvoice."Quantity Transferred":=JobPlanningLine."Qty. to Transfer to Invoice";
                    JobPlanningLineInvoice."Transferred Date":=PostingDate;
                    JobPlanningLineInvoice.Insert();
                    JobPlanningLine.UpdateQtyToTransfer;
                    JobPlanningLine.Modify();
                    CreateTextSalesLine2(JobPlanningLine); //053
                UNTIL TempJobPlanningLine.Next() = 0;
            //UNTIL JobCust.Next() = 0;
            END;
            TempJobPlanningLine.DeleteAll();
            //060 //facturas de gastos !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            IF TempJobPlanningLine2.FIND('-')THEN BEGIN
                //NoOfInvoices := NoOfInvoices + 1;
                //SalesHeader2."Document Type" := SalesHeader2."Document Type"::Invoice;
                //CreateSalesheader(Job,PostingDate,CustNo);
                REPEAT JobPlanningLine:=TempJobPlanningLine2;
                    JobPlanningLine.Find();
                    IF JobPlanningLine.Type IN[JobPlanningLine.Type::Resource, JobPlanningLine.Type::Item, JobPlanningLine.Type::"G/L Account"]THEN JobPlanningLine.TESTFIELD("No.");
                    TestExchangeRate(JobPlanningLine, PostingDate);
                    CreateSalesLine(JobPlanningLine);
                    JobPlanningLineInvoice."Job No.":=JobPlanningLine."Job No.";
                    JobPlanningLineInvoice."Job Task No.":=JobPlanningLine."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No.":=JobPlanningLine."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No.":=SalesHeader."No.";
                    JobPlanningLineInvoice."Line No.":=SalesLine."Line No.";
                    JobPlanningLineInvoice."Quantity Transferred":=JobPlanningLine."Qty. to Transfer to Invoice";
                    JobPlanningLineInvoice."Transferred Date":=PostingDate;
                    JobPlanningLineInvoice.Insert();
                    JobPlanningLine.UpdateQtyToTransfer;
                    JobPlanningLine.Modify();
                UNTIL TempJobPlanningLine2.Next() = 0;
                TempJobPlanningLine2.DeleteAll();
            END;
        //060
        END;
        IF LastJobTask THEN BEGIN
            IF NoOfSalesLinesCreated = 0 THEN ERROR(Text002, JobPlanningLine.TABLECAPTION, JobPlanningLine.FIELDCAPTION("Qty. to Transfer to Invoice"));
            EXIT;
        END;
        JobPlanningLine.Reset();
        JobPlanningLine.SETCURRENTKEY("Job No.", "Job Task No.");
        JobPlanningLine.SETRANGE("Job No.", JT2."Job No.");
        JobPlanningLine.SETRANGE("Job Task No.", JT2."Job Task No.");
        JobPlanningLine.SETFILTER("Planning Date", JT2.GETFILTER("Planning Date Filter"));
        //<
        IF JobPlanningLine."Customer No. AT" <> '' THEN JobPlanningLine.SETFILTER("Customer No. AT", CustNo);
        JobPlanningLine.SETRANGE("Confirmed AT", TRUE); //010617
        //>
        IF JobPlanningLine.FIND('-')THEN REPEAT //060
 Job.GET(JobPlanningLine."Job No.");
                IF(NOT Job."Expenses on same Invoice AT") AND ((JobPlanningLine."Direct Unit Cost (LCY)" <> 0) AND (JobPlanningLine."Unit Price" <> 0))THEN BEGIN //línea de gasto
                    IF TransferLine(JobPlanningLine)THEN BEGIN
                        TempJobPlanningLine2:=JobPlanningLine;
                        IF NOT TempJobPlanningLine2.Insert()then TempJobPlanningLine2.Modify();
                    END;
                END
                ELSE
                BEGIN
                    //060
                    IF TransferLine(JobPlanningLine)THEN BEGIN
                        TempJobPlanningLine:=JobPlanningLine;
                        IF NOT TempJobPlanningLine.Insert()then TempJobPlanningLine.Modify();
                    END;
                //060
                END;
            //060
            UNTIL JobPlanningLine.Next() = 0;
    end;
    procedure RealizarComprobacionLimiteCredito(realizar: Boolean)
    begin
        //EX-OMI 041219
        RealizarComprobacion:=realizar;
    end;
    // procedure CreateSalesInvoiceMultiple(JobPlanningLine: Record 1003; CrMemo: Boolean)
    procedure CreateSalesInvoiceMultiple(var JobPlanningLine: Record 1003; CrMemo: Boolean; PostingDate2: Date)
    var
        SalesHeader: Record 36;
        // GetSalesInvoiceNo: Report 1094;
        GetSalesInvoiceNo: Report 52081;
        // GetSalesCrMemoNo: Report 1092;
        GetSalesCrMemoNo: Report 52082;
        Done: Boolean;
        NewInvoice: Boolean;
        PostingDate: Date;
        InvoiceNo: Code[20];
        lRecSalesHeader: Record 36;
    begin
        lRecSalesHeader.SetRange("Job No.", JobPlanningLine."Job No.");
        lRecSalesHeader.SETRANGE("Sell-to Customer No.", JobPlanningLine."Customer No. AT");
        lRecSalesHeader.SetRange("Posting Date", PostingDate);
        if not lRecSalesHeader.findfirst()then begin
            NewInvoice:=TRUE; //Siempre nueva factura
            IF NOT CrMemo THEN BEGIN
                // GetSalesInvoiceNo.SetCustomer(JobPlanningLine."Job No.");
                GetSalesInvoiceNo.SetCustomer(JobPlanningLine."Customer No. AT"); //EX-RBF 220922
                GetSalesInvoiceNo.USEREQUESTPAGE:=FALSE;
                GetSalesInvoiceNo.InitReport;
                GetSalesInvoiceNo.RUNMODAL;
                GetSalesInvoiceNo.GetInvoiceNo(Done, Done, PostingDate, InvoiceNo);
            END
            ELSE
            BEGIN
                // GetSalesCrMemoNo.SetCustomer(JobPlanningLine."Job No.");
                GetSalesCrMemoNo.SetCustomer(JobPlanningLine."Customer No. AT"); //EX-RBF 220922
                GetSalesCrMemoNo.USEREQUESTPAGE:=FALSE;
                GetSalesCrMemoNo.InitReport;
                GetSalesCrMemoNo.RUNMODAL;
                GetSalesCrMemoNo.GetCreditMemoNo(Done, Done, PostingDate, InvoiceNo);
            END;
            IF Done THEN BEGIN
                IF(PostingDate2 = 0D) AND NewInvoice THEN ERROR(Text007, SalesHeader.FIELDCAPTION("Posting Date"));
                IF(InvoiceNo = '') AND NOT NewInvoice THEN BEGIN
                    IF CrMemo THEN ERROR(Text005);
                    ERROR(Text004);
                END;
                IF TransferLine(JobPlanningLine)THEN CreateSalesInvoiceLinesMultiple(JobPlanningLine."Job No.", JobPlanningLine, InvoiceNo, NewInvoice, PostingDate2, CrMemo, JobPlanningLine."Customer No. AT");
            END;
        end;
    end;
    // local procedure CreateSalesInvoiceLinesMultiple(JobNo: Code[20]; JobPlanningLine: Record 1003; InvoiceNo: Code[20]; NewInvoice: Boolean; PostingDate: Date; CreditMemo: Boolean; CustNo: Code[20])
    local procedure CreateSalesInvoiceLinesMultiple(JobNo: Code[20]; var JobPlanningLine: Record 1003; InvoiceNo: Code[20]; NewInvoice: Boolean; PostingDate: Date; CreditMemo: Boolean; CustNo: Code[20])
    var
        Job: Record Job;
        JobPlanningLineInvoice: Record 1022;
        LineCounter: Integer;
        UpdJobPlanningLine: Record 1003;
        JobPlanningLine2: Record "Job Planning Line";
    begin
        ClearAll();
        JobPlanningLine2.Copy(JobPlanningLine);
        Job.GET(JobNo);
        // Message(FORMAT(JobPlanningLine2.Count));
        IF Job.Blocked = Job.Blocked::All THEN Job.TestBlocked;
        IF Job."Currency Code" = '' THEN JobInvCurrency:=Job."Invoice Currency Code" <> '';
        //Job.TESTFIELD("Bill-to Customer No.");
        //Cust.GET(Job."Bill-to Customer No.");
        IF CreditMemo THEN BEGIN
            SalesHeader2."Document Type":=SalesHeader2."Document Type"::"Credit Memo";
            SalesHeader2."Corrected Invoice No.":=JobPlanningLine2."Document No."; //029
        END
        ELSE
            SalesHeader2."Document Type":=SalesHeader2."Document Type"::Invoice;
        IF NOT NewInvoice THEN SalesHeader.GET(SalesHeader2."Document Type", InvoiceNo);
        JobPlanningLine2.SetRange("Customer No. AT", CustNo); //EX-RBF 260922
        IF JobPlanningLine2.FIND('-')THEN REPEAT // if JobPlanningLine."Customer No. AT" = CustNo then begin
 IF TransferLine(JobPlanningLine2)THEN BEGIN
                    LineCounter:=LineCounter + 1;
                    // IF JobPlanningLine."Job No." <> JobNo THEN //EX-RBF 260922
                    // ERROR(Text009, JobPlanningLine.FIELDCAPTION("Job No.")); //EX-RBF 260922
                    IF NewInvoice THEN TestExchangeRate(JobPlanningLine2, PostingDate)
                    ELSE
                        TestExchangeRate(JobPlanningLine2, SalesHeader."Posting Date");
                END;
            // end;
            UNTIL JobPlanningLine2.Next() = 0;
        IF LineCounter = 0 THEN ERROR(Text002, JobPlanningLine2.TABLECAPTION, JobPlanningLine2.FIELDCAPTION("Qty. to Transfer to Invoice"));
        //300517
        IF CustNo = '' THEN ERROR(Text50001, JobPlanningLine2."Line No.", JobPlanningLine2."Job No.");
        //300517
        IF NewInvoice THEN CreateSalesheader(Job, PostingDate, CustNo, NoOfSalesLinesCreated)
        ELSE
            TestSalesHeader(SalesHeader, Job, CustNo);
        // JobPlanningLine.SetRange("Customer No. AT", CustNo);//EX-RBF 260922
        IF JobPlanningLine2.FIND('-')THEN REPEAT // if JobPlanningLine."Customer No. AT" = CustNo then begin
 IF TransferLine(JobPlanningLine2)THEN BEGIN
                    IF JobPlanningLine2.Type IN[JobPlanningLine2.Type::Resource, JobPlanningLine2.Type::Item, JobPlanningLine2.Type::"G/L Account"]THEN JobPlanningLine2.TESTFIELD("No.");
                    CreateSalesLine(JobPlanningLine2);
                    JobPlanningLineInvoice."Job No.":=JobPlanningLine2."Job No.";
                    JobPlanningLineInvoice."Job Task No.":=JobPlanningLine2."Job Task No.";
                    JobPlanningLineInvoice."Job Planning Line No.":=JobPlanningLine2."Line No.";
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::Invoice;
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN JobPlanningLineInvoice."Document Type":=JobPlanningLineInvoice."Document Type"::"Credit Memo";
                    JobPlanningLineInvoice."Document No.":=SalesHeader."No.";
                    JobPlanningLineInvoice."Line No.":=SalesLine."Line No.";
                    JobPlanningLineInvoice."Job Assistant":=SalesLine."Job Assistant";
                    JobPlanningLineInvoice."Quantity Transferred":=JobPlanningLine2."Qty. to Transfer to Invoice";
                    IF NewInvoice THEN JobPlanningLineInvoice."Transferred Date":=PostingDate
                    ELSE
                        JobPlanningLineInvoice."Transferred Date":=SalesHeader."Posting Date";
                    JobPlanningLineInvoice.Insert();
                    JobPlanningLine2.UpdateQtyToTransfer;
                    JobPlanningLine2.Modify();
                    //<029. TEMPORARY
                    IF JobPlanningLine.ISTEMPORARY THEN BEGIN
                        UpdJobPlanningLine.GET(JobPlanningLine2."Job No.", JobPlanningLine2."Job Task No.", JobPlanningLine2."Line No.");
                        UpdJobPlanningLine.TRANSFERFIELDS(JobPlanningLine2);
                        UpdJobPlanningLine.Modify();
                    END;
                    //029>
                    CreateTextSalesLine2(JobPlanningLine2); //053
                END;
            // end;
            UNTIL JobPlanningLine2.Next() = 0;
        //053
        CreateTextSalesLine(JobNo);
        //053
        IF NoOfSalesLinesCreated = 0 THEN ERROR(Text002, JobPlanningLine2.TABLECAPTION, JobPlanningLine2.FIELDCAPTION("Qty. to Transfer to Invoice"));
        Commit();
    // IF CreditMemo THEN
    //     MESSAGE(Text008)
    // ELSE
    //     MESSAGE(Text000);
    end;
}
