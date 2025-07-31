pageextension 52058 "PurchaseOrderSubform" extends "Purchase Order Subform"
{
    layout
    {
        addafter("Job No.")
        {
            field("Job Name"; Rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter("Job Line Amount (LCY)")
        {
            field("Job Line Account No."; Rec."Job Line Account No.")
            {
                ToolTip = 'Job Line Account No.';
                ApplicationArea = All;
            }
        }
        addafter("Total Amount Incl. VAT")
        {
            field(RefreshTotals; RefreshMessageText)
            {
                ToolTip = 'RefreshTotals';
                ApplicationArea = All;
                DrillDown = true;
                Editable = false;
                Enabled = RefreshMessageEnabled;
                ShowCaption = false;
            }
        }
        //3526 MEP 2022 02 04 START
        modify("Job No.")
        {
            Visible = true;
        }
        modify("Job Task No.")
        {
            Visible = true;
        }
        modify("Job Line Type")
        {
            Visible = true;
        }
    }
    var PurchHeader: Record 38;
    var Text000: Label 'Unable to run this function while in View mode.';
    //PurchPriceCalcMgt: Codeunit 7010;
    var UpdateAllowedVar: Boolean;
    var TotalAmountStyle: Text;
    RefreshMessageEnabled: Boolean;
    RefreshMessageText: Text;
    TypeChosen: Boolean;
}
