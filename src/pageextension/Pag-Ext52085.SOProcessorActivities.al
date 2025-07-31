pageextension 52085 "SOProcessorActivities" extends "SO Processor Activities"
{
    layout
    {
        addafter("Sales Orders - Open")
        {
            field("Job Planning Line - Sale Open"; Rec."Job Planning Line - Sale Open")
            {
                ToolTip = 'Job Planning Line - Sale Open';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                //046
                end;
            }
        }
    }
}
