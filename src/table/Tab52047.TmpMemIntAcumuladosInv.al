table 52047 "Tmp MemIntAcumulados Inv"
{
    fields
    {
        field(1; "Cod 1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Cod 2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Cod 3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Cod 4"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Cod 5"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Descripción; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Description 1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Description 2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; Importe1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; Importe2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; Importe3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; Importe4; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Int 20"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(14; Cod100; Code[100])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Cod 1", "Cod 2", "Int 20")
        {
            Clustered = true;
        }
    }
}
