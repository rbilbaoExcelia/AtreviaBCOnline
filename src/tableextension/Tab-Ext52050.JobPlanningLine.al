tableextension 52050 "JobPlanningLine" extends "Job Planning Line"
{
    fields
    {
        modify("Line Type")
        {
        trigger OnAfterValidate()
        var
            Job: Record Job;
        begin
            //055                
            Job.GET("Job No.");
            IF("Line Type" = Rec."Line Type"::"Both Budget and Billable") OR ("Line Type" = Rec."Line Type"::Billable)THEN IF(Job."Expenses Surcharge % AT" <> 0) AND (Rec.Type = Rec.Type::"G/L Account") //090517 //solo recargo a las líneas cta (solo gastos)
                THEN BEGIN
                    IF GLAcc.GET(Rec."No.")THEN BEGIN
                        IF GLAcc."Expenses Billable AT" THEN VALIDATE("Line Discount %", -Job."Expenses Surcharge % AT")
                        ELSE
                            VALIDATE("Line Discount %", 0);
                    END;
                END
                ELSE
                    VALIDATE("Line Discount %", 0);
        //055
        end;
        }
        field(52000; "SQL Synchronized AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
            Description = '-025';
        }
        field(52002; "Line Type 2 AT"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Type';
            Description = '-011';
            OptionCaption = ' ,Expense';
            OptionMembers = " ", Expense;
        }
        field(52003; "Billing Company AT"; Text[30])
        {
            Caption = 'Billing Company';
            FieldClass = FlowField;
            CalcFormula = Lookup(Job."Billing Company AT" WHERE("No."=FIELD("Job No.")));
            Description = '-025';
        }
        field(52005; "Sale Document No. AT"; Code[20])
        {
            Caption = 'Sale Document No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Planning Line Invoice"."Document No." WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Job Task No."), "Job Planning Line No."=FIELD("Line No."), "Document Type"=FILTER("Posted Invoice")));
            Description = '-025';
            Editable = false;
        }
        field(52006; "CrMemo Document No. AT"; Code[20])
        {
            Caption = 'Cr. Memo Document No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Job Planning Line Invoice"."Document No." WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Job Task No."), "Job Planning Line No."=FIELD("Line No."), "Document Type"=FILTER("Posted Credit Memo")));
            Description = '-025';
            Editable = false;
        }
        field(52010; "External Job Document No. AT"; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'External Job Document No.';
            Description = '-027';
        }
        field(52100; "Billable AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Billable';
            Description = '-001';
        }
        field(52105; "Mandatory Purch. Order AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mandatory Purch. Order';
            Description = '-025';
        }
        field(52106; "Customer No. AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(52107; "Job Assistant AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Asistente';
        }
        field(52108; "ToCredit AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'To Credit';
        }
        field(52109; "Customer Name AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
            Editable = false;
            TableRelation = Customer.Name WHERE("No."=FIELD("Customer No. AT"));
        }
        field(52110; "Job Customer Line No. AT"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Customer Line No.';
            Description = '-029';

            trigger OnValidate()
            begin
            //029,030
            end;
        }
        field(52111; "Confirmed AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed';
            Description = '-055';
        }
        field(52112; "Job Cntr. Entry No. to Cred AT"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Contract Entry No.';
            Description = 'Job Contract Entry No. to Cred';
            Editable = false;
        }
    }
    keys
    {
        key(Key14; "SQL Synchronized AT")
        {
        }
    }
    trigger OnAfterDelete()
    begin
    //053
    //No es posible en cloud
    //ManageJobConceptsDescriptions.DeleteJobConceptsDescriptions(Rec);
    //053
    end;
    //Unsupported feature: Code Modification on "ValidateModification(PROCEDURE 21)".
    //procedure ValidateModification();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if FieldChanged then begin
      CalcFields("Qty. Transferred to Invoice");
      TestField("Qty. Transferred to Invoice",0);
    end;

    OnAfterValidateModification(Rec,FieldChanged);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    CALCFIELDS("Qty. Transferred to Invoice");
    //TESTFIELD("Qty. Transferred to Invoice",0); //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    */
    //end;
    var GLAcc: Record "G/L Account";
//ManageJobConceptsDescriptions: Codeunit "SQL Integration";
}
