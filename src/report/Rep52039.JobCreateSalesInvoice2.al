report 52039 "Job Create Sales Invoice 2"
{
    // 030 OS.SPG  15/01/2017  PROY.005  Facturación multicliente desde proyecto
    // EX-OMI 041219 Comprobacion limite de credito
    Caption = 'Proyectos crear factura venta ATREVIA';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Customer;18)
        {
            DataItemTableView = SORTING("No.");

            dataitem(Job;167)
            {
                DataItemLink = "Bill-to Customer No."=FIELD("No.");
                DataItemTableView = SORTING("No.");

                dataitem("Job Planning Line";1003)
                {
                    DataItemLink = "Job No."=FIELD("No.");
                    DataItemTableView = SORTING("Job No.", "Job Task No.", "Schedule Line", "Planning Date")WHERE("Qty. to Transfer to Invoice"=FILTER(<>0), "Confirmed AT"=FILTER(true));
                    RequestFilterFields = "Planning Date", "Job No.";

                    trigger OnAfterGetRecord()
                    begin
                        //030
                        CALCFIELDS("Job Planning Line"."Billing Company AT");
                        IF "Billing Company AT" <> COMPANYNAME THEN CurrReport.Skip();
                        //030
                        /*
                        IF "Job Planning Line"."Job No."= JobNo THEN
                          CurrReport.Skip();
                        JobNo := "Job Planning Line"."Job No.";
                        */
                        //rec_jobtask.SETRANGE(rec_jobtask."Job No.","Job Planning Line"."Job No.");
                        //<030
                        //070417
                        IF Job."Job Type AT" = Job."Job Type AT"::Salon THEN CurrReport.Skip();
                        //070417
                        rec_jobtask.GET("Job No.", "Job Task No.");
                        COPYFILTER("Job Planning Line"."Planning Date", rec_jobtask."Planning Date Filter");
                        Job.CALCFIELDS(Job."Multiple Customers AT");
                        JobCreateMultInvoice.RealizarComprobacionLimiteCredito(TRUE); //EX-OMI 041219
                        IF Job."Multiple Customers AT" = FALSE THEN BEGIN
                            //030
                            //IF JobNo <> "Job Planning Line"."Job No." THEN BEGIN
                            //  JobNo := "Job Planning Line"."Job No.";
                            //"Job Planning Line".COPYFILTER("Job Planning Line"."Planning Date","Job Task"."Planning Date Filter");
                            JobCreateMultInvoice.CreateSalesInvoiceJT( //   rec_jobtask, PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, FALSE, Job."Bill-to Customer No.")
                            rec_jobtask, PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, FALSE, "Customer No. AT") //EX-RBF 220922
                        //END ELSE BEGIN
                        //"Job Planning Line".COPYFILTER("Job Planning Line"."Planning Date","Job Task"."Planning Date Filter");
                        //JobCreateMultInvoice.CreateSalesInvoiceJT2(
                        //  rec_jobtask,PostingDate,InvoicePerTask,NoOfInvoices,OldJobNo,OldJTNo,FALSE,Job."Bill-to Customer No.");
                        //END;
                        //<030
                        END
                        ELSE
                        BEGIN
                            //JobPlanningLine.SETRANGE(JobPlanningLine."Job No.", "Job Task"."Job No.");
                            //JobPlanningLine.SETRANGE(JobPlanningLine."Job Task No.","Job Task"."Job Task No.");
                            //JobPlanningLine.SETRANGE(JobPlanningLine.Confirmed,TRUE);
                            //"Job Planning Line".COPYFILTER("Planning Date",JobPlanningLine."Planning Date");
                            //IF JobPlanningLine.FIND('-') THEN REPEAT
                            IF Job."Bill-to Customer No." <> '' THEN BEGIN
                                xJobPlanningLine.COPY("Job Planning Line");
                                //xJobPlanningLine.SETRANGE("Line No.",JobPlanningLine."Line No.");
                                // JobCreateMultInvoice.CreateSalesInvoice(xJobPlanningLine, xJobPlanningLine."ToCredit AT");
                                JobCreateMultInvoice.CreateSalesInvoiceMultiple(xJobPlanningLine, xJobPlanningLine."ToCredit AT", PostingDate); //EX-RBF 280922
                            END;
                        //UNTIL JobPlanningLine.NEXT=0;
                        END;
                    //030>
                    end;
                    trigger OnPostDataItem()
                    begin
                        //<030
                        IF rec_jobtask.FindLast()then;
                        IF(rec_jobtask."Job No." = "Job No.") AND (rec_jobtask."Job Task No." <> "Job Task No.")THEN CurrReport.Skip();
                        JobCreateMultInvoice.RealizarComprobacionLimiteCredito(TRUE); //EX-OMI 041219
                        //Job.GET("Job Task"."Job No.");
                        Job.CALCFIELDS(Job."Multiple Customers AT");
                        IF Job."Multiple Customers AT" = FALSE THEN //030>
 JobCreateMultInvoice.CreateSalesInvoiceJT( // rec_jobtask, PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, TRUE, Job."Bill-to Customer No.")
                            rec_jobtask, PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, TRUE, "Customer No. AT") //EX-RBF 220922
                        //<030
                        ELSE
                        BEGIN
                        /*---No factura per tasks amb multiclient
                            JobCust.SETFILTER(JobCust."Job No.",Job."No.");
                            JobCust.SETFILTER(JobCust."Invoice No.",'');
                            IF JobCust.Find() then REPEAT
                             JobCreateMultInvoice.CreateSalesInvoiceJT(
                               "Job Task",PostingDate,InvoicePerTask,NoOfInvoices,OldJobNo,OldJTNo,TRUE,JobCust."Customer No.");
                             //Falta informar el num de fra generada al jobcust
                            UNTIL JobCust.Next() = 0;
                            */
                        END;
                    //030>
                    end;
                    trigger OnPreDataItem()
                    begin
                        IF "Job Planning Line".GETFILTER("Job Planning Line"."Planning Date") = '' THEN ERROR(Text50001);
                        OldJobNo:='';
                        OldJTNo:='';
                    end;
                }
            }
            trigger OnPreDataItem()
            begin
                NoOfInvoices:=0;
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

                    field(PostingDate; PostingDate)
                    {
                        ToolTip = 'Posting Date';
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            PostingDate:=WorkDate();
        end;
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        JobCalcBatches.EndCreateInvoice(NoOfInvoices);
    end;
    trigger OnPreReport()
    begin
        JobCalcBatches.BatchError(PostingDate, Text000);
        InvoicePerTask:=JobChoice = JobChoice::"Job Task";
        JobCreateMultInvoice.DeleteSalesInvoiceBuffer;
    end;
    var JobCreateMultInvoice: Codeunit "Job-Create Multiple Custs. Inv";
    JobCalcBatches: Codeunit 1005;
    PostingDate: Date;
    NoOfInvoices: Integer;
    InvoicePerTask: Boolean;
    JobChoice: Option Job, "Job Task";
    OldJobNo: Code[20];
    OldJTNo: Code[20];
    JobNo: Code[20];
    rec_jobtask: Record 1001;
    xJobPlanningLine: Record 1003;
    Text000: Label 'A', Comment = 'A';
    Text50001: Label 'Es necesario indicar un filtro fecha.';
}
