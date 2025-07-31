table 52016 "Job Base Budget"
{
    // 010 OS.MIR  20/06/2016  FIN.009   Funcionalidad filiales
    Caption = 'Job Base Budget';
    PasteIsValid = false;
    Permissions = TableData 1015=rimd;

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            Editable = false;
        }
        field(2; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            Editable = false;
            TableRelation = Job;
        }
        field(3; "Planning Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Planning Date';
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(5; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account,Text';
            OptionMembers = Resource, Item, "G/L Account", Text;
        }
        field(7; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            //TODO: VER
            TableRelation = //IF (Type = CONST(Resource)) Resource WHERE("Shortcut Dimension 1 Code" = FIELD("Resource type"))
 //ELSE
            IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Text))"Standard Text";
        }
        field(8; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(9; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;
        }
        field(11; "Direct Unit Cost (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
        }
        field(12; "Unit Cost (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = false;
        }
        field(13; "Total Cost (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(14; "Unit Price (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = false;
        }
        field(15; "Total Price (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = false;
        }
        field(16; "Resource Group No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource Group No.';
            Editable = false;
            TableRelation = "Resource Group";
        }
        field(17; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
            TableRelation = IF(Type=CONST(Item))"Item Unit of Measure".Code WHERE("Item No."=FIELD("No."))
            ELSE IF(Type=CONST(Resource))"Resource Unit of Measure".Code WHERE("Resource No."=FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                Resource: Record 156;
            begin
            end;
        }
        field(20; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));
        }
        field(29; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            Editable = false;
            TableRelation = User;
        //This property is currently not supported
        //TestTableRelation = false;
        }
        field(32; "Work Type Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(33; "Customer Price Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(79; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(80; "Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group';
            Editable = false;
            TableRelation = "Gen. Business Posting Group";
        }
        field(81; "Gen. Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Prod. Posting Group';
            Editable = false;
            TableRelation = "Gen. Product Posting Group";
        }
        field(83; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(1000; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No."=FIELD("Job No."));
        }
        field(1001; "Line Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;
        }
        field(1002; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
        }
        field(1003; "Total Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
            Editable = false;
        }
        field(1004; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(1005; "Total Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
            Editable = false;
        }
        field(1006; "Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(1007; "Line Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(1008; "Line Discount Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;
        }
        field(1015; "Cost Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cost Factor';
            Editable = false;
        }
        field(1019; "Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serial No.';
            Editable = false;
        }
        field(1020; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
            Editable = false;
        }
        field(1021; "Line Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Line Discount %';
        }
        field(1022; "Line Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Type';
            OptionCaption = 'Schedule,Contract,Both Schedule and Contract';
            OptionMembers = Schedule, Contract, "Both Schedule and Contract";
        }
        field(1023; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(1024; "Currency Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Date';
        }
        field(1025; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0: 15;
            Editable = false;
            MinValue = 0;
        }
        field(1026; "Schedule Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Schedule Line';
            Editable = false;
            InitValue = true;
        }
        field(1027; "Contract Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Line';
            Editable = false;
        }
        field(1028; Invoiced; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced';
            Editable = false;
        }
        field(1029; Transferred; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transferred';
            Editable = false;
        }
        field(1030; "Job Contract Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Contract Entry No.';
            Editable = false;
        }
        field(1031; "Invoice Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Type';
            Editable = false;
            OptionCaption = ' ,Invoice,Credit Memo,Posted Invoice,Posted Credit Memo';
            OptionMembers = " ", Invoice, "Credit Memo", "Posted Invoice", "Posted Credit Memo";
        }
        field(1032; "Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice No.';
            Editable = false;
            TableRelation = IF("Invoice Type"=CONST(Invoice), "Invoice Type"=CONST("Credit Memo"))"Sales Invoice Header"
            ELSE IF("Invoice Type"=CONST("Credit Memo"))"Sales Cr.Memo Header";

            trigger OnLookup()
            var
                JobCreateInvoice: Codeunit 1002;
            begin
            end;
        }
        field(1033; "Transferred Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Transferred Date';
            Editable = false;
        }
        field(1034; "Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Date';
            Editable = false;
        }
        field(1035; "Invoiced Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced Amount (LCY)';
            Editable = false;
        }
        field(1036; "Invoiced Cost Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced Cost Amount (LCY)';
            Editable = false;
        }
        field(1037; "VAT Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Unit Price';
        }
        field(1038; "VAT Line Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Line Discount Amount';
        }
        field(1039; "VAT Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Line Amount';
        }
        field(1041; "VAT %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
        }
        field(1042; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
        field(1043; "Job Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Job Ledger Entry No.';
            Editable = false;
            TableRelation = "Job Ledger Entry";
        }
        field(1044; "Inv. Curr. Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Invoice Currency Code";
            AutoFormatType = 2;
            Caption = 'Inv. Curr. Unit Price';
            Editable = false;
        }
        field(1045; "Inv. Curr. Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Invoice Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Curr. Line Amount';
            Editable = false;
        }
        field(1046; "Invoice Currency"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Currency';
            Editable = false;
        }
        field(1047; "Invoice Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Currency Code';
            TableRelation = Currency;
        }
        field(1048; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
            InitValue = Stuty;
            OptionCaption = 'Stuty,Promotion,Constrution,Finished,Cancelled';
            OptionMembers = Stuty, Promotion, Constrution, Finished, Cancelled;
        }
        field(1049; "Invoice Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Currency Factor';
            Editable = false;
        }
        field(1050; "Ledger Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Ledger Entry Type';
            OptionCaption = ' ,Resource,Item,G/L Account';
            OptionMembers = " ", Resource, Item, "G/L Account";
        }
        field(1051; "Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Ledger Entry No.';
            TableRelation = IF("Ledger Entry Type"=CONST(Resource))"Res. Ledger Entry"
            ELSE IF("Ledger Entry Type"=CONST(Item))"Item Ledger Entry"
            ELSE IF("Ledger Entry Type"=CONST("G/L Account"))"G/L Entry";
        }
        field(1052; "System-Created Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'System-Created Entry';
        }
        field(5402; "Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = IF(Type=CONST(Item))"Item Variant".Code WHERE("Item No."=FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code"=FIELD("Location Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0: 5;
            Editable = false;
            InitValue = 1;
        }
        field(5410; "Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0: 5;
        }
        field(5900; "Service Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Order No.';
        }
        field(52040; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'PPLUS.001';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(52041; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'PPLUS.001';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(52042; "Purchase Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Type';
            Description = 'PPLUS.001';
            Editable = false;
            OptionCaption = ' ,Request,Quote,Order,Factura';
            OptionMembers = " ", Request, Quote, "Order", Factura;
        }
        field(52043; "Purchase Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Document No.';
            Description = 'PPLUS.001';
            Editable = false;
        }
        field(52044; "Purchase Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Line No.';
            Description = 'PPLUS.001';
            Editable = false;
        }
        field(52045; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No.';
            Description = 'PPLUS.001';
            TableRelation = Vendor;
        }
        field(52046; "Resource type"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource type';
            Description = 'PPLUS.001';
        }
        field(52047; "Purch. Transferred"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Purch. Transferred';
            Description = 'PPLUS.001';
            Editable = false;
        }
        field(52000; "Subcontr. aproved"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Subcontr. aproved';
            Description = 'PPLUS.003';
        }
        field(52001; "Assigned Hr."; Decimal)
        {
            BlankZero = true;
            Caption = 'Assigned Hr.';
            Description = 'PPLUS.002';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52002; "Not Invoic. Subcontracting"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Not Invoic. Subcontracting';
            Description = 'PPLUS.003';
        }
        field(52003; Subcontracted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Subcontracted';
            Description = 'PPLUS.003';
            Editable = false;
        }
        field(52004; Finished; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished';
            Description = 'PPLUS.003';
        }
        field(52005; "Tipo línea planificación"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo línea planificación';
            Description = 'PPLUS.004';
            OptionCaption = 'Manual,Anticipo,Automática';
            OptionMembers = Manual, Anticipo, "Automática";
        }
        field(52006; "Coste hist. (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Coste hist. (LCY)';
            Description = 'PPLUS.006';
            Editable = false;
        }
        field(52070; "Bill-to customer no."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to customer no.';
            Description = 'KONIC.001';
            TableRelation = Customer;
        }
        field(52071; "Contact code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact code';
            Description = 'KONIC.001';
            TableRelation = Contact;
        }
        field(52072; "Salesperson code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesperson code';
            Description = 'KONIC.001 RELACION CAMPO 73076';
        }
        field(52075; "Payment terms code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment terms code';
            Description = 'KONIC.001';
            TableRelation = "Payment Terms";
        }
        field(52076; "Payment Method Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Method Code';
            Description = 'KONIC.001';
            TableRelation = "Payment Method";
        }
        field(52077; "Due date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due date';
            Description = 'KONIC.001';
        }
        field(52078; "% comison"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% comison';
            Description = 'KONIC.001';
        }
        field(52079; "Commision amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Commision amount (LCY)';
            Description = 'KONIC.001';
            Editable = false;
        }
        field(52080; "Realized Hr."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Job Ledger Entry".Quantity WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Job Task No."), /*TODO - Field7078705 = FIELD("Line No."), */ "Entry Type"=CONST(Usage)));
            Caption = 'Realized Hr.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52081; "Real Cost"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Job Ledger Entry"."Total Cost (LCY)" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Job Task No."), /* Field7078705 = FIELD("Line No."), */ "Entry Type"=CONST(Usage)));
            Caption = 'Real Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52082; "Contacto asisntente curso"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contacto asisntente curso';
            TableRelation = Contact;
        }
    }
    keys
    {
        key(Key1; "Job No.", "Job Task No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Job No.", "Job Task No.", "Schedule Line", "Planning Date")
        {
            SumIndexFields = "Total Cost (LCY)", "Total Cost";
        }
        key(Key3; "Job No.", "Job Task No.", "Contract Line", "Planning Date")
        {
            SumIndexFields = "Line Amount (LCY)", "Total Price (LCY)", "Total Cost (LCY)", "Invoiced Amount (LCY)", "Invoiced Cost Amount (LCY)", "Coste hist. (LCY)";
        }
    }
    fieldgroups
    {
    }
    var
//GLAcc: Record "G/L Account";
//Location: Record 14;
//Item: Record 27;
//JobEntryNo: Record 1015;
//JT: Record 1001;
//ItemVariant: Record 5401;
//Res: Record 156;
//ResCost: Record 202;
//WorkType: Record 200;
//Job: Record Job;
//ResUnitofMeasure: Record 205;
//ItemJnlLine: Record 83;
//CurrExchRate: Record 330;
//SKU: Record 5700;
//StdTxt: Record 7;
//Currency: Record 4;
//ItemTranslation: Record 30;
//GLSetup: Record 98;
//SalesPriceCalcMgt: Codeunit 7000;
//PurchPriceCalcMgt: Codeunit 7010;
//UOMMgt: Codeunit 5402;
//ResFindUnitCost: Codeunit 220;
//ItemCheckAvail: Codeunit 311;
//Text001: Label 'cannot be specified without %1';
//Text002: Label 'You cannot rename a %1.';
//CurrencyDate: Date;
//Text004: Label 'You must specify %1 %2 in planning line.';
//HasGotGLSetup: Boolean;
//UnitAmountRoundingPrecision: Decimal;
//AmountRoundingPrecision: Decimal;
//CheckedAvailability: Boolean;
//DimMgt: Codeunit 408;
//PaymentTerms: Record 3;
//AdjustDueDate: Codeunit "Due Date-Adjust";
//Cust: Record 18;
//SalesPerson: Record 13;
//JobsSetup: Record 315;
}
