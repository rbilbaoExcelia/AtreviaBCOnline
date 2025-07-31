pageextension 52093 "Payment Orders Ext" extends "Payment Orders"
{
    actions
    {
        addafter(Listing)
        {
            action("Confirming La Caixa")
            {
                ApplicationArea = all;
                Caption = 'Confirming La Caixa';
                Image = ExportToBank;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    lRec: record "Payment Order";
                    lRptConfCaixa: report "Confirming La Caixa";
                begin
                    lrec.SetRange("No.", rec."No.");
                    lRptConfCaixa.SetTableView(lRec);
                    lRptConfCaixa.RunModal();
                end;
            }
        }
    }
}
