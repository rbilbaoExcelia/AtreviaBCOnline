report 52051 "Poner Sincronizado TRUE"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor;23)
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            begin
                Vendor."SQL Synchronized AT":=TRUE;
                Vendor.Modify();
            end;
        }
        dataitem(Customer;18)
        {
            trigger OnAfterGetRecord()
            begin
                Customer."SQL Synchronized":=TRUE;
                Customer.Modify();
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
    trigger OnInitReport()
    begin
        EXIT;
    end;
    trigger OnPostReport()
    begin
        MESSAGE('FIN');
    end;
}
