table 52038 "Selo Tax Ledger Entries"
{
    // 003 OS.MIR  07/06/2016  FIN.003 Fichero SAF-T Portugal
    Caption = 'Selo Tax Ledger Entries';

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(3; "Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Amount';
        }
        field(4; "Base Qty."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Qty.';
        }
        field(5; "Selo Tax code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Selo Tax code';
            TableRelation = "Selo Tax General Table";
        }
        field(6; "Selo Tax Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Selo Tax Amount';
        }
        field(7; "Paid?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Paid?';
        }
        field(8; "Payment date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment date';
        }
        field(9; "Bill No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill No.';
        }
        field(10; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
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
