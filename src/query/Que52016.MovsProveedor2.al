query 52016 "Movs_Proveedor_2"
{
    elements
    {
    dataitem(QueryElement1000000000;
    25)
    {
    column(Vendor_No;
    "Vendor No.")
    {
    }
    column(Posting_Date;
    "Posting Date")
    {
    }
    column(Due_Date;
    "Due Date")
    {
    }
    column(Document_No;
    "Document No.")
    {
    }
    column(Description;
    Description)
    {
    }
    column(Original_Amt_LCY;
    "Original Amt. (LCY)")
    {
    }
    column(Remaining_Amt_LCY;
    "Remaining Amt. (LCY)")
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
    column(Job_No;
    "Job No.")
    {
    }
    column(Company_source;
    "Company source")
    {
    }
    }
    }
    trigger OnBeforeOpen()
    begin
        SETFILTER(Posting_Date, '%1..', DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 1));
    end;
}
