page 52031 "Tipo de empresa list"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Tipo de empresa";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("tipo empresa"; Rec."tipo empresa")
                {
                    ToolTip = 'tipo empresa';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
