tableextension 52061 "PaymentMethodPT" extends "Payment Method"
{
    fields
    {
        modify(Description)
        {
        Description = '-003';
        }
        field(52000; "Payment Processor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Processor';
            OptionCaption = ' ,Dynamics Online';
            OptionMembers = " ", "Dynamics Online";

            trigger OnValidate()
            begin
                IF "Payment Processor" = "Payment Processor"::"Dynamics Online" THEN Rec.TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
            end;
        }
        field(52001; "Collection Bank"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Collection Bank';
            Description = '-008';
            TableRelation = "Bank Account";
        }
        field(52002; "Show Address"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show Address';
            Description = '-008';
        }
        field(52003; "Payment Mechanism PT"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Mechanism';
            Description = '-003';
            OptionCaption = 'Cash,Check,Debit Card,Credit Card,Bank Transfer,Restaurant Ticket';
            OptionMembers = Cash, Check, "Debit Card", "Credit Card", "Bank Transfer", "Restaurant Ticket";
        }
    }
}
