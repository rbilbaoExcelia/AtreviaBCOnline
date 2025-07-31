query 52017 "Movs_Proyectos"
{
    elements
    {
    dataitem(QueryElement1000000000;
    169)
    {
    column(Job_No;
    "Job No.")
    {
    }
    column(Posting_Date;
    "Posting Date")
    {
    }
    column(Description;
    Description)
    {
    }
    column(Global_Dimension_1_Code;
    "Global Dimension 1 Code")
    {
    }
    column(Global_Dimension_2_Code;
    "Global Dimension 2 Code")
    {
    }
    column(No;
    "No.")
    {
    }
    column(Entry_Type;
    "Entry Type")
    {
    }
    column(Total_Cost;
    "Total Cost")
    {
    }
    column(Document_No;
    "Document No.")
    {
    }
    column(Entry_No;
    "Entry No.")
    {
    }
    column(Ledger_Entry_No;
    "Ledger Entry No.")
    {
    }
    }
    }
    trigger OnBeforeOpen()
    begin
        SETFILTER(Posting_Date, '%1..', DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 1));
    end;
}
