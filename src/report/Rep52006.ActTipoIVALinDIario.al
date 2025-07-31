report 52006 "ActTipoIVA LinDIario"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ActTipoIVALinDIario.rdlc';
    Caption = 'ActTipoIVA LinDiario';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gen. Journal Line";81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")WHERE("Journal Template Name"=FILTER('GENERAL'), "Journal Batch Name"=FILTER('MIGRACION'), "Account No."=FILTER('629*'), "Gen. Posting Type"=FILTER(' '));

            trigger OnAfterGetRecord()
            begin
                "Gen. Journal Line".VALIDATE("Gen. Posting Type", "Gen. Journal Line"."Gen. Posting Type"::Purchase);
                Modify();
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Fin');
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
