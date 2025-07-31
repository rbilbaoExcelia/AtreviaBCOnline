page 52027 "Sectors"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Sectors';
    PageType = List;
    SourceTable = "Sector AT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    ApplicationArea = All;
                }
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
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Blocked';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SETFILTER(Type, '2');
    end;
}
