tableextension 52106 "VendorPostingGroup" extends "Vendor Posting Group"
{
    fields
    {
        field(52000; "Not Invoiced Shipments Acc."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Not Invoiced Shipments Acc.';
            Description = '-010';
            TableRelation = "G/L Account";
        }
    }
}
