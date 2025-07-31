page 52009 "Customer Groups"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Customer Group';
    PageType = List;
    SourceTable = "Customer group";

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
