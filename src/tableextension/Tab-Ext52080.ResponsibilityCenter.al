tableextension 52080 "ResponsibilityCenter" extends "Responsibility Center"
{
    fields
    {
        field(52000; "Cash Account AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cash Account';
            Description = '-011';
            TableRelation = "G/L Account"."No." WHERE("Account Type"=CONST(Posting));
        }
        field(52010; "SQL Synchronized AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
            Description = '-025';
        }
    }
    trigger OnAfterModify()
    begin
        "SQL Synchronized AT":=FALSE; //025
    end;
}
