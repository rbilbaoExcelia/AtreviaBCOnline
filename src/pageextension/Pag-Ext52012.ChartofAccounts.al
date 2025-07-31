pageextension 52012 "ChartofAccounts" extends "Chart of Accounts"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field("Expenses Billable"; Rec."Expenses Billable AT")
            {
                ToolTip = 'Expenses Billable';
                ApplicationArea = All;
            }
            field(Blocked; Rec.Blocked)
            {
                ToolTip = 'Blocked';
                ApplicationArea = All;
            }
        }
    }
}
