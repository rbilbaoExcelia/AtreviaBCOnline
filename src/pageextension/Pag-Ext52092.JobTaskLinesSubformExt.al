pageextension 52092 "Job Task Lines Subform Ext" extends "Job Task Lines Subform"
{
    layout
    {
        addafter("Job Task Type")
        {
            field(Status; Rec."Status AT")
            {
                ToolTip = 'Status';
                ApplicationArea = All;
            }
            field("Tipo Tarea"; Rec."Task Type AT")
            {
                ToolTip = 'Tipo Tarea';
                ApplicationArea = All;
            }
        }
        addafter("End Date")
        {
            field(Billable; Rec."Billable AT")
            {
                ToolTip = 'Billable';
                ApplicationArea = All;
            }
        }
    }
}
