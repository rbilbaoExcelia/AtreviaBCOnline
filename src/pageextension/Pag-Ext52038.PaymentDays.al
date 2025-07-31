pageextension 52038 "PaymentDays" extends "Payment Days"
{
    layout
    {
        addfirst(Control1)
        {
            field(Code; Rec.Code)
            {
                ToolTip = 'Code';
                ApplicationArea = All;
            }
        }
    }
}
