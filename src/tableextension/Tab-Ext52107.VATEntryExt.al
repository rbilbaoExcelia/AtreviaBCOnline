tableextension 52107 "VATEntryExt" extends "VAT Entry"
{
    fields
    {
        field(52810; "SAF-T PT VAT Code PT"; Option) //EX-SGG 210322
        {
            Caption = 'SAF-T PT VAT Code';
            Description = 'EX-QR';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("VAT Posting Setup"."SAF-T PT VAT Code PT" WHERE("VAT Bus. Posting Group"=FIELD("VAT Bus. Posting Group"), "VAT Prod. Posting Group"=FIELD("VAT Prod. Posting Group")));
            OptionCaption = ' ,Intermediate tax rate,Normal tax rate,Reduced tax rate,No tax rate,Others';
            OptionMembers = " ", "Intermediate tax rate", "Normal tax rate", "Reduced tax rate", "No tax rate", "Others";
        }
        field(52811; "SAF-T PT VAT Type Descr. PT"; Option) //EX-SGG 210322
        {
            Caption = 'SAF-T PT VAT Type Description';
            Description = 'EX-QR';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("VAT Posting Setup"."SAF-T PT VAT Type Descr. PT" WHERE("VAT Bus. Posting Group"=FIELD("VAT Bus. Posting Group"), "VAT Prod. Posting Group"=FIELD("VAT Prod. Posting Group")));
            OptionCaption = ' ,VAT Portugal Mainland,VAT Madeira,VAT Azores,VAT European Union,VAT Exportation';
            OptionMembers = " ", "VAT Portugal Mainland", "VAT Madeira", "VAT Azores", "VAT European Union", "VAT Exportation";
        }
    }
}
