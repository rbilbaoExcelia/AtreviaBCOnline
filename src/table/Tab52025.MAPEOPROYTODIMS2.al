table 52025 "MAPEO PROY TO DIMS2"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Num proy"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Dim1; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(3; dim2; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(4; Nombre; Text[50])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Num proy")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Num proy")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
