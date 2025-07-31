page 52007 "Check Credit Limit Perso"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Check Credit Limit';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    InstructionalText = 'An action is requested regarding the Credit Limit check.';
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = StandardDialog;
    SourceTable = 18;

    layout
    {
        area(content)
        {
            label(Text000)
            {
                ApplicationArea = All;
            //CaptionClass = FORMAT(STRSUBSTNO(Text000, Heading));
            //MultiLine = true;
            }
            group(Details)
            {
                Caption = 'Details';

                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Name';
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ToolTip = 'Balance (LCY)';
                    ApplicationArea = All;
                }
                field(OrderAmountTotalLCY; OrderAmountTotalLCY)
                {
                    ToolTip = 'OrderAmountTotalLCY';
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Outstanding Amt. (LCY)';
                }
                field(ShippedRetRcdNotIndLCY; ShippedRetRcdNotIndLCY)
                {
                    ToolTip = 'ShippedRetRcdNotIndLCY';
                    ApplicationArea = All;
                    Caption = 'Shipped/Ret. Rcd. Not Invd. (LCY)';
                }
                field(OrderAmountThisOrderLCY; OrderAmountThisOrderLCY)
                {
                    ToolTip = 'OrderAmountThisOrderLCY';
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Current Amount (LCY)';
                }
                field(CustCreditAmountLCY; CustCreditAmountLCY)
                {
                    ToolTip = 'CustCreditAmountLCY';
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Total Amount (LCY)';
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ToolTip = 'Credit Limit (LCY)';
                    ApplicationArea = All;
                }
                field("Balance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    ToolTip = 'Balance Due (LCY)';
                    ApplicationArea = All;
                    CaptionClass = FORMAT(STRSUBSTNO(Text001, FORMAT(Rec.GetRangeMax("Date Filter"))));
                }
                field(GetInvoicedPrepmtAmountLCY; Rec.GetInvoicedPrepmtAmountLCY)
                {
                    ToolTip = 'GetInvoicedPrepmtAmountLCY';
                    ApplicationArea = All;
                    Caption = 'Invoiced Prepayment Amount (LCY)';
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Customer")
            {
                Caption = '&Customer';
                Image = Customer;

                action(Card)
                {
                    ToolTip = 'Card';
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 21;
                    RunPageLink = "No."=FIELD("No."), "Date Filter"=FIELD("Date Filter"), "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'Shift+F7';
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    ToolTip = 'Statistics';
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 151;
                    RunPageLink = "No."=FIELD("No."), "Date Filter"=FIELD("Date Filter"), "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CalcCreditLimitLCY;
        CalcOverdueBalanceLCY;
    end;
    trigger OnOpenPage()
    begin
        Rec.COPY(Cust2);
    end;
    var Text000: Label '%1 Do you still want to record the amount?';
    Text001: Label 'Overdue Amounts (LCY) as of %1';
    Text002: Label 'The customer''s credit limit has been exceeded.';
    Text003: Label 'This customer has an overdue balance.';
    CurrExchRate: Record 330;
    SalesHeader: Record 36;
    SalesLine: Record 37;
    ServHeader: Record 5900;
    ServLine: Record 5902;
    Cust2: Record 18;
    SalesSetup: Record 311;
    CustNo: Code[20];
    Heading: Text[250];
    NewOrderAmountLCY: Decimal;
    OldOrderAmountLCY: Decimal;
    OrderAmountThisOrderLCY: Decimal;
    OrderAmountTotalLCY: Decimal;
    CustCreditAmountLCY: Decimal;
    ShippedRetRcdNotIndLCY: Decimal;
    OutstandingRetOrdersLCY: Decimal;
    RcdNotInvdRetOrdersLCY: Decimal;
    Text004: Label 'This customer has an overdue balance and the customer''s credit limit has been exceeded.';
    DeltaAmount: Decimal;
    procedure GenJnlLineShowWarning(GenJnlLine: Record 81): Boolean begin
        SalesSetup.Get();
        IF SalesSetup."Credit Warnings" = SalesSetup."Credit Warnings"::"No Warning" THEN EXIT(FALSE);
        IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer THEN EXIT(ShowWarning(GenJnlLine."Account No.", GenJnlLine."Amount (LCY)", 0, TRUE));
        EXIT(ShowWarning(GenJnlLine."Bal. Account No.", -GenJnlLine.Amount, 0, TRUE));
    end;
    procedure SalesHeaderShowWarning(SalesHeader: Record 36): Boolean begin
        // Used when additional lines are inserted
        SalesSetup.Get();
        IF SalesSetup."Credit Warnings" = SalesSetup."Credit Warnings"::"No Warning" THEN EXIT(FALSE);
        IF SalesHeader."Currency Code" = '' THEN NewOrderAmountLCY:=SalesHeader."Amount Including VAT"
        ELSE
            NewOrderAmountLCY:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate(), SalesHeader."Currency Code", SalesHeader."Amount Including VAT", SalesHeader."Currency Factor"));
        IF NOT(SalesHeader."Document Type" IN[SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"])THEN NewOrderAmountLCY:=NewOrderAmountLCY + SalesLineAmount(SalesHeader."Document Type", SalesHeader."No.");
        DeltaAmount:=NewOrderAmountLCY;
        EXIT(ShowWarning(SalesHeader."Bill-to Customer No.", NewOrderAmountLCY, 0, TRUE));
    end;
    procedure SalesLineShowWarning(SalesLine: Record 37): Boolean begin
        SalesSetup.Get();
        IF SalesSetup."Credit Warnings" = SalesSetup."Credit Warnings"::"No Warning" THEN EXIT(FALSE);
        IF(SalesHeader."Document Type" <> SalesLine."Document Type") OR (SalesHeader."No." <> SalesLine."Document No.")THEN SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        NewOrderAmountLCY:=SalesLine."Outstanding Amount (LCY)" + SalesLine."Shipped Not Invoiced (LCY)";
        IF SalesLine.Find()then OldOrderAmountLCY:=SalesLine."Outstanding Amount (LCY)" + SalesLine."Shipped Not Invoiced (LCY)"
        ELSE
            OldOrderAmountLCY:=0;
        DeltaAmount:=NewOrderAmountLCY - OldOrderAmountLCY;
        NewOrderAmountLCY:=DeltaAmount + SalesLineAmount(SalesLine."Document Type", SalesLine."Document No.");
        EXIT(ShowWarning(SalesHeader."Bill-to Customer No.", NewOrderAmountLCY, OldOrderAmountLCY, FALSE))end;
    procedure ServiceHeaderShowWarning(ServHeader: Record 5900): Boolean var
        ServSetup: Record 5911;
    begin
        ServSetup.Get();
        SalesSetup.Get();
        IF SalesSetup."Credit Warnings" = SalesSetup."Credit Warnings"::"No Warning" THEN EXIT(FALSE);
        NewOrderAmountLCY:=0;
        ServLine.Reset();
        ServLine.SETRANGE("Document Type", ServHeader."Document Type");
        ServLine.SETRANGE("Document No.", ServHeader."No.");
        IF ServLine.FindSet()then REPEAT IF ServHeader."Currency Code" = '' THEN NewOrderAmountLCY:=NewOrderAmountLCY + ServLine."Amount Including VAT"
                ELSE
                    NewOrderAmountLCY:=NewOrderAmountLCY + ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE, ServHeader."Currency Code", ServLine."Amount Including VAT", ServHeader."Currency Factor"));
            UNTIL ServLine.Next() = 0;
        IF ServHeader."Document Type" <> ServHeader."Document Type"::Order THEN NewOrderAmountLCY:=NewOrderAmountLCY + ServLineAmount(ServHeader."Document Type", ServHeader."No.", ServLine);
        DeltaAmount:=NewOrderAmountLCY;
        EXIT(ShowWarning(ServHeader."Bill-to Customer No.", NewOrderAmountLCY, 0, TRUE));
    end;
    local procedure ServiceLineShowWarning(ServLine: Record 5902): Boolean begin
        SalesSetup.Get();
        IF SalesSetup."Credit Warnings" = SalesSetup."Credit Warnings"::"No Warning" THEN EXIT(FALSE);
        IF(ServHeader."Document Type" <> ServLine."Document Type") OR (ServHeader."No." <> ServLine."Document No.")THEN ServHeader.GET(ServLine."Document Type", ServLine."Document No.");
        NewOrderAmountLCY:=ServLine."Outstanding Amount (LCY)" + ServLine."Shipped Not Invoiced (LCY)";
        IF ServLine.Find()then OldOrderAmountLCY:=ServLine."Outstanding Amount (LCY)" + ServLine."Shipped Not Invoiced (LCY)"
        ELSE
            OldOrderAmountLCY:=0;
        DeltaAmount:=NewOrderAmountLCY - OldOrderAmountLCY;
        NewOrderAmountLCY:=DeltaAmount + ServLineAmount(ServLine."Document Type", ServLine."Document No.", ServLine);
        EXIT(ShowWarning(ServHeader."Bill-to Customer No.", NewOrderAmountLCY, OldOrderAmountLCY, FALSE))end;
    local procedure SalesLineAmount(DocType: Integer; DocNo: Code[20]): Decimal begin
        SalesLine.Reset();
        SalesLine.SETRANGE("Document Type", DocType);
        SalesLine.SETRANGE("Document No.", DocNo);
        SalesLine.CALCSUMS("Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)");
        EXIT(SalesLine."Outstanding Amount (LCY)" + SalesLine."Shipped Not Invoiced (LCY)");
    end;
    local procedure ServLineAmount(DocType: Integer; DocNo: Code[20]; var ServLine2: Record 5902): Decimal begin
        ServLine2.Reset();
        ServLine2.SETRANGE("Document Type", DocType);
        ServLine2.SETRANGE("Document No.", DocNo);
        ServLine2.CALCSUMS("Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)");
        EXIT(ServLine2."Outstanding Amount (LCY)" + ServLine2."Shipped Not Invoiced (LCY)");
    end;
    local procedure ShowWarning(NewCustNo: Code[20]; NewOrderAmountLCY2: Decimal; OldOrderAmountLCY2: Decimal; CheckOverDueBalance: Boolean): Boolean var
        ExitValue: Integer;
    begin
        IF NewCustNo = '' THEN EXIT;
        CustNo:=NewCustNo;
        NewOrderAmountLCY:=NewOrderAmountLCY2;
        OldOrderAmountLCY:=OldOrderAmountLCY2;
        Rec.GET(CustNo);
        Rec.SETRANGE("No.", Rec."No.");
        Cust2.COPY(Rec);
        IF SalesSetup."Credit Warnings" IN[SalesSetup."Credit Warnings"::"Both Warnings", SalesSetup."Credit Warnings"::"Credit Limit"]THEN BEGIN
            CalcCreditLimitLCY;
            IF(CustCreditAmountLCY > Rec."Credit Limit (LCY)") AND (Rec."Credit Limit (LCY)" <> 0)THEN ExitValue:=1;
        END;
        IF CheckOverDueBalance AND (SalesSetup."Credit Warnings" IN[SalesSetup."Credit Warnings"::"Both Warnings", SalesSetup."Credit Warnings"::"Overdue Balance"])THEN BEGIN
            CalcOverdueBalanceLCY;
            IF Rec."Balance Due (LCY)" > 0 THEN ExitValue:=ExitValue + 2;
        END;
        IF ExitValue > 0 THEN BEGIN
            CASE ExitValue OF 1: Heading:=Text002;
            2: Heading:=Text003;
            3: Heading:=Text004;
            END;
            EXIT(TRUE);
        END;
    end;
    local procedure CalcCreditLimitLCY()
    begin
        IF Rec.GETFILTER("Date Filter") = '' THEN Rec.SETFILTER("Date Filter", '..%1', WorkDate());
        Rec.CALCFIELDS("Balance (LCY)", "Shipped Not Invoiced (LCY)", "Serv Shipped Not Invoiced(LCY)");
        CalcReturnAmounts(OutstandingRetOrdersLCY, RcdNotInvdRetOrdersLCY);
        OrderAmountTotalLCY:=CalcTotalOutstandingAmt - OutstandingRetOrdersLCY + DeltaAmount;
        ShippedRetRcdNotIndLCY:=Rec."Shipped Not Invoiced (LCY)" + Rec."Serv Shipped Not Invoiced(LCY)" - RcdNotInvdRetOrdersLCY;
        IF Rec."No." = CustNo THEN OrderAmountThisOrderLCY:=NewOrderAmountLCY
        ELSE
            OrderAmountThisOrderLCY:=0;
        CustCreditAmountLCY:=Rec."Balance (LCY)" + Rec."Shipped Not Invoiced (LCY)" + Rec."Serv Shipped Not Invoiced(LCY)" - RcdNotInvdRetOrdersLCY + OrderAmountTotalLCY - Rec.GetInvoicedPrepmtAmountLCY;
    end;
    local procedure CalcOverdueBalanceLCY()
    begin
        IF Rec.GETFILTER("Date Filter") = '' THEN Rec.SETFILTER("Date Filter", '..%1', WorkDate());
        Rec.CALCFIELDS("Balance Due (LCY)");
    end;
    local procedure CalcReturnAmounts(var OutstandingRetOrdersLCY2: Decimal; var RcdNotInvdRetOrdersLCY2: Decimal): Decimal begin
        SalesLine.Reset();
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", "Currency Code");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE("Bill-to Customer No.", Rec."No.");
        SalesLine.CALCSUMS("Outstanding Amount (LCY)", "Return Rcd. Not Invd. (LCY)");
        OutstandingRetOrdersLCY2:=SalesLine."Outstanding Amount (LCY)";
        RcdNotInvdRetOrdersLCY2:=SalesLine."Return Rcd. Not Invd. (LCY)";
    end;
    local procedure CalcTotalOutstandingAmt(): Decimal var
        SalesLine: Record 37;
        SalesOutstandingAmountFromShipment: Decimal;
        ServOutstandingAmountFromShipment: Decimal;
    begin
        Rec.CALCFIELDS("Outstanding Invoices (LCY)", "Outstanding Orders (LCY)", "Outstanding Serv.Invoices(LCY)", "Outstanding Serv. Orders (LCY)");
        SalesOutstandingAmountFromShipment:=SalesLine.OutstandingInvoiceAmountFromShipment(Rec."No.");
        ServOutstandingAmountFromShipment:=ServLine.OutstandingInvoiceAmountFromShipment(Rec."No.");
        EXIT(Rec."Outstanding Orders (LCY)" + Rec."Outstanding Invoices (LCY)" + Rec."Outstanding Serv. Orders (LCY)" + Rec."Outstanding Serv.Invoices(LCY)" - SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment);
    end;
    local procedure RecogerCliente(rec_cliente: Record 18)
    begin
    end;
}
