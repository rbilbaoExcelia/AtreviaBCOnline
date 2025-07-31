report 52009 "ARREGLA TIPO CAMBIO CONSOL."
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ARREGLATIPOCAMBIOCONSOL.rdlc';
    Caption = 'Arreglar tipo cambio Consol.';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
    /*TODO - Resolve missing table 7135710
        dataitem("Consol. Exchange Rates"; 7135710)
        {

            trigger OnAfterGetRecord()
            begin
                "Consol. Exchange Rates"."Average Exchange Rate" := "Consol. Exchange Rates"."Average Exchange Rate" * 100;
                "Consol. Exchange Rates"."Close Exchange Rate" := "Consol. Exchange Rates"."Close Exchange Rate" * 100;
                "Consol. Exchange Rates"."Budget Exchange Rate" := "Consol. Exchange Rates"."Budget Exchange Rate" * 100;
                Modify();
            end;
        } */
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
