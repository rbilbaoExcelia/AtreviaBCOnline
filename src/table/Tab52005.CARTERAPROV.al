table 52005 "CARTERA PROV."
{
    Description = 'lue';

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; VendorNo; Code[20])
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
        field(7; Docdate; Date)
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
