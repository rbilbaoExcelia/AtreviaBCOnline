table 52042 "Vend. Ledger Entry Historico"
{
    Caption = 'Post Vendor Ledger Entry';
    DrillDownPageID = 29;
    LookupPageID = 29;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(3; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,,,,,,,,,,,Bill';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund, , , , , , , , , , , , , , , Bill;
        }
        field(6; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(7; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(11; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            FieldClass = Normal;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = Normal;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Original Amt. (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Remaining Amt. (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(18; "Purchase (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Purchase (LCY)';
        }
        field(20; "Inv. Discount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(21; "Buy-from Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
        }
        field(22; "Vendor Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
        }
        field(25; "Purchaser Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(27; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                LoginMgt: Codeunit 418;
            begin
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(33; "On Hold"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'On Hold';
        }
        field(34; "Applies-to Doc. Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,,,,,,,,,,,Bill';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund, , , , , , , , , , , , , , , Bill;
        }
        field(35; "Applies-to Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to Doc. No.';
        }
        field(36; Open; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Open';
        }
        field(37; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(38; "Pmt. Discount Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pmt. Discount Date';
        }
        field(39; "Original Pmt. Disc. Possible"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Pmt. Disc. Possible';
            Editable = false;
        }
        field(40; "Pmt. Disc. Rcd.(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Rcd.(LCY)';
        }
        field(43; Positive; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Positive';
        }
        field(44; "Closed by Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Closed by Entry No.';
        }
        field(45; "Closed at Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Closed at Date';
        }
        field(46; "Closed by Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
        }
        field(47; "Applies-to ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to ID';
        }
        field(49; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Batch Name';
        //This property is currently not supported
        //TestTableRelation = false;
        }
        field(50; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(51; "Bal. Account Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset";
        }
        field(52; "Bal. Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bal. Account No.';
        }
        field(53; "Transaction No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction No.';
        }
        field(54; "Closed by Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Closed by Amount (LCY)';
        }
        field(58; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE("Vendor Ledger Entry No."=FIELD("Entry No."), "Entry No."=FILTER(<>'Application'), "Posting Date"=FIELD("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
        }
        field(59; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor Ledger Entry No."=FIELD("Entry No."), "Entry No."=FILTER(<>'Application'), "Posting Date"=FIELD("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" WHERE("Vendor Ledger Entry No."=FIELD("Entry No."), "Entry No."=FILTER(<>'Application'), "Posting Date"=FIELD("Date Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" WHERE("Vendor Ledger Entry No."=FIELD("Entry No."), "Entry No."=FILTER(<>'Application'), "Posting Date"=FIELD("Date Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(63; "External Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'External Document No.';
        }
        field(64; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(65; "Closed by Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Closed by Currency Code';
            TableRelation = Currency;
        }
        field(66; "Closed by Currency Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Closed by Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Currency Amount';
        }
        field(73; "Adjusted Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Adjusted Currency Factor';
            DecimalPlaces = 0: 6;
        }
        field(74; "Original Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Currency Factor';
            DecimalPlaces = 0: 15;
        }
        field(75; "Original Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor Ledger Entry No."=FIELD("Entry No."), "Entry No."=FILTER('Initial Entry'), "Posting Date"=FIELD("Date Filter")));
            Caption = 'Original Amount';
            Editable = false;
        }
        field(76; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(77; "Remaining Pmt. Disc. Possible"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Pmt. Disc. Possible';
        }
        field(78; "Pmt. Disc. Tolerance Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pmt. Disc. Tolerance Date';
        }
        field(79; "Max. Payment Tolerance"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Max. Payment Tolerance';
        }
        field(81; "Accepted Payment Tolerance"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Accepted Payment Tolerance';
        }
        field(82; "Accepted Pmt. Disc. Tolerance"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Accepted Pmt. Disc. Tolerance';
        }
        field(83; "Pmt. Tolerance (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Pmt. Tolerance (LCY)';
        }
        field(10702; "Generated Autodocument"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Generated Autodocument';
            Editable = false;
        }
        field(10703; "Autodocument No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Autodocument No.';
            Editable = false;
        }
        field(52000; "Cash Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Metálico (347)';
            Description = '340-347/2012';
        }
        field(52001; "Spetial operation type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo operación especial';
            Description = '340-347/2012';
            OptionCaption = ' ,Compra-Venta Inmueble,Alquiler local negocio,Operación por cuenta tercero';
            OptionMembers = " ", "Compra-Venta Inmueble", "Alquiler local negocio", "Operación por cuenta tercero";
        }
        field(52002; "Spetial Operation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cód. operacion especial';
            Description = '340-347/2012';
            TableRelation = IF("Spetial operation type"=CONST("Compra-Venta Inmueble"))IAE
            ELSE IF("Spetial operation type"=CONST("Alquiler local negocio"))IAE
            ELSE IF("Spetial operation type"=CONST("Operación por cuenta tercero"))Vendor;
        }
        field(52003; "Exclude 347"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excluir 347';
            Description = '340-347/2012';
        }
        field(52004; Reversed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reversed';
        }
        field(52005; "Reversed by Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Reversed by Entry No.';
        }
        field(52006; "Reversed Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Reversed Entry No.';
        }
        field(52007; "Bill No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill No.';
        }
        field(52008; "Document Situation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Situation';
            OptionCaption = ' ,Posted BG/PO,Closed BG/PO,BG/PO,Cartera,Closed Documents';
            OptionMembers = " ", "Posted BG/PO", "Closed BG/PO", "BG/PO", Cartera, "Closed Documents";
        }
        field(52009; "Applies-to Bill No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to Bill No.';
        }
        field(52010; "Document Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Status';
            OptionCaption = ' ,Open,Honored,Rejected,Redrawn';
            OptionMembers = " ", Open, Honored, Rejected, Redrawn;
        }
        field(52011; "Remaining Amount (LCY) stats."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Amount (LCY) stats.';
        }
        field(52012; "Amount (LCY) stats."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount (LCY) stats.';
        }
        field(52013; "Cash Criteria Operation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cash Criteria Operation';
            Description = 'OTOOLS.002';
        }
        field(52014; "Reverse Charge"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reverse Charge';
            Description = 'OTOOLS.002';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No.", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        }
        key(Key3; "Document No.")
        {
        }
        key(Key4; "External Document No.")
        {
        }
        key(Key5; "Vendor No.", Open, Positive, "Due Date", "Currency Code")
        {
        }
        key(Key6; Open, "Due Date")
        {
        }
        key(Key7; "Document Type", "Vendor No.", "Posting Date", "Currency Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        }
        key(Key8; "Closed by Entry No.")
        {
        }
        key(Key9; "Transaction No.")
        {
        }
        key(Key10; "Vendor No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)", "Pmt. Disc. Rcd.(LCY)";
        }
        key(Key11; "Document Type", "Vendor No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
        key(Key12; "Vendor No.", "Applies-to ID", Open, Positive, "Due Date")
        {
        }
        key(Key13; "Vendor No.", "Document Type", "Document Situation", "Document Status")
        {
            SumIndexFields = "Remaining Amount (LCY) stats.", "Amount (LCY) stats.";
        }
        key(Key14; "Document No.", "Document Type", "Vendor No.")
        {
        }
        key(Key15; "Applies-to ID", "Document Type")
        {
        }
        key(Key16; "Document Type", "Vendor No.", "Document Date", "Currency Code")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Vendor No.", "Posting Date", "Document Type", "Document No.")
        {
        }
        fieldgroup(Brick; "Document No.", Description, "Remaining Amt. (LCY)", "Due Date")
        {
        }
    }
    trigger OnInsert()
    var
        GenJnlPostPreview: Codeunit 19;
    begin
    end;
    var FieldIsNotEmptyErr: Label '%1 cannot be used while %2 has a value.', Comment = '%1=Field;%2=Field';
    MustHaveSameSignErr: Label 'must have the same sign as %1';
    MustNotBeLargerErr: Label 'must not be larger than %1';
    Text1100000: Label 'Payment Discount (VAT Excl.)';
    Text1100001: Label 'Payment Discount (VAT Adjustment)';
    DocMisc: Codeunit "Document-Misc";
    CannotChangePmtMethodErr: Label 'For Cartera-based bills and invoices, you cannot change the Payment Method Code to this value.';
    procedure ShowDoc(): Boolean var
        PurchInvHeader: Record 122;
        PurchCrMemoHdr: Record 124;
    begin
        CASE "Document Type" OF "Document Type"::Invoice: IF PurchInvHeader.GET("Document No.")THEN BEGIN
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
                EXIT(TRUE);
            END;
        "Document Type"::"Credit Memo": IF PurchCrMemoHdr.GET("Document No.")THEN BEGIN
                PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
                EXIT(TRUE);
            END END;
    end;
    procedure DrillDownOnEntries(var DtldVendLedgEntry: Record 380)
    var
        VendLedgEntry: Record 25;
    begin
        VendLedgEntry.Reset();
        DtldVendLedgEntry.COPYFILTER("Vendor No.", VendLedgEntry."Vendor No.");
        DtldVendLedgEntry.COPYFILTER("Currency Code", VendLedgEntry."Currency Code");
        DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", VendLedgEntry."Global Dimension 1 Code");
        DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", VendLedgEntry."Global Dimension 2 Code");
        VendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
        VendLedgEntry.SETRANGE(Open, TRUE);
        PAGE.RUN(0, VendLedgEntry);
    end;
    procedure DrillDownOnOverdueEntries(var DtldVendLedgEntry: Record 380)
    var
        VendLedgEntry: Record 25;
    begin
        VendLedgEntry.Reset();
        DtldVendLedgEntry.COPYFILTER("Vendor No.", VendLedgEntry."Vendor No.");
        DtldVendLedgEntry.COPYFILTER("Currency Code", VendLedgEntry."Currency Code");
        DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", VendLedgEntry."Global Dimension 1 Code");
        DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", VendLedgEntry."Global Dimension 2 Code");
        VendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
        VendLedgEntry.SETFILTER("Date Filter", '..%1', WorkDate());
        VendLedgEntry.SETFILTER("Due Date", '<%1', WorkDate());
        VendLedgEntry.SETFILTER("Remaining Amount", '<>%1', 0);
        PAGE.RUN(0, VendLedgEntry);
    end;
    procedure GetOriginalCurrencyFactor(): Decimal begin
        IF "Original Currency Factor" = 0 THEN EXIT(1);
        EXIT("Original Currency Factor");
    end;
    procedure CheckBillSituation()
    var
        Doc: Record "Cartera Doc.";
        Text1100100: Label '%1 cannot be applied, since it is included in a payment order.';
        Text1100101: Label ' Remove it from its payment order and try again.';
    begin
        IF Doc.GET(Doc.Type::Payable, Rec."Entry No.")THEN IF Doc."Bill Gr./Pmt. Order No." <> '' THEN ERROR(Text1100100 + Text1100101, Rec.Description);
    end;
    procedure ShowDimensions()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
    end;
    procedure SetStyle(): Text begin
        IF Open THEN BEGIN
            IF WorkDate() > "Due Date" THEN EXIT('Unfavorable')END
        ELSE IF "Closed at Date" > "Due Date" THEN EXIT('Attention');
        EXIT('');
    end;
}
