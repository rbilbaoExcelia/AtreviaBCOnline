tableextension 52059 "NoSeriesLine" extends "No. Series Line"
{
    fields
    {
        field(52000; "Last Hash Used"; Text[172])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Hash Used';
            Description = '-003';
        }
        field(52001; "Last No. Posted"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Last No. Posted';
            Description = '-003';
        }
        field(52002; "Previous Last Date Used"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Previous Last Date Used';
            Description = '-003';
        }
    }
}
