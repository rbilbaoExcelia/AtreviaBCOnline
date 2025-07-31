pageextension 52016 "DefaultDimensions" extends "Default Dimensions"
{
    layout
    {
        addfirst(Control1)
        {
            field("No."; Rec."No.")
            {
                ToolTip = 'No.';
                ApplicationArea = All;
                Enabled = false;
            }
        }
    }
}
