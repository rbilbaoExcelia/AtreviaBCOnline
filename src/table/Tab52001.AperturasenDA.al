table 52001 "Aperturas en DA"
{
    fields
    {
        field(1; Account; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
        }
        field(2; "Amount DA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; Account)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
