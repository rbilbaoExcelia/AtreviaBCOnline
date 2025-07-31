query 52014 "Movimientos Contabilidad"
{
    elements
    {
    dataitem(QueryElement7141743;
    17)
    {
    column(Entry_No;
    "Entry No.")
    {
    }
    column(G_L_Account_No;
    "G/L Account No.")
    {
    ColumnFilter = G_L_Account_No=FILTER('6*|7*');
    }
    column(Posting_Date;
    "Posting Date")
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
    column(Amount;
    Amount)
    {
    }
    column(Debit_Amount;
    "Debit Amount")
    {
    }
    column(Credit_Amount;
    "Credit Amount")
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
    column(Dimension_Set_ID;
    "Dimension Set ID")
    {
    }
    column(Job_No;
    "Job No.")
    {
    }
    column(Journal_Batch_Name;
    "Journal Batch Name")
    {
    }
    column(Job_Name;
    "Job Name")
    {
    }
    column(Source_No;
    "Source No.")
    {
    }
    column(Document_Date;
    "Document Date")
    {
    }
    }
    }
    trigger OnBeforeOpen()
    var
        empresa: Record Company;
    begin
        /*
        empresa.GET(COMPANYNAME);
        
        IF empresa."Ignorar en WS" THEN
          EXIT(0);
        ELSE*/
        SETFILTER(Posting_Date, '%1..', DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 2));
    //END;
    //CurrQuery.SETRANGE(DATE2MY(CurrQuery.Posting_Date,3), (CY-1Y|Y));
    end;
}
