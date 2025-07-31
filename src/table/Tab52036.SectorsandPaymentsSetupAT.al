table 52036 "Sectors and Payments Setup AT"
{
    // 025 OS.MIR  29/06/2016  COM.002   Texto descriptivo timming a pedidos de compra (Sincronización SQL)
    Caption = 'Sectors and Payments Setup';

    fields
    {
        field(1; Sector; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector';
            TableRelation = "Sector AT".Code WHERE(Type=CONST("9"));
        }
        field(2; "Payment Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Inforpress payment,Accrued,Action,Closed Job';
            OptionMembers = "Inforpress payment", Accrued, "Action", "Closed Job";
        }
        field(3; "G/L Account"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Account';
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Contract G/L Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract G/L Account';
            TableRelation = "G/L Account"."No." WHERE("No."=FILTER(7..799999999));
        }
    }
    keys
    {
        key(Key1; Sector, "Payment Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
