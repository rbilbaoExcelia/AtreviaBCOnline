report 52026 "DELETE Vendors"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

            trigger OnAfterGetRecord()
            begin
                Vendor.SETRANGE(Vendor.Name, '');
                Vendor.SETRANGE(Vendor."VAT Registration No.", '');
                qty:=Vendor.COUNT;
                Vendor.DELETEALL(TRUE);
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Fin %1', qty);
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
    var Vendor: Record 23;
    qty: Integer;
}
