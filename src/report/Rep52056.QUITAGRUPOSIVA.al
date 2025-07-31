report 52056 "QUITA GRUPOS IVA"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gen. Journal Line";81)
        {
            trigger OnAfterGetRecord()
            begin
                "Gen. Journal Line".VALIDATE("Gen. Posting Type", "Gen. Journal Line"."Gen. Posting Type"::" ");
                "Gen. Journal Line".VALIDATE("Gen. Bus. Posting Group", '');
                "Gen. Journal Line".VALIDATE("Gen. Prod. Posting Group", '');
                "Gen. Journal Line".VALIDATE("VAT Bus. Posting Group", '');
                "Gen. Journal Line".VALIDATE("VAT Prod. Posting Group", '');
                "Gen. Journal Line".Modify();
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
