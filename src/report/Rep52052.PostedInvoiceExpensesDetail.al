report 52052 "Posted Invoice Expenses Detail"
{
    // 147  OS.RM  07/06/2017  Report Posted Invoice Expenses Detail
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/PostedInvoiceExpensesDetail.rdlc';
    Caption = 'Posted Invoice Expenses Detail';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(InvHeader;112)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(TXTTitle; TXTTitleLbl)
            {
            }
            column(TXTPage; TXTPageLbl)
            {
            }
            column(TXTNo; TXTNoLbl)
            {
            }
            column(TXTPostingDate; TXTPostingDateLbl)
            {
            }
            column(TXTBillToCustomerNo; TXTBillToLbl + TXTCustomerLbl)
            {
            }
            column(TXTBillToName; TXTBillToLbl + TXTNameLbl)
            {
            }
            column(TXTTotal; TXTTotalLbl)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(No_InvHeader; InvHeader."No.")
            {
            }
            column(PostingDate_InvHeader; InvHeader."Posting Date")
            {
            }
            column(BilltoCustomerNo_InvHeader; InvHeader."Bill-to Customer No.")
            {
            }
            column(BilltoName_InvHeader; InvHeader."Bill-to Name")
            {
            }
            dataitem(InvLine;113)
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")ORDER(Ascending)WHERE("Line Type"=CONST(Expense));

                column(Description_InvLine; InvLine.Description)
                {
                }
                column(ExpenseDate_InvLine; InvLine."Expense Date")
                {
                }
                column(UnitPrice_InvLine; InvLine."Unit Price")
                {
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
        CompanyInformation.Get();
        CompanyInformation.CALCFIELDS(Picture);
    end;
    var CompanyInformation: Record "Company Information";
    TXTTitleLbl: Label 'Invoice expense detail';
    TXTPageLbl: Label 'Page';
    TXTNoLbl: Label 'N.';
    TXTPostingDateLbl: Label 'Posting Date';
    TXTTotalLbl: Label 'TOTAL INVOICE';
    TXTNameLbl: Label 'Name';
    TXTCustomerLbl: Label 'Customer N.';
    TXTBillToLbl: Label 'Bill to - ';
}
