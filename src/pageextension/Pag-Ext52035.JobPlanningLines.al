pageextension 52035 "JobPlanningLines" extends "Job Planning Lines"
{
    layout
    {
        addafter("Line Type")
        {
            field(Billable; Rec."Billable AT")
            {
                ToolTip = 'Billable';
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field(ToCredit; Rec."ToCredit AT")
            {
                ToolTip = 'ToCredit';
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            //SAR  2024 19 01 Modificacion nombre de campo
            field("AT Description 2"; Rec."Description 2")
            //SAR  2024 19 01 Modificacion nombre de campo END
            {
                ToolTip = 'Description 2';
                ApplicationArea = All;
            }
            field("Customer No."; Rec."Customer No. AT")
            {
                ToolTip = 'Customer No.';
                ApplicationArea = All;
            }
            field("Job Assistant"; Rec."Job Assistant AT")
            {
                ToolTip = 'Job Assistant';
                ApplicationArea = All;
            }
        }
        addafter("System-Created Entry")
        {
            field("Line Type 2"; Rec."Line Type 2 AT")
            {
                ToolTip = 'Line Type 2';
                ApplicationArea = All;
            }
        }
        addafter(Overdue)
        {
            field(Confirmed; Rec."Confirmed AT")
            {
                ToolTip = 'Confirmed';
                ApplicationArea = All;
            }
            field("External Job Document No."; Rec."External Job Document No. AT")
            {
                ToolTip = 'External Job Document No.';
                ApplicationArea = All;
            }
            field("Billing Company"; Rec."Billing Company AT")
            {
                ToolTip = 'Billing Company';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        //EX-RBF 220922 Inicio
        addafter("Create &Sales Invoice")
        {
            action("Crear Factura Atrevia")
            {
                ApplicationArea = All;
                Image = Document;

                trigger OnAction()
                var
                    RecJobPlanningLine: Record "Job Planning Line";
                    JobCreateInvoice: Codeunit "Job-Create Multiple Custs. Inv";
                    GetSalesInvoiceNo: Report 52081;
                    PostingDate: Date;
                    Done: Boolean;
                    InvoiceNo: Code[20];
                begin
                    rec.TestField("Line No.");
                    RecJobPlanningLine.Copy(Rec);
                    CurrPage.SetSelectionFilter(RecJobPlanningLine);
                    GetSalesInvoiceNo.SetCustomer(RecJobPlanningLine."Customer No. AT");
                    GetSalesInvoiceNo.RUNMODAL;
                    GetSalesInvoiceNo.GetInvoiceNo(Done, Done, PostingDate, InvoiceNo);
                    if RecJobPlanningLine.FindSet()then begin
                        repeat JobCreateInvoice.CreateSalesInvoiceMultiple(RecJobPlanningLine, false, PostingDate);
                        until RecJobPlanningLine.Next() = 0;
                    end;
                    Message('Proceso finalizado');
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        //079
        Rec."Line No.":=Rec."Line No." + 100;
    //079
    end;
//procedure CreateSalesInvoice();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    TestField("Line No.");
    JobPlanningLine.Copy(Rec);
    CurrPage.SetSelectionFilter(JobPlanningLine);
    JobCreateInvoice.CreateSalesInvoice(JobPlanningLine,CrMemo)
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*

    TESTFIELD("Line No.");

    JobPlanningLine.COPY(Rec);
    CurrPage.SETSELECTIONFILTER(JobPlanningLine);

    //<030
    // JobPlanningLine.SETRANGE(Confirmed, TRUE);
    // JobPlanningLine.SETFILTER(ToCredit,'=%1',CrMemo);
    //030
    JobCreateInvoice.RealizarComprobacionLimiteCredito(TRUE);//EX-OMI 041219
    Job.GET(Rec."Job No.");
    Job.CALCFIELDS(Job."Multiple Customers");
    IF Job."Multiple Customers" = FALSE THEN
    //030>
      JobCreateInvoice.CreateSalesInvoice(JobPlanningLine,CrMemo)
    //<030
    ELSE
      IF JobPlanningLine.FIND('-') THEN REPEAT
        xJobPlanningLine.COPY(JobPlanningLine);
        xJobPlanningLine.SETRANGE("Line No.",JobPlanningLine."Line No.");
        JobCreateMultInvoice.CreateSalesInvoice(xJobPlanningLine,CrMemo);
      UNTIL JobPlanningLine.NEXT=0;
    //030>
    */
//end;
}
