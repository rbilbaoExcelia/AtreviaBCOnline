pageextension 52046 "PostedSalesInvoicePT" extends "Posted Sales Invoice"
{
    actions
    {
        addafter(Print)
        {
            action(PrintExpensesDetailReport)
            {
                ToolTip = 'Print Expenses detail';
                ApplicationArea = All;
                Caption = 'Print Expenses detail';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //<035
                    //SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(Report::"Posted Invoice Expenses Detail", TRUE, FALSE, Rec);
                //035>
                end;
            }
        }
        addafter(FindCorrectiveInvoices)
        {
            action(CreditInvoice)
            {
                ToolTip = 'Credit Invoice';
                ApplicationArea = All;
                Caption = 'Credit Invoice';

                trigger OnAction()
                begin
                    //029
                    Rec.CreateCreditMemo(Rec);
                end;
            }
            action(ModifyYourReferenceField)
            {
                ToolTip = 'Modificar campo Su/ntra referencia';
                ApplicationArea = All;
                Caption = 'Modificar campo Su/ntra referencia';
                Image = UpdateDescription;

                trigger onAction()
                var
                    ModifyYourReferenceField: Page ModifyYourReferenceField;
                begin
                    Clear(ModifyYourReferenceField);
                    ModifyYourReferenceField.InitPage(Rec);
                    ModifyYourReferenceField.RunModal();
                end;
            }
        }
    }
    var CRMCouplingManagement: Codeunit 5331;
    CRMIntegrationManagement: Codeunit 5330;
}
