tableextension 52048 "JobJournalLine" extends "Job Journal Line"
{
    fields
    {
        field(52000; Billable; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Billable';
            Description = '-026';
        }
        field(52001; "Expenses Surcharge %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses Surcharge %';
            Description = '-011';
        }
        field(52002; "Job Line Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Line Account No.';
            Description = '-055';
            TableRelation = IF(Type=CONST("G/L Account"))"G/L Account";

            trigger OnValidate()
            var
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(52107; "Job Assistant"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Asistente';
            Description = '-057';
        }
        field(52111; Confirmed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed';
            Description = '-055';
        }
        field(52112; "To Credit"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Abonar';
            Description = '-055';
        }
    }
    var ResFindUnitCost: Codeunit 220;
}
