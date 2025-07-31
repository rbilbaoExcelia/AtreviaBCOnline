page 52035 "Personal Assignation List"
{
    ApplicationArea = All;
    Caption = 'Personal Assignation List';
    PageType = List;
    SourceTable = "Personal Assignation";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Date';
                    ApplicationArea = All;
                }
                field(IdMyNet; Rec.IdMyNet)
                {
                    ToolTip = 'IdMyNet';
                    ApplicationArea = All;
                }
                field(NavDimension1; Rec.NavDimension1)
                {
                    ToolTip = 'NavDimension1';
                    ApplicationArea = All;
                }
                field(NavDimension2; Rec.NavDimension2)
                {
                    ToolTip = 'NavDimension2';
                    ApplicationArea = All;
                }
                field(EmployeeName; Rec.EmployeeName)
                {
                    ToolTip = 'EmployeeName';
                    ApplicationArea = All;
                }
                field(CollaboratorType; Rec.CollaboratorType)
                {
                    ToolTip = 'CollaboratorType';
                    ApplicationArea = All;
                }
                field(ImputationPercentage; Rec.ImputationPercentage)
                {
                    ToolTip = 'ImputationPercentage';
                    ApplicationArea = All;
                }
                field(FTEPercentage; Rec.FTEPercentage)
                {
                    ToolTip = 'FTEPercentage';
                    ApplicationArea = All;
                }
            }
        }
    }
}
