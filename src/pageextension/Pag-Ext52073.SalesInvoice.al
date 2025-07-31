pageextension 52073 "SalesInvoice" extends "Sales Invoice"
{
    actions
    {
        addafter("Test Report")
        {
            action(PrintExpensesDetailReport)
            {
                ToolTip = 'Print Expenses detail';
                ApplicationArea = All;
                Caption = 'Print Expenses detail';
                Ellipsis = true;
                Image = Print;

                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                trigger OnAction()
                begin
                    //<035
                    SalesHeader:=Rec;
                    CurrPage.SETSELECTIONFILTER(SalesHeader);
                    REPORT.RUN(Report::"Invoice Expenses Detail", TRUE, FALSE, SalesHeader);
                //035>
                end;
            }
        }
    }
    var SalesHeader: Record 36;
}
