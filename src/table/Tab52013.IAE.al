table 52013 "IAE"
{
    // EXC - 2728 - 2021 05 10   Creacion de la tabla IAE Con los campos Codigo IAE, Descripcion y Sector.
    Caption = 'Description';
    DataPerCompany = false;
    DrillDownPageID = IAE;
    LookupPageID = IAE;

    fields
    {
        field(1; "Codigo IAE"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IAE Code';
        }
        field(2; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Sector; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector';
            TableRelation = "Sector AT".Code WHERE(Type=CONST("9"));
        }
    }
    keys
    {
        key(Key1; "Codigo IAE")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
