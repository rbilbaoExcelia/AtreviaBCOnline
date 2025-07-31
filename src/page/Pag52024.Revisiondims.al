page 52024 "Revision dims"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = 169;

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
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Job No.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Posting Date';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Global Dimension 2 Code';
                    ApplicationArea = All;
                }
                field("Job Dimension 1"; Rec."Job Dimension 1")
                {
                    ToolTip = 'Job Dimension 1';
                    ApplicationArea = All;
                }
                field("Job Dimension 2"; Rec."Job Dimension 2")
                {
                    ToolTip = 'Job Dimension 2';
                    ApplicationArea = All;
                }
                field("Old Dimension Value"; Rec."Old Dimension Value")
                {
                    ToolTip = 'Old Dimension Value';
                    ApplicationArea = All;
                }
                field(Marcat; Marcat)
                {
                    ToolTip = 'Marcat';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Marcat:=FALSE;
        IF(Rec."Job Dimension 1" <> Rec."Global Dimension 1 Code") OR (Rec."Job Dimension 2" <> Rec."Global Dimension 2 Code")THEN BEGIN
            Marcat:=TRUE;
            Rec.Next();
        END;
    end;
    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Posting Date", '>%1', 20170501D);
    end;
    var JobLedgerEntry: Record 169;
    Marcat: Boolean;
}
