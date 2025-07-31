pageextension 52063 "ResourceCard" extends "Resource Card"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("E-Mail"; Rec."E-Mail AT")
            {
                ToolTip = 'E-Mail';
                ApplicationArea = All;
            }
            field(Holidays; Rec."Holidays AT")
            {
                ToolTip = 'Holidays';
                ApplicationArea = All;
            }
            field("Remaining Days"; Rec."Remaining Days AT")
            {
                ToolTip = 'Remaining Days';
                ApplicationArea = All;
            }
            field("Extra Days"; Rec."Extra Days AT")
            {
                ToolTip = 'Extra Days';
                ApplicationArea = All;
            }
            field("Accumulated Days"; Rec."Accumulated Days AT")
            {
                ToolTip = 'Accumulated Days';
                ApplicationArea = All;
            }
            field("Other Days"; Rec."Other Days AT")
            {
                ToolTip = 'Other Days';
                ApplicationArea = All;
            }
        }
        addafter("Resource Group No.")
        {
            field("Business Office Code AT"; Rec."Business Office Code AT")
            {
                ToolTip = 'Business Office Code AT';
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
            field("Director/Supervisor"; Rec."Director/Supervisor AT")
            {
                ToolTip = 'Director/Supervisor';
                ApplicationArea = All;
            }
        }
        addafter("Automatic Ext. Texts")
        {
            field("Without Time Control"; Rec."Without Time Control AT")
            {
                ToolTip = 'Without Time Control';
                ApplicationArea = All;
            }
        }
        moveafter("Without Time Control"; "IC Partner Purch. G/L Acc. No.")
        moveafter(City; County)
        addafter("Employment Date")
        {
            field("Incorporation Date"; Rec."Incorporation Date AT")
            {
                ToolTip = 'Incorporation Date';
                ApplicationArea = All;
            }
            field("Leaving Date"; Rec."Leaving Date AT")
            {
                ToolTip = 'Leaving Date';
                ApplicationArea = All;
            }
            field("Birth Date"; Rec."Birth Date AT")
            {
                ToolTip = 'Birth Date';
                ApplicationArea = All;
            }
            field(English; Rec."English AT")
            {
                ToolTip = 'English';
                ApplicationArea = All;
            }
            field(French; Rec."French AT")
            {
                ToolTip = 'French';
                ApplicationArea = All;
            }
            field(Portuguese; Rec."Portuguese AT")
            {
                ToolTip = 'Portuguese';
                ApplicationArea = All;
            }
            field(Catalan; Rec."Catalan AT")
            {
                ToolTip = 'Catalan';
                ApplicationArea = All;
            }
            field(Spanish; Rec."Spanish AT")
            {
                ToolTip = 'Spanish';
                ApplicationArea = All;
            }
        }
    }
}
