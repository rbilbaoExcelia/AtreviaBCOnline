report 52040 "Job Create Sales Invoice 3"
{
    // 030 OS.SPG  15/01/2017  PROY.005  Facturación multicliente desde proyecto
    Caption = 'Proyectos crear factura venta ATREVIA';
    ProcessingOnly = true;

    //3634 - ED
    //ApplicationArea = all;
    //UsageCategory = Tasks;
    //3634 - ED END
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
                        Job.CALCFIELDS(Job."Multiple Customers AT");
                        IF Job."Multiple Customers AT" = FALSE THEN BEGIN
                            //030
                            //IF JobNo <> "Job Planning Line"."Job No." THEN BEGIN
                            //  JobNo := "Job Planning Line"."Job No.";
                            //"Job Planning Line".COPYFILTER("Job Planning Line"."Planning Date","Job Task"."Planning Date Filter");
                            JobCreateMultInvoice.CreateSalesInvoiceJT(rec_jobtask, PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, FALSE, Job."Bill-to Customer No.") //END ELSE BEGIN
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
                            xJobPlanningLine.COPY("Job Planning Line");
                            //xJobPlanningLine.SETRANGE("Line No.",JobPlanningLine."Line No.");
                            JobCreateMultInvoice.CreateSalesInvoice(xJobPlanningLine, xJobPlanningLine."ToCredit AT");
                        //UNTIL JobPlanningLine.NEXT=0;
                        END;
                    //030>
                    end;
                    trigger OnPostDataItem()
                    begin
                        //<030
                        IF rec_jobtask.FindLast()then;
                        IF(rec_jobtask."Job No." = "Job No.") AND (rec_jobtask."Job Task No." <> "Job Task No.")THEN CurrReport.Skip();
                        //Job.GET("Job Task"."Job No.");
                        Job.CALCFIELDS(Job."Multiple Customers AT");
                        IF Job."Multiple Customers AT" = FALSE THEN //030>
 JobCreateMultInvoice.CreateSalesInvoiceJT(rec_jobtask, PostingDate, InvoicePerTask, NoOfInvoices, OldJobNo, OldJTNo, TRUE, Job."Bill-to Customer No.")
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
                        NoOfInvoices:=0;
                        OldJobNo:='';
                        OldJTNo:='';
                    end;
                }
            }
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
    Text000: Label 'A', Comment = 'A';
    JobNo: Code[20];
    Text50001: Label 'Es necesario indicar un filtro fecha.';
    rec_jobtask: Record 1001;
    xJobPlanningLine: Record 1003;
}
