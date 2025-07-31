tableextension 52054 "JobsSetup" extends "Jobs Setup"
{
    fields
    {
        field(52000; "Expenses Series No. AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses Series No.';
            Description = '-011';
            TableRelation = "No. Series";
        }
        field(52001; "Expenses Source Code AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses Souce Code';
            Description = '-011';
            TableRelation = "Source Code";
        }
        field(52002; "Increase by Expenses AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Increase by Expenses';
            Description = '-011';
        }
        field(52010; "SQL User AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'SQL User';
            Description = '-025';
        }
        field(52011; "SQL Password AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Password';
            Description = '-025';
            ExtendedDatatype = Masked;
        }
        field(52012; "SQL IP AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'SQL IP';
            Description = '-025';
        }
        field(52013; "SQL Database AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Database';
            Description = '-025';
        }
        field(52014; "Gen. Prod. Posting Group AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Prod. Posting Group';
            Description = '-025';
            TableRelation = "Gen. Product Posting Group";
        }
        field(52015; "Job Posting Group AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Posting Group default';
            Description = '-025';
            TableRelation = "Job Posting Group";
        }
        field(52016; "Unit of Measure AT"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure';
            Description = '-025';
            TableRelation = "Unit of Measure";
        }
        field(52017; "Word Path AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Word Path';
            Description = '-025';
        }
        field(52018; "CPI % AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CPI %';
            Description = '-025';
        }
        field(52019; "CPI Text AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'CPI Text';
            Description = '-025';
            Editable = false;
        }
        field(52020; "Sector Text 1 AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector Text 1';
            Description = '-025';
        }
        field(52021; "Sector Text 2 AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector Text 2';
            Description = '-025';
        }
        field(52022; "Sector Text 3 AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector Text 3';
            Description = '-025';
        }
        field(52030; "G/L Accounts Rep. Filter AT"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Accounts Rep. Filter';
            Description = '-018';
        }
        field(52031; "G/L Acct. Dept. Rep. Filter AT"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Acct. Dept. Rep. Filter';
            Description = '-018';
        }
        field(52036; "Generic Task Identation AT"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Generic Task Identation', Comment = 'Indentación tarea genérica';
        }
        field(52037; "Customer Billing Acct. No. AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Billing Account No.', Comment = 'Nº Cuenta facturación cliente';
            TableRelation = "G/L Account";
        }
        field(52041; "Accounts Services AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Accounts Services', Comment = 'Cuentas Servicios';
        }
        field(52042; "Management Accounts AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Management Accounts', Comment = 'Cuentas Gestion';
        }
        field(52043; "Refillable Accounts AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Refillable Accounts', Comment = ' Cuentas Refacturable';
        }
    }
}
