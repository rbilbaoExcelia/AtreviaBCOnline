tableextension 52098 "VATPosting_Setup" extends "VAT Posting Setup"
{
    fields
    {
        field(52000; "SAF-T PT VAT Type Descr. PT"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'SAF-T PT VAT Type Description';
            Description = '-003';
            OptionCaption = ' ,VAT Portugal Mainland,VAT Madeira,VAT Azores,VAT European Union,VAT Exportation';
            OptionMembers = " ", "VAT Portugal Mainland", "VAT Madeira", "VAT Azores", "VAT European Union", "VAT Exportation";
        }
        field(52001; "SAF-T PT VAT Code PT"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'SAF-T PT VAT Code';
            Description = '-003';
            OptionCaption = ' ,Intermediate tax rate,Normal tax rate,Reduced tax rate,No tax rate,Others';
            OptionMembers = " ", "Intermediate tax rate", "Normal tax rate", "Reduced tax rate", "No tax rate", Others;
        }
        field(52002; "Exempt Legal Precept PT"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Exempt Legal Precept';
            Description = '-003';
        }
        field(52003; "SAF-T Exempt Code PT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'SAF-T Exempt Code';
        }
    }
}
