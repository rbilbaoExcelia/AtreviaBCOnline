tableextension 52009 "CashFlowForecastEntry" extends "Cash Flow Forecast Entry"
{
    fields
    {
        modify("Source Type")
        {
        Description = '-007';
        }
        //Unsupported feature: Property Modification (Data type) on "Description(Field 15)".
        modify("Global Dimension 2 Code")
        {
        TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        modify("Global Dimension 1 Code")
        {
        TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        /* modify("Recurring Method")
        {
            BlankZero = true;
        } */
        modify("Source No.")
        {
        TableRelation = IF("Source Type"=CONST("Liquid Funds"))"G/L Account"
        ELSE IF("Source Type"=CONST("Receivables"))Customer
        ELSE IF("Source Type"=CONST("Payables"))Vendor
        ELSE IF("Source Type"=CONST("Fixed Assets Budget"))"Fixed Asset"
        ELSE IF("Source Type"=CONST("Fixed Assets Disposal"))"Fixed Asset"
        ELSE IF("Source Type"=CONST("Sales Orders"))"Sales Header"."No." WHERE("Document Type"=CONST(Order))
        ELSE IF("Source Type"=CONST("Purchase Orders"))"Purchase Header"."No." WHERE("Document Type"=CONST(Order))
        ELSE IF("Source Type"=CONST("Service Orders"))"Service Header"."No." WHERE("Document Type"=CONST(Order))
        ELSE IF("Source Type"=CONST("Cash Flow Manual Expense"))"Cash Flow Manual Expense"
        ELSE IF("Source Type"=CONST("Cash Flow Manual Revenue"))"Cash Flow Manual Revenue"
        ELSE IF("Source Type"=CONST("G/L Budget"))"G/L Account"
        ELSE IF("Source Type"=CONST("Jobs Billing"))"Job Planning Line"."Job No." WHERE("Contract Line"=CONST(true));
        Description = '-007';
        }
    }
}
