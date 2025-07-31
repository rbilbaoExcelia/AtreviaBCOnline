table 52017 "Job Concept Descriptions"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            Editable = true;
            NotBlank = true;
            TableRelation = Job;
        }
        field(2; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.';
            NotBlank = true;

            trigger OnValidate()
            var
                Job: Record Job;
                Cust: Record 18;
            begin
            end;
        }
        field(3; "Job Plan. Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            Editable = true;
        }
        field(6; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }
    keys
    {
        key(Key1; "Job No.", "Job Task No.", "Job Plan. Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
