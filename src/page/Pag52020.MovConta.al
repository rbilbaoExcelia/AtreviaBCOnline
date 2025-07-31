page 52020 "Mov. Conta"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    Permissions = TableData "MOV.CONTAB"=r;
    SourceTable = "MOV.CONTAB";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'G/L Account No.';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Posting Date';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Document Type';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Document No.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Amount';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Global Dimension 2 Code';
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Job No.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantity';
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Entry No.';
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ToolTip = 'Transaction No.';
                    ApplicationArea = All;
                }
                field(TxtImporte; Rec.TxtImporte)
                {
                    ToolTip = 'TxtImporte';
                    ApplicationArea = All;
                }
                field(NewDim1; Rec.NewDim1)
                {
                    ToolTip = 'NewDim1';
                    ApplicationArea = All;
                }
                field(NewDim2; Rec.NewDim2)
                {
                    ToolTip = 'NewDim2';
                    ApplicationArea = All;
                }
                field("Existe Proyecto"; Rec."Existe Proyecto")
                {
                    ToolTip = 'Existe Proyecto';
                    ApplicationArea = All;
                }
                field("Existe NewDim1"; Rec."Existe NewDim1")
                {
                    ToolTip = 'Existe NewDim1';
                    ApplicationArea = All;
                }
                field("Existe NewDim2"; Rec."Existe NewDim2")
                {
                    ToolTip = 'Existe NewDim2';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
