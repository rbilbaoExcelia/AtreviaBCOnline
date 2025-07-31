report 52018 "Cliente Quitar - CIF borrar"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ClienteQuitarCIFborrar.rdlc';
    Caption = 'Cliente Quitar - CIF borrar';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer;18)
        {
            trigger OnAfterGetRecord()
            begin
                IF Customer."VAT Registration No." <> '' THEN BEGIN
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
