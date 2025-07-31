table 52015 "IRPF Atrevia"
{
    // 024 OS.MIR  21/06/2016  COM.001   Módulo IRPF OS
    // 999 OS.MIR  29/06/2016  DataPerCompany = No
    DataPerCompany = false;
    DrillDownPageID = "IRPF Atrevia";
    LookupPageID = "IRPF Atrevia";

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Account No.';
            TableRelation = "G/L Account";
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; "IRPF %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'IRPF %';
        }
        field(5; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
