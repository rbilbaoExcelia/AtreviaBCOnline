xmlport 52005 "IMPORT Post Vend. Ledger Entry"
{
    Direction = Import;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
    textelement(root)
    {
    tableelement("Vend. Ledger Entry Historico";
    "Vend. Ledger Entry Historico")
    {
    XmlName = 'source';
    SourceTableView = SORTING("Entry No.");

    fieldelement(EntryNo;
    "Vend. Ledger Entry Historico"."Entry No.")
    {
    }
    fieldelement(VendorNo;
    "Vend. Ledger Entry Historico"."Vendor No.")
    {
    }
    fieldelement(PostingDate;
    "Vend. Ledger Entry Historico"."Posting Date")
    {
    }
    fieldelement(DocumentType;
    "Vend. Ledger Entry Historico"."Document Type")
    {
    }
    fieldelement(DocumentNo;
    "Vend. Ledger Entry Historico"."Document No.")
    {
    }
    fieldelement(Description;
    "Vend. Ledger Entry Historico".Description)
    {
    }
    fieldelement(CurrencyCode;
    "Vend. Ledger Entry Historico"."Currency Code")
    {
    }
    fieldelement(Amount;
    "Vend. Ledger Entry Historico".Amount)
    {
    }
    fieldelement(RemainingAmount;
    "Vend. Ledger Entry Historico"."Remaining Amount")
    {
    }
    fieldelement(OriginalAmtLCY;
    "Vend. Ledger Entry Historico"."Original Amt. (LCY)")
    {
    }
    fieldelement(RemainingAmtLCY;
    "Vend. Ledger Entry Historico"."Remaining Amt. (LCY)")
    {
    }
    fieldelement(AmountLCY;
    "Vend. Ledger Entry Historico"."Amount (LCY)")
    {
    }
    fieldelement(PurchaseLCY;
    "Vend. Ledger Entry Historico"."Purchase (LCY)")
    {
    }
    fieldelement(InvDiscountLCY;
    "Vend. Ledger Entry Historico"."Inv. Discount (LCY)")
    {
    }
    fieldelement(BuyfromVendorNo;
    "Vend. Ledger Entry Historico"."Buy-from Vendor No.")
    {
    }
    fieldelement(VendorPostingGroup;
    "Vend. Ledger Entry Historico"."Vendor Posting Group")
    {
    }
    fieldelement(GlobalDimension1Code;
    "Vend. Ledger Entry Historico"."Global Dimension 1 Code")
    {
    }
    fieldelement(GlobalDimension2Code;
    "Vend. Ledger Entry Historico"."Global Dimension 2 Code")
    {
    }
    fieldelement(PurchaserCode;
    "Vend. Ledger Entry Historico"."Purchaser Code")
    {
    }
    fieldelement(UserID;
    "Vend. Ledger Entry Historico"."User ID")
    {
    }
    fieldelement(SourceCode;
    "Vend. Ledger Entry Historico"."Source Code")
    {
    }
    fieldelement(OnHold;
    "Vend. Ledger Entry Historico"."On Hold")
    {
    }
    fieldelement(AppliestoDocType;
    "Vend. Ledger Entry Historico"."Applies-to Doc. Type")
    {
    }
    fieldelement(AppliestoDocNo;
    "Vend. Ledger Entry Historico"."Applies-to Doc. No.")
    {
    }
    fieldelement(Open;
    "Vend. Ledger Entry Historico".Open)
    {
    }
    fieldelement(DueDate;
    "Vend. Ledger Entry Historico"."Due Date")
    {
    }
    fieldelement(PmtDiscountDate;
    "Vend. Ledger Entry Historico"."Pmt. Discount Date")
    {
    }
    fieldelement(OriginalPmtDiscPossible;
    "Vend. Ledger Entry Historico"."Original Pmt. Disc. Possible")
    {
    }
    fieldelement(PmtDiscRcdLCY;
    "Vend. Ledger Entry Historico"."Pmt. Disc. Rcd.(LCY)")
    {
    }
    fieldelement(Positive;
    "Vend. Ledger Entry Historico".Positive)
    {
    }
    fieldelement(ClosedbyEntryNo;
    "Vend. Ledger Entry Historico"."Closed by Entry No.")
    {
    }
    fieldelement(ClosedatDate;
    "Vend. Ledger Entry Historico"."Closed at Date")
    {
    }
    fieldelement(ClosedbyAmount;
    "Vend. Ledger Entry Historico"."Closed by Amount")
    {
    }
    fieldelement(AppliestoID;
    "Vend. Ledger Entry Historico"."Applies-to ID")
    {
    }
    fieldelement(JournalBatchName;
    "Vend. Ledger Entry Historico"."Journal Batch Name")
    {
    }
    fieldelement(ReasonCode;
    "Vend. Ledger Entry Historico"."Reason Code")
    {
    }
    fieldelement(BalAccountType;
    "Vend. Ledger Entry Historico"."Bal. Account Type")
    {
    }
    fieldelement(BalAccountNo;
    "Vend. Ledger Entry Historico"."Bal. Account No.")
    {
    }
    fieldelement(TransactionNo;
    "Vend. Ledger Entry Historico"."Transaction No.")
    {
    }
    fieldelement(ClosedbyAmountLCY;
    "Vend. Ledger Entry Historico"."Closed by Amount (LCY)")
    {
    }
    fieldelement(DebitAmount;
    "Vend. Ledger Entry Historico"."Debit Amount")
    {
    }
    fieldelement(CreditAmount;
    "Vend. Ledger Entry Historico"."Credit Amount")
    {
    }
    fieldelement(DebitAmountLCY;
    "Vend. Ledger Entry Historico"."Debit Amount (LCY)")
    {
    }
    fieldelement(CreditAmountLCY;
    "Vend. Ledger Entry Historico"."Credit Amount (LCY)")
    {
    }
    fieldelement(DocumentDate;
    "Vend. Ledger Entry Historico"."Document Date")
    {
    }
    fieldelement(ExternalDocumentNo;
    "Vend. Ledger Entry Historico"."External Document No.")
    {
    }
    fieldelement(NoSeries;
    "Vend. Ledger Entry Historico"."No. Series")
    {
    }
    fieldelement(ClosedbyCurrencyCode;
    "Vend. Ledger Entry Historico"."Closed by Currency Code")
    {
    }
    fieldelement(ClosedbyCurrencyAmount;
    "Vend. Ledger Entry Historico"."Closed by Currency Amount")
    {
    }
    fieldelement(AdjustedCurrencyFactor;
    "Vend. Ledger Entry Historico"."Adjusted Currency Factor")
    {
    }
    fieldelement(OriginalCurrencyFactor;
    "Vend. Ledger Entry Historico"."Original Currency Factor")
    {
    }
    fieldelement(OriginalAmount;
    "Vend. Ledger Entry Historico"."Original Amount")
    {
    }
    fieldelement(DateFilter;
    "Vend. Ledger Entry Historico"."Date Filter")
    {
    }
    fieldelement(RemainingPmtDiscPossible;
    "Vend. Ledger Entry Historico"."Remaining Pmt. Disc. Possible")
    {
    }
    fieldelement(PmtDiscToleranceDate;
    "Vend. Ledger Entry Historico"."Pmt. Disc. Tolerance Date")
    {
    }
    fieldelement(MaxPaymentTolerance;
    "Vend. Ledger Entry Historico"."Max. Payment Tolerance")
    {
    }
    fieldelement(AcceptedPaymentTolerance;
    "Vend. Ledger Entry Historico"."Accepted Payment Tolerance")
    {
    }
    fieldelement(AcceptedPmtDiscTolerance;
    "Vend. Ledger Entry Historico"."Accepted Pmt. Disc. Tolerance")
    {
    }
    fieldelement(PmtToleranceLCY;
    "Vend. Ledger Entry Historico"."Pmt. Tolerance (LCY)")
    {
    }
    fieldelement(GeneratedAutodocument;
    "Vend. Ledger Entry Historico"."Generated Autodocument")
    {
    }
    fieldelement(AutodocumentNo;
    "Vend. Ledger Entry Historico"."Autodocument No.")
    {
    }
    fieldelement(CashEntry;
    "Vend. Ledger Entry Historico"."Cash Entry")
    {
    }
    fieldelement(Spetialoperationtype;
    "Vend. Ledger Entry Historico"."Spetial operation type")
    {
    }
    fieldelement(SpetialOperationCode;
    "Vend. Ledger Entry Historico"."Spetial Operation Code")
    {
    }
    fieldelement(Exclude347;
    "Vend. Ledger Entry Historico"."Exclude 347")
    {
    }
    fieldelement(Reversed;
    "Vend. Ledger Entry Historico".Reversed)
    {
    }
    fieldelement(ReversedbyEntryNo;
    "Vend. Ledger Entry Historico"."Reversed by Entry No.")
    {
    }
    fieldelement(ReversedEntryNo;
    "Vend. Ledger Entry Historico"."Reversed Entry No.")
    {
    }
    fieldelement(BillNo;
    "Vend. Ledger Entry Historico"."Bill No.")
    {
    }
    fieldelement(DocumentSituation;
    "Vend. Ledger Entry Historico"."Document Situation")
    {
    }
    fieldelement(AppliestoBillNo;
    "Vend. Ledger Entry Historico"."Applies-to Bill No.")
    {
    }
    fieldelement(DocumentStatus;
    "Vend. Ledger Entry Historico"."Document Status")
    {
    }
    fieldelement(RemainingAmountLCYstats;
    "Vend. Ledger Entry Historico"."Remaining Amount (LCY) stats.")
    {
    }
    fieldelement(AmountLCYstats;
    "Vend. Ledger Entry Historico"."Amount (LCY) stats.")
    {
    }
    fieldelement(CashCriteriaOperation;
    "Vend. Ledger Entry Historico"."Cash Criteria Operation")
    {
    }
    fieldelement(ReverseCharge;
    "Vend. Ledger Entry Historico"."Reverse Charge")
    {
    }
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    trigger OnPostXmlPort()
    begin
        MESSAGE('Finalizado');
    end;
}
