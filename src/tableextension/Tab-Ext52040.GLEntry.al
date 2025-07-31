tableextension 52040 "GLEntry" extends "G/L Entry"
{
    fields
    {
        field(52010; "Old Dimension Value"; Code[20])
        {
            CalcFormula = Lookup("MOV.CONTAB"."Global Dimension 1 Code" WHERE("G/L Account No."=FIELD("G/L Account No."), "Posting Date"=FIELD("Posting Date"), "Document No."=FIELD("Document No."), Amount=FIELD(Amount), "Global Dimension 2 Code"=FIELD("Job No."), Description=FIELD(Description)));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(52011; "Job Name"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Name';
            FieldClass = FlowField;
        }
        field(52012; "Global Dimension 3 Code"; Code[20])
        {
            CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Set ID"=FIELD("Dimension Set ID"), "Dimension Code"=FILTER('PROYECTO')));
            Caption = 'Global Dimension 3 Code';
            FieldClass = FlowField;
        }
        field(52013; "Global Dimension 3 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Name" WHERE("Dimension Set ID"=FIELD("Dimension Set ID"), "Dimension Code"=FILTER('PROYECTO')));
            Caption = 'Global Dimension 3 Name ';
            Enabled = false;
            FieldClass = FlowField;
        }
        field(52100; "Job Type"; Option)
        {
            CalcFormula = Lookup(Job."Job Type AT" WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Type';
            Description = '-025';
            FieldClass = FlowField;
            OptionCaption = ',Internal,"One Off",Periodical,Salon,Seminar';
            OptionMembers = , Internal, "One Off", Periodical, Salon, Seminar, Continuado, , , , , , "a revisar";
        }
    }
}
