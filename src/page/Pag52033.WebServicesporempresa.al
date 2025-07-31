page 52033 "Web Services por empresa"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    PageType = List;
    SourceTable = "Company Information";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Name';
                    ApplicationArea = All;
                }
                field("Ignorar en WS"; Rec."Ignorar en WS")
                {
                    ToolTip = 'Ignorar en WS';
                    ApplicationArea = All;
                }
                field(Consolidated; Rec.Consolidated)
                {
                    ToolTip = 'Consolidated';
                    ApplicationArea = All;
                }
            /*field("NOC Filter"; Rec."NOC Filter")
                {
                    ToolTip = 'NOC Filter';
                    ApplicationArea = All;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ToolTip = 'Date Filter';
                    ApplicationArea = All;
                }
                field("NOC Periodic Filter"; Rec."NOC Periodic Filter")
                {
                    ToolTip = 'NOC Periodic Filter';
                    ApplicationArea = All;
                }ToolTip = 'Job Consolidation';
                    ApplicationArea = All;
                }*/
            }
        /* Todo: El part SerWeb (ID 50029) no existe en nav
            part(SerWeb; 50029)
            {
                ToolTip = 'SerWeb';
                ApplicationArea = All;
            }*/
        }
    }
    actions
    {
    }
/* Todo: El part SerWeb (ID 50029) no existe en nav
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.SerWeb.Page.GetCompany(Rec.Name);
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.SerWeb.PAGE.GetCompany(Rec.Name);
    end;

    trigger OnOpenPage()
    begin
        IF FINDFIRST THEN
            CurrPage.SerWeb.PAGE.GetCompany(Rec.Name);
    end; */
}
