tableextension 52066 "PurchaseHeader" extends "Purchase Header"
{
    fields
    {
        field(52000; "Job Description AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Description';
            Description = '-025';
        }
        field(52001; "Action Amount AT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            Caption = 'Action Amount';
            Description = '-025';
        }
        field(52002; "Web Description AT"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Web Description';
            Description = '-025';
        }
        field(52003; "CalculatedAmt AT"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Line Amount" WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.")));
            Caption = 'CalculatedAmt';
            Description = '-025';
            FieldClass = FlowField;
        }
        field(52005; "Job No. AT"; Code[20])
        {
            CalcFormula = Lookup("Purchase Line"."Job No." WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No."), "Job No."=FILTER(<>'')));
            Caption = 'Job No.';
            FieldClass = FlowField;
        }
        field(52006; "Job Name AT"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No. AT")));
            Caption = 'Job Name';
            FieldClass = FlowField;
        }
        field(52007; "Business Office Code AT"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Business Office AT";
        }
        field(52008; "Sector AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector';
            TableRelation = "Sector AT".Code WHERE(Type=CONST("9"));
        }
        field(52010; "Approves expenditure AT"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        //This property is currently not supported
        //TestTableRelation = false;
        }
        field(52014; "Facturas de Gastos"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'EX-OMI 231019';
        }
        field(52015; "Saltar Mensaje Final"; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = false;
            Description = 'For 100817 EX-JVN';
        }
        field(52060; "precio venta proyecto"; Decimal)
        {
            CalcFormula = Lookup("Purchase Line"."Job Unit Price" WHERE("Document No."=FIELD("No.")));
            FieldClass = FlowField;
        }
    }
//var
//lNoSeries: Record 308;
//Text1100002: Label 'The %1 does not exist. \Identification fields and values:\%1 = %2';
//Err001: Label 'La fecha de contabilización no puede ser posterior a la actual.';
//Err002: Label 'La fecha de contabilización es anterior al margen de días permitidos para la presentación a Hacienda.';
}
