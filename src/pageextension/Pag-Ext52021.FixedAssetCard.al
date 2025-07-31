pageextension 52021 "FixedAssetCard" extends "Fixed Asset Card"
{
    layout
    {
        addafter("Responsible Employee")
        {
            field("Responsible Resource"; Rec."Responsible Resource")
            {
                ToolTip = 'Responsible Resource';
                ApplicationArea = All;
            }
        }
        addafter(Inactive)
        {
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ToolTip = 'FA Posting Group';
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
        }
        addafter(Maintenance)
        {
            group(SII)
            {
                field(Property; Rec.Property)
                {
                    ToolTip = 'Property';
                    ApplicationArea = All;
                }
            }
        }
    }
}
