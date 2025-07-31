tableextension 52103 "Vendor" extends Vendor
{
    fields
    {
        modify("No.")
        {
        trigger OnAfterValidate()
        begin
            //<026
            //"Payment Days Code" := "No.";
            "Payment Days Code":='';
        //026>
        end;
        }
        field(52000; "SQL Synchronized AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
            Description = '-025';
        }
        field(52001; "Sector AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector';
            Description = '-025';
            TableRelation = "Sector AT".Code WHERE(Type=CONST("9"));
        }
        field(52002; "Billing Class"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Montly,Bimonthly,Quarterly';
            OptionMembers = " ", Montly, Bimonthly, Quarterly;
        }
        field(52004; IBAN; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor Bank Account".IBAN WHERE("Vendor No."=FIELD("No."), Code=FIELD("Preferred Bank Account Code")));
            Caption = 'IBAN';
            Description = '-123';

            trigger OnValidate()
            var
                CompanyInfo: Record 79;
            begin
            end;
        }
        field(52010; "IRPF Pctg"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = '-024';
        }
        field(52012; "IRPF Codigo"; Code[10])
        {
            DataClassification = CustomerContent;
            Description = '-024';
            TableRelation = "IRPF Atrevia";

            trigger OnValidate()
            begin
                //<024
                IF IRPFAtrevia.GET("IRPF Codigo")THEN "IRPF Pctg":=IRPFAtrevia."IRPF %";
            //024>
            end;
        }
        field(52050; "Codigo IAE"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IAE Code';
            Description = '2728';
            TableRelation = IAE."Codigo IAE";

            trigger OnValidate()
            var
                IAE: Record IAE;
            begin
                //EXC - 2728 - 2021 05 10
                IAE.Reset();
                IAE.SETRANGE(IAE."Codigo IAE", Rec."Codigo IAE");
                IF IAE.FindFirst()then Rec."Sector AT":=IAE.Sector;
            //EXC - 2728 - 2021 05 10 END
            end;
        }
        field(52013; "IRPF %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'IRPF %';
            Description = '-024';
        }
        field(52014; "IRPF Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'IRPF Code';
            Description = '-024';

            //TableRelation = IRPF;
            trigger OnValidate()
            begin
            //<024
            //IF IRPF.GET("IRPF Code") THEN
            //  "IRPF %" := IRPF."IRPF %";
            //024>
            end;
        }
        //3626  -  JX  -  2022 04 20
        field(52015; Homologado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Homologado';
        }
        field(52016; "Fecha Homologacion"; date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha homologacion';
        }
        //3626  -  JX  -  2022 04 20 END
        //3590 - MEP - 2022 03 22
        //luego de seleccionar la cuenta de banco preferida actualizo el iban
        modify("Preferred Bank Account Code")
        {
        trigger OnAfterValidate()
        begin
            rec.CalcFields(IBAN);
        end;
        }
    }
    keys
    {
        key(Key10; "SQL Synchronized AT")
        {
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('No es posible eliminar');
    end;
    trigger OnAfterInsert()
    begin
        //<026
        //"Payment Days Code" := "No.";
        "Payment Days Code":='';
    //026>
    end;
    trigger OnAfterModify()
    var
    begin
        "SQL Synchronized AT":=FALSE; //025
    end;
    var IRPFAtrevia: Record "IRPF Atrevia";
}
