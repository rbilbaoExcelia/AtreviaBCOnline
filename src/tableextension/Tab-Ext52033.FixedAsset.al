tableextension 52033 "FixedAsset" extends "Fixed Asset"
{
    fields
    {
        field(52000; "Responsible Resource"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsible Employee';
            TableRelation = Resource;
        }
        field(52001; "Responsible Resource Name"; Text[250])
        {
            CalcFormula = Lookup(Resource.Name WHERE("No."=FIELD("Responsible Resource")));
            Caption = 'Responsible Resource Name';
            FieldClass = FlowField;
        }
        field(52002; Property; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Property';
            Description = 'SIIME';
        }
    }
}
