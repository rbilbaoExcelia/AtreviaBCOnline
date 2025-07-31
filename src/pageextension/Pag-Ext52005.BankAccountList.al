pageextension 52005 "BankAccountList" extends "Bank Account List"
{
    Editable = false;

    layout
    {
        addafter("Search Name")
        {
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ToolTip = 'Balance (LCY)';
                ApplicationArea = All;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ToolTip = 'Net Change (LCY)';
                ApplicationArea = All;
            }
        }
    }
}
