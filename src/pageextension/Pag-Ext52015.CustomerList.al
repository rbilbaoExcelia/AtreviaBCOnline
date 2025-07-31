pageextension 52015 "CustomerList" extends "Customer List"
{
    layout
    {
        //3635 - ED
        addafter(Name)
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ToolTip = 'VAT Registration No.';
                ApplicationArea = All;
            }
        }
        //3635 - ED END
        addlast(Control1)
        {
            field(Sector; rec.Sector)
            {
                ToolTip = 'Sector';
                ApplicationArea = all;
                Visible = true;
            }
            field(Subsector; rec.Subsector)
            {
                ToolTip = 'Sub-Sector';
                ApplicationArea = all;
                Visible = true;
            }
            field("Net Change"; rec."Net Change")
            {
                ApplicationArea = all;
            } //EX-RBF 190624
        }
    }
//3593 - MEP - 2022 03 21 END
}
