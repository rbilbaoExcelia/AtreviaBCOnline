pageextension 52066 "ResourcesSetup" extends "Resources Setup"
{
    layout
    {
        addafter("Time Sheet by Job Approval")
        {
            field("Gen. Prod. Posting Group Gener"; Rec."Gen. Prod. Ptg. Group Gener AT")
            {
                ToolTip = 'Gen. Prod. Posting Group Gener';
                ApplicationArea = All;
            }
            field("Base Unit of Measure Generic"; Rec."Base Unit of Measure Gener AT")
            {
                ToolTip = 'Base Unit of Measure Generic';
                ApplicationArea = All;
            }
        }
    }
}
