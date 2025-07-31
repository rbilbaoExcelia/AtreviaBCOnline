tableextension 52078 "ResourcesSetup" extends "Resources Setup"
{
    fields
    {
        field(52000; "Gen. Prod. Ptg. Group Gener AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            Description = 'Gen. Prod. Posting Group Generic';
        }
        field(52001; "Base Unit of Measure Gener AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            Description = 'Base Unit of Measure Generic';

            trigger OnValidate()
            var
                UnitOfMeasure: Record 204;
                ResUnitOfMeasure: Record 205;
            begin
            end;
        }
    }
}
