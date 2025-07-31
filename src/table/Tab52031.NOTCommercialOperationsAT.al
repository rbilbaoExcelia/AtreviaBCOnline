table 52031 "NOT Commercial Operations AT"
{
    // 
    // CONS-LOG DE CAMBIOS
    // CONS.001 OS.AC 020708
    //          Procedimiento de operaciones tipo, para simplificar su contabilización e implementarlo en procedimiento de consolidaci�n
    //          (eliminaciones)
    // CONS.002 OS.AC 101209
    //          Funcionalidad de "Operación tipo especial"
    // CONS.003 OS.AC 300310
    //          Al modificar la operación tipo tras el registro, no hará cambios adicionales.
    // CONS.004 OS.AC 280510
    //          Añadimos el código de operación tipo especial
    // CONS.005 OS.AC 111011
    //          No pemitimos hacer movimientos en filiales (para que no se descuadre vs. el balance normal)
    // 010 OS.MIR/SPG  20/06/2016  FIN.009   Funcionalidad filiales
    Caption = 'NOT Commercial Operations';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            Editable = false;
            SQLDataType = Integer;
        }
        field(2; "NCO Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'NCO Code';
            TableRelation = "Reason Code" WHERE("Not Commercial Operation AT"=CONST(true));

            trigger OnValidate()
            begin
                IF Posted THEN //CONS.099
 EXIT;
                ReasonCode.GET("NCO Code");
                Description:=ReasonCode.Description;
                "Special NCO":=ReasonCode."Special NCO AT"; //CONS.002
                IF ReasonCode."Special NCO AT" THEN BEGIN //CONS.003
                    ReasonCode.TESTFIELD(ReasonCode."Balance NCO AT"); //CONS.003
                    "NCO Special Code":=ReasonCode."Balance NCO AT"; //CONS.003
                END
                ELSE //CONS.003
                    "NCO Special Code":=''; //CONS.003
            end;
        }
        field(3; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(5; "Account No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Account No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                GLAccount.GET("Account No.");
                IF NOT GLAccount."Not Commercial Operations AT" THEN ERROR(Text0002, "Account No.");
            end;
        }
        field(6; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(7; "Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount (LCY)';
        }
        field(8; "Balance Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Balance Account No.';
            TableRelation = IF("Bal. Account Type"=FILTER("G/L Account"))"G/L Account"
            ELSE IF("Bal. Account Type"=FILTER(Bank))"Bank Account";

            trigger OnValidate()
            begin
                IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN BEGIN
                    GLAccount.GET("Balance Account No.");
                    IF "Special NCO" THEN BEGIN
                        IF NOT GLAccount."Not Commercial Operations AT" THEN ERROR(Text0003, "Balance Account No.");
                    END
                    ELSE IF GLAccount."Not Commercial Operations AT" THEN ERROR(Text0004, "Balance Account No.");
                END
                ELSE IF "Special NCO" THEN ERROR(Text0005);
            end;
        }
        field(9; Correction; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Correction';
        }
        field(10; "Bal. Account Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank';
            OptionMembers = "G/L Account", Bank;

            trigger OnValidate()
            begin
                "Source No.":='';
            end;
        }
        field(20; "Source Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ", Customer, Vendor;
        }
        field(21; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';
            TableRelation = IF("Source Type"=CONST(Customer))Customer
            ELSE IF("Source Type"=CONST(Vendor))Vendor;
        }
        field(22; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted';
            Editable = false;
        }
        field(30; "Dim 1"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,1';
            Caption = 'Dim 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(31; "Dim 2"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,2';
            Caption = 'Dim 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(32; "GL Transaction No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'GL Transaction No.';
        }
        field(33; "Special NCO"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Special NCO';
            Editable = false;
        }
        field(34; "NCO Special Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'NCO special code';
            TableRelation = "Reason Code" WHERE("Not Commercial Operation AT"=CONST(true));
        }
        field(35; "Source Company No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Company No.';
            TableRelation = Company;
        }
        field(100; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'N� proyecto';
            TableRelation = Job;
        }
        field(101; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'N° tarea';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No."=FIELD("Job No."));
        }
        field(102; "G/L Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Document No.';
        }
    }
    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        xOPTTipo.Reset();
        IF xOPTTipo.ISEMPTY THEN "Document No.":='1'
        ELSE
        BEGIN
            xOPTTipo.FindLast();
            "Document No.":=INCSTR(xOPTTipo."Document No.");
        END;
    end;
    var ReasonCode: Record 231;
    xOPTTipo: Record "NOT Commercial Operations AT";
    GLAccount: Record "G/L Account";
    Posted: Boolean;
    Text0002: Label 'Account %1 should be setup as NCO';
    Text0003: Label 'Account %1 should be setup as NCO, because is a SPECIAL operation';
    Text0004: Label 'Account %1 should NOT be setup as NCO';
    Text0005: Label 'On Special operations, Balance account should be a G/L Account';
}
