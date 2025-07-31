table 52002 "BIC Code"
{
    DataPerCompany = false;

    fields
    {
        field(1; NRBE; Code[4])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "BIC 11"; Code[11])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; NRBE)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
