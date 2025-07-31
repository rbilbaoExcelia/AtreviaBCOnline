tableextension 52017 "CountryRegionPT" extends "Country/Region"
{
    fields
    {
        field(52000; "VAT Text PT"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Text';
            Description = '-003,310123';
        }
    }
}
