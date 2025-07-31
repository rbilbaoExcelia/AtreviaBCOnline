tableextension 52044 "Item" extends Item
{
    fields
    {
        field(52000; "SQL Synchronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
            Description = '-025';
        }
        field(52001; ForSale; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ForSale';
            Description = '-025';
        }
        field(52002; ForPurchase; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ForPurchase';
            Description = '-025';
        }
        field(52010; "Grouping Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grouping Code';
            Description = '-013';
            TableRelation = "Account Grouping AT";
        }
    }
    keys
    {
        key(Key15; "SQL Synchronized")
        {
        }
    }
    trigger OnAfterModify()
    begin
        "SQL Synchronized":=FALSE; //025
    end;
}
