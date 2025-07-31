report 52070 "TMP PT"
{
    ProcessingOnly = true;

    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = all;
    dataset
    {
        dataitem("Sales Invoice Header";112)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE("No."=CONST('201811121'));

            trigger OnAfterGetRecord()
            begin
                "Document Date":=20181211D;
                Modify();
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
}
