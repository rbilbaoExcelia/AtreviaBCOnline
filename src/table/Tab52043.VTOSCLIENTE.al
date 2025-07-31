table 52043 "VTOS_CLIENTE"
{
    fields
    {
        field(1; CUSTOMER; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; POSTINGDATE; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; DOCTYPE; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pago,Factura,Abono,Docs. interés,Recordatorio,Reembolso,,,,,,,,,,,,,,,Efecto';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund, , , , , , , , , , , , , , , Bill;
        }
        field(4; DOCNO; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; IMPTEPDTE; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; DUEDATE; Date)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; CUSTOMER, DOCNO, IMPTEPDTE)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
