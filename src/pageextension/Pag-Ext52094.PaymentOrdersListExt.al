pageextension 52094 "Payment Orders List Ext" extends "Payment Orders List"
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
