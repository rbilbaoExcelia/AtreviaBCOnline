pageextension 52024 "GeneralJournal" extends "General Journal"
{
    layout
    {
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ToolTip = 'Line No.';
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Campaign No.")
        {
            field("Currency Factor"; Rec."Currency Factor")
            {
                ToolTip = 'Currency Factor';
                ApplicationArea = All;
            }
        }
        moveafter(Amount; "Amount (LCY)")
        addafter("VAT Amount")
        {
            field("Job Quantity"; Rec."Job Quantity")
            {
                ToolTip = 'Job Quantity';
                ApplicationArea = All;
                Visible = true;
            }
            field("Job No."; Rec."Job No.")
            {
                ToolTip = 'Job No.';
                ApplicationArea = All;
                Visible = true;
            }
            field("Job Name"; Rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
            }
            //EX-RBF 310725 Inicio
            field("Source No."; rec."Source No.") { ApplicationArea = all; }
            field("Source Type"; rec."Source Type") { ApplicationArea = all; }
            //EX-RBF 310725 Fin
        }
        /* addafter(ShortcutDimCode7)
         {
            field(ShortcutDimCode[3];ShortcutDimCode[3])
            {
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                                                            "Dimension Value Type"=CONST(Standard),
                                                            Blocked=CONST(false));
                Visible = false;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                end;
            }
            field(ShortcutDimCode[4];ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(4),
                                                            "Dimension Value Type"=CONST(Standard),
                                                            Blocked=CONST(false));
                Visible = false;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                end;
            }
            field(ShortcutDimCode[5];ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(5),
                                                            "Dimension Value Type"=CONST(Standard),
                                                            Blocked=CONST(false));
                Visible = false;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(5,ShortcutDimCode[5]);
                end;
            }
            field(ShortcutDimCode[6];ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(6),
                                                            "Dimension Value Type"=CONST(Standard),
                                                            Blocked=CONST(false));
                Visible = false;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(6,ShortcutDimCode[6]);
                end;
            }
            field(ShortcutDimCode[7];ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(7),
                                                            "Dimension Value Type"=CONST(Standard),
                                                            Blocked=CONST(false));
                Visible = false;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(7,ShortcutDimCode[7]);
                end;
            }
            field(ShortcutDimCode[8];ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(8),
                                                            "Dimension Value Type"=CONST(Standard),
                                                            Blocked=CONST(false));
                Visible = false;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(8,ShortcutDimCode[8]);
                end;
            }
        
        }*/
        addafter("Direct Debit Mandate ID")
        {
            field("Job Task No."; Rec."Job Task No.")
            {
                ToolTip = 'Job Task No.';
                ApplicationArea = All;
            }
            field("Due Date"; Rec."Due Date")
            {
                ToolTip = 'Due Date';
                ApplicationArea = All;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ToolTip = 'Payment Method Code';
                ApplicationArea = All;
            }
            field("Job Unit Cost (LCY)"; Rec."Job Unit Cost (LCY)")
            {
                ToolTip = 'Job Unit Cost (LCY)';
                ApplicationArea = All;
            }
            field("Job Total Cost (LCY)"; Rec."Job Total Cost (LCY)")
            {
                ToolTip = 'Job Total Cost (LCY)';
                ApplicationArea = All;
            }
            field("Job Line Type"; Rec."Job Line Type")
            {
                ToolTip = 'Job Line Type';
                ApplicationArea = All;
            }
            field("Job Unit Price"; Rec."Job Unit Price")
            {
                ToolTip = 'Job Unit Price';
                ApplicationArea = All;
            }
            field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
            {
                ToolTip = 'Job Line Amount (LCY)';
                ApplicationArea = All;
            }
        }
        moveafter("Job Line Amount (LCY)"; Correction)
        addafter(Correction)
        {
            field("Reversed subsidiary"; Rec."Reversed subsidiary AT")
            {
                ToolTip = 'Reversed subsidiary';
                ApplicationArea = All;
            }
        }
    }
}
