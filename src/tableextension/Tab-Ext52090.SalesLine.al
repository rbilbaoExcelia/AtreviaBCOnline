tableextension 52090 "SalesLine" extends "Sales Line"
{
    fields
    {
        //3616 - ED
        modify("Job No.")
        {
        trigger OnAfterValidate()
        var
            DimMgt: Codeunit DimensionManagement;
            JobTask: Record "Job Task";
            // SAR  -  2024 19 01
            DefaultDimSource: List of[Dictionary of[Integer, Code[20]]];
        // SAR  -  2024 19 01 END
        begin
            JobTask.Reset();
            JobTask.SetRange("Job No.", Rec."Job No.");
            JobTask.SetRange("Job Task No.", Rec."Job No.");
            if JobTask.FindFirst()then Rec.Validate("Job Task No.", "Job No.")
            else
                Clear(Rec."Job Task No.");
            // SAR  -  2024 19 01  -  Correcion de campo
            /*
                CreateDim(
                    DimMgt.TypeToTableID3(Rec.Type), "No.",
                    DimMgt.SalesLineTypeToTableID(Rec.Type), "No.",

                        DATABASE::Job, "Job No.",
                        DATABASE::"Responsibility Center", "Responsibility Center");
                */
            InitDefaultDimensionSources(DefaultDimSource, Rec.FieldNo("Job Contract Entry No."));
            CreateDim(DefaultDimSource);
        // SAR  -  2024 19 01  -  Correcion de campo END
        end;
        }
        //3616 - ED END
        field(52000; "Concept Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Concept Line No';
            Description = '-030';
            Editable = false;
        }
        field(52001; "Attendant Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Attendant Line No.';
            Description = '-030';
            Editable = false;
        }
        field(52002; "Line Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Type';
            Description = '-011';
            OptionCaption = ' ,Expense';
            OptionMembers = " ", Expense;
        }
        field(52003; "Expense Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expense Date';
            Description = '-011';
        }
        field(52004; "Text Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Text Line No.';
            Description = '-030';
            Editable = false;
        }
        field(52107; "Job Assistant"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Asistente';
            Description = '-030';
        }
        field(52108; "Cust Order Purch No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cust Order Purch No.';
            Description = '-080';
        }
    }
    procedure GetTotalAmount(): Decimal begin
        EXIT(TotalAmountForTax);
    end;
    var TotalAmountForTax: Decimal;
}
