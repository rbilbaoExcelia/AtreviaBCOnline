table 52033 "Proy bloqueados"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Cod Proy"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; dESC; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(3; Tabla; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Cod Proy", Tabla)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
