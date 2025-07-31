tableextension 52086 "SalesCue" extends "Sales Cue"
{
    fields
    {
        field(52000; "Job Planning Line - Sale Open"; Integer)
        {
            AccessByPermission = TableData 1003=R;
            CalcFormula = Count("Job Planning Line" WHERE("Line Type"=FILTER(Billable|"Both Budget and Billable"), "Qty. to Invoice"=FILTER(<>0), "No."=FILTER(<>'A1'&<>'A2'), "Planning Date"=FIELD("Date Filter3"), "Confirmed AT"=FILTER(true)));
            Caption = 'Job Planning Line - Sale Open';
            Description = '-046';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52001; "Date Filter3"; Date)
        {
            FieldClass = FlowFilter;
        }
    }
}
