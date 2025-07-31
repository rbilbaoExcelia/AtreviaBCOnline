page 52012 "Importar diarios periodicos"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ToolTip = 'Journal Template Name';
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ToolTip = 'Journal Batch Name';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Line No.';
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Account Type';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Account No.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Posting Date';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Document No.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ToolTip = 'Debit Amount';
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ToolTip = 'Credit Amount';
                    ApplicationArea = All;
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    ToolTip = 'Bill-to/Pay-to No.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Shortcut Dimension 1 Code';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Shortcut Dimension 2 Code';
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Job No.';
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Source Code';
                    ApplicationArea = All;
                }
                field("Recurring Method"; Rec."Recurring Method")
                {
                    ToolTip = 'Recurring Method';
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Expiration Date';
                    ApplicationArea = All;
                }
                field("Recurring Frequency"; Rec."Recurring Frequency")
                {
                    ToolTip = 'Recurring Frequency';
                    ApplicationArea = All;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ToolTip = 'Posting No. Series';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
