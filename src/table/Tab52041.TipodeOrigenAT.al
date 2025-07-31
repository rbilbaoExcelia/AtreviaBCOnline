table 52041 "Tipo de Origen AT"
{
    // Excelia - 2021 02 09 - Creo objeto
    Caption = 'Origin Type';
    DataPerCompany = false;
    DrillDownPageID = "Tipo de Origen";
    LookupPageID = "Tipo de Origen";

    fields
    {
        field(1; "Tipo de Origen"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Origin Type';
        }
    }
    keys
    {
        key(Key1; "Tipo de Origen")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
