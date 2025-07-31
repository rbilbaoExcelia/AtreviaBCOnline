tableextension 52049 "JobLedgerEntry" extends "Job Ledger Entry"
{
    fields
    {
        field(52000; "Transferred to Planning Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tranferido a lín. planific';
            Description = '045';
            Editable = false;
        }
        field(52002; "Job Line Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Line Account No.';
            Description = '-055';
            TableRelation = IF(Type=CONST("G/L Account"))"G/L Account";

            trigger OnValidate()
            var
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(52010; "Old Dimension Value"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("MOVS PROYECTOS".Dim1 WHERE("Job No."=FIELD("Job No."), "Posting Date"=FIELD("Posting Date"), "Document No."=FIELD("Document No."), Cost=FIELD("Unit Cost (LCY)"), "Unit Price"=FIELD("Unit Price (LCY)")));
        }
        field(52107; "Job Assistant"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Asistente';
            Description = '057';
        }
        field(52111; Confirmed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed';
            Description = '055';
        }
        field(52112; "To Credit"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Abonar';
            Description = '055';
        }
        field(52113; "Company source"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company source';
            Description = '065';
            TableRelation = Company;
        }
        field(52114; "Job Dimension 1"; Code[20])
        {
            CalcFormula = Lookup(Job."Global Dimension 1 Code" WHERE("No."=FIELD("Job No.")));
            FieldClass = FlowField;
        }
        field(52115; "Job Dimension 2"; Code[20])
        {
            CalcFormula = Lookup(Job."Global Dimension 2 Code" WHERE("No."=FIELD("Job No.")));
            FieldClass = FlowField;
        }
        field(52116; "Cod. agrupacion"; Code[50])
        {
            CalcFormula = Lookup("G/L Account"."Grouping Code" WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
        }
    }
    trigger OnBeforeInsert()
    begin
        //075
        "Company source":=COMPANYNAME;
    //075
    end;
}
