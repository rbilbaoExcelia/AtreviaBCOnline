report 52054 "Proveedor Quitar - CIF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ProveedorQuitarCIF.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor;23)
        {
            trigger OnAfterGetRecord()
            begin
                IF Vendor."VAT Registration No." <> '' THEN BEGIN
                    "VAT Registration No.":=DELCHR("VAT Registration No.", '=', '-');
                    Modify();
                END;
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
}
