table 52011 "File Atrevia"
{
    fields
    {
        field(1; "Path"; Code[98])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Is a file"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Name"; Text[99])
        {
            DataClassification = CustomerContent;
        }
        field(4; Size; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Data"; Blob)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(pk; "Path", "Is a file", "Name")
        {
        }
    }
}
