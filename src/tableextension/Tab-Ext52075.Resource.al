tableextension 52075 "Resource" extends Resource
{
    fields
    {
        field(52000; "Business Office Code AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Office Code';
            Description = '-011';
            Editable = false;
        }
        field(52001; "Incorporation Date AT"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Incorporation Date';
            Description = '-025';
        }
        field(52002; "Leaving Date AT"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Leaving Date';
            Description = '-025';
        }
        field(52003; "E-Mail AT"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            Description = '-025';
        }
        field(52004; "Without Time Control AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Without Time Control';
            Description = '-025';
        }
        field(52005; "Birth Date AT"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Birth Date';
            Description = '-025';
        }
        field(52006; "English AT"; Option)
        {
            DataClassification = CustomerContent;
            BlankZero = false;
            Caption = 'English';
            Description = '-025';
            NotBlank = false;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ", Low, Mediun, High;
        }
        field(52007; "French AT"; Option)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'French';
            Description = '-025';
            NotBlank = false;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ", Low, Medium, High;
        }
        field(52008; "Portuguese AT"; Option)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Portuguese';
            Description = '-025';
            NotBlank = false;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ", Low, Medium, High;
        }
        field(52009; "Catalan AT"; Option)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Catalan';
            Description = '-025';
            NotBlank = false;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ", Low, Medium, High;
        }
        field(52010; "Spanish AT"; Option)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Spanish';
            Description = '-025';
            NotBlank = false;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ", Low, Medium, High;
        }
        field(52011; "Director/Supervisor AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Director/Supervisor';
            Description = '-025';
        }
        field(52012; "Holidays AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Holidays';
            Description = '-025';
        }
        field(52013; "Remaining Days AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Days';
            Description = '-025';
        }
        field(52014; "Accumulated Days AT"; Decimal)
        {
            CalcFormula = Sum("Hours consulting AT".Horas WHERE("No. consultor"=FIELD("No."), "No. proyecto"=FILTER(000000000), Fecha=FIELD("Date Filter")));
            Caption = 'Accumulated Days';
            Description = '-025';
            FieldClass = FlowField;
        }
        field(52015; "Extra Days AT"; Decimal)
        {
            CalcFormula = Sum("Hours consulting AT".Horas WHERE("No. consultor"=FIELD("No."), "No. proyecto"=FILTER(000000028), Fecha=FIELD("Date Filter")));
            Caption = 'Extra Days';
            Description = '-025';
            FieldClass = FlowField;
        }
        field(52016; "Other Days AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Days';
            Description = '-025';
        }
        field(52017; "Old Dimension 1 Code AT"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(52018; "Old Dimension 2 Code AT"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(52080; "Fecha alta texto AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha alta texto';
        }
        field(52081; "Fecha baja texto AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha baja texto';
        }
    }
}
