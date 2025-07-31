report 52017 "Cliente Quitar - CIF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ClienteQuitarCIF.rdlc';
    Caption = 'Cliente Quitar - CIF';
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
