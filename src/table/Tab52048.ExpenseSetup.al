table 52048 "Expense Setup"
{
    // 011 OS.MIR  16/06/2016  FIN.010   Gastos de caja
    // 999 OS.MIR  29/06/2016  DataPerCompany = No    
    DataPerCompany = false;

    fields
    {
        field(1; "Surcharge %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Surcharge %';
        }
        field(2; "Expenses ESP Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses ESP Text';
        }
        field(3; "Surcharge ESP Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Surcharge ESP Text';
        }
        field(4; "Expenses PTG Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses PTG Text';
        }
        field(5; "Surcharge PTG Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Surcharge PTG Text';
        }
        field(6; "Expenses ENU Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses ENU Text';
        }
        field(7; "Surcharge ENU Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Surcharge ENU Text';
        }
        field(8; "Expenses CAT Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses CAT Text';
        }
        field(9; "Surcharge CAT Text"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Surcharge CAT Text';
        }
        field(10; "General Journal MyNet"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'General Journal MyNet';
            TableRelation = "Gen. Journal Template";
        }
        field(11; "Gen. Journal Section MyNet"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Journal Section MyNet';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name"=field("General Journal MyNet"));
        }
        field(12; "Expense Account No. MyNet"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Expense Account No. MyNet';
            TableRelation = "G/L Account";
        }
        field(13; "Generic task Jobs"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Generic task Jobs';
            Description = 'MN06';
        }
        field(14; "Generic task description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Generic task description';
            Description = 'MN06';
        }
        field(15; "Generic task identation"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Generic task identation';
            Description = 'MN06';
        }
        field(16; "Offsetting Account No. MyNet"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Offsetting Account No. MyNet';
            Description = 'MN06';
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; "Surcharge %")
        {
            Clustered = true;
        }
    }
    procedure GetTxt(Gastos: Boolean; Lng: Code[10])txt: Text[30]begin
        CASE Lng OF '': BEGIN
            TESTFIELD("Expenses ESP Text");
            TESTFIELD("Surcharge ESP Text");
            IF Gastos THEN EXIT("Expenses ESP Text")
            ELSE
                EXIT("Surcharge ESP Text");
        END;
        'POR', 'PTG': BEGIN
            TESTFIELD("Expenses PTG Text");
            TESTFIELD("Surcharge PTG Text");
            IF Gastos THEN EXIT("Expenses PTG Text")
            ELSE
                EXIT("Surcharge PTG Text");
        END;
        'ENU': BEGIN
            TESTFIELD("Expenses ENU Text");
            TESTFIELD("Surcharge ENU Text");
            IF Gastos THEN EXIT("Expenses ENU Text")
            ELSE
                EXIT("Surcharge ENU Text");
        END;
        'CAT': BEGIN
            TESTFIELD("Expenses CAT Text");
            TESTFIELD("Surcharge CAT Text");
            IF Gastos THEN EXIT("Expenses CAT Text")
            ELSE
                EXIT("Surcharge CAT Text");
        END;
        END;
    end;
}
