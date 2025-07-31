page 52029 "Session List ATREVIA"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Session List';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Session,SQL Trace,Events';
    RefreshOnActivate = true;
    SourceTable = "Active Session";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SessionIdText; SessionIdText)
                {
                    ToolTip = 'Session ID';
                    ApplicationArea = All;
                    Caption = 'Session ID';
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'User ID';
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false;
                }
                field(IsSQLTracing; IsSQLTracing)
                {
                    ToolTip = 'SQL Tracingw';
                    ApplicationArea = All;
                    Caption = 'SQL Tracing';

                    trigger OnValidate()
                    begin
                    //DEBUGGER.EnableSqlTrace("Session ID", IsSQLTracing); Todo: cannot be usen on OnPrem
                    end;
                }
                field("Client Type"; ClientTypeText)
                {
                    ToolTip = 'Client Type';
                    ApplicationArea = All;
                    Caption = 'Client Type';
                    Editable = false;
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ToolTip = 'Login Datetime';
                    ApplicationArea = All;
                    Caption = 'Login Date';
                    Editable = false;
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ToolTip = 'Server Computer Name';
                    ApplicationArea = All;
                    Caption = 'Server Computer Name';
                    Editable = false;
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ToolTip = 'Server Instance Name';
                    ApplicationArea = All;
                    Caption = 'Server Instance Name';
                    Editable = false;
                }
                field(IsDebugging; IsDebugging)
                {
                    ToolTip = 'IsDebugging';
                    ApplicationArea = All;
                    Caption = 'Debugging';
                    Editable = false;
                }
                field(IsDebugged; IsDebugged)
                {
                    ToolTip = 'IsDebugged';
                    ApplicationArea = All;
                    Caption = 'Debugged';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            separator(Separador)
            {
            }
            group(Session)
            {
                Caption = 'Session';

                action("Kill Session")
                {
                    Caption = 'Cerrar sesion';
                    ToolTip = 'Cerrar sesion';
                    ApplicationArea = All;
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Txt50000: Label '¿Confirma que desea cerrar la sesión?';
                    begin
                        IF CONFIRM(Txt50000)THEN //
 ActiveSessions.SETRANGE(ActiveSessions."Session ID", Rec."Session ID");
                        IF ActiveSessions.FIND('-')THEN IF ActiveSessions."User ID" <> 'INFORPRESS\ADMINISTRADOR' THEN //
 STOPSESSION(Rec."Session ID");
                    end;
                }
            }
            group("Event")
            {
                Caption = 'Event';

                action(Subscriptions)
                {
                    Caption = 'Subscriptions';
                    ToolTip = 'Subscriptions';
                    ApplicationArea = All;
                    Image = "Event";
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Event Subscriptions";
                    Visible = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        /*Todo: DEBUGGER cannot be usen on Onprem  
        IsDebugging := DEBUGGER.ISACTIVE AND ("Session ID" = DEBUGGER.DEBUGGINGSESSIONID);
        IsDebugged := DEBUGGER.ISATTACHED AND ("Session ID" = DEBUGGER.DEBUGGEDSESSIONID);
        IsSQLTracing := DEBUGGER.ENABLESQLTRACE("Session ID"); */
        // If this is the empty row, clear the Session ID and Client Type
        IF Rec."Session ID" = 0 THEN BEGIN
            SessionIdText:='';
            ClientTypeText:='';
        END
        ELSE
        BEGIN
            SessionIdText:=FORMAT(Rec."Session ID");
            ClientTypeText:=FORMAT(Rec."Client Type");
        END;
    end;
    trigger OnFindRecord(Which: Text): Boolean begin
        /* Todo: Debugger cannot be usen on OnPrem
        CanDebugNextSession := NOT DEBUGGER.ISACTIVE;
        CanDebugSelectedSession := NOT DEBUGGER.ISATTACHED AND NOT ISEMPTY; */
        // If the session list is empty, insert an empty row to carry the button state to the client
        IF NOT Rec.FIND(Which)THEN BEGIN
            Rec.Init();
            Rec."Session ID":=0;
        END;
        EXIT(TRUE);
    end;
    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Server Instance ID", '=%1', SERVICEINSTANCEID);
        Rec.SETFILTER("Session ID", '<>%1', SESSIONID);
        Rec.FILTERGROUP(0);
    //FullSQLTracingStarted := DEBUGGER.ENABLESQLTRACE(0); TODO: Debugger cannot be usen on OnPrem
    end;
    var ActiveSessions: Record "Active Session";
    DebuggerManagement: Codeunit "Debugger Triggers";
    [InDataSet]
    CanDebugNextSession: Boolean;
    [InDataSet]
    CanDebugSelectedSession: Boolean;
    [InDataSet]
    FullSQLTracingStarted: Boolean;
    IsDebugging: Boolean;
    IsDebugged: Boolean;
    IsSQLTracing: Boolean;
    SessionIdText: Text;
    ClientTypeText: Text;
}
