table 52034 "Sector AT"
{
    // 025 OS.MIR  29/06/2016  COM.002   Texto descriptivo timming a pedidos de compra (Sincronización SQL)
    // 999 OS.MIR  29/06/2016  DataPerCompany = No
    Caption = 'Sector';
    DataPerCompany = false;

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = '0,1,2,3,9';
            OptionMembers = "0", "1", "2", "3", "9";
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(3; Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(5; "SQL Synchronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
        }
    }
    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
        key(Key2; "SQL Synchronized")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnModify()
    begin
        "SQL Synchronized":=FALSE;
    end;
}
