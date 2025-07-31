xmlport 52004 "IMPORT PostCust. Ledger Entry"
{
    Direction = Import;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
    textelement(root)
    {
    tableelement("Cust. Ledger Entry Historico";
    "Cust. Ledger Entry Historico")
    {
    XmlName = 'source';
    SourceTableView = SORTING("Entry No.");

    fieldelement(EntryNo;
    "Cust. Ledger Entry Historico"."Entry No.")
    {
    }
    fieldelement(CustomerNo;
    "Cust. Ledger Entry Historico"."Customer No.")
    {
    }
    fieldelement(PostingDate;
    "Cust. Ledger Entry Historico"."Posting Date")
    {
    }
    fieldelement(DocumentType;
    "Cust. Ledger Entry Historico"."Document Type")
    {
    }
    fieldelement(DocumentNo;
    "Cust. Ledger Entry Historico"."Document No.")
    {
    }
    fieldelement(Description;
    "Cust. Ledger Entry Historico".Description)
    {
    }
    fieldelement(CurrencyCode;
    "Cust. Ledger Entry Historico"."Currency Code")
    {
    }
    fieldelement(Amount;
    "Cust. Ledger Entry Historico".Amount)
    {
    }
    fieldelement(RemainingAmount;
    "Cust. Ledger Entry Historico"."Remaining Amount")
    {
    }
    fieldelement(OriginalAmtLCY;
    "Cust. Ledger Entry Historico"."Original Amt. (LCY)")
    {
    }
    fieldelement(RemainingAmtLCY;
    "Cust. Ledger Entry Historico"."Remaining Amt. (LCY)")
    {
    }
    fieldelement(AmountLCY;
    "Cust. Ledger Entry Historico"."Amount (LCY)")
    {
    }
    fieldelement(SalesLCY;
    "Cust. Ledger Entry Historico"."Sales (LCY)")
    {
    }
    fieldelement(ProfitLCY;
    "Cust. Ledger Entry Historico"."Profit (LCY)")
    {
    }
    fieldelement(InvDiscountLCY;
    "Cust. Ledger Entry Historico"."Inv. Discount (LCY)")
    {
    }
    fieldelement(SelltoCustomerNo;
    "Cust. Ledger Entry Historico"."Sell-to Customer No.")
    {
    }
    fieldelement(CustomerPostingGroup;
    "Cust. Ledger Entry Historico"."Customer Posting Group")
    {
    }
    fieldelement(GlobalDimension1Code;
    "Cust. Ledger Entry Historico"."Global Dimension 1 Code")
    {
    }
    fieldelement(GlobalDimension2Code;
    "Cust. Ledger Entry Historico"."Global Dimension 2 Code")
    {
    }
    fieldelement(SalespersonCode;
    "Cust. Ledger Entry Historico"."Salesperson Code")
    {
    }
    fieldelement(UserID;
    "Cust. Ledger Entry Historico"."User ID")
    {
    }
    fieldelement(SourceCode;
    "Cust. Ledger Entry Historico"."Source Code")
    {
    }
    fieldelement(OnHold;
    "Cust. Ledger Entry Historico"."On Hold")
    {
    }
    fieldelement(AppliestoDocType;
    "Cust. Ledger Entry Historico"."Applies-to Doc. Type")
    {
    }
    fieldelement(AppliestoDocNo;
    "Cust. Ledger Entry Historico"."Applies-to Doc. No.")
    {
    }
    fieldelement(Open;
    "Cust. Ledger Entry Historico".Open)
    {
    }
    fieldelement(DueDate;
    "Cust. Ledger Entry Historico"."Due Date")
    {
    }
    fieldelement(PmtDiscountDate;
    "Cust. Ledger Entry Historico"."Pmt. Discount Date")
    {
    }
    fieldelement(OriginalPmtDiscPossible;
    "Cust. Ledger Entry Historico"."Original Pmt. Disc. Possible")
    {
    }
    fieldelement(PmtDiscGivenLCY;
    "Cust. Ledger Entry Historico"."Pmt. Disc. Given (LCY)")
    {
    }
    fieldelement(Positive;
    "Cust. Ledger Entry Historico".Positive)
    {
    }
    fieldelement(ClosedbyEntryNo;
    "Cust. Ledger Entry Historico"."Closed by Entry No.")
    {
    }
    fieldelement(ClosedatDate;
    "Cust. Ledger Entry Historico"."Closed at Date")
    {
    }
    fieldelement(ClosedbyAmount;
    "Cust. Ledger Entry Historico"."Closed by Amount")
    {
    }
    fieldelement(AppliestoID;
    "Cust. Ledger Entry Historico"."Applies-to ID")
    {
    }
    fieldelement(JournalBatchName;
    "Cust. Ledger Entry Historico"."Journal Batch Name")
    {
    }
    fieldelement(ReasonCode;
    "Cust. Ledger Entry Historico"."Reason Code")
    {
    }
    fieldelement(BalAccountType;
    "Cust. Ledger Entry Historico"."Bal. Account Type")
    {
    }
    fieldelement(BalAccountNo;
    "Cust. Ledger Entry Historico"."Bal. Account No.")
    {
    }
    fieldelement(TransactionNo;
    "Cust. Ledger Entry Historico"."Transaction No.")
    {
    }
    fieldelement(ClosedbyAmountLCY;
    "Cust. Ledger Entry Historico"."Closed by Amount (LCY)")
    {
    }
    fieldelement(DebitAmount;
    "Cust. Ledger Entry Historico"."Debit Amount")
    {
    }
    fieldelement(CreditAmount;
    "Cust. Ledger Entry Historico"."Credit Amount")
    {
    }
    fieldelement(DebitAmountLCY;
    "Cust. Ledger Entry Historico"."Debit Amount (LCY)")
    {
    }
    fieldelement(CreditAmountLCY;
    "Cust. Ledger Entry Historico"."Credit Amount (LCY)")
    {
    }
    fieldelement(DocumentDate;
    "Cust. Ledger Entry Historico"."Document Date")
    {
    }
    fieldelement(ExternalDocumentNo;
    "Cust. Ledger Entry Historico"."External Document No.")
    {
    }
    fieldelement(CalculateInterest;
    "Cust. Ledger Entry Historico"."Calculate Interest")
    {
    }
    fieldelement(ClosingInterestCalculated;
    "Cust. Ledger Entry Historico"."Closing Interest Calculated")
    {
    }
    fieldelement(NoSeries;
    "Cust. Ledger Entry Historico"."No. Series")
    {
    }
    fieldelement(ClosedbyCurrencyCode;
    "Cust. Ledger Entry Historico"."Closed by Currency Code")
    {
    }
    fieldelement(ClosedbyCurrencyAmount;
    "Cust. Ledger Entry Historico"."Closed by Currency Amount")
    {
    }
    fieldelement(AdjustedCurrencyFactor;
    "Cust. Ledger Entry Historico"."Adjusted Currency Factor")
    {
    }
    fieldelement(OriginalCurrencyFactor;
    "Cust. Ledger Entry Historico"."Original Currency Factor")
    {
    }
    fieldelement(OriginalAmount;
    "Cust. Ledger Entry Historico"."Original Amount")
    {
    }
    fieldelement(DateFilter;
    "Cust. Ledger Entry Historico"."Date Filter")
    {
    }
    fieldelement(RemainingPmtDiscPossible;
    "Cust. Ledger Entry Historico"."Remaining Pmt. Disc. Possible")
    {
    }
    fieldelement(PmtDiscToleranceDate;
    "Cust. Ledger Entry Historico"."Pmt. Disc. Tolerance Date")
    {
    }
    fieldelement(MaxPaymentTolerance;
    "Cust. Ledger Entry Historico"."Max. Payment Tolerance")
    {
    }
    fieldelement(LastIssuedReminderLevel;
    "Cust. Ledger Entry Historico"."Last Issued Reminder Level")
    {
    }
    fieldelement(AcceptedPaymentTolerance;
    "Cust. Ledger Entry Historico"."Accepted Payment Tolerance")
    {
    }
    fieldelement(AcceptedPmtDiscTolerance;
    "Cust. Ledger Entry Historico"."Accepted Pmt. Disc. Tolerance")
    {
    }
    fieldelement(PmtToleranceLCY;
    "Cust. Ledger Entry Historico"."Pmt. Tolerance (LCY)")
    {
    }
    fieldelement(CashEntry;
    "Cust. Ledger Entry Historico"."Cash Entry")
    {
    }
    fieldelement(Spetialoperationtype;
    "Cust. Ledger Entry Historico"."Spetial operation type")
    {
    }
    fieldelement(SpetialOperationCode;
    "Cust. Ledger Entry Historico"."Spetial Operation Code")
    {
    }
    fieldelement(Exclude347;
    "Cust. Ledger Entry Historico"."Exclude 347")
    {
    }
    fieldelement(ICPartnerCode;
    "Cust. Ledger Entry Historico"."IC Partner Code")
    {
    }
    fieldelement(ApplyingEntry;
    "Cust. Ledger Entry Historico"."Applying Entry")
    {
    }
    fieldelement(Reversed;
    "Cust. Ledger Entry Historico".Reversed)
    {
    }
    fieldelement(ReversedbyEntryNo;
    "Cust. Ledger Entry Historico"."Reversed by Entry No.")
    {
    }
    fieldelement(ReversedEntryNo;
    "Cust. Ledger Entry Historico"."Reversed Entry No.")
    {
    }
    fieldelement(Prepayment;
    "Cust. Ledger Entry Historico".Prepayment)
    {
    }
    fieldelement(DirectDebitMandateID;
    "Cust. Ledger Entry Historico"."Direct Debit Mandate ID")
    {
    }
    fieldelement(BillNo;
    "Cust. Ledger Entry Historico"."Bill No.")
    {
    }
    fieldelement(DocumentSituation;
    "Cust. Ledger Entry Historico"."Document Situation")
    {
    }
    fieldelement(AppliestoBillNo;
    "Cust. Ledger Entry Historico"."Applies-to Bill No.")
    {
    }
    fieldelement(DocumentStatus;
    "Cust. Ledger Entry Historico"."Document Status")
    {
    }
    fieldelement(RemainingAmountLCYstats;
    "Cust. Ledger Entry Historico"."Remaining Amount (LCY) stats.")
    {
    }
    fieldelement(AmountLCYstats;
    "Cust. Ledger Entry Historico"."Amount (LCY) stats.")
    {
    }
    fieldelement(CashCriteriaOperation;
    "Cust. Ledger Entry Historico"."Cash Criteria Operation")
    {
    }
    fieldelement(ReverseCharge;
    "Cust. Ledger Entry Historico"."Reverse Charge")
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
