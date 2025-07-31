tableextension 52082 "SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(52000; "Seminar Foot Text"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Seminar Foot Text';
            Description = '-008';
        }
        field(52001; "Salon Foot Text"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Salon Foot Text';
            Description = '-008';
        }
        field(52002; "Print on PDF"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print on PDF';
        }
        field(52003; "Admin email"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Email administración';
            Description = '-028';
        }
    }
}
