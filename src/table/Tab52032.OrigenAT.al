table 52032 "Origen AT"
{
    // Excelia - 2021 02 09 - Creo objeto
    Caption = 'Origin';
    DataPerCompany = false;
    DrillDownPageID = Origen;
    LookupPageID = Origen;

    fields
    {
        field(1; Origen; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Origin';
        }
    }
    keys
    {
        key(Key1; Origen)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
