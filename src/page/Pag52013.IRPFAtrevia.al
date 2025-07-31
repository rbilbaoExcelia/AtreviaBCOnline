page 52013 "IRPF Atrevia"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Income Tax';
    SourceTable = "IRPF Atrevia";

    // 024 OS.MIR  21/06/2016  COM.001   Módulo IRPF OS
    layout
    {
        area(content)
        {
            repeater(Tax)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Code';
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Account No.';
                    ApplicationArea = All;
                    Caption = 'Account No.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("IRPF %"; Rec."IRPF %")
                {
                    ToolTip = 'IRPF %';
                    ApplicationArea = All;
                    Caption = 'Tax %';
                }
            }
        }
    }
    actions
    {
    }
}
