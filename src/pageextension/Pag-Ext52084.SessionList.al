pageextension 52084 "SessionList" extends "Concurrent Session List"
{
    actions
    {
        addfirst(Processing)
        {
            action("Kill Session")
            {
                ToolTip = 'Kill Session';
                Caption = 'Kill Session';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM(Text50000, FALSE)THEN STOPSESSION(Rec."Session ID");
                end;
            }
        }
    }
    var Text50000: Text;
}
