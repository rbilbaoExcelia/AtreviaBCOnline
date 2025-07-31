xmlport 52009 "Partidas vivas clientes OLD"
{
    FieldDelimiter = '<Nono>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
    textelement(PartidasVivas)
    {
    tableelement("Cust. Ledger Entry";
    21)
    {
    XmlName = 'CustLedgEntry';

    fieldelement(EntryNo;
    "Cust. Ledger Entry"."Entry No.")
    {
    }
    fieldelement(CustNo;
    "Cust. Ledger Entry"."Customer No.")
    {
    }
    fieldelement(PostingDate;
    "Cust. Ledger Entry"."Posting Date")
    {
    }
    fieldelement(DocType;
    "Cust. Ledger Entry"."Document Type")
    {
    }
    fieldelement(DocNo;
    "Cust. Ledger Entry"."Document No.")
    {
    }
    fieldelement(Descr;
    "Cust. Ledger Entry".Description)
    {
    }
    fieldelement(CurrCode;
    "Cust. Ledger Entry"."Currency Code")
    {
    }
    textelement(amt)
    {
    XmlName = 'Imo';
    }
    textelement(remamt)
    {
    XmlName = 'RemImp';
    }
    fieldelement(OrImp;
    "Cust. Ledger Entry"."Original Amt. (LCY)")
    {
    }
    textelement(remamtlcy)
    {
    XmlName = 'RemImpDL';
    }
    textelement(amtlcy)
    {
    XmlName = 'ImpL';
    }
    fieldelement(Sales;
    "Cust. Ledger Entry"."Sales (LCY)")
    {
    }
    fieldelement(Profit;
    "Cust. Ledger Entry"."Profit (LCY)")
    {
    }
    fieldelement(InvDisc;
    "Cust. Ledger Entry"."Inv. Discount (LCY)")
    {
    }
    fieldelement(SellCust;
    "Cust. Ledger Entry"."Sell-to Customer No.")
    {
    }
    fieldelement(CPG;
    "Cust. Ledger Entry"."Customer Posting Group")
    {
    }
    fieldelement(Dim1;
    "Cust. Ledger Entry"."Global Dimension 1 Code")
    {
    }
    fieldelement(Dim2;
    "Cust. Ledger Entry"."Global Dimension 2 Code")
    {
    }
    fieldelement(SalesP;
    "Cust. Ledger Entry"."Salesperson Code")
    {
    }
    fieldelement(User;
    "Cust. Ledger Entry"."User ID")
    {
    }
    fieldelement(Source;
    "Cust. Ledger Entry"."Source Code")
    {
    }
    fieldelement(OnHold;
    "Cust. Ledger Entry"."On Hold")
    {
    }
    fieldelement(AplDocType;
    "Cust. Ledger Entry"."Applies-to Doc. Type")
    {
    }
    fieldelement(AplDocNo;
    "Cust. Ledger Entry"."Applies-to Doc. No.")
    {
    }
    fieldelement(Op;
    "Cust. Ledger Entry".Open)
    {
    }
    fieldelement(DueDate;
    "Cust. Ledger Entry"."Due Date")
    {
    }
    fieldelement(PmtDisc;
    "Cust. Ledger Entry"."Pmt. Discount Date")
    {
    }
    fieldelement(OrPmtDisc;
    "Cust. Ledger Entry"."Original Pmt. Disc. Possible")
    {
    }
    fieldelement(PmtDiscGiven;
    "Cust. Ledger Entry"."Pmt. Disc. Given (LCY)")
    {
    }
    fieldelement(Pos;
    "Cust. Ledger Entry".Positive)
    {
    }
    fieldelement(ClosedbyEntry;
    "Cust. Ledger Entry"."Closed by Entry No.")
    {
    }
    fieldelement(ClosedDate;
    "Cust. Ledger Entry"."Closed at Date")
    {
    }
    fieldelement(ClosedAmt;
    "Cust. Ledger Entry"."Closed by Amount")
    {
    }
    fieldelement(ApplesID;
    "Cust. Ledger Entry"."Applies-to ID")
    {
    }
    fieldelement(JnlBatch;
    "Cust. Ledger Entry"."Journal Batch Name")
    {
    }
    fieldelement(Reason;
    "Cust. Ledger Entry"."Reason Code")
    {
    }
    fieldelement(BalAccType;
    "Cust. Ledger Entry"."Bal. Account Type")
    {
    }
    fieldelement(BalAccNo;
    "Cust. Ledger Entry"."Bal. Account No.")
    {
    }
    fieldelement(Trans;
    "Cust. Ledger Entry"."Transaction No.")
    {
    }
    fieldelement(ClosedAmtLCY;
    "Cust. Ledger Entry"."Closed by Amount (LCY)")
    {
    }
    fieldelement(DebitAmt;
    "Cust. Ledger Entry"."Debit Amount")
    {
    }
    fieldelement(CreditAmt;
    "Cust. Ledger Entry"."Credit Amount")
    {
    }
    fieldelement(DebirAmtLCY;
    "Cust. Ledger Entry"."Debit Amount (LCY)")
    {
    }
    fieldelement(CreditAmtLCY;
    "Cust. Ledger Entry"."Credit Amount (LCY)")
    {
    }
    fieldelement(DocDate;
    "Cust. Ledger Entry"."Document Date")
    {
    }
    fieldelement(ExternalDoc;
    "Cust. Ledger Entry"."External Document No.")
    {
    }
    fieldelement(CalculateInt;
    "Cust. Ledger Entry"."Calculate Interest")
    {
    }
    fieldelement(ClosingInt;
    "Cust. Ledger Entry"."Closing Interest Calculated")
    {
    }
    fieldelement(NoSeries;
    "Cust. Ledger Entry"."No. Series")
    {
    }
    fieldelement(ClosedCurr;
    "Cust. Ledger Entry"."Closed by Currency Code")
    {
    }
    fieldelement(ClosedCurrAmt;
    "Cust. Ledger Entry"."Closed by Currency Amount")
    {
    }
    fieldelement(AdjCurr;
    "Cust. Ledger Entry"."Adjusted Currency Factor")
    {
    }
    fieldelement(OrigCurr;
    "Cust. Ledger Entry"."Original Currency Factor")
    {
    }
    fieldelement(OrigAmt;
    "Cust. Ledger Entry"."Original Amount")
    {
    }
    fieldelement(DateFilter;
    "Cust. Ledger Entry"."Date Filter")
    {
    }
    fieldelement(RemPmt;
    "Cust. Ledger Entry"."Remaining Pmt. Disc. Possible")
    {
    }
    fieldelement(PmtD;
    "Cust. Ledger Entry"."Pmt. Disc. Tolerance Date")
    {
    }
    fieldelement(MaxPmt;
    "Cust. Ledger Entry"."Max. Payment Tolerance")
    {
    }
    fieldelement(LastIssued;
    "Cust. Ledger Entry"."Last Issued Reminder Level")
    {
    }
    fieldelement(AcceptedPmt;
    "Cust. Ledger Entry"."Accepted Payment Tolerance")
    {
    }
    fieldelement(AcceptendPmtDisc;
    "Cust. Ledger Entry"."Accepted Pmt. Disc. Tolerance")
    {
    }
    fieldelement(PmtTol;
    "Cust. Ledger Entry"."Pmt. Tolerance (LCY)")
    {
    }
    textelement(dummy1)
    {
    XmlName = 'DummA';
    }
    textelement(dummy2)
    {
    XmlName = 'DummB';
    }
    textelement(dummy3)
    {
    XmlName = 'DummC';
    }
    textelement(dummy4)
    {
    XmlName = 'DummD';
    }
    fieldelement(ICPartner;
    "Cust. Ledger Entry"."IC Partner Code")
    {
    }
    fieldelement(ApplEntNo;
    "Cust. Ledger Entry"."Applying Entry")
    {
    }
    fieldelement(Rev;
    "Cust. Ledger Entry".Reversed)
    {
    }
    fieldelement(RevBy;
    "Cust. Ledger Entry"."Reversed by Entry No.")
    {
    }
    fieldelement(RevEnt;
    "Cust. Ledger Entry"."Reversed Entry No.")
    {
    }
    fieldelement(PrepPmt;
    "Cust. Ledger Entry".Prepayment)
    {
    }
    fieldelement(DirectDebit;
    "Cust. Ledger Entry"."Direct Debit Mandate ID")
    {
    }
    fieldelement(BillNo;
    "Cust. Ledger Entry"."Bill No.")
    {
    }
    fieldelement(DocSituation;
    "Cust. Ledger Entry"."Document Situation")
    {
    }
    fieldelement(AppBill;
    "Cust. Ledger Entry"."Applies-to Bill No.")
    {
    }
    fieldelement(DocStatus;
    "Cust. Ledger Entry"."Document Status")
    {
    }
    fieldelement(RemAmtStats;
    "Cust. Ledger Entry"."Remaining Amount (LCY) stats.")
    {
    }
    fieldelement(AmtLCYStats;
    "Cust. Ledger Entry"."Amount (LCY) stats.")
    {
    }
    textelement(dummy5)
    {
    XmlName = 'DummE';
    }
    textelement(dummy6)
    {
    XmlName = 'DummF';
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
}
