page 52010 "Hours consulting AT"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Hours consulting AT';
    Editable = false;
    PageType = List;
    SourceTable = "Hours consulting AT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. consultor"; Rec."No. consultor")
                {
                    ToolTip = 'No. consultor';
                    ApplicationArea = All;
                }
                field("No. proyecto"; Rec."No. proyecto")
                {
                    ToolTip = 'No. proyecto';
                    ApplicationArea = All;
                }
                field(Fecha; Rec.Fecha)
                {
                    ToolTip = 'Fecha';
                    ApplicationArea = All;
                }
                field(Horas; Rec.Horas)
                {
                    ToolTip = 'Horas';
                    ApplicationArea = All;
                }
                field("Tipo error"; Rec."Tipo error")
                {
                    ToolTip = 'Tipo error';
                    ApplicationArea = All;
                }
                field(Registrado; Rec.Registrado)
                {
                    ToolTip = 'Registrado';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                ToolTip = 'Post';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Post Consulting Hours";
            }
        }
    }
}
