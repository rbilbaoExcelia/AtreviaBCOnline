page 52019 "MAPEO DIMENSIONES"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "MAPEO DIM to 2 DIM";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Code Orig"; Rec."Dimension Code Orig")
                {
                    ToolTip = 'Dimension Code Orig';
                    ApplicationArea = All;
                }
                field("Code Orig"; Rec."Code Orig")
                {
                    ToolTip = 'Code Orig';
                    ApplicationArea = All;
                }
                field("Dim Code 1"; Rec."Dim Code 1")
                {
                    ToolTip = 'Dim Code 1';
                    ApplicationArea = All;
                }
                field("Dim Code 2"; Rec."Dim Code 2")
                {
                    ToolTip = 'Dim Code 2';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
