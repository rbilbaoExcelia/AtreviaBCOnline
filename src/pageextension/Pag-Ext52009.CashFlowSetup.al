pageextension 52009 "CashFlowSetup" extends "Cash Flow Setup"
{
    layout
    {
        addafter("FA Disposal CF Account No.")
        {
            field("Jobs Billing CF Account No."; Rec."Jobs Billing CF Account No.")
            {
                ToolTip = 'Jobs Billing CF Account No.';
                ApplicationArea = All;
            }
        }
    }
}
