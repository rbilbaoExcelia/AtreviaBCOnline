page 52004 "Business Office ATs"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Business Office AT";

    // 011 OS.MIR  16/06/2016  FIN.010   Gastos de caja
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Code';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Name';
                    ApplicationArea = All;
                }
                field("No. Entries Ranking"; Rec."No. Entries Ranking")
                {
                    ToolTip = 'No. Entries Ranking';
                    ApplicationArea = All;
                }
                field("Excel Column"; Rec."Excel Column")
                {
                    ToolTip = 'Excel Column';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Shortcut Dimension 1 Code';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
