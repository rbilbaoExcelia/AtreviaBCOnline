table 52023 "MAPEO DIM to 2 DIMs AT"
{
    Caption = 'MAPEO DIM to 2 DIMs';
    DataPerCompany = false;

    fields
    {
        field(1; "Dimension Code Orig"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(2; "Code Orig"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; "Dim Code 1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(4; "Dim Code 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
    }
    keys
    {
        key(Key1; "Dimension Code Orig", "Code Orig")
        {
            Clustered = true;
        }
    }
}
