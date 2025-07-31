tableextension 52064 "PostedWhseShipmentHeader" extends "Posted Whse. Shipment Header"
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
    }
    trigger OnBeforeDelete()
    begin
        //<003
        ERROR(LText0001);
    //003>
    end;
    var LText0001: Label 'Posted warehouse shipments cannot be deleted.';
}
