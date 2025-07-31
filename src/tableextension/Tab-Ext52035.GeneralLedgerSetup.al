tableextension 52035 "GeneralLedgerSetup" extends "General Ledger Setup"
{
    fields
    {
        field(52000; "Libro generacion diario"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'EX-OMI 231019';
            TableRelation = "Gen. Journal Template".Name WHERE(Type=FILTER(General), Recurring=FILTER(false));
        }
        field(52001; "Seccion generacion diario"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'EX-OMI 231019';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Libro generacion diario"));
        }
        field(52002; "Dimension Proyecto"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension.Code;
        }
        field(52030; "Average Exchange Rate AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Average Exchange Rate';
            Description = '-010';

            trigger OnValidate()
            begin
                Rec.TESTFIELD("Additional Reporting Currency"); //010
            end;
        }
        field(52031; "Close Exchange Rate AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Close Exchange Rate';
            Description = '-010';

            trigger OnValidate()
            begin
                Rec.TESTFIELD("Additional Reporting Currency"); //010
            end;
        }
        field(52032; OmmitAllCompanies; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Omite todas compañias';
        }
    }
}
