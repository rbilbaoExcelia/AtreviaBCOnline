page 52032 "Tipo de Origen"
{
    // Excelia - 2021 02 09 - Creo objeto
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Origin Type';
    PageType = List;
    SourceTable = "Tipo de Origen AT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo de Origen"; Rec."Tipo de Origen")
                {
                    ToolTip = 'Tipo de Origen';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
