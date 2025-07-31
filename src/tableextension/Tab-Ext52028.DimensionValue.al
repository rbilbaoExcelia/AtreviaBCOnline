tableextension 52028 "DimensionValue" extends "Dimension Value"
{
    fields
    {
        field(52000; "SQL Synchronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
            Description = '-025';
        }
        field(52001; "Show Office"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show Office';
            Description = '-025';
        }
        field(52002; "No. of Ranking Entries"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Ranking Entries';
            Description = '-019';
        }
        field(52003; "Excel Column"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Excel Column';
            Description = '-019';
            MinValue = 0;
        }
        field(52004; "Dim Estructura"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Dim Estructure';
            Description = '-999';
        }
        field(52005; "Split Dimension"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Split Dimension';
        }
        field(52006; Alias; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Alias';
        }
    }
    keys
    {
        key(Key4; "SQL Synchronized")
        {
        }
        key(Key5; "Excel Column")
        {
        }
    }
    trigger OnAfterDelete()
    begin
    //<025
    //IF ("Global Dimension No." = 1) AND ((NOT Blocked) OR (NOT "SQL Synchronized")) THEN
    //  ERROR(Text50000);
    //025>
    end;
    var Text50000: Label 'You have to block the value and synchronize the web before deleting this entry.';
}
