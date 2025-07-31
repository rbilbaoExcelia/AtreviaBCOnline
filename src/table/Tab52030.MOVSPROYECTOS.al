table 52030 "MOVS PROYECTOS"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Direct Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Unit of Measure Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; "External Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Remaining Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; Open; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(17; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource, Item, "G/L Account";
        }
        field(18; TxtQuantity; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(19; TxtDirectCost; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(20; TxtUnitCost; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(21; TxtUnitPrice; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(22; TxtRemAmount; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(23; Dim1; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(24; Dim2; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(25; TotalCost; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(26; TotalPrice; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(27; TxtTotalCost; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(28; TxtTotalPrice; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Usage,Sale';
            OptionMembers = Consumo, Sale;
        }
        field(52000; Cost; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(52001; "Dif Vtas"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(52002; "No.mov JobLedgEntry"; Integer)
        {
            CalcFormula = Lookup("Job Ledger Entry"."Entry No." WHERE("Job No."=FIELD("Job No."), "Posting Date"=FIELD("Posting Date"), "Document No."=FIELD("Document No."), Type=FIELD(Type), "No."=FIELD("No."), Description=FIELD(Description), Quantity=FIELD(Quantity)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {
        }
        key(Key3; "Job No.")
        {
        }
    }
    fieldgroups
    {
    }
    procedure GetDifAmount(): Decimal var
        Valor: Decimal;
    begin
        EXIT((TotalPrice / Quantity) - "Unit Price");
    end;
}
