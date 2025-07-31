page 52028 "Sectors and Pmts. Setup"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Sectors and Pmts. Setup';
    PageType = List;
    SourceTable = "Sectors and Payments Setup AT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Sector; Rec.Sector)
                {
                    ToolTip = 'Sector';
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Payment Type';
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'G/L Account';
                    ApplicationArea = All;
                }
                field("Contract G/L Account"; Rec."Contract G/L Account")
                {
                    ToolTip = 'Contract G/L Account';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
