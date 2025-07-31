page 52001 "Account Grouping List"
{
    // 012 OS.MIR  30708/2016  FIN.011   Informe Previsión Rentas Netas Agr. AC
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Account Grouping List';
    PageType = List;
    SourceTable = "Account Grouping AT";

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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
