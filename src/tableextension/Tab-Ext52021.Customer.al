tableextension 52021 "Customer" extends Customer
{
    fields
    {
        field(52000; "Customer Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Type';
            Description = '-002';
            OptionCaption = ' ,Continuous,One Off';
            OptionMembers = " ", Continuous, "One Off";
        }
        field(52005; "Invoice Optional Text"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Optional Text';
            Description = '-008';
        }
        field(52010; "SQL Synchronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
            Description = '-025';
        }
        field(52011; "Mandatory Purch. Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mandatory Purch. Order';
            Description = '-025';
        }
        field(52014; "Customer Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Group';
            Description = '-061';
            TableRelation = "Customer group";
        }
        field(52020; "Billing Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Billing Type';
            Description = '-023';
            OptionCaption = 'Print,Mail,eInvoice';
            OptionMembers = Print, Mail, eInvoice;
        }
        field(52021; Sector; Code[50])
        {
            DataClassification = CustomerContent;
            Description = 'EX-OMI 180320';
            TableRelation = Sector2;
        }
        field(52022; Subsector; Code[100])
        {
            DataClassification = CustomerContent;
            Description = 'EX-OMI 180320';
            TableRelation = Subsector;
        }
        field(52023; "Tipo empresa"; Code[35])
        {
            DataClassification = CustomerContent;
            Description = 'EX-OMI 180320';
            TableRelation = "Tipo de empresa";
        }
    }
    keys
    {
        key(Key10; "SQL Synchronized")
        {
        }
    }
    trigger OnBeforeDelete()
    begin
        ERROR('No es posible eliminar');
    end;
    trigger OnAfterModify()
    begin
        //TESTFIELD("Customer Type");//023
        "SQL Synchronized":=FALSE; //025
    end;
}
