report 52003 "Act IPRF Vendors"
{
    ProcessingOnly = true;
    Caption = 'Act IPRF Vendors';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor;23)
        {
            trigger OnAfterGetRecord()
            var
                updVendor: Record 23;
            begin
                updVendor:=Vendor;
                updVendor."IRPF Codigo":=Vendor."IRPF Code";
                updVendor."IRPF Pctg":=Vendor."IRPF %";
                updVendor.Modify();
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
    trigger OnPostReport()
    begin
        MESSAGE('Fin');
    end;
}
