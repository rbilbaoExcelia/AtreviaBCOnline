tableextension 52007 "CarteraDoc" extends "Cartera Doc."
{
    fields
    {
        field(52000; "Documento Externo"; Code[35])
        {
            CalcFormula = Lookup("Vendor Ledger Entry"."External Document No." WHERE("Document No."=FIELD("Document No.")));
            FieldClass = FlowField;
        }
    }
}
