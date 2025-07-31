pageextension 52036 "JobsSetup" extends "Jobs Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group(Expenses)
            {
                Caption = 'Expenses';

                field("Expenses Series No."; Rec."Expenses Series No. AT")
                {
                    ToolTip = 'Expenses Series No.';
                    ApplicationArea = All;
                }
                field("Expenses Source Code"; Rec."Expenses Source Code AT")
                {
                    ToolTip = 'Expenses Source Code';
                    ApplicationArea = All;
                }
                field("Increase by Expenses"; Rec."Increase by Expenses AT")
                {
                    ToolTip = 'Increase by Expenses';
                    ApplicationArea = All;
                }
            }
            group(Billing)
            {
                Caption = 'Billing';

                field("Word Path"; Rec."Word Path AT")
                {
                    ToolTip = 'Word Path';
                    ApplicationArea = All;
                }
                field("CPI %"; Rec."CPI % AT")
                {
                    ToolTip = 'CPI %';
                    ApplicationArea = All;
                }
                field("CPI Text"; Rec."CPI Text AT")
                {
                    ToolTip = 'CPI Text';
                    ApplicationArea = All;
                }
                field("Sector Text 1"; Rec."Sector Text 1 AT")
                {
                    ToolTip = 'Sector Text 1';
                    ApplicationArea = All;
                }
                field("Sector Text 2"; Rec."Sector Text 2 AT")
                {
                    ToolTip = 'Sector Text 2';
                    ApplicationArea = All;
                }
                field("Sector Text 3"; Rec."Sector Text 3 AT")
                {
                    ToolTip = 'Sector Text 3';
                    ApplicationArea = All;
                }
            }
            group(Reports)
            {
                Caption = 'Reports';

                field("G/L Accounts Rep. Filter"; Rec."G/L Accounts Rep. Filter AT")
                {
                    ToolTip = 'G/L Accounts Rep. Filter';
                    ApplicationArea = All;
                }
                field("G/L Acct. Dept. Rep. Filter"; Rec."G/L Acct. Dept. Rep. Filter AT")
                {
                    ToolTip = 'G/L Acct. Dept. Rep. Filter';
                    ApplicationArea = All;
                }
            }
            group(SQL)
            {
                Caption = 'SQL';

                field("SQL User"; Rec."SQL User AT")
                {
                    ToolTip = 'SQL User';
                    ApplicationArea = All;
                }
                field("SQL Password"; Rec."SQL Password AT")
                {
                    ToolTip = 'SQL Password';
                    ApplicationArea = All;
                }
                field("SQL IP"; Rec."SQL IP AT")
                {
                    ToolTip = 'SQL IP';
                    ApplicationArea = All;
                }
                field("SQL Database"; Rec."SQL Database AT")
                {
                    ToolTip = 'SQL Database';
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group AT")
                {
                    ToolTip = 'Gen. Prod. Posting Group';
                    ApplicationArea = All;
                }
                field("Job Posting Group"; Rec."Job Posting Group AT")
                {
                    ToolTip = 'Job Posting Group';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure AT")
                {
                    ToolTip = 'Unit of Measure';
                    ApplicationArea = All;
                }
            }
        }
    }
}
