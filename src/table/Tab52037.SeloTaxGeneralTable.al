table 52037 "Selo Tax General Table"
{
    // 003 OS.MIR  07/06/2016  FIN.003 Fichero SAF-T Portugal
    Caption = 'Selo Tax General Table';

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Measure units"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Measure units';
            OptionCaption = 'Value,Item,Month';
            OptionMembers = Value, Item, Month;
        }
        field(4; "Qty per tax unit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty per tax unit';
        }
        field(5; "Minimum unit qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum unit qty.';
        }
        field(6; "Maximum unit qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum unit qty.';
        }
        field(7; "Tax value type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Percentage,Absolute';
            OptionMembers = Percentage, Absolute;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Selo Tax Account No."; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Other Tax Account No."; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Reverse charge"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Minimum Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; Header; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(14; Zone; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'C,A,M';
            OptionMembers = C, A, M;
        }
        field(15; "Amount To Pay"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Date Filter"; Date)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
