table 52019 "Jobs consol. compromised"
{
    // 010 OS.MIR  20/06/2016  FIN.009   Funcionalidad filiales
    Caption = 'Jobs consol. compromised';

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type"=FIELD("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ", "G/L Account", Item, Resource, "Fixed Asset", "Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            TableRelation = IF(Type=CONST(" "))"Standard Text"
            ELSE IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST(Resource))Resource
            ELSE IF(Type=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF(Type=CONST("Charge (Item)"))"Item Charge";

            trigger OnValidate()
            var
                ICPartner: Record 413;
                ItemCrossReference: Record "Item Reference";
                PrepmtMgt: Codeunit 441;
            begin
            end;
        }
        field(10; "Expected Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Receipt Date';
        }
        field(11; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(45; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
        }
        field(1001; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No."=FIELD("Job No."));
        }
        field(52087; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'N° Movimiento';
        }
        field(52089; "Source Company No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Company No.';
            TableRelation = Company;
        }
        field(52090; "Outstanding Amount (LCY) wVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY) wVAT';
            Editable = false;
        }
        field(52091; "Amt. Rcd. Not Inv. (LCY) wVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Inv. (LCY) wVAT';
            Editable = false;
        }
        field(52092; "Outstanding Amount (DA) wVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY) wVAT';
            Editable = false;
        }
        field(52094; "Amt. Rcd. Not Inv. (DA) wVAT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Inv. (LCY) wVAT';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Job No.", "Job Task No.", "Expected Receipt Date")
        {
            SumIndexFields = "Outstanding Amount (LCY) wVAT", "Amt. Rcd. Not Inv. (LCY) wVAT", "Outstanding Amount (DA) wVAT", "Amt. Rcd. Not Inv. (DA) wVAT";
        }
    }
    fieldgroups
    {
    }
}
