page 52030 "Subsector List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = Subsector;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod Subsector"; Rec."Cod Subsector")
                {
                    ToolTip = 'Cod Subsector';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
