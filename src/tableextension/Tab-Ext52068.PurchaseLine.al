tableextension 52068 "PurchaseLine" extends "Purchase Line"
{
    fields
    {
        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchSetup;

        "No." := FindOrCreateRecordByNo("No.");

        TestStatusOpen;
        Rec.TESTFIELD("Qty. Rcd. Not Invoiced",0);
        Rec.TESTFIELD("Quantity Received",0);
        Rec.TESTFIELD("Receipt No.",'');

        Rec.TESTFIELD("Prepmt. Amt. Inv.",0);

        TestReturnFieldsZero;

        if "Drop Shipment" then
          Error(
            Text001,
            FieldCaption("No."),"Sales Order No.");

        if "Special Order" then
          Error(
            Text001,
            FieldCaption("No."),"Special Order Sales No.");

        if "Prod. Order No." <> '' then
          Error(
            Text044,
            FieldCaption(Type),FieldCaption("Prod. Order No."),"Prod. Order No.");

        OnValidateNoOnAfterChecks(Rec,xRec,CurrFieldNo);

        if "No." <> xRec."No." then begin
          if (Quantity <> 0) and ItemExists(xRec."No.") then begin
            ReservePurchLine.VerifyChange(Rec,xRec);
            CalcFields("Reserved Qty. (Base)");
            Rec.TESTFIELD("Reserved Qty. (Base)",0);
            if Type = Type::Item then
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
            OnValidateNoOnAfterVerifyChange(Rec,xRec);
          end;
          if Type = Type::Item then
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          if Type = Type::"Charge (Item)" then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        end;

        OnValidateNoOnBeforeInitRec(Rec,xRec,CurrFieldNo);
        TempPurchLine := Rec;
        Init();
        if xRec."Line Amount" <> 0 then
          "Recalculate Invoice Disc." := true;
        Type := TempPurchLine.Type;
        "No." := TempPurchLine."No.";
        OnValidateNoOnCopyFromTempPurchLine(Rec,TempPurchLine);
        if "No." = '' then
          exit;

        if HasTypeToFillMandatoryFields then begin
          Quantity := TempPurchLine.Quantity;
          "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
        end;

        "System-Created Entry" := TempPurchLine."System-Created Entry";
        GetPurchHeader;
        InitHeaderDefaults(PurchHeader);
        UpdateLeadTimeFields;
        UpdateDates;

        OnAfterAssignHeaderValues(Rec,PurchHeader);

        case Type of
          Type::" ":
            CopyFromStandardText;
          Type::"G/L Account":
            CopyFromGLAccount;
          Type::Item:
            CopyFromItem;
          3:
            Error(Text003);
          Type::"Fixed Asset":
            CopyFromFixedAsset;
          Type::"Charge (Item)":
            CopyFromItemCharge;
        end;

        OnAfterAssignFieldsForNo(Rec,xRec,PurchHeader);

        if Type <> Type::" " then begin
          PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
          PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        end;

        if HasTypeToFillMandatoryFields and not (Type = Type::"Fixed Asset") then
          Validate("VAT Prod. Posting Group");

        UpdatePrepmtSetupFields;

        if HasTypeToFillMandatoryFields then begin
          Quantity := xRec.Quantity;
          OnValidateNoOnAfterAssignQtyFromXRec(Rec,TempPurchLine);
          Validate("Unit of Measure Code");
          if Quantity <> 0 then begin
            InitOutstanding;
            if IsCreditDocType then
              InitQtyToShip
            else
              InitQtyToReceive;
          end;
          UpdateWithWarehouseReceive;
          UpdateDirectUnitCost(FieldNo("No."));
          if xRec."Job No." <> '' then
            Validate("Job No.",xRec."Job No.");
          "Job Line Type" := xRec."Job Line Type";
          if xRec."Job Task No." <> '' then begin
            Validate("Job Task No.",xRec."Job Task No.");
            if "No." = xRec."No." then
              Validate("Job Planning Line No.",xRec."Job Planning Line No.");
          end;
        end;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.");

        PurchHeader.Get("Document Type","Document No.");
        UpdateItemReference;

        GetDefaultBin;

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(true);
          UpdateJobPrices;
          UpdateDimensionsFromJobTask;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        Rec.TESTFIELD("Qty. Rcd. Not Invoiced",0);
        Rec.TESTFIELD("Quantity Received",0);
        Rec.TESTFIELD("Receipt No.",'');

        Rec.TESTFIELD("Prepmt. Amt. Inv.",0);
        #11..13
        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("No."),"Sales Order No.");

        IF "Special Order" THEN
          ERROR(
            Text001,
            FIELDCAPTION("No."),"Special Order Sales No.");

        IF "Prod. Order No." <> '' THEN
          ERROR(
            Text044,
            FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");

        IF "No." <> xRec."No." THEN BEGIN
          IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
            ReservePurchLine.VerifyChange(Rec,xRec);
            CALCFIELDS("Reserved Qty. (Base)");
            Rec.TESTFIELD("Reserved Qty. (Base)",0);
            IF Type = Type::Item THEN
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          END;
          IF Type = Type::Item THEN
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          IF Type = Type::"Charge (Item)" THEN
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        END;
        TempPurchLine := Rec;
        Init();
        IF xRec."Line Amount" <> 0 THEN
          "Recalculate Invoice Disc." := TRUE;
        Type := TempPurchLine.Type;
        "No." := TempPurchLine."No.";
        IF "No." = '' THEN
          EXIT;
        IF Type <> Type::" " THEN BEGIN
          Quantity := TempPurchLine.Quantity;
          "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
        END;
        #61..63
        PurchHeader.TESTFIELD("Buy-from Vendor No.");

        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
        "Currency Code" := PurchHeader."Currency Code";
        "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
        "Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
        IF NOT IsServiceItem THEN
          "Location Code" := PurchHeader."Location Code";
        "Transaction Type" := PurchHeader."Transaction Type";
        "Transport Method" := PurchHeader."Transport Method";
        "Pay-to Vendor No." := PurchHeader."Pay-to Vendor No.";
        "Gen. Bus. Posting Group" := PurchHeader."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := PurchHeader."VAT Bus. Posting Group";
        "Entry Point" := PurchHeader."Entry Point";
        Area := PurchHeader.Area;
        "Transaction Specification" := PurchHeader."Transaction Specification";
        "Tax Area Code" := PurchHeader."Tax Area Code";
        "Tax Liable" := PurchHeader."Tax Liable";
        IF NOT "System-Created Entry" AND ("Document Type" = "Document Type"::Order) AND (Type <> Type::" ") THEN
          "Prepayment %" := PurchHeader."Prepayment %";
        "Prepayment Tax Area Code" := PurchHeader."Tax Area Code";
        "Prepayment Tax Liable" := PurchHeader."Tax Liable";
        "Responsibility Center" := PurchHeader."Responsibility Center";

        "Requested Receipt Date" := PurchHeader."Requested Receipt Date";
        "Promised Receipt Date" := PurchHeader."Promised Receipt Date";
        "Inbound Whse. Handling Time" := PurchHeader."Inbound Whse. Handling Time";
        "Order Date" := PurchHeader."Order Date";
        #65..67
        CASE Type OF
          Type::" ":
            BEGIN
              //.GET("No.");
              Description := //.Description;
              "Allow Item Charge Assignment" := FALSE;
            END;
          Type::"G/L Account":
            BEGIN
              GLAcc.GET("No.");
              GLAcc.CheckGLAcc;
              IF NOT "System-Created Entry" THEN
                GLAcc.TESTFIELD("Direct Posting",TRUE);
              Description := GLAcc.Name;
              "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
              "Tax Group Code" := GLAcc."Tax Group Code";
              "Allow Invoice Disc." := NOT GLAcc.InvoiceDiscountAllowed("No.");
              "Allow Item Charge Assignment" := FALSE;
              InitDeferralCode;
              //055
              IF GLAcc."Expenses Billable" THEN BEGIN
                "Job Line Type":= PurchLine2."Job Line Type"::Billable;
                "Job Line Account No.":= CalcJobLineAccountNo(Rec);
              END;
              //055
            END;
          Type::Item:
            BEGIN
              GetItem;
              GetGLSetup;
              Item.TESTFIELD(Blocked,FALSE);
              Item.TESTFIELD("Gen. Prod. Posting Group");
              IF Item.Type = Item.Type::Inventory THEN BEGIN
                Item.TESTFIELD("Inventory Posting Group");
                "Posting Group" := Item."Inventory Posting Group";
              END;
              Description := Item.Description;
              "Description 2" := Item."Description 2";
              "Unit Price (LCY)" := Item."Unit Price";
              "Units per Parcel" := Item."Units per Parcel";
              "Indirect Cost %" := Item."Indirect Cost %";
              "Overhead Rate" := Item."Overhead Rate";
              "Allow Invoice Disc." := Item."Allow Invoice Disc.";
              "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
              "Tax Group Code" := Item."Tax Group Code";
              Nonstock := Item."Created From Nonstock Item";
              "Item Category Code" := Item."Item Category Code";
              "Product Group Code" := Item."Product Group Code";
              "Allow Item Charge Assignment" := TRUE;
              //.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");

              IF Item."Price Includes VAT" THEN BEGIN
                IF NOT VATPostingSetup.GET(
                     Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group")
                THEN
                  VATPostingSetup.Init();
                CASE VATPostingSetup."VAT Calculation Type" OF
                  VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                    VATPostingSetup."VAT+EC %" := 0;
                  VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                    ERROR(
                      Text002,
                      VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
                      VATPostingSetup."VAT Calculation Type");
                END;
                "Unit Price (LCY)" :=
                  ROUND("Unit Price (LCY)" / (1 + VATPostingSetup."VAT+EC %" / 100),
                    GLSetup."Unit-Amount Rounding Precision");
              END;

              IF PurchHeader."Language Code" <> '' THEN
                GetItemTranslation;

              "Unit of Measure Code" := Item."Purch. Unit of Measure";
              InitDeferralCode;
            END;
          Type::"3":
            ERROR(Text003);
          Type::"Fixed Asset":
            BEGIN
              FA.GET("No.");
              FA.TESTFIELD(Inactive,FALSE);
              FA.TESTFIELD(Blocked,FALSE);
              GetFAPostingGroup;
              Description := FA.Description;
              "Description 2" := FA."Description 2";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
            END;
          Type::"Charge (Item)":
            BEGIN
              ItemCharge.GET("No.");
              Description := ItemCharge.Description;
              "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := ItemCharge."VAT Prod. Posting Group";
              "Tax Group Code" := ItemCharge."Tax Group Code";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
              "Indirect Cost %" := 0;
              "Overhead Rate" := 0;
            END;
        END;

        IF NOT (Type IN [Type::" ",Type::"Fixed Asset"]) THEN
          VALIDATE("VAT Prod. Posting Group");
        #94..96
        IF Type <> Type::" " THEN BEGIN
          Quantity := xRec.Quantity;
          VALIDATE("Unit of Measure Code");
          IF Quantity <> 0 THEN BEGIN
            InitOutstanding;
            IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
              InitQtyToShip
            ELSE
              InitQtyToReceive;
          END;
          UpdateWithWarehouseReceive;
          UpdateDirectUnitCost(FIELDNO("No."));
          IF xRec."Job No." <> '' THEN
            VALIDATE("Job No.",xRec."Job No.");
          "Job Line Type" := xRec."Job Line Type";
          IF xRec."Job Task No." <> '' THEN BEGIN
            VALIDATE("Job Task No.",xRec."Job Task No.");
            IF "No." = xRec."No." THEN
              VALIDATE("Job Planning Line No.",xRec."Job Planning Line No.");
          END;
         //055
              IF GLAcc."Expenses Billable" THEN BEGIN
                "Job Line Type":= PurchLine2."Job Line Type"::Billable;
                "Job Line Account No.":= CalcJobLineAccountNo(Rec);
              END;
         //055
        END;
        #119..125
        PurchHeader.GET("Document Type","Document No.");
        UpdateItemCrossRef;
        #128..130
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        END
        */
        //end;
        modify("Job No.")
        {
        trigger OnAfterValidate()
        begin
        /*
                Rec.TESTFIELD("Drop Shipment",false);
                Rec.TESTFIELD("Special Order",false);
                Rec.TESTFIELD("Receipt No.",'');
                if "Document Type" = "Document Type"::Order then
                  Rec.TESTFIELD("Quantity Received",0);

                if ReservEntryExist then
                  Rec.TESTFIELD("Job No.",'');

                if "Job No." <> xRec."Job No." then begin
                  Validate("Job Task No.",'');
                  Validate("Job Planning Line No.",0);
                end;

                if "Job No." = '' then begin
                  CreateDim(
                    DATABASE::Job,"Job No.",
                    DimMgt.TypeToTableID3(Type),"No.",
                    DATABASE::"Responsibility Center","Responsibility Center",
                    DATABASE::"Work Center","Work Center No.");
                  exit;
                end;

                if not (Type in [Type::Item,Type::"G/L Account"]) then
                  FieldError("Job No.",StrSubstNo(Text012,FieldCaption(Type),Type));
                Job.Get("Job No.");
                Job.TestBlocked;
                "Job Currency Code" := Job."Currency Code";

                CreateDim(
                  DATABASE::Job,"Job No.",
                  DimMgt.TypeToTableID3(Type),"No.",
                  DATABASE::"Responsibility Center","Responsibility Center",
                  DATABASE::"Work Center","Work Center No.");
                */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
                Rec.TESTFIELD("Drop Shipment",FALSE);
                Rec.TESTFIELD("Special Order",FALSE);
                Rec.TESTFIELD("Receipt No.",'');
                IF "Document Type" = "Document Type"::Order THEN
                  Rec.TESTFIELD("Quantity Received",0);

                IF ReservEntryExist THEN
                  Rec.TESTFIELD("Job No.",'');

                IF "Job No." <> xRec."Job No." THEN BEGIN
                  //123
                  //VALIDATE("Job Task No.",'');
                  VALIDATE("Job Task No.", "Job No.");
                  //123
                  VALIDATE("Job Planning Line No.",0);
                END;

                IF "Job No." = '' THEN BEGIN
                #16..20
                  EXIT;
                END;
                //<062
                {
                IF NOT (Type IN [Type::Item,Type::"G/L Account"]) THEN
                  FIELDERROR("Job No.",STRSUBSTNO(Text012,FIELDCAPTION(Type),Type));
                }
                //062>

                Job.GET("Job No.");
                Job.TestBlocked;
                "Job Currency Code" := Job."Currency Code";
                //123
                CALCFIELDS("Job Name");
                "Job Task No." := "Job No.";
                //123

                //055
                IF ("Job Line Type"="Job Line Type"::Billable) THEN BEGIN //AND ("Document Type" <>Rec."Document Type"::"Credit Memo") THEN BEGIN
                    IF Job.GET("Job No.") THEN BEGIN
                      VALIDATE("Job Unit Price", "Direct Unit Cost");
                      IF (Job."Expenses Surcharge %" <>0) AND (Type=Type::"G/L Account") THEN BEGIN  //solo recargo si es cuenta refacturable
                        GLAcc.GET("No.");
                        IF GLAcc."Expenses Billable" THEN
                           VALIDATE(Rec."Job Line Discount %", -Job."Expenses Surcharge %");
                      END;
                    END;
                END;
                //055
                */
        end;
        }
        modify("Job Task No.")
        {
        trigger OnAfterValidate()
        var
            GLAcc: Record "G/L Account";
        begin
            //EX-OMI 260219
            IF("Job Line Type" = "Job Line Type"::Billable)THEN BEGIN //AND ("Document Type" <>Rec."Document Type"::"Credit Memo") THEN BEGIN
                IF Job.GET("Job No.")THEN IF(Job."Expenses Surcharge % AT" <> 0) AND (Type = Type::"G/L Account")THEN BEGIN //solo recargo si es cuenta refacturable
                        GLAcc.GET("No.");
                        IF GLAcc."Expenses Billable AT" THEN VALIDATE(Rec."Job Line Discount %", -Job."Expenses Surcharge % AT");
                    END;
                VALIDATE("Job Unit Price", "Direct Unit Cost");
            END;
        end;
        }
        modify("Job Line Type")
        {
        trigger OnAfterValidate()
        var
            Job: Record Job;
            GLAcc: Record "G/L Account";
        begin
            //055
            //IF ("Job Line Type"="Job Line Type"::Billable) THEN BEGIN //AND ("Document Type" <>Rec."Document Type"::"Credit Memo") THEN BEGIN
            //    IF Job.GET("Job No.") THEN
            //      IF Job."Expenses Surcharge %" <>0 THEN
            //        VALIDATE(Rec."Job Line Discount %", -Job."Expenses Surcharge %");
            //    VALIDATE("Job Unit Price", "Direct Unit Cost");
            //END;
            //055
            //055
            IF("Job Line Type" = "Job Line Type"::Billable)THEN BEGIN //AND ("Document Type" <>Rec."Document Type"::"Credit Memo") THEN BEGIN
                IF Job.GET("Job No.")THEN BEGIN
                    IF(Job."Expenses Surcharge % AT" <> 0) AND (Type = Type::"G/L Account")THEN BEGIN //solo recargo si es cuenta refacturable
                        GLAcc.GET("No.");
                        IF GLAcc."Expenses Billable AT" THEN VALIDATE(Rec."Job Line Discount %", -Job."Expenses Surcharge % AT");
                    END;
                END;
                VALIDATE("Job Unit Price", "Direct Unit Cost");
            END;
        //055
        end;
        }
        field(52000; "Job Name"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Name';
            FieldClass = FlowField;
        }
        field(52002; "Job Line Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Line Account No.';
            TableRelation = IF(Type=CONST("G/L Account"))"G/L Account";

            trigger OnValidate()
            var
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
                TestStatusOpen;
            end;
        }
    }
    procedure GetTotalAmount(): Decimal begin
        EXIT(TotalAmountForTax);
    end;
    local procedure CheckReservationDateConflict(DateFieldNo: Integer)
    var
        ReservEntry: Record 337;
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
    begin
        IF CurrFieldNo = DateFieldNo THEN IF PurchLineReserve.FindReservEntry(Rec, ReservEntry)THEN BEGIN
                ReservEntry.SETFILTER("Shipment Date", '<%1', "Expected Receipt Date");
                IF NOT ReservEntry.ISEMPTY THEN IF NOT CONFIRM(DataConflictQst)THEN ERROR('');
            END;
    end;
    //"------------"
    //3698 - JS 2022 06 07
    procedure CalcJobLineAccountNo(VarPurchLine: Record 39): Code[20] //3698 - JS 2022 06 07 END
    var
        SectorsSetup: Record "Sectors and Payments Setup AT";
    begin
        //055
        SectorsSetup.SETRANGE(SectorsSetup."G/L Account", VarPurchLine."No.");
        IF SectorsSetup.FindFirst()then EXIT(SectorsSetup."Contract G/L Account");
    //055
    end;
    var //TempPurchLine: Record 39;
 //PrepmtMgt: Codeunit "Prepayment Mgt.";
    //Item: Record 27;
    Job: Record Job;
    ReservEntry: Record 337;
    //StdTxt: Record 7;
    //FA: Record 5600;
    TotalAmountForTax: Decimal;
    DataConflictQst: Label 'The change creates a date conflict with existing reservations. Do you want to continue?';
}
