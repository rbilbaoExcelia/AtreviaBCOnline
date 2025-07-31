table 52012 "Hours consulting AT"
{
    Caption = 'Hours consulting AT';

    fields
    {
        field(1; "No. consultor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Resource;
        }
        field(2; "No. proyecto"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Job;
        }
        field(3; Fecha; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; Horas; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Sincronizado; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(6; Registrado; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Horas registradas"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "No. movimiento"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Tipo error"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(52000; "Cód. Oficina"; Code[20])
        {
            CalcFormula = Lookup(Resource."Business Office Code AT" WHERE("No."=FIELD("No. consultor")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "No. movimiento")
        {
            Clustered = true;
        }
        key(Key2; "No. consultor", "No. proyecto", Fecha)
        {
            SumIndexFields = Horas;
        }
    }
    fieldgroups
    {
    }
}
