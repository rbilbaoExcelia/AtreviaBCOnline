tableextension 52067 "PurchaseHeaderArchive" extends "Purchase Header Archive"
{
    fields
    {
        field(52002; "Web Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Web Description';
            Description = '-025';
        }
    }
    procedure ShowOrderCard(DocumentNo: Code[20])
    begin
        //001
        SETRANGE("Document Type", Rec."Document Type"::Order);
        SETRANGE("No.", DocumentNo);
        IF NOT FindFirst()THEN BEGIN
            MESSAGE(Txt001);
            EXIT;
        END;
        SETRECFILTER;
        PAGE.RUN(PAGE::"Purchase Order Archive", Rec);
    end;
    var Txt001: Label 'No existe ningun pedido';
}
