pageextension 52040 "PaymentMethodsPT" extends "Payment Methods"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            // field("Payment Mechanism"; Rec."Payment Mechanism")
            // {
            //     ToolTip = 'Payment Mechanism';
            //     ApplicationArea = All;
            // }
            field("Payment Processor"; Rec."Payment Processor")
            {
                ToolTip = 'Payment Processor';
                ApplicationArea = All;
            }
        }
        addafter("Collection Agent")
        {
            field("Collection Bank"; Rec."Collection Bank")
            {
                ToolTip = 'Collection Bank';
                ApplicationArea = All;
            }
        }
    }
}
