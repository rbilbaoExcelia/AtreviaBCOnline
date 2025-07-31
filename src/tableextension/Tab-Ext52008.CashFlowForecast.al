tableextension 52008 "CashFlowForecast" extends "Cash Flow Forecast"
{
    fields
    {
        modify("Source Type Filter")
        {
        OptionCaption = ' ,Receivables,Payables,Liquid Funds,Cash Flow Manual Expense,Cash Flow Manual Revenue,Sales Order,Purchase Order,Fixed Assets Budget,Fixed Assets Disposal,Service Orders,G/L Budget,,,,Jobs Billing';
        Description = '-007';
        }
    }
}
