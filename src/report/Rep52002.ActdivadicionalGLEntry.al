report 52002 "Act div adicional GLEntry"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ActdivadicionalGLEntry.rdlc';
    Permissions = TableData 17=rm;
    ProcessingOnly = false;
    Caption = 'Act div adicional GLEntry';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry";17)
        {
            DataItemTableView = SORTING("Posting Date", "G/L Account No.", "Dimension Set ID");

            column(NoCuenta; "G/L Entry"."G/L Account No.")
            {
            }
            column(FechaRegistro; "G/L Entry"."Posting Date")
            {
            }
            column(NoDoc; "G/L Entry"."Document No.")
            {
            }
            column(Debe; "G/L Entry"."Debit Amount")
            {
            }
            column(Haber; "G/L Entry"."Credit Amount")
            {
            }
            column(Importe; "G/L Entry".Amount)
            {
            }
            column(ImporteDA; "G/L Entry"."Additional-Currency Amount")
            {
            }
            column(DebeDA; "G/L Entry"."Add.-Currency Debit Amount")
            {
            }
            column(HaberDA; "G/L Entry"."Add.-Currency Credit Amount")
            {
            }
            trigger OnAfterGetRecord()
            begin
                // TIPO DE CAMBIO SEGUN CARGA DE FILIALES
                /*IF "G/L Entry"."Source Code"='FILIAL' THEN BEGIN
                
                ConsExchangeRate.SETFILTER(ConsExchangeRate.Date,'<=%1', "G/L Entry"."Posting Date");
                ConsExchangeRate.SETRANGE(ConsExchangeRate."Currency Code",GLSetup."Additional Reporting Currency");
                ConsExchangeRate.FindLast();
                
                ConsExchangeRate.TESTFIELD("Average Exchange Rate");
                ConsExchangeRate.TESTFIELD("Close Exchange Rate");
                
                "Add.-Currency Debit Amount" := ROUND("Debit Amount" * ConsExchangeRate."Average Exchange Rate",0.01);
                "Add.-Currency Credit Amount" := ROUND("Credit Amount" * ConsExchangeRate."Average Exchange Rate",0.01);
                "Additional-Currency Amount" := ROUND(Amount * ConsExchangeRate."Average Exchange Rate",0.01);
                
                
                END ELSE BEGIN
                
                CurrencyExchangeRate.SETRANGE("Currency Code", GLSetup."Additional Reporting Currency");
                CurrencyExchangeRate.SETFILTER("Starting Date",'<=%1', "G/L Entry"."Posting Date");
                IF CurrencyExchangeRate.FindLast() then
                  CurrencyExchangeRate.TESTFIELD("Exchange Rate Amount");
                
                "Add.-Currency Debit Amount" := ROUND("Debit Amount" * CurrencyExchangeRate."Exchange Rate Amount",0.01);
                "Add.-Currency Credit Amount" := ROUND("Credit Amount" * CurrencyExchangeRate."Exchange Rate Amount",0.01);
                "Additional-Currency Amount" := ROUND(Amount * CurrencyExchangeRate."Exchange Rate Amount",0.01);
                END;
                */
                IF STRPOS("G/L Entry".Description, 'Imp. (DL)') <> 0 THEN BEGIN
                    "Add.-Currency Debit Amount":=0;
                    "Add.-Currency Credit Amount":=0;
                    "Additional-Currency Amount":=0;
                END;
                Modify();
            end;
            trigger OnPreDataItem()
            begin
                GLSetup.Get();
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
    var GLSetup: Record 98;
    //ConsExchangeRate: Record 7135710;
    CurrencyExchangeRate: Record 330;
}
