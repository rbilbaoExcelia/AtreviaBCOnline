table 52046 "Personal Assignation"
{
    Caption = 'Personal Assignation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(2; IdMyNet; Code[50])
        {
            Caption = 'IdMyNet';
            DataClassification = CustomerContent;
            TableRelation = Resource;
        }
        field(3; NavDimension1; Code[50])
        {
            Caption = 'NavDimension1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code;

            trigger OnValidate()
            begin
                IF GLSetup.FindFirst()THEN IF DimensionValue.GET(GLSetup."Global Dimension 1 Code", NavDimension1)THEN EXIT;
                ERROR(dimensionValidationErrorLbl);
            end;
        }
        field(4; NavDimension2; Code[50])
        {
            Caption = 'NavDimension2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code;

            trigger OnValidate()
            begin
                IF GLSetup.FindFirst()THEN IF DimensionValue.GET(GLSetup."Global Dimension 2 Code", NavDimension2)THEN EXIT;
                ERROR(dimensionValidationErrorLbl);
            end;
        }
        field(5; EmployeeName; Text[100])
        {
            Caption = 'EmployeeName';
            DataClassification = CustomerContent;
        }
        field(6; CollaboratorType; Text[50])
        {
            Caption = 'CollaboratorType';
            DataClassification = CustomerContent;
        }
        field(7; ImputationPercentage; Decimal)
        {
            Caption = 'ImputationPercentage';
            DataClassification = CustomerContent;
        }
        field(8; FTEPercentage; Decimal)
        {
            Caption = 'FTEPercentage';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Date", IdMyNet, NavDimension1, NavDimension2)
        {
            Clustered = true;
        }
    }
    var GLSetup: Record "General Ledger Setup";
    DimensionValue: Record "Dimension Value";
    dimensionValidationErrorLbl: Label 'Dimension could not be found';
}
