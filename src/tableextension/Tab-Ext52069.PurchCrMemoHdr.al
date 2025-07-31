tableextension 52069 "PurchCrMemoHdr" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(52005; "Job No."; Code[20])
        {
            CalcFormula = Lookup("Purch. Cr. Memo Line"."Job No." WHERE("Document No."=FIELD("No."), "Job No."=FILTER(<>'')));
            Caption = 'Job No.';
            Description = '-056';
            FieldClass = FlowField;
        }
        field(52006; "Job Name"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Name';
            FieldClass = FlowField;
        }
    }
    trigger OnBeforeDelete()
    BEGIN
        //123
        ERROR(Text50000);
    //123
    END;
    var Text50000: Label 'No es posible eliminar documentos registrados.';
}
