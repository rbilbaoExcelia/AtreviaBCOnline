pageextension 52062 "RecurringGeneralJournal" extends "Recurring General Journal"
{
    layout
    {
        moveafter("VAT Difference"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        addafter("Shortcut Dimension 2 Code")
        {
            field("Job No."; Rec."Job No.")
            {
                ToolTip = 'Job No.';
                ApplicationArea = All;
                Visible = true;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ToolTip = 'Job Task No.';
                ApplicationArea = All;
                Visible = true;
            }
        /*field(ShortcutDimCode[3];ShortcutDimCode[3])
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
            }*/
        }
    }
}
