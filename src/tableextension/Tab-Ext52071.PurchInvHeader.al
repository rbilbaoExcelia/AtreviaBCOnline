tableextension 52071 "PurchInvHeader" extends "Purch. Inv. Header"
{
    fields
    {
        field(52002; "Web Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Web Description';
            Description = '-025';
        }
        field(52005; "Job No."; Code[20])
        {
            CalcFormula = Lookup("Purch. Inv. Line"."Job No." WHERE("Document No."=FIELD("No."), "Job No."=FILTER(<>'')));
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
        field(52014; "Facturas de Gastos"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'EX-OMI 231019';
        }
    }
    trigger OnBeforeDelete()
    begin
        //123
        ERROR(Text50000);
    //123
    end;
    var Text50000: Label 'No es posible eliminar documentos registrados.';
}
