tableextension 52092 "ServiceLine" extends "Service Line"
{
    fields
    {
    }
    //Unsupported feature: Property Insertion (PasteIsValid) on ""Service Line"(Table 5902)".
    local procedure TaxFactor(TaxRate1: Decimal; TaxRate2: Decimal): Decimal begin
        IF TaxRate1 + TaxRate2 = 0 THEN EXIT(1);
        EXIT(TaxRate1 / (TaxRate1 + TaxRate2));
    end;
}
