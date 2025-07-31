report 52030 "Facturación - Proyectos"
{
    // 150 OS.RM  07/06/2017  Facturación - Proyecto
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/FacturaciónProyectos.rdlc';
    Caption = 'Billing - Projects';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Resource;156)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;

            column(ResourceNo; Resource."No.")
            {
            }
            column(ResourceName; Resource.Name)
            {
            }
            dataitem(Job;167)
            {
                DataItemLink = "Person Responsible"=FIELD("No.");
                DataItemTableView = SORTING("Search Description");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Posting Date Filter";

                column(JobAmountDL; Job."Invoice Amt. (DL) AT")
                {
                }
                column(JobDescription; Job.Description)
                {
                }
                column(JobNo; Job."No.")
                {
                }
                dataitem("Company"; Company)
                {
                    DataItemTableView = SORTING(Name)ORDER(Ascending);
                    PrintOnlyIfDetail = true;

                    dataitem("Sales Invoice Line";113)
                    {
                        DataItemLink = "Job No."=FIELD("No."), "Posting Date"=FIELD("Posting Date Filter");
                        DataItemLinkReference = Job;
                        DataItemTableView = SORTING("Document No.", "Line No.")ORDER(Ascending)WHERE(Amount=FILTER(<>0));

                        column(LineDescription; "Sales Invoice Line".Description)
                        {
                        }
                        column(LineAmount; "Sales Invoice Line".Amount)
                        {
                        }
                        column(LinePostingDate; "Sales Invoice Line"."Posting Date")
                        {
                        }
                        column(LineDocumentNo; "Sales Invoice Line"."Document No.")
                        {
                        }
                        column(TxtFilters__Lbl; TxtFilters)
                        {
                        }
                        column(Fecha_Lbl; Fecha)
                        {
                        }
                        column(Concepto_Lbl; Concepto)
                        {
                        }
                        column(Importe_Lbl; Importe)
                        {
                        }
                        column(NoFactura_Lbl; "Nº Factura")
                        {
                        }
                        column(Proyecto_Lbl; Proyecto)
                        {
                        }
                        column(TOTALFACTURADO_Lbl; "TOTAL FACTURADO")
                        {
                        }
                        column(COMPANYNAME; COMPANYNAME)
                        {
                        }
                        column(BillingProject_Lbl; BillingProject_Lbl)
                        {
                        }
                        column(CurrReport_PAGENOCapcionLbl; CurrReport_PAGENOCaptionLbl)
                        {
                        }
                        column(TotalProyecto; "Total del Proyecto")
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            "Sales Invoice Line".CHANGECOMPANY(Company.Name);
                        end;
                    }
                }
            }
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
    trigger OnPreReport()
    begin
        TxtFilters:=Job.GETFILTERS;
    end;
    var TxtFilters: Text[250];
    Fecha: Label 'Date';
    Concepto: Label 'Concept';
    Importe: Label 'Amount';
    "Nº Factura": Label 'Invoice No';
    Proyecto: Label 'Project';
    "TOTAL FACTURADO": Label 'TOTAL CHARGED';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    BillingProject_Lbl: Label 'BILLING PROJECT';
    "Total del Proyecto": Label 'Total of project';
}
