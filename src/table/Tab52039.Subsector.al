table 52039 "Subsector"
{
    DataPerCompany = false;
    LookupPageID = "Subsector List";

    fields
    {
        field(1; "Cod Subsector"; Code[100])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Cod Subsector")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
