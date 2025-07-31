pageextension 52050 "PurchaseCreditMemo" extends "Purchase Credit Memo"
{
    layout
    {
        //3526 MEP 2022 02 04 START
        addbefore("Buy-from Vendor No.")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ToolTip = 'VAT Registration No.';
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Posting Description")
        {
            Visible = true;
        }
        moveafter("Buy-from Vendor Name"; "Posting Description")
    }
    actions
    {
        addfirst("P&osting")
        {
            action(CalcIRPF)
            {
                ToolTip = 'Calculate IRPF';
                ApplicationArea = All;
                Caption = 'Calculate IRPF';

                trigger OnAction()
                var
                //TODO - Codeunit '7070313' is missing
                //PurchLib: Codeunit 7070313;
                begin
                    //<024
                    //PurchLib.AddIRPF(Rec);
                    CurrPage.UPDATE(FALSE);
                //024>
                end;
            }
        }
    }
}
