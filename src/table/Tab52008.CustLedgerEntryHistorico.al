table 52008 "Cust. Ledger Entry Historico"
{
    Caption = 'Past Cust. Ledger Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(3; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
            TableRelation = Customer;
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
            Editable = false;
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
        field(18; "Sales (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Sales (LCY)';
        }
        field(19; "Profit (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
        }
        field(20; "Inv. Discount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(21; "Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(22; "Customer Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
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
        field(25; "Salesperson Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
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
            //LoginMgt.LookupUserID("User ID");
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
        field(40; "Pmt. Disc. Given (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Given (LCY)';
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
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = Normal;
        }
        field(59; "Credit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = Normal;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = Normal;
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
        field(64; "Calculate Interest"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Calculate Interest';
        }
        field(65; "Closing Interest Calculated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Closing Interest Calculated';
        }
        field(66; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(67; "Closed by Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Closed by Currency Code';
            TableRelation = Currency;
        }
        field(68; "Closed by Currency Amount"; Decimal)
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
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Amount';
            Editable = false;
            FieldClass = Normal;
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
        field(80; "Last Issued Reminder Level"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Issued Reminder Level';
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
            ELSE IF("Spetial operation type"=CONST("Operación por cuenta tercero"))Customer;
        }
        field(52003; "Exclude 347"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excluir 347';
            Description = '340-347/2012';
        }
        field(52005; "IC Partner Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IC Partner Code';
            TableRelation = Customer;
        }
        field(52006; "Applying Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Applying Entry';
        }
        field(52007; Reversed; Boolean)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Reversed';
        }
        field(52008; "Reversed by Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Reversed by Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(52009; "Reversed Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Reversed Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(52010; Prepayment; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment';
        }
        field(52011; "Direct Debit Mandate ID"; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Direct Debit Mandate ID';
            Description = 'SEPA_XML';
            TableRelation = "SEPA Direct Debit Mandate" WHERE("Customer No."=FIELD("Customer No."));
        }
        field(52070; "Bill No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill No.';
        }
        field(52071; "Document Situation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Situation';
            OptionCaption = ' ,Posted BG/PO,Closed BG/PO,BG/PO,Cartera,Closed Documents';
            OptionMembers = " ", "Posted BG/PO", "Closed BG/PO", "BG/PO", Cartera, "Closed Documents";
        }
        field(52072; "Applies-to Bill No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to Bill No.';
        }
        field(52073; "Document Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Status';
            OptionCaption = ' ,Open,Honored,Rejected,Redrawn';
            OptionMembers = " ", Open, Honored, Rejected, Redrawn;
        }
        field(52075; "Remaining Amount (LCY) stats."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Amount (LCY) stats.';
        }
        field(52076; "Amount (LCY) stats."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount (LCY) stats.';
        }
        field(52077; "Cash Criteria Operation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cash Criteria Operation';
            Description = 'OTOOLS.002';
        }
        field(52078; "Reverse Charge"; Boolean)
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
        key(Key2; "Customer No.", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key3; "Document No.")
        {
        }
        key(Key4; "External Document No.")
        {
        }
        key(Key5; "Customer No.", Open, Positive, "Due Date", "Currency Code")
        {
        }
        key(Key6; Open, "Due Date")
        {
        }
        key(Key7; "Document Type", "Customer No.", "Posting Date", "Currency Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key8; "Salesperson Code", "Posting Date")
        {
        }
        key(Key9; "Closed by Entry No.")
        {
        }
        key(Key10; "Transaction No.")
        {
        }
        key(Key11; "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)", "Pmt. Disc. Given (LCY)";
        }
        key(Key12; "Customer No.", Open, "Global Dimension 1 Code", "Global Dimension 2 Code", Positive, "Due Date", "Currency Code")
        {
        }
        key(Key13; "Document Type", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
        {
        }
        key(Key14; "Customer No.", "Applies-to ID", Open, Positive, "Due Date")
        {
        }
        key(Key15; "Customer No.", Open, Positive, "Applies-to ID", "Due Date")
        {
        }
        key(Key16; "Customer No.", "Document Type", "Document Situation", "Document Status")
        {
            SumIndexFields = "Remaining Amount (LCY) stats.", "Amount (LCY) stats.";
        }
        key(Key17; "Document No.", "Bill No.")
        {
        }
        key(Key18; "Document No.", "Document Type", "Customer No.")
        {
        }
        key(Key19; "Applies-to ID", "Document Type", "Document Situation", "Document Status")
        {
        }
        key(Key20; "Document Type", "Customer No.", "Document Date", "Currency Code")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Customer No.", "Posting Date", "Document Type", "Document No.")
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
}
