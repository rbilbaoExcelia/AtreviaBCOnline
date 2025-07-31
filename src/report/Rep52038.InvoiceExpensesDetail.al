report 52038 "Invoice Expenses Detail"
{
    // 147  OS.RM  07/06/2017  Report Invoice Expenses Detail
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/InvoiceExpensesDetail.rdlc';
    Caption = 'Invoice Expenses Detail';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(InvHeader;36)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(TXTTitle; TXTTitle)
            {
            }
            column(TXTPage; TXTPage)
            {
            }
            column(TXTNo; TXTNo)
            {
            }
            column(TXTPostingDate; TXTPostingDate)
            {
            }
            column(TXTBillToCustomerNo; TXTBillTo + TXTCustomer)
            {
            }
            column(TXTBillToName; TXTBillTo + TXTName)
            {
            }
            column(TXTTotal; TXTTotal)
            {
            }
            column(CompanyName; RECCompany.Name)
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
            dataitem(InvLine;37)
            {
                DataItemLink = "Document No."=FIELD("No."), "Document Type"=FIELD("Document Type");
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
        RECCompany.Get();
        RECCompany.CALCFIELDS(Picture);
    end;
    var TXTTitle: Label 'Invoice expense detail';
    TXTPage: Label 'Page';
    TXTNo: Label 'N.';
    TXTPostingDate: Label 'Posting Date';
    TXTTotal: Label 'TOTAL INVOICE';
    TXTName: Label 'Name';
    TXTCustomer: Label 'Customer N.';
    TXTBillTo: Label 'Bill to - ';
    RECCompany: Record 79;
}
