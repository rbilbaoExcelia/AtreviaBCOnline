table 52007 "Control Filiales Tmp AT"
{
    fields
    {
        field(1; Cuenta; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(2; Importe; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(3; Int; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; Int)
        {
            Clustered = true;
        }
    }
}
