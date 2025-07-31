table 52029 "MOV.CONTAB"
{
    fields
    {
        field(1; "G/L Account No."; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,,,,,,,,,,,Efecto';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund, , , , , , , , , , , , , , , Bill;
        }
        field(4; "Document No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Transaction No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(13; TxtImporte; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(14; NewDim1; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; NewDim2; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Existe NewDim1"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Existe NewDim2"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Existe Proyecto"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52000; "Usado mapeo"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Transaction No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
