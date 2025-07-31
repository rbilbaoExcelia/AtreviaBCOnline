query 52013 "Lin_Proyecto"
{
    elements
    {
    dataitem(QueryElement1000000000;
    1003)
    {
    column(Job_No;
    "Job No.")
    {
    }
    column(Description;
    Description)
    {
    }
    column(Total_Price_LCY;
    "Total Price (LCY)")
    {
    }
    column(Planning_Date;
    "Planning Date")
    {
    }
    column(Type;
    Type)
    {
    }
    column(No;
    "No.")
    {
    }
    column(Line_Amount_LCY;
    "Line Amount (LCY)")
    {
    }
    column(Total_Price;
    "Total Price")
    {
    }
    column(Qty_Invoiced;
    "Qty. Invoiced")
    {
    }
    column(Customer_No;
    "Customer No. AT")
    {
    }
    column(Customer_Name;
    "Customer Name AT")
    {
    }
    }
    }
    trigger OnBeforeOpen()
    begin
        /*
        empresa.GET(COMPANYNAME);
        
        IF empresa."Ignorar en WS" THEN
          EXIT(0);
        ELSE*/
        SETFILTER(Planning_Date, '%1..', DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 1));
    //END;
    //CurrQuery.SETRANGE(DATE2MY(CurrQuery.Posting_Date,3), (CY-1Y|Y));
    end;
}
