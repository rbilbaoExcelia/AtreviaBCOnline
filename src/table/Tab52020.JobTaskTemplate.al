table 52020 "Job Task (Template)"
{
    // FERSA-LOG DE CAMBIOS
    // FERSA.001 OS.CBS 150711
    //           Tabla nueva para plantillas facturas, punto GEN-01 del documento memo-adaptaciones-fersa.
    // 
    // 010 OS.MIR  20/06/2016  FIN.009   Funcionalidad filiales
    Caption = 'Job Task (Template)';
    DataPerCompany = false;

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'N° Línea';
        }
        field(2; "Task Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Código';
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(5; "Job Task Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting, Heading, Total, "Begin-Total", "End-Total";
        }
        field(6; Totaling; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Totaling';
        //This property is currently not supported
        //TestTableRelation = false;
        //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
        //ValidateTableRelation = false;
        }
        field(10; "Schedule (Total Cost LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Planning Line"."Total Cost (LCY)" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Schedule Line"=CONST(true), "Planning Date"=FIELD("Planning Date Filter")));
            Caption = 'Schedule (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Usage (Total Cost LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Ledger Entry"."Total Cost (LCY)" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Entry Type"=CONST(Usage), "Posting Date"=FIELD("Posting Date Filter")));
            Caption = 'Usage (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(20; "Planning Date Filter"; Date)
        {
            Caption = 'Planning Date Filter';
            FieldClass = FlowFilter;
        }
        /* field(62; "Outstanding Orders"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purchase Line".Field7078690 WHERE("Document Type" = CONST(Order),
                                                                  "Job No." = FIELD("Job No."),
                                                                  "Job Task No." = FIELD("Task Code"),
                                                                  "Job Task No." = FIELD(FILTER(Totaling)),
                                                                  "Expected Receipt Date" = FIELD("Posting Date Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purchase Line".Field7078691 WHERE("Document Type" = CONST(Order),
                                                                  "Job No." = FIELD("Job No."),
                                                                  "Job Task No." = FIELD("Task Code"),
                                                                  "Job Task No." = FIELD(FILTER(Totaling)),
                                                                  "Expected Receipt Date" = FIELD("Posting Date Filter")));
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52000; "Job Type"; Code[10])
        {DataClassification= CustomerContent;
            Caption = 'Clasificaci�n tarea';
            TableRelation = "Expenses Setup"."Surcharge %" WHERE("Surcharge %" = FIELD("Job Type"));
        }
        */
        field(52001; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Editable = false;
            FieldClass = FlowFilter;
            TableRelation = Job;
        }
        field(52020; "Outstanding Orders Cons (DL)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Jobs consol. compromised"."Outstanding Amount (LCY) wVAT" WHERE("Document Type"=CONST(Order), "Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Expected Receipt Date"=FIELD("Posting Date Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52021; "Amt. Rcd. Not Invoiced Con (DL"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Jobs consol. compromised"."Amt. Rcd. Not Inv. (LCY) wVAT" WHERE("Document Type"=CONST(Order), "Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Expected Receipt Date"=FIELD("Posting Date Filter")));
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52023; "Schedule (Initial Budget)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Base Budget"."Total Cost (LCY)" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Schedule Line"=CONST(true), "Planning Date"=FIELD("Planning Date Filter")));
            Caption = 'Schedule (Initial Budget)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52050; "Schedule (Total Cost AC)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Planning Line"."Total Cost" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Schedule Line"=CONST(true), "Planning Date"=FIELD("Planning Date Filter")));
            Caption = 'Schedule (Total Cost AC)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52051; "Usage (Total Cost AC)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Ledger Entry"."Total Cost" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Entry Type"=CONST(Usage), "Posting Date"=FIELD("Posting Date Filter")));
            Caption = 'Usage (Total Cost AC)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52052; "Schedule (Initial Budget AC)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Base Budget"."Total Cost" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Schedule Line"=CONST(true), "Planning Date"=FIELD("Planning Date Filter")));
            Caption = 'Schedule (Initial Budget)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52053; "Outstanding Orders Cons (DA)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Jobs consol. compromised"."Outstanding Amount (DA) wVAT" WHERE("Document Type"=CONST(Order), "Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Expected Receipt Date"=FIELD("Posting Date Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52054; "Amt. Rcd. Not Invoiced Con (DA"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Jobs consol. compromised"."Amt. Rcd. Not Inv. (DA) wVAT" WHERE("Document Type"=CONST(Order), "Job No."=FIELD("Job No."), "Job Task No."=FIELD("Task Code"), "Job Task No."=FIELD(FILTER(Totaling)), "Expected Receipt Date"=FIELD("Posting Date Filter")));
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Task Code")
        {
        }
    }
    fieldgroups
    {
    }
}
