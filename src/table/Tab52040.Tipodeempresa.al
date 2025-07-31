table 52040 "Tipo de empresa"
{
    DataPerCompany = false;
    LookupPageID = "Tipo de empresa list";

    fields
    {
        field(1; "tipo empresa"; Code[35])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "tipo empresa")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
