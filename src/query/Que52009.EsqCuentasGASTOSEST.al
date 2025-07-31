query 52009 "Esq_Cuentas_GASTOS_EST"
{
    elements
    {
    dataitem(QueryElement1000000000;
    85)
    {
    column(Schedule_Name;
    "Schedule Name")
    {
    ColumnFilter = Schedule_Name=FILTER('GASTOS BI');
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
