tableextension 52073 "ReasonCode" extends "Reason Code"
{
    fields
    {
        field(52000; "Not Commercial Operation AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Not Commercial Operation';
            Description = '-010';
        }
        field(52001; "Removal Account AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Removal Account';
            Description = '-010';
            TableRelation = "G/L Account";
        }
        field(52002; "Only Period AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Solo período';
            Description = '-010';
        }
        field(52003; "Special NCO AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Special NCO';
            Description = '-010';
        }
        field(52004; "Balance NCO AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Balance NCO';
            Description = '-010';
            TableRelation = "Reason Code" WHERE("Not Commercial Operation AT"=CONST(true), "Removal Account AT"=FILTER(<>'')); //CONST(true));
        }
        field(52006; "Removal 100% AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Removal 100%';
            Description = '-010';
        }
    }
}
