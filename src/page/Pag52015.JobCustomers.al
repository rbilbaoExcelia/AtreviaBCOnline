page 52015 "Job Customers"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Job Customers';
    PageType = List;
    Permissions = TableData "Job Customer AT"=rm;
    SourceTable = "Job Customer AT";

    // 030 OS.MIR  20/06/2016  PROY.005  Facturación multicliente desde proyecto
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Job No.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Customer No.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Line No.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Customer Name';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Attendant Name"; Rec."Attendant Name")
                {
                    ToolTip = 'Attendant Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Credit"; Rec."To Credit")
                {
                    ToolTip = 'To Credit';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("SQL Synchronized"; Rec."SQL Synchronized")
                {
                    ToolTip = 'SQL Synchronized';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Blocked';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("<Invoice No.>"; Rec.FindInvoiceNo())
                {
                    ToolTip = '<Invoice No.>';
                    ApplicationArea = All;
                    Caption = 'Invoice No.';
                    Enabled = false;
                }
                field("<Cr. Memo No.>"; Rec.FindCrMemoNo())
                {
                    ToolTip = '<Cr. Memo No.>';
                    ApplicationArea = All;
                    Caption = 'Cr. Memo No.';
                    Enabled = false;
                }
                field("Discount %"; Rec."Discount %")
                {
                    ToolTip = 'Discount %';
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Net Amount';
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
