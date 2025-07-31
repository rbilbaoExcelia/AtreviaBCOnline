page 52018 "MAPEO DIM DEPT s/PROYECTO"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    Permissions = TableData "MAPEO PROY TO DIMS"=rimd;
    SourceTable = "MAPEO PROY TO DIMS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Num proy"; Rec."Num proy")
                {
                    ToolTip = 'Num proy';
                    ApplicationArea = All;
                }
                field(Dim1; Rec.Dim1)
                {
                    ToolTip = 'Dim1';
                    ApplicationArea = All;
                }
                field(dim2; Rec.dim2)
                {
                    ToolTip = 'dim2';
                    ApplicationArea = All;
                }
                field(Nombre; Rec.Nombre)
                {
                    ToolTip = 'Nombre';
                    ApplicationArea = All;
                    Caption = 'Nombre Proy';
                }
            }
        }
    }
    actions
    {
    }
}
