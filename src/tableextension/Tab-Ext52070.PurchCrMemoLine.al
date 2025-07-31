tableextension 52070 "PurchCrMemoLine" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(52002; "Job Line Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Line Account No.';
            Description = '055';
            TableRelation = IF(Type=CONST("G/L Account"))"G/L Account";

            trigger OnValidate()
            var
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
    }
}
