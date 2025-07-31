page 52021 "Origen"
{
    Caption = 'Origin';
    PageType = List;
    SourceTable = "Origen AT";
    ApplicationArea = ALL;
    UsageCategory = Administration;

    // Excelia - 2021 02 09 - Creo objeto
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Origen; Rec.Origen)
                {
                    ToolTip = 'Origen';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
