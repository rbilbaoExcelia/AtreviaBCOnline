pageextension 52055 "PurchaseOrder" extends "Purchase Order"
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
        addfirst("F&unctions")
        {
            action(CalcIRPF)
            {
                Caption = 'Calculate IRPF';
                ToolTip = 'Calculate IRPF';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Calculate;

                trigger OnAction()
                var
                    PurchLib: Codeunit "Lib. Compra ATREVIA";
                begin
                    //<024
                    PurchLib.AddIRPF(Rec);
                    CurrPage.UPDATE(FALSE);
                //024>
                end;
            }
        }
    }
}
