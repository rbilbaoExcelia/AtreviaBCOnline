pageextension 52027 "GLAccountCard" extends "G/L Account Card"
{
    layout
    {
        addafter(Totaling)
        {
            field("Grouping Code"; Rec."Grouping Code")
            {
                ToolTip = 'Grouping Code';
                ApplicationArea = All;
            }
        }
        addafter("Income Stmt. Bal. Acc.")
        {
            field("Expenses Billable"; Rec."Expenses Billable AT")
            {
                ToolTip = 'Expenses Billable';
                ApplicationArea = All;
            }
        }
    }
}
