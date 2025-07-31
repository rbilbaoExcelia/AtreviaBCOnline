table 52004 "CARTERA CLIENTS"
{
    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; CustomerNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; DocumentNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; BillNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; PostingDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; ExtDocNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; DocDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; DueDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; RemAmount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; SalespersonCode; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(13; DocType; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,,,,,,,,,,,Bill';
            OptionMembers = " ", Pago, Factura, Abono, "Docs. interés", Recordatorio, Reembolso, , , , , , , , , , , , , , , Efecto;
        }
        field(14; "Existe Cliente"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(15; TxtImporte; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(16; TxtImportePte; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Old Dimension1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Old Dimension2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
