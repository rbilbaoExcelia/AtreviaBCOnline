page 52011 "IAE"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = IAE;

    // EXC - 2728 - 2021 05 10   Creacion de la Page IAE con los campos Codigo IAE, Descripcion y Sector
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo IAE"; Rec."Codigo IAE")
                {
                    ToolTip = 'Codigo IAE';
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Descripcion';
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field(Sector; Rec.Sector)
                {
                    ToolTip = 'Sector';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
