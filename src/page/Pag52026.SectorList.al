page 52026 "Sector List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = Sector2;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod Sector"; Rec."Cod Sector")
                {
                    ToolTip = 'Cod Sector';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
