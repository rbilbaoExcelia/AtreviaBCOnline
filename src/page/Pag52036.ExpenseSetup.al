page 52036 "Expense Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Expense Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Surcharge %"; Rec."Surcharge %")
                {
                    ToolTip = 'Surcharge %';
                    ApplicationArea = All;
                }
                field("Expenses ESP Text"; Rec."Expenses ESP Text")
                {
                    ToolTip = 'Expenses ESP Text';
                    ApplicationArea = All;
                }
                field("Surcharge ESP Text"; Rec."Surcharge ESP Text")
                {
                    ToolTip = 'Surcharge ESP Text';
                    ApplicationArea = All;
                }
                field("Expenses PTG Text"; Rec."Expenses PTG Text")
                {
                    ToolTip = 'Expenses PTG Text';
                    ApplicationArea = All;
                }
                field("Surcharge PTG Text"; Rec."Surcharge PTG Text")
                {
                    ToolTip = 'Surcharge PTG Text';
                    ApplicationArea = All;
                }
                field("Expenses ENU Text"; Rec."Expenses ENU Text")
                {
                    ToolTip = 'Expenses ENU Text';
                    ApplicationArea = All;
                }
                field("Surcharge ENU Text"; Rec."Surcharge ENU Text")
                {
                    ToolTip = 'Surcharge ENU Text';
                    ApplicationArea = All;
                }
                field("Expenses CAT Text"; Rec."Expenses CAT Text")
                {
                    ToolTip = 'Expenses CAT Text';
                    ApplicationArea = All;
                }
                field("Surcharge CAT Text"; Rec."Surcharge CAT Text")
                {
                    ToolTip = 'Surcharge CAT Text';
                    ApplicationArea = All;
                }
                field("General Journal MyNet"; Rec."General Journal MyNet")
                {
                    ToolTip = 'General Journal MyNet';
                    ApplicationArea = All;
                }
                field("Gen. Journal Section MyNet"; Rec."Gen. Journal Section MyNet")
                {
                    ToolTip = 'Gen. Journal Section MyNet';
                    ApplicationArea = All;
                }
                field("Expense Account No. MyNet"; Rec."Expense Account No. MyNet")
                {
                    ToolTip = 'Expense Account No. MyNet';
                    ApplicationArea = All;
                }
                field("Generic task Jobs"; Rec."Generic task Jobs")
                {
                    ToolTip = 'Generic task Jobs';
                    ApplicationArea = All;
                }
                field("Generic task description"; Rec."Generic task description")
                {
                    ToolTip = 'Generic task description';
                    ApplicationArea = All;
                }
                field("Generic task identation"; Rec."Generic task identation")
                {
                    ToolTip = 'Generic task identation';
                    ApplicationArea = All;
                }
                field("Offsetting Account No. MyNet"; Rec."Offsetting Account No. MyNet")
                {
                    ToolTip = 'Offsetting Account No. MyNet';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
}
