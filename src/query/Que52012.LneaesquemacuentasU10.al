query 52012 "Línea esquema cuentas U10"
{
    elements
    {
    dataitem(QueryElement1000000000;
    85)
    {
    column(Schedule_Name;
    "Schedule Name")
    {
    ColumnFilter = Schedule_Name=FILTER('UNIDADES10');
    }
    column(Row_No;
    "Row No.")
    {
    ColumnFilter = Row_No=FILTER(<>'');
    }
    column(Description;
    Description)
    {
    }
    column(Totaling;
    Totaling)
    {
    }
    column(Totaling_Type;
    "Totaling Type")
    {
    }
    column(Reverse_Sign;
    "Reverse Sign")
    {
    }
    }
    }
}
