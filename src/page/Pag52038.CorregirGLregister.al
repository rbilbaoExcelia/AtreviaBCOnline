page 52038 "Corregir GL register"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "G/L Register";
    Caption = 'Corregir GL register';
    Editable = true;
    Permissions = tabledata 45=rimd;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("From Entry No."; rec."From Entry No.")
                {
                    ApplicationArea = All;
                }
                field("To Entry No."; rec."To Entry No.")
                {
                    ApplicationArea = All;
                }
                field("From VAT Entry No."; rec."From VAT Entry No.")
                {
                    ApplicationArea = All;
                }
                field("To VAT Entry No."; rec."To VAT Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Reversed; rec.Reversed)
                {
                    ApplicationArea = All;
                    Editable = true;
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
        }
    }
}
