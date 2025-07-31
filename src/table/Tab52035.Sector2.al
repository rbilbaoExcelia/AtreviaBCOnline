table 52035 "Sector2"
{
    DataPerCompany = false;
    LookupPageID = "Sector List";

    fields
    {
        field(1; "Cod Sector"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Cod Sector")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
