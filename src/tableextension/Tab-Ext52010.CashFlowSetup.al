tableextension 52010 "CashFlowSetup" extends "Cash Flow Setup"
{
    fields
    {
        field(52000; "Jobs Billing CF Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = TableData 1003=R;
            Caption = 'Jobs Billing CF Account No.';
            Description = '-007';
            TableRelation = "Cash Flow Account";
        }
    }
}
