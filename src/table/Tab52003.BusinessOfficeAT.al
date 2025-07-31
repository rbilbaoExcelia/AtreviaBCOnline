table 52003 "Business Office AT"
{
    // 011 OS.MIR  16/06/2016  FIN.010   Gastos de caja
    // 999 OS.MIR  29/06/2016  DataPerCompany = No
    Caption = 'Business Office';
    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Name; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(3; "SQL Synchronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
        }
        field(4; "No. Entries Ranking"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Entries Ranking';
        }
        field(5; "Excel Column"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Excel Column';
        }
        field(52000; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "SQL Synchronized")
        {
        }
        key(Key3; "Excel Column")
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
