table 52010 "Department Grouping"
{
    Caption = 'Department Grouping';
    DataPerCompany = false;

    fields
    {
        field(1; "Línea"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Nombre Hoja"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Filtro departamento"; Text[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(4; "Filtro zona"; Text[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5; "Departamento matriz"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento matriz';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
    }
    keys
    {
        key(Key1; "Línea")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
