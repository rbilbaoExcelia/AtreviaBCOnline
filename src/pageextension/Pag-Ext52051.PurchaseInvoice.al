pageextension 52051 "PurchaseInvoice" extends "Purchase Invoice"
{
    layout
    {
        addafter("No.")
        { /*
            field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
            {
                ToolTip = 'Buy-from Vendor No.';
                ApplicationArea = All;
                Importance = Promoted;
                ShowMandatory = true;
                TableRelation = Vendor WHERE(Blocked = FILTER(' '));

                trigger OnValidate()
                begin
                    BuyfromVendorNoOnAfterValidate;
                end;
            }*/
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ToolTip = 'VAT Registration No.';
                ApplicationArea = All;
                Editable = false;
            }
        } /*
        addafter("Buy-from Vendor Name")
        {
            field("Buy-from County"; Rec."Buy-from County")
            {
                ToolTip = 'Buy-from County';
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Accounting Posting Date"; Rec."Accounting Posting Date")
            {
                ToolTip = 'Accounting Posting Date';
                ApplicationArea = All;
                Visible = false;
            }
            field(DueDate; "Due Date")
            {
                ToolTip = 'DueDate';
                ApplicationArea = All;
                Caption = 'Due Date';
                Importance = Promoted;
            }
        }
        addafter("Vendor Invoice No.")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ToolTip = 'Posting No.';
                ApplicationArea = All;
            }
        }*/
        modify("Posting Description")
        {
            Visible = true;
        }
    }
    actions
    {
        addfirst("F&unctions")
        {
            action(CalcIRPF)
            {
                ToolTip = 'Calculate IRPF';
                ApplicationArea = All;
                Caption = 'Calculate IRPF';
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
