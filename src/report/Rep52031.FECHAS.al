report 52031 "FECHAS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/FECHAS.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry";17)
        {
            trigger OnAfterGetRecord()
            begin
                "G/L Entry"."Posting Date":=CLOSINGDATE("G/L Entry"."Posting Date");
                "G/L Entry".Modify();
            end;
            trigger OnPreDataItem()
            begin
                SETRANGE("G/L Entry"."Posting Date", 20131231D);
                SETRANGE("G/L Entry"."Document No.", 'CIERRE 2013');
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
