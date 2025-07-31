table 52000 "Account Grouping AT"
{
    // 012 OS.MIR  30708/2016  FIN.011   Informe Previsión Rentas Netas Agr. AC
    // 999 OS.MIR  29/06/2016  DataPerCompany = No
    Caption = 'Account Grouping';
    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}
