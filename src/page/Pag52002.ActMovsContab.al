page 52002 "Act Movs Contab"
{
    PageType = List;
    Permissions = TableData 17=rimd;
    SourceTable = 17;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Entry No.';
                    ApplicationArea = All;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'G/L Account No.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Posting Date';
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
