pageextension 52067 "ResponsibilityCenterCard" extends "Responsibility Center Card"
{
    layout
    {
        addafter("Location Code")
        {
            field("Cash Account"; Rec."Cash Account AT")
            {
                ToolTip = 'Cash Account';
                ApplicationArea = All;
            }
        }
    }
}
