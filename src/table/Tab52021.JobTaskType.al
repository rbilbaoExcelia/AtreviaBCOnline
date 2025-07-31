table 52021 "Job Task (Type)"
{
    // FERSA-LOG DE CAMBIOS
    // FERSA.001 OS.CBS 150711
    //           Tabla nueva para plantillas facturas, punto GEN-01 del documento memo-adaptaciones-fersa.
    // 
    // 010 OS.MIR  20/06/2016  FIN.009   Funcionalidad filiales
    Caption = 'Job Task (Type)';
    DataPerCompany = false;

    fields
    {
        field(1; "Task type Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cód. Tipo Tarea';
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Activable; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activable';
        }
        field(4; "A/F grupo contable"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'A/F grupo contable';
            TableRelation = "FA Posting Group".Code WHERE(Code=FIELD("A/F grupo contable"));
        }
        field(5; "WIP Account No."; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'WIP Account No.';
            TableRelation = "G/L Account";
        }
        field(9; "Depreciation Book Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Depreciation Book Code';
            NotBlank = false;
            TableRelation = "Depreciation Book";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(10; "Depreciation Method"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Depreciation Method';
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line", "Declining-Balance 1", "Declining-Balance 2", "DB1/SL", "DB2/SL", "User-Defined", Manual;
        }
        field(12; "No. of Depreciation Years"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'No. of Depreciation Years';
            DecimalPlaces = 2: 8;
            MinValue = 0;

            trigger OnValidate()
            var
                DeprBook2: Record 5611;
            begin
                IF NOT rec5611.GET("Depreciation Book Code")THEN ERROR(text0007);
                rec5611.TESTFIELD("Fiscal Year 365 Days", FALSE);
            end;
        }
        field(14; "Straight-Line %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Straight-Line %';
            DecimalPlaces = 2: 8;
            MinValue = 0;
        }
        field(15; "Fixed Depr. Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Fixed Depr. Amount';
            MinValue = 0;
        }
        field(16; "Add To Aero"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Add To Aero';
        }
    }
    keys
    {
        key(Key1; "Task type Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var rec5611: Record 5611;
    rec5612: Record 5612;
    FADateCalc: Codeunit 5617;
    DepreciationCalc: Codeunit 5616;
    text0006: Label '%1 is later than %2.';
    text0007: Label 'Debe introducir un libro de amortizaci�n.';
    text0009: Label 'No puede ser %1.';
}
