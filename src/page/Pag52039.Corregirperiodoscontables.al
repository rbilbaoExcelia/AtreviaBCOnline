page 52039 "Corregir periodos contables"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Accounting Period";
    Caption = 'Corregir periodos contables';
    Editable = true;
    Permissions = tabledata 50=rimd;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field("New Fiscal Year"; rec."New Fiscal Year")
                {
                    ApplicationArea = All;
                }
                field(Closed; rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Date Locked"; rec."Date Locked")
                {
                    ApplicationArea = All;
                }
                field("Average Cost Calc. Type"; rec."Average Cost Calc. Type")
                {
                    ApplicationArea = All;
                }
                field("Average Cost Period"; rec."Average Cost Period")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Hacer editable")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.Editable:=true;
                end;
            }
            action(Borrar)
            {
                ApplicationArea = all;

                trigger OnAction()
                var
                    lRecPeriods: Record "Accounting Period";
                begin
                    CurrPage.SetSelectionFilter(lRecPeriods);
                    if lRecPeriods.FindFirst()then lRecPeriods.Delete(false);
                end;
            }
        }
    }
}
