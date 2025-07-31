tableextension 52083 "SalesCommentLine" extends "Sales Comment Line"
{
    fields
    {
        field(52000; "Print On Invoices"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Invoices';
            Description = '-008';
        }
    }
}
