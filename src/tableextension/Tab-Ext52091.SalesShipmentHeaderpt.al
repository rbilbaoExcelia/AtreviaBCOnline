tableextension 52091 "SalesShipmentHeaderpt" extends "Sales Shipment Header"
{
    fields
    {
        field(52000; Hash; Text[172])
        {
            DataClassification = CustomerContent;
            Caption = 'Hash';
            Description = '-003';
        }
        field(52001; "Private Key Version"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Private Key Version';
            Description = '-003';
        }
        field(52002; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Time';
            Description = '-003';
        }
        field(52003; "Creation Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Time';
            Description = '-003';
        }
        field(52010; "External Job Document No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'External Job Document No.';
            Description = '-027';
        }
    }
}
