page 52003 "BIC Codes"
{
    PageType = List;
    SourceTable = "BIC Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(NRBE; Rec.NRBE)
                {
                    ToolTip = 'NRBE';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field("BIC 11"; Rec."BIC 11")
                {
                    ToolTip = 'BIC 11';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
