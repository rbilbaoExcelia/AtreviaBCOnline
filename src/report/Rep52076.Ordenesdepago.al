report 52076 "Ordenes de pago"
{
    // 140 OS.RM 25/05/2017 Modificaciones report
    //       - Modificaciones en layout.
    //       - Se añade error si proveedor no tiene IBAN informado.
    // 123 OS.RM 24/07/2017 Modificació del report.
    //       - Documentos "External Documento No.".
    DefaultLayout = RDLC;
    RDLCLayout = '././src/report/layouts/Ordenes de pago.rdlc';
    Caption = 'Payment Order - Test';

    dataset
    {
        dataitem(PmtOrd; "Payment Order")
        {
            RequestFilterFields = "No.";

            column(PmtOrd_No_; "No.")
            {
            }
            column(PmtOrd_Bank_Account_No_; "Bank Account No.")
            {
            }
            column(PmtOrd_Currency_Code; "Currency Code")
            {
            }
            dataitem(PageCounter; Integer)
            {
                DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                column(USERID; USERID)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(PmtOrd_TABLECAPTION__________PmtOrdFilter; PmtOrd.TABLECAPTION + ':' + PmtOrdFilter)
                {
                }
                column(PmtOrd_TABLECAPTION_________PmtOrd__No__; PmtOrd.TABLECAPTION + ' ' + PmtOrd."No.")
                {
                }
                column(BankAccAddr_1_; BankAccAddr[1])
                {
                }
                column(BankAccAddr_2_; BankAccAddr[2])
                {
                }
                column(BankAccAddr_3_; BankAccAddr[3])
                {
                }
                column(BankAccAddr_4_; BankAccAddr[4])
                {
                }
                column(BankAccAddr_5_; BankAccAddr[5])
                {
                }
                column(BankAccAddr_6_; BankAccAddr[6])
                {
                }
                column(BankAccAddr_7_; BankAccAddr[7])
                {
                }
                column(PmtOrd__Bank_Account_Name_; PmtOrd."Bank Account Name")
                {
                }
                column(Posting_Date; FORMAT(PmtOrd."Posting Date"))
                {
                }
                column(PmtOrd__Posting_Description_; PmtOrd."Posting Description")
                {
                }
                column(PostingGroup; PostingGroup)
                {
                }
                column(PmtOrd__Currency_Code_; PmtOrd."Currency Code")
                {
                }
                column(PageCounter_Number; Number)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Payment_Order___TestCaption; Payment_Order___TestCaptionLbl)
                {
                }
                column(PmtOrd__Bank_Account_Name_Caption; PmtOrd__Bank_Account_Name_CaptionLbl)
                {
                }
                column(PmtOrd__Posting_Date_Caption; PmtOrd__Posting_Date_CaptionLbl)
                {
                }
                column(PmtOrd__Posting_Description_Caption; PmtOrd__Posting_Description_CaptionLbl)
                {
                }
                column(PostingGroupCaption; PostingGroupCaptionLbl)
                {
                }
                column(PmtOrd__Currency_Code_Caption; PmtOrd__Currency_Code_CaptionLbl)
                {
                }
                dataitem(HeaderErrorCounter; Integer)
                {
                    DataItemTableView = SORTING(Number);

                    column(ErrorText_Number_; ErrorText[Number])
                    {
                    }
                    column(HeaderErrorCounter_Number; Number)
                    {
                    }
                    column(ErrorText_Number_Caption; ErrorText_Number_CaptionLbl)
                    {
                    }
                    trigger OnPostDataItem()
                    begin
                        ErrorCounter:=0;
                    end;
                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, ErrorCounter);
                    end;
                }
                dataitem(Doc; "Cartera Doc.")
                {
                    DataItemLink = "Bill Gr./Pmt. Order No."=FIELD("No.");
                    DataItemLinkReference = PmtOrd;
                    DataItemTableView = SORTING(Type, "Collection Agent", "Bill Gr./Pmt. Order No.")WHERE("Collection Agent"=CONST(Bank), Type=CONST(Payable));

                    column(Doc__Remaining_Amount_; "Remaining Amount")
                    {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    }
                    column(Vend_City; Vend.City)
                    {
                    }
                    column(Vend_County; Vend.County)
                    {
                    }
                    column(Vend__Post_Code_; Vend."Post Code")
                    {
                    }
                    column(Vend_Name; Vend.Name)
                    {
                    }
                    column(Vend_Iban; Vend.IBAN)
                    {
                    }
                    column(Doc__Account_No__; "Account No.")
                    {
                    }
                    column(Doc__Document_No__; "Document No." + VendorInvNo)
                    {
                    }
                    column(Doc__Due_Date_; FORMAT("Due Date"))
                    {
                    }
                    column(Doc__Document_Type_; "Document Type")
                    {
                    }
                    column(DocumentTypeBill; "Document Type" = "Document Type"::Bill)
                    {
                    }
                    column(DocumentTypeInvoice; "Document Type" = "Document Type"::Invoice)
                    {
                    }
                    column(Doc__Due_Date__Control44; FORMAT("Due Date"))
                    {
                    }
                    column(Doc__Document_No___Control46; "Document No.")
                    {
                    }
                    column(Doc__No__; "No.")
                    {
                    }
                    column(Doc__Account_No___Control50; "Account No.")
                    {
                    }
                    column(Vend_Name_Control52; Vend.Name)
                    {
                    }
                    column(Vend__Post_Code__Control53; Vend."Post Code")
                    {
                    }
                    column(Vend_City_Control54; Vend.City)
                    {
                    }
                    column(Vend_County_Control55; Vend.County)
                    {
                    }
                    column(Doc__Remaining_Amount__Control35; "Remaining Amount")
                    {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    }
                    column(Doc__Document_Type__Control26; "Document Type")
                    {
                    }
                    column(Doc_Type; Type)
                    {
                    }
                    column(Doc_Entry_No_; "Entry No.")
                    {
                    }
                    column(Doc_Bill_Gr__Pmt__Order_No_; "Bill Gr./Pmt. Order No.")
                    {
                    }
                    column(Vend_Name_Control52Caption; Vend_Name_Control52CaptionLbl)
                    {
                    }
                    column(Post_CodeCaption; Post_CodeCaptionLbl)
                    {
                    }
                    column(City__Caption; City__CaptionLbl)
                    {
                    }
                    column(CountyCaption; CountyCaptionLbl)
                    {
                    }
                    column(Doc__Due_Date__Control44Caption; Doc__Due_Date__Control44CaptionLbl)
                    {
                    }
                    column(Doc__Document_No___Control46Caption; FIELDCAPTION("Document No."))
                    {
                    }
                    column(Doc__No__Caption; Doc__No__CaptionLbl)
                    {
                    }
                    column(Vendor_No_Caption; Vendor_No_CaptionLbl)
                    {
                    }
                    column(Doc__Remaining_Amount__Control35Caption; FIELDCAPTION("Remaining Amount"))
                    {
                    }
                    column(Doc__Document_Type__Control26Caption; FIELDCAPTION("Document Type"))
                    {
                    }
                    dataitem(LineErrorCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        column(ErrorText_Number__Control56; ErrorText[Number])
                        {
                        }
                        column(LineErrorCounter_Number; Number)
                        {
                        }
                        column(ErrorText_Number__Control56Caption; ErrorText_Number__Control56CaptionLbl)
                        {
                        }
                        trigger OnPostDataItem()
                        begin
                            ErrorCounter:=0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, ErrorCounter);
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        Vend.GET("Account No.");
                        Vend.CALCFIELDS(Vend.IBAN);
                        //<140
                        IF Vend.IBAN = '' THEN ERROR(STRSUBSTNO(Error001, Vend."No."));
                        //140>
                        DocCount:=DocCount + 1;
                        IF "Collection Agent" <> "Collection Agent"::Bank THEN AddError(STRSUBSTNO(Text1100007, FIELDCAPTION("Collection Agent"), "Collection Agent"::Bank));
                        IF "Currency Code" <> PmtOrd."Currency Code" THEN AddError(STRSUBSTNO(Text1100008, FIELDCAPTION("Currency Code"), PmtOrd."Currency Code"));
                        IF "Remaining Amt. (LCY)" = 0 THEN AddError(STRSUBSTNO(Text1100009, FIELDCAPTION("Remaining Amt. (LCY)")));
                        IF Type <> Type::Payable THEN AddError(STRSUBSTNO(Text1100008, FIELDCAPTION(Type), Type::Receivable));
                        IF Accepted = Accepted::No THEN AddError(STRSUBSTNO(Text1100010, FIELDCAPTION(Accepted), FALSE));
                        VendLedgEntry.GET("Entry No.");
                        VendPostingGr.GET(VendLedgEntry."Vendor Posting Group");
                        IF "Document Type" = "Document Type"::Bill THEN BEGIN
                            IF VendPostingGr."Bills in Payment Order Acc." = '' THEN AddError(STRSUBSTNO(Text1100011, VendPostingGr.FIELDCAPTION("Bills in Payment Order Acc."), VendPostingGr.TABLECAPTION, VendPostingGr.Code));
                            AccountNo:=VendPostingGr."Bills in Payment Order Acc.";
                        END
                        ELSE
                        BEGIN
                            IF VendPostingGr."Invoices in  Pmt. Ord. Acc." = '' THEN AddError(STRSUBSTNO(Text1100011, VendPostingGr.FIELDCAPTION("Invoices in  Pmt. Ord. Acc."), VendPostingGr.TABLECAPTION, VendPostingGr.Code));
                            AccountNo:=VendPostingGr."Invoices in  Pmt. Ord. Acc.";
                        END;
                        NoOfDays:="Due Date" - PmtOrd."Posting Date";
                        IF NoOfDays < 0 THEN NoOfDays:=0;
                        IF CalcExpenses THEN FeeRange.CalcPmtOrdCollExpensesAmt(BankAcc2."Operation Fees Code", BankAcc2."Currency Code", "Remaining Amount", "Entry No.");
                        IF CheckOtherBanks THEN BEGIN
                            IF DocPostBuffer.FIND('+')THEN;
                            DocPostBuffer."Entry No.":=DocPostBuffer."Entry No." + 1;
                            DocPostBuffer."No. of Days":=NoOfDays;
                            DocPostBuffer.Amount:="Remaining Amt. (LCY)";
                            DocPostBuffer.INSERT;
                        END;
                        IF VendPostingGr."Bills Account" = '' THEN AddError(STRSUBSTNO(Text1100011, VendPostingGr.FIELDCAPTION("Bills Account"), VendPostingGr.TABLECAPTION, VendPostingGr.Code));
                        BalanceAccNo:=VendPostingGr."Bills Account";
                        IF BGPOPostBuffer.GET(AccountNo, BalanceAccNo)THEN BEGIN
                            BGPOPostBuffer.Amount:=BGPOPostBuffer.Amount + "Remaining Amount";
                            BGPOPostBuffer.MODIFY;
                        END
                        ELSE
                        BEGIN
                            BGPOPostBuffer.Account:=AccountNo;
                            BGPOPostBuffer."Balance Account":=BalanceAccNo;
                            BGPOPostBuffer.Amount:="Remaining Amount";
                            BGPOPostBuffer.INSERT;
                        END;
                        //<123
                        CLEAR(VendorInvNo);
                        IF NOT PurchInvHe.GET(Doc."Document No.")THEN BEGIN
                            CLEAR(PurchInvHe);
                            IF VendorLedgerEntry.GET(Doc."Entry No.")THEN VendorInvNo:=' | ' + VendorLedgerEntry."External Document No.";
                        END
                        ELSE
                        BEGIN
                            IF PurchInvHe."Vendor Invoice No." <> '' THEN VendorInvNo:=' | ' + PurchInvHe."Vendor Invoice No." END;
                    //123>
                    end;
                    trigger OnPreDataItem()
                    begin
                        CLEAR(DocPostBuffer);
                        IF CalcExpenses THEN FeeRange.InitPmtOrdCollExpenses(BankAcc2."Operation Fees Code", BankAcc2."Currency Code");
                        DocCount:=0;
                    end;
                }
                dataitem(Total; Integer)
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(DocCount; DocCount)
                    {
                    }
                    column(PmtOrd_Amount; PmtOrd.Amount)
                    {
                    AutoFormatExpression = PmtOrd."Currency Code";
                    AutoFormatType = 1;
                    }
                    column(Total_Number; Number)
                    {
                    }
                    column(No__of_DocumentsCaption; No__of_DocumentsCaptionLbl)
                    {
                    }
                    column(TotalCaption; TotalCaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        PmtOrd.CALCFIELDS(Amount);
                    end;
                }
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                column(Integer_Number; Number)
                {
                }
                column(FeeRange_GetTotalPmtOrdCollExpensesAmt_Control89Caption; FeeRange_GetTotalPmtOrdCollExpensesAmt_Control89CaptionLbl)
                {
                }
                column(Payment_Order_Expenses_Amt_Caption; Payment_Order_Expenses_Amt_CaptionLbl)
                {
                }
                column(BankAcc__No__Caption; BankAcc__No__CaptionLbl)
                {
                }
                dataitem(BillGrBankAcc; "Bank Account")
                {
                    DataItemLink = "No."=FIELD("Bank Account No.");
                    DataItemLinkReference = PmtOrd;
                    DataItemTableView = SORTING("No.");

                    column(FeeRange_GetTotalPmtOrdCollExpensesAmt; FeeRange.GetTotalPmtOrdCollExpensesAmt)
                    {
                    AutoFormatExpression = PmtOrd."Currency Code";
                    AutoFormatType = 1;
                    }
                    column(FeeRange_GetTotalPmtOrdCollExpensesAmt_Control92; FeeRange.GetTotalPmtOrdCollExpensesAmt)
                    {
                    AutoFormatExpression = PmtOrd."Currency Code";
                    AutoFormatType = 1;
                    }
                    column(BillGrBankAcc__No__; "No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        CALCFIELDS("Posted Receiv. Bills Rmg. Amt.");
                        RiskIncGr:="Posted Receiv. Bills Rmg. Amt.";
                        IF NOT CalcExpenses THEN CurrReport.BREAK;
                    end;
                }
                dataitem(BankAcc; "Bank Account")
                {
                    DataItemLink = "Currency Code"=FIELD("Currency Code");
                    DataItemLinkReference = PmtOrd;
                    DataItemTableView = SORTING("No.");
                    RequestFilterFields = "No.";

                    column(FeeRange_GetTotalPmtOrdCollExpensesAmt_Control88; FeeRange.GetTotalPmtOrdCollExpensesAmt)
                    {
                    AutoFormatExpression = PmtOrd."Currency Code";
                    AutoFormatType = 1;
                    }
                    column(FeeRange_GetTotalPmtOrdCollExpensesAmt_Control89; FeeRange.GetTotalPmtOrdCollExpensesAmt)
                    {
                    AutoFormatExpression = PmtOrd."Currency Code";
                    AutoFormatType = 1;
                    }
                    column(BankAcc__No__; "No.")
                    {
                    }
                    column(BankAcc_Currency_Code; "Currency Code")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF "No." = PmtOrd."Bank Account No." THEN CurrReport.SKIP;
                        CALCFIELDS("Posted Receiv. Bills Rmg. Amt.");
                        RiskIncGr:="Posted Receiv. Bills Rmg. Amt.";
                        IF NOT DocPostBuffer.FIND('-')THEN CurrReport.SKIP;
                        CLEAR(FeeRange);
                        IF NOT FeeRange.FIND('=<>')THEN CurrReport.SKIP;
                        FeeRange.InitCollExpenses("Operation Fees Code", "Currency Code");
                        REPEAT FeeRange.CalcCollExpensesAmt("Operation Fees Code", "Currency Code", DocPostBuffer.Amount, DocPostBuffer."Entry No.");
                        UNTIL DocPostBuffer.NEXT = 0;
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                CLEAR(BankAcc2);
                CLEAR(PostingGroup);
                CLEAR(CalcExpenses);
                IF BankAcc2.GET(PmtOrd."Bank Account No.")THEN BEGIN
                    IF BankAcc2."Currency Code" <> PmtOrd."Currency Code" THEN AddError(STRSUBSTNO(Text1100000, BankAcc2.FIELDCAPTION("Currency Code"), PmtOrd."Currency Code", BankAcc2.TABLECAPTION, BankAcc2."No."));
                    IF BankAcc2."Operation Fees Code" = '' THEN AddError(STRSUBSTNO(Text1100001, BankAcc2.FIELDCAPTION("Operation Fees Code"), BankAcc2.TABLECAPTION, BankAcc2."No."));
                    IF PmtOrd."Posting Date" <> 0D THEN CalcExpenses:=TRUE;
                    FormatAddress.FormatAddr(BankAccAddr, BankAcc2.Name, BankAcc2."Name 2", '', BankAcc2.Address, BankAcc2."Address 2", BankAcc2.City, BankAcc2."Post Code", BankAcc2.County, BankAcc2."Country/Region Code");
                    PostingGroup:=BankAcc2."Bank Acc. Posting Group";
                    CompanyIsBlocked:=BankAcc2.Blocked;
                    PmtOrd."Bank Account Name":=BankAcc2.Name;
                END;
                IF "Bank Account No." = '' THEN AddError(STRSUBSTNO(Text1100002, FIELDCAPTION("Bank Account No.")))
                ELSE IF PostingGroup = '' THEN AddError(STRSUBSTNO(Text1100003, BankAcc2.TABLECAPTION, "Bank Account No.", BankAcc2.FIELDCAPTION("Bank Acc. Posting Group")));
                IF "Posting Date" = 0D THEN AddError(STRSUBSTNO(Text1100002, FIELDCAPTION("Posting Date")));
                IF "No. Printed" = 0 THEN AddError(Text1100004);
                IF CompanyIsBlocked THEN AddError(STRSUBSTNO(Text1100005, BankAcc2.TABLECAPTION, "Bank Account No."));
                Doc.RESET;
                Doc.SETCURRENTKEY(Type, "Collection Agent", "Bill Gr./Pmt. Order No.");
                Doc.SETRANGE(Type, Doc.Type::Payable);
                Doc.SETRANGE("Collection Agent", Doc."Collection Agent"::Bank);
                Doc.SETRANGE("Bill Gr./Pmt. Order No.", "No.");
                IF NOT Doc.FIND('-')THEN AddError(Text1100006);
            end;
            trigger OnPreDataItem()
            begin
                IF BankAccNoFilter <> '' THEN BEGIN
                    SETCURRENTKEY("Bank Account No.");
                    SETRANGE("Bank Account No.", BankAccNoFilter);
                END;
            end;
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
    labels
    {
    }
    trigger OnPreReport()
    begin
        PmtOrdFilter:=PmtOrd.GETFILTERS;
        CheckOtherBanks:=BankAcc.GETFILTER("No.") <> '';
        BankAccNoFilter:=BankAcc.GETFILTER("No.");
    end;
    var Text1100000: Label '%1 must be %2 in %3 %4.';
    Text1100001: Label '%1 must be specified in %2 %3.';
    Text1100002: Label '%1 must be specified.';
    Text1100003: Label '%1 %2 has no %3.';
    Text1100004: Label 'The payment order has not been printed.';
    Text1100005: Label '%1 %2 is blocked.';
    Text1100006: Label 'The payment order is empty.';
    Text1100007: Label '%1 should be %2.';
    Text1100008: Label '%1 must be %2.';
    Text1100009: Label '%1 must not be zero.';
    Text1100010: Label '%1 cannot be %2.';
    Text1100011: Label 'Specify %1 in %2 %3.';
    BankAcc2: Record "Bank Account";
    Vend: Record Vendor;
    VendLedgEntry: Record "Vendor Ledger Entry";
    VendPostingGr: Record "Vendor Posting Group";
    DocPostBuffer: Record "Doc. Post. Buffer" temporary;
    BGPOPostBuffer: Record "BG/PO Post. Buffer" temporary;
    FeeRange: Record "Fee Range";
    FormatAddress: Codeunit "Format Address";
    PmtOrdFilter: Text[250];
    BankAccAddr: array[8]of Text[50];
    City: Text[30];
    County: Text[30];
    Name: Text[50];
    ErrorText: array[99]of Text[250];
    ErrorCounter: Integer;
    PostingGroup: Code[10];
    CompanyIsBlocked: Boolean;
    DocCount: Integer;
    AccountNo: Text[20];
    BalanceAccNo: Text[20];
    RiskIncGr: Decimal;
    CalcExpenses: Boolean;
    CheckOtherBanks: Boolean;
    NoOfDays: Integer;
    BankAccNoFilter: Text[20];
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Payment_Order___TestCaptionLbl: Label 'Payment Order - Test';
    PmtOrd__Bank_Account_Name_CaptionLbl: Label 'Bank Account Name';
    PmtOrd__Posting_Date_CaptionLbl: Label 'Posting Date';
    PmtOrd__Posting_Description_CaptionLbl: Label 'Posting Description';
    PostingGroupCaptionLbl: Label 'Posting Group';
    PmtOrd__Currency_Code_CaptionLbl: Label 'Currency Code';
    ErrorText_Number_CaptionLbl: Label 'Warning!';
    Vend_Name_Control52CaptionLbl: Label 'Name';
    Post_CodeCaptionLbl: Label 'Post Code';
    City__CaptionLbl: Label 'City /';
    CountyCaptionLbl: Label 'County';
    Doc__Due_Date__Control44CaptionLbl: Label 'Due Date';
    Doc__No__CaptionLbl: Label 'Bill No.';
    Vendor_No_CaptionLbl: Label 'Vendor No.';
    ErrorText_Number__Control56CaptionLbl: Label 'Warning!';
    No__of_DocumentsCaptionLbl: Label 'No. of Documents';
    TotalCaptionLbl: Label 'Total';
    FeeRange_GetTotalPmtOrdCollExpensesAmt_Control89CaptionLbl: Label 'Total Expenses';
    Payment_Order_Expenses_Amt_CaptionLbl: Label 'Payment Order Expenses Amt.';
    BankAcc__No__CaptionLbl: Label 'Bank Account No.';
    "---------------": Label '------------------------ INFORPRESS';
    Error001: Label 'The vendor does not have the IBAN informed.';
    "------------------------------ ATREVIA-------------------------------": Integer;
    PurchInvHe: Record "Purch. Inv. Header";
    VendorInvNo: Text;
    VendorLedgerEntry: Record "Vendor Ledger Entry";
    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter:=ErrorCounter + 1;
        ErrorText[ErrorCounter]:=Text;
    end;
}
