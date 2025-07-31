page 52037 "Corregir GL Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "G/L Entry";
    Caption = 'Corregir GL Entry';
    Editable = true;
    Permissions = tabledata 17=rimd;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
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
