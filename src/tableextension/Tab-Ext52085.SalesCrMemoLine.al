tableextension 52085 "SalesCrMemoLine" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(52000; "Concept Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Concept Line No';
            Description = '-030';
            Editable = false;
        }
        field(52001; "Attendant Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Attendant Line No.';
            Description = '-030';
            Editable = false;
        }
        field(52002; "Line Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Type';
            Description = '-011';
            OptionCaption = ' ,Expense';
            OptionMembers = " ", Expense;
        }
        field(52003; "Expense Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expense Date';
            Description = '-011';
        }
        field(52004; "Text Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Text Line No.';
            Description = '-030';
            Editable = false;
        }
        field(52107; "Job Assistant"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Asistente';
            Description = '-029';
        }
        field(52108; "Cust Order Purch No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cust Order Purch No.';
            Description = '-080';
        }
    }
}
