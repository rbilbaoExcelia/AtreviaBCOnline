report 52016 "Change Global Dimensions"
{
    Caption = 'Change Global Dimensions';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Permissions = TableData 17=imd,
        TableData 21=imd,
        TableData 25=imd,
        TableData 32=imd,
        TableData 110=imd,
        TableData 111=imd,
        TableData 112=imd,
        TableData 113=imd,
        TableData 114=imd,
        TableData 115=imd,
        TableData 120=imd,
        TableData 121=imd,
        TableData 122=imd,
        TableData 123=imd,
        TableData 124=imd,
        TableData 125=imd,
        TableData 169=imd,
        TableData 171=imd,
        TableData 174=imd,
        TableData 203=imd,
        TableData 271=imd,
        TableData 281=imd,
        TableData 297=imd,
        TableData 304=imd,
        TableData 379=imd,
        TableData 380=imd,
        TableData 1001=imd,
        TableData 1004=imd,
        TableData 1005=imd,
        TableData 5107=imd,
        TableData 5108=imd,
        TableData 5109=imd,
        TableData 5110=imd,
        TableData 5601=imd,
        TableData 5625=imd,
        TableData 5629=imd,
        TableData 5802=imd,
        TableData 5832=imd,
        TableData 5907=imd,
        TableData 5908=imd,
        TableData 5965=imd,
        TableData 5970=imd,
        TableData 5971=imd,
        TableData 6650=imd,
        TableData 6651=imd,
        TableData 6660=imd,
        TableData 6661=imd,
        TableData 8383=imd,
        TableData "Cartera Doc."=imd,
        TableData "Posted Cartera Doc."=imd,
        TableData "Closed Cartera Doc."=imd;
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NewGlobalDim1Code; NewGlobalDim1Code)
                    {
                        ToolTip = 'Global Dimension 1 Code';
                        ApplicationArea = All;
                        Caption = 'Global Dimension 1 Code';
                        TableRelation = Dimension;

                        trigger OnValidate()
                        begin
                            IF NewGlobalDim1Code = NewGlobalDim2Code THEN NewGlobalDim2Code:='';
                        end;
                    }
                    field(NewGlobalDim2Code; NewGlobalDim2Code)
                    {
                        ToolTip = 'Global Dimension 2 Code';
                        ApplicationArea = All;
                        Caption = 'Global Dimension 2 Code';
                        TableRelation = Dimension;

                        trigger OnValidate()
                        begin
                            IF NewGlobalDim1Code = NewGlobalDim2Code THEN NewGlobalDim1Code:='';
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            GLSetup.Get();
            NewGlobalDim1Code:=GLSetup."Global Dimension 1 Code";
            NewGlobalDim2Code:=GLSetup."Global Dimension 2 Code";
        end;
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        IF ChangeGlobalDim THEN BEGIN
            GLSetup.VALIDATE("Global Dimension 1 Code", NewGlobalDim1Code);
            GLSetup.VALIDATE("Global Dimension 2 Code", NewGlobalDim2Code);
            GLSetup.MODIFY(TRUE);
            MESSAGE(Text004, ConfirmationMessage);
        END;
    end;
    trigger OnPreReport()
    var
        Dim: Record 348;
    begin
        IF NewGlobalDim1Code <> GLSetup."Global Dimension 1 Code" THEN BEGIN
            ConfirmationMessage:=GLSetup.FIELDCAPTION("Global Dimension 1 Code") + ' (' + GLSetup.FIELDCAPTION("Shortcut Dimension 1 Code") + ')';
            IF NewGlobalDim2Code <> GLSetup."Global Dimension 2 Code" THEN ConfirmationMessage:=ConfirmationMessage + Text000 + GLSetup.FIELDCAPTION("Global Dimension 2 Code") + ' (' + GLSetup.FIELDCAPTION("Shortcut Dimension 2 Code") + ')';
        END
        ELSE IF NewGlobalDim2Code <> GLSetup."Global Dimension 2 Code" THEN ConfirmationMessage:=GLSetup.FIELDCAPTION("Global Dimension 2 Code") + ' (' + GLSetup.FIELDCAPTION("Shortcut Dimension 2 Code") + ')';
        IF ConfirmationMessage <> '' THEN BEGIN
            IF(NewGlobalDim1Code = GLSetup."Global Dimension 2 Code") AND (NewGlobalDim2Code = GLSetup."Global Dimension 1 Code")THEN BEGIN
                MESSAGE(Text001);
                CurrReport.QUIT;
            END;
            IF Dim.CheckIfDimUsed(NewGlobalDim1Code, 1, '', '', 0)THEN ERROR(Text002, Dim.GetCheckDimErr, GLSetup.FIELDCAPTION("Global Dimension 1 Code"));
            IF Dim.CheckIfDimUsed(NewGlobalDim2Code, 2, '', '', 0)THEN ERROR(Text002, Dim.GetCheckDimErr, GLSetup.FIELDCAPTION("Global Dimension 2 Code"));
            IF NOT CONFIRM(Text003, FALSE, ConfirmationMessage)THEN CurrReport.QUIT;
        END
        ELSE
            CurrReport.QUIT;
    end;
    var Text000: Label ' and ';
    Text001: Label 'You must run this batch job twice to reverse the global dimensions.';
    Text002: Label '%1\You cannot use it as %2.';
    Text003: Label 'Are you sure that you want to change:\%1?';
    Text004: Label 'The following dimensions have been successfully changed:\%1.';
    Text005: Label 'Database information\';
    Text006: Label ' No. of Records        #1######\';
    Text007: Label ' Progress              @2@@@@@@@@@@@@@\';
    Text008: Label ' Estimated Ending Time #3#######################\';
    Text009: Label 'Table information\';
    Text010: Label ' Company               #4#######################\';
    Text011: Label ' Table                 #5#######################\';
    Text012: Label ' No. of Records        #6######\';
    Text013: Label ' Progress              @7@@@@@@@@@@@@@';
    Text014: Label 'Please wait while the operation is being completed.';
    Text015: Label '<Hours24>:<Minutes,2>';
    DimVal: Record 349;
    ItemBudgetEntry: Record 7134;
    GLSetup: Record 98;
    GLAcc: Record "G/L Account";
    GLEntry: Record 17;
    Cust: Record 18;
    CustLedgEntry: Record 21;
    DtldCustLedgEntry: Record 379;
    Vend: Record 23;
    VendorLedgEntry: Record 25;
    DtldVendLedgEntry: Record 380;
    Item: Record 27;
    ItemLedgEntry: Record 32;
    SalesHeader: Record 36;
    SalesLine: Record 37;
    PurchHeader: Record 38;
    PurchLine: Record 39;
    GenJnlLine: Record 81;
    ItemJnlLine: Record 83;
    GLBudgetEntry: Record 96;
    SalesShptHeader: Record 110;
    SaleShptLine: Record 111;
    SalesInvHeader: Record 112;
    SalesInvLine: Record 113;
    ReturnRcptHeader: Record 6660;
    ReturnRcptLine: Record 6661;
    SalesCrMemoHeader: Record 114;
    SalesCrMemoLine: Record 115;
    PurchRcptHeader: Record 120;
    PurchRcptLine: Record 121;
    PurchInvHeader: Record 122;
    PurchInvLine: Record 123;
    PurchCrMemoHeader: Record 124;
    PurchCrMemoLine: Record 125;
    ServHeader: Record 5900;
    ServLine: Record 5902;
    ServShptHeader: Record 5990;
    ServShptLine: Record 5991;
    ServInvHeader: Record 5992;
    ServInvLine: Record 5993;
    ServCrMemoHeader: Record 5994;
    ServCrMemoLine: Record 5995;
    ReturnShptHeader: Record 6650;
    ReturnShptLine: Record 6651;
    ResGr: Record 152;
    Res: Record 156;
    Job: Record Job;
    JobLedgEntry: Record 169;
    ResLedgEntry: Record 203;
    StdSalesLine: Record 171;
    StdPurchLine: Record 174;
    ValueEntry: Record 5802;
    CapLedgEntry: Record 5832;
    ResJnlLine: Record 207;
    JobJnlLine: Record 210;
    GenJnlAlloc: Record 221;
    ReqLine: Record 246;
    BankAcc: Record 270;
    BankAccLedgEntry: Record 271;
    PhysInvtLedgEntry: Record 281;
    ReminderHeader: Record 295;
    IssuedReminderHeader: Record 297;
    FinChrgMemoHeader: Record 302;
    IssuedFinChrgMemoHeader: Record 304;
    Employee: Record 5200;
    ProdOrder: Record 5405;
    ProdOrderLine: Record 5406;
    ProdOrderComp: Record 5407;
    FA: Record 5600;
    FALedgEntry: Record 5601;
    FAAlloc: Record 5615;
    FAJnlLine: Record 5621;
    MaintenanceLedgEntry: Record 5625;
    Insurance: Record 5628;
    InsCovLedgEntry: Record 5629;
    InsuranceJnlLine: Record 5635;
    RespCenter: Record 5714;
    SalespersonPurchaser: Record 13;
    Campaign: Record 5071;
    // SAR  -  2024 19 01  -  Correcion de tabla Customer Templ
    CustomerTemplate: Record 1381;
    // SAR  -  2024 19 01  -  Correcion de tabla Customer Templ END
    SalesHeaderArchive: Record 5107;
    SalesLineArchive: Record 5108;
    PurchHeaderArchive: Record 5109;
    PurchLineArchive: Record 5110;
    DimSetEntry: Record 480;
    DefaultDim: Record 352;
    DimBuf: Record 360;
    WarrantyLedgerEntry: Record 5908;
    ServiceLedgerEntry: Record 5907;
    ItemCharge: Record 5800;
    TransferHeader: Record 5740;
    TransferLine: Record 5741;
    TransferShipmentHeader: Record 5744;
    TransferShipmentLine: Record 5745;
    TransferReceiptHeader: Record 5746;
    TransferReceiptLine: Record 5747;
    WorkCenter: Record "Work Center";
    PlanningComponent: Record "Planning Component";
    ServItemLine: Record 5901;
    JobTask: Record 1001;
    JobTaskDim: Record 1002;
    JobWIPEntry: Record 1004;
    JobWIPGLEntry: Record 1005;
    StdGenJnlLine: Record 751;
    StdItemJnlLine: Record 753;
    ServCtrHeader: Record 5965;
    FiledServCtrHeader: Record 5970;
    StdServLine: Record 5997;
    CarteraDoc: Record "Cartera Doc.";
    PostedCarteraDoc: Record "Posted Cartera Doc.";
    ClosedCarteraDoc: Record "Closed Cartera Doc.";
    TempDefaultDimDimensionsFieldMap: Record 8383 temporary;
    TempDimSetDimensionsFieldMap: Record 8383 temporary;
    IndicatorWindow: Dialog;
    NewGlobalDim1Code: Code[20];
    NewGlobalDim2Code: Code[20];
    DatabaseRecords: Integer;
    CheckedDatabaseRecords: Integer;
    TableRecords: Integer;
    CheckedTableRecords: Integer;
    StartTime: Time;
    StartDate: Date;
    ConfirmationMessage: Text[250];
    local procedure ChangeGlobalDim(): Boolean var
        DimFilter: Text[250];
        TempTableOption: Option DefaultDimTables, DimSetTables;
    begin
        InitializeTablesForModification;
        OpenIndicator;
        CountRowsAndLockTable(TempDefaultDimDimensionsFieldMap);
        CountRowsAndLockTable(TempDimSetDimensionsFieldMap);
        CountRowsAndLockExceptionalCases;
        DimVal.SETCURRENTKEY(Code, "Global Dimension No.");
        DimVal.SETRANGE("Global Dimension No.", 1, 2);
        DimVal.MODIFYALL("Global Dimension No.", 0);
        DimVal.Reset();
        IF NewGlobalDim1Code <> '' THEN BEGIN
            DimVal.SETRANGE("Dimension Code", NewGlobalDim1Code);
            DimVal.MODIFYALL("Global Dimension No.", 1);
        END;
        IF NewGlobalDim2Code <> '' THEN BEGIN
            DimVal.SETRANGE("Dimension Code", NewGlobalDim2Code);
            DimVal.MODIFYALL("Global Dimension No.", 2);
        END;
        IF NewGlobalDim1Code <> '' THEN IF NewGlobalDim2Code <> '' THEN DimFilter:=NewGlobalDim1Code + '|' + NewGlobalDim2Code
            ELSE
                DimFilter:=NewGlobalDim1Code
        ELSE IF NewGlobalDim2Code <> '' THEN DimFilter:=NewGlobalDim2Code
            ELSE
                DimFilter:='';
        DefaultDim.SETFILTER("Dimension Code", DimFilter);
        DimBuf.SETFILTER("Dimension Code", DimFilter);
        JobTaskDim.SETFILTER("Dimension Code", DimFilter);
        StartTime:=TIME;
        StartDate:=TODAY;
        ChangeGlobalsInTables(TempTableOption::DefaultDimTables);
        ChangeGlobalsInTables(TempTableOption::DimSetTables);
        UpdateExceptionalCases;
        IndicatorWindow.Close();
        EXIT(TRUE);
    end;
    local procedure GetDefaultJobTaskDim(JobNo: Code[20]; JobTaskNo: Code[20]; var GlobalDim1Value: Code[20]; var GlobalDim2Value: Code[20])
    begin
        GlobalDim1Value:='';
        GlobalDim2Value:='';
        JobTaskDim.SETRANGE("Job No.", JobNo);
        JobTaskDim.SETRANGE("Job Task No.", JobTaskNo);
        IF JobTaskDim.FindSet()then REPEAT IF JobTaskDim."Dimension Code" = NewGlobalDim1Code THEN GlobalDim1Value:=JobTaskDim."Dimension Value Code";
                IF JobTaskDim."Dimension Code" = NewGlobalDim2Code THEN GlobalDim2Value:=JobTaskDim."Dimension Value Code";
            UNTIL JobTaskDim.Next() = 0;
    end;
    local procedure OpenIndicator()
    begin
        IndicatorWindow.OPEN(Text005 + Text006 + Text007 + Text008 + Text009 + Text010 + Text011 + Text012 + Text013);
    end;
    local procedure UpdateGeneralInfo(CompanyName: Text[100]; TableName: Text[50]; CurrentTableRecords: Integer)
    begin
        TableRecords:=CurrentTableRecords;
        CheckedTableRecords:=0;
        IndicatorWindow.UPDATE(1, DatabaseRecords);
        IF DatabaseRecords <> 0 THEN IndicatorWindow.UPDATE(2, ROUND(CheckedDatabaseRecords / DatabaseRecords * 10000, 1))
        ELSE
            IndicatorWindow.UPDATE(2, 0);
        IF CheckedDatabaseRecords <> 0 THEN IndicatorWindow.UPDATE(3, CalcEndingTime(TODAY, TIME))
        ELSE
            IndicatorWindow.UPDATE(3, Text014);
        IndicatorWindow.UPDATE(4, CompanyName);
        IndicatorWindow.UPDATE(5, TableName);
        IndicatorWindow.UPDATE(6, CurrentTableRecords);
        CheckedDatabaseRecords:=CheckedDatabaseRecords + CurrentTableRecords;
    end;
    local procedure UpdateProgressInfo()
    begin
        IF TableRecords <> 0 THEN IndicatorWindow.UPDATE(7, ROUND(CheckedTableRecords / TableRecords * 10000, 1))
        ELSE
            IndicatorWindow.UPDATE(7, 0);
    end;
    local procedure CalcEndingTime(PresentDate: Date; PresentTime: Time): Text[250]var
        RemainingTime: Integer;
        EndingDate: Date;
        EndingTime: Time;
    begin
        IF PresentDate > StartDate THEN RemainingTime:=((PresentDate - StartDate) * 8640000) + (235959T - StartTime) + (PresentTime - 000000T)
        ELSE
            RemainingTime:=(PresentTime - StartTime);
        RemainingTime:=ROUND((RemainingTime / CheckedDatabaseRecords) * (DatabaseRecords - CheckedDatabaseRecords), 1);
        EndingDate:=StartDate + ABS(ROUND(RemainingTime / 360000, 1));
        EndingTime:=StartTime + ABS(ROUND(RemainingTime MOD 360000, 1));
        IF EndingTime < StartTime THEN EndingDate:=EndingDate + 1;
        EXIT(FORMAT(EndingDate) + ' ' + FORMAT(EndingTime, 0, Text015));
    end;
    procedure InitializeRequest(NewGlobalDim1CodeFrom: Code[20]; NewGlobalDim2CodeFrom: Code[20])
    begin
        NewGlobalDim1Code:=NewGlobalDim1CodeFrom;
        NewGlobalDim2Code:=NewGlobalDim2CodeFrom;
    end;
    local procedure GetDefaultDim(No: Code[20]; Global1FieldRef: FieldRef; Global2FieldRef: FieldRef)
    begin
        Global1FieldRef.VALUE:='';
        Global2FieldRef.VALUE:='';
        DefaultDim.SETRANGE("Table ID", Global1FieldRef.RECORD.NUMBER);
        DefaultDim.SETRANGE("No.", No);
        IF DefaultDim.FindSet()then REPEAT IF DefaultDim."Dimension Code" = NewGlobalDim1Code THEN Global1FieldRef.VALUE:=DefaultDim."Dimension Value Code";
                IF DefaultDim."Dimension Code" = NewGlobalDim2Code THEN Global2FieldRef.VALUE:=DefaultDim."Dimension Value Code";
            UNTIL DefaultDim.Next() = 0;
    end;
    local procedure AddToDefaultDimTempTable(TableNo: Integer; Global1FieldNo: Integer; Global2FieldNo: Integer; IDFieldNo: Integer)
    begin
        AddToTempTable(TempDefaultDimDimensionsFieldMap, TableNo, Global1FieldNo, Global2FieldNo, IDFieldNo);
    end;
    local procedure AddToDimSetTempTable(TableNo: Integer; Global1FieldNo: Integer; Global2FieldNo: Integer; IDFieldNo: Integer)
    begin
        AddToTempTable(TempDimSetDimensionsFieldMap, TableNo, Global1FieldNo, Global2FieldNo, IDFieldNo);
    end;
    local procedure ChangeGlobalsInTables(TempTableOption: Option DefaultDimTables, DimSetTables)
    var
        FieldRecordRef: RecordRef;
        TempRecRef: RecordRef;
        TableNoFieldRef: FieldRef;
        TableNumber: Integer;
        TableNoFieldNumber: Integer;
    begin
        CASE TempTableOption OF TempTableOption::DefaultDimTables: FieldRecordRef.GETTABLE(TempDefaultDimDimensionsFieldMap);
        TempTableOption::DimSetTables: FieldRecordRef.GETTABLE(TempDimSetDimensionsFieldMap);
        END;
        // Get the field no when the "Table No." is stored.
        TableNoFieldNumber:=TempDimSetDimensionsFieldMap.FIELDNO("Table No.");
        TableNoFieldRef:=FieldRecordRef.FIELD(TableNoFieldNumber);
        IF FieldRecordRef.FINDSET THEN BEGIN
            REPEAT TableNumber:=TableNoFieldRef.VALUE;
                TempRecRef.OPEN(TableNumber);
                CASE TempTableOption OF TempTableOption::DefaultDimTables: ChangeGlobalsWithDefaultDim(TempRecRef);
                TempTableOption::DimSetTables: ChangeGlobalsWithDimensionSet(TempRecRef);
                END;
                TempRecRef.Close();
            UNTIL FieldRecordRef.NEXT = 0;
        END end;
    local procedure ChangeGlobalsWithDefaultDim(RecordRefForProcessing: RecordRef)
    var
        Global1FieldNo: Integer;
        Global2FieldNo: Integer;
        NoFieldNo: Integer;
        No: Code[20];
    begin
        GetFieldNumbersFromTempTable(TempDefaultDimDimensionsFieldMap, RecordRefForProcessing.NUMBER, Global1FieldNo, Global2FieldNo, NoFieldNo);
        UpdateGeneralInfo(COMPANYNAME, RecordRefForProcessing.CAPTION, RecordRefForProcessing.COUNT);
        IF RecordRefForProcessing.FINDFIRST THEN BEGIN
            REPEAT No:=RecordRefForProcessing.FIELD(NoFieldNo).VALUE;
                GetDefaultDim(No, RecordRefForProcessing.FIELD(Global1FieldNo), RecordRefForProcessing.FIELD(Global2FieldNo));
                RecordRefForProcessing.Modify();
                CheckedTableRecords:=CheckedTableRecords + 1;
                UpdateProgressInfo;
            UNTIL RecordRefForProcessing.NEXT = 0;
        END;
    end;
    local procedure ChangeGlobalsWithDimensionSet(RecordRefForProcessing: RecordRef)
    var
        Global1FieldNo: Integer;
        Global2FieldNo: Integer;
        DimSetIDFieldNo: Integer;
        DimSetID: Integer;
    begin
        GetFieldNumbersFromTempTable(TempDimSetDimensionsFieldMap, RecordRefForProcessing.NUMBER, Global1FieldNo, Global2FieldNo, DimSetIDFieldNo);
        UpdateGeneralInfo(COMPANYNAME, RecordRefForProcessing.CAPTION, RecordRefForProcessing.COUNT);
        IF RecordRefForProcessing.FIND('-')THEN BEGIN
            REPEAT DimSetID:=RecordRefForProcessing.FIELD(DimSetIDFieldNo).VALUE;
                GetDimSetEntry(DimSetID, RecordRefForProcessing.FIELD(Global1FieldNo), RecordRefForProcessing.FIELD(Global2FieldNo));
                RecordRefForProcessing.Modify();
                CheckedTableRecords:=CheckedTableRecords + 1;
                UpdateProgressInfo;
            UNTIL RecordRefForProcessing.NEXT = 0;
        END;
    end;
    local procedure GetDimSetEntry(DimSetID: Integer; Global1FieldRef: FieldRef; Global2FieldRef: FieldRef)
    begin
        Global1FieldRef.VALUE:='';
        Global2FieldRef.VALUE:='';
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        IF DimSetEntry.FindSet()then REPEAT IF DimSetEntry."Dimension Code" = NewGlobalDim1Code THEN Global1FieldRef.VALUE:=DimSetEntry."Dimension Value Code";
                IF DimSetEntry."Dimension Code" = NewGlobalDim2Code THEN Global2FieldRef.VALUE:=DimSetEntry."Dimension Value Code";
            UNTIL DimSetEntry.Next() = 0;
    end;
    local procedure CountRowsAndLockExceptionalCases()
    var
        TempRecRef: RecordRef;
    begin
        TempRecRef.GETTABLE(SalesLineArchive);
        CountRowsAndLock(TempRecRef, DatabaseRecords);
        TempRecRef.GETTABLE(PurchLineArchive);
        CountRowsAndLock(TempRecRef, DatabaseRecords);
        TempRecRef.GETTABLE(CustLedgEntry);
        CountRowsAndLock(TempRecRef, DatabaseRecords);
        TempRecRef.GETTABLE(VendorLedgEntry);
        CountRowsAndLock(TempRecRef, DatabaseRecords);
        TempRecRef.GETTABLE(JobTask);
        CountRowsAndLock(TempRecRef, DatabaseRecords);
    end;
    local procedure UpdateExceptionalCases()
    var
        TempRecRef: RecordRef;
    begin
        UpdateGeneralInfo(COMPANYNAME, SalesLineArchive.TABLECAPTION, SalesLineArchive.COUNT);
        SalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Line No.", "Doc. No. Occurrence", "Version No.");
        IF SalesLineArchive.FIND('-')THEN BEGIN
            REPEAT TempRecRef.GETTABLE(SalesLineArchive);
                GetDimSetEntry(SalesLineArchive."Dimension Set ID", TempRecRef.FIELD(SalesLineArchive.FIELDNO("Shortcut Dimension 1 Code")), TempRecRef.FIELD(SalesLineArchive.FIELDNO("Shortcut Dimension 2 Code")));
                SalesLineArchive.Modify();
                CheckedTableRecords:=CheckedTableRecords + 1;
                UpdateProgressInfo;
            UNTIL SalesLineArchive.NEXT = 0;
        END;
        UpdateGeneralInfo(COMPANYNAME, PurchLineArchive.TABLECAPTION, PurchLineArchive.COUNT);
        PurchLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Line No.", "Doc. No. Occurrence", "Version No.");
        IF PurchLineArchive.FIND('-')THEN BEGIN
            REPEAT TempRecRef.GETTABLE(PurchLineArchive);
                GetDimSetEntry(PurchLineArchive."Dimension Set ID", TempRecRef.FIELD(PurchLineArchive.FIELDNO("Shortcut Dimension 1 Code")), TempRecRef.FIELD(PurchLineArchive.FIELDNO("Shortcut Dimension 2 Code")));
                PurchLineArchive.Modify();
                CheckedTableRecords:=CheckedTableRecords + 1;
                UpdateProgressInfo;
            UNTIL PurchLineArchive.NEXT = 0;
        END;
        UpdateGeneralInfo(COMPANYNAME, CustLedgEntry.TABLECAPTION, CustLedgEntry.COUNT);
        DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.");
        IF CustLedgEntry.FIND('-')THEN BEGIN
            REPEAT TempRecRef.GETTABLE(CustLedgEntry);
                GetDimSetEntry(CustLedgEntry."Dimension Set ID", TempRecRef.FIELD(CustLedgEntry.FIELDNO("Global Dimension 1 Code")), TempRecRef.FIELD(CustLedgEntry.FIELDNO("Global Dimension 2 Code")));
                CustLedgEntry.Modify();
                DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                IF DtldCustLedgEntry.FIND('-')THEN REPEAT DtldCustLedgEntry."Initial Entry Global Dim. 1":=CustLedgEntry."Global Dimension 1 Code";
                        DtldCustLedgEntry."Initial Entry Global Dim. 2":=CustLedgEntry."Global Dimension 2 Code";
                        DtldCustLedgEntry.Modify();
                    UNTIL DtldCustLedgEntry.Next() = 0;
                CheckedTableRecords:=CheckedTableRecords + 1;
                UpdateProgressInfo;
            UNTIL CustLedgEntry.NEXT = 0;
        END;
        UpdateGeneralInfo(COMPANYNAME, VendorLedgEntry.TABLECAPTION, VendorLedgEntry.COUNT);
        DtldVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.");
        IF VendorLedgEntry.FIND('-')THEN BEGIN
            REPEAT TempRecRef.GETTABLE(VendorLedgEntry);
                GetDimSetEntry(VendorLedgEntry."Dimension Set ID", TempRecRef.FIELD(VendorLedgEntry.FIELDNO("Global Dimension 1 Code")), TempRecRef.FIELD(VendorLedgEntry.FIELDNO("Global Dimension 2 Code")));
                VendorLedgEntry.Modify();
                DtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntry."Entry No.");
                IF DtldVendLedgEntry.FIND('-')THEN REPEAT DtldVendLedgEntry."Initial Entry Global Dim. 1":=VendorLedgEntry."Global Dimension 1 Code";
                        DtldVendLedgEntry."Initial Entry Global Dim. 2":=VendorLedgEntry."Global Dimension 2 Code";
                        DtldVendLedgEntry.Modify();
                    UNTIL DtldVendLedgEntry.Next() = 0;
                CheckedTableRecords:=CheckedTableRecords + 1;
                UpdateProgressInfo;
            UNTIL VendorLedgEntry.NEXT = 0;
        END;
        UpdateGeneralInfo(COMPANYNAME, JobTask.TABLECAPTION, JobTask.COUNT);
        IF JobTask.FINDSET THEN BEGIN
            REPEAT GetDefaultJobTaskDim(JobTask."Job No.", JobTask."Job Task No.", JobTask."Global Dimension 1 Code", JobTask."Global Dimension 2 Code");
                JobTask.Modify();
                CheckedTableRecords:=CheckedTableRecords + 1;
                UpdateProgressInfo;
            UNTIL JobTask.NEXT = 0;
        END;
    end;
    local procedure CountRowsAndLock(RecRef: RecordRef; var NumberOfRecords: Integer)
    begin
        RecRef.LOCKTABLE;
        IF RecRef.FINDLAST THEN;
        NumberOfRecords:=NumberOfRecords + RecRef.COUNT;
    end;
    local procedure CountRowsAndLockTable(var TempDimensionsFieldMap: Record 8383 temporary)
    var
        TempRecRef: RecordRef;
    begin
        TempDimensionsFieldMap.FINDSET;
        REPEAT TempRecRef.OPEN(TempDimensionsFieldMap."Table No.");
            CountRowsAndLock(TempRecRef, DatabaseRecords);
            TempRecRef.Close();
        UNTIL TempDimensionsFieldMap.NEXT = 0;
    end;
    local procedure AddToTempTable(var TempDimensionsFieldMap: Record 8383 temporary; TableNo: Integer; Global1FieldNo: Integer; Global2FieldNo: Integer; IDFieldNo: Integer)
    begin
        // populate the table with rows of the field numbers that we will use.
        TempDimensionsFieldMap."Table No.":=TableNo;
        TempDimensionsFieldMap."Global Dim.1 Field No.":=Global1FieldNo;
        TempDimensionsFieldMap."Global Dim.2 Field No.":=Global2FieldNo;
        TempDimensionsFieldMap."ID Field No.":=IDFieldNo;
        TempDimensionsFieldMap.Insert();
    end;
    local procedure GetFieldNumbersFromTempTable(var TempDimensionsFieldMap: Record 8383 temporary; TableNo: Integer; var Global1FieldNo: Integer; var Global2FieldNo: Integer; var IDFieldNo: Integer)
    begin
        TempDimensionsFieldMap.GET(TableNo);
        Global1FieldNo:=TempDimensionsFieldMap."Global Dim.1 Field No.";
        Global2FieldNo:=TempDimensionsFieldMap."Global Dim.2 Field No.";
        IDFieldNo:=TempDimensionsFieldMap."ID Field No.";
    end;
    procedure InitializeTablesForModification()
    begin
        TempDefaultDimDimensionsFieldMap.DeleteAll();
        TempDimSetDimensionsFieldMap.DeleteAll();
        AddingDefaultValueDim;
        // Initialize the tables using the Dimension Set
        AddToDimSetTempTable(DATABASE::"G/L Entry", GLEntry.FIELDNO("Global Dimension 1 Code"), GLEntry.FIELDNO("Global Dimension 2 Code"), GLEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Cust. Ledger Entry", CustLedgEntry.FIELDNO("Global Dimension 1 Code"), CustLedgEntry.FIELDNO("Global Dimension 2 Code"), CustLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Vendor Ledger Entry", VendorLedgEntry.FIELDNO("Global Dimension 1 Code"), VendorLedgEntry.FIELDNO("Global Dimension 2 Code"), VendorLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Item Ledger Entry", ItemLedgEntry.FIELDNO("Global Dimension 1 Code"), ItemLedgEntry.FIELDNO("Global Dimension 2 Code"), ItemLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Job Ledger Entry", JobLedgEntry.FIELDNO("Global Dimension 1 Code"), JobLedgEntry.FIELDNO("Global Dimension 2 Code"), JobLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Res. Ledger Entry", ResLedgEntry.FIELDNO("Global Dimension 1 Code"), ResLedgEntry.FIELDNO("Global Dimension 2 Code"), ResLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Value Entry", ValueEntry.FIELDNO("Global Dimension 1 Code"), ValueEntry.FIELDNO("Global Dimension 2 Code"), ValueEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Capacity Ledger Entry", CapLedgEntry.FIELDNO("Global Dimension 1 Code"), CapLedgEntry.FIELDNO("Global Dimension 2 Code"), CapLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Bank Account Ledger Entry", BankAccLedgEntry.FIELDNO("Global Dimension 1 Code"), BankAccLedgEntry.FIELDNO("Global Dimension 2 Code"), BankAccLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Phys. Inventory Ledger Entry", PhysInvtLedgEntry.FIELDNO("Global Dimension 1 Code"), PhysInvtLedgEntry.FIELDNO("Global Dimension 2 Code"), PhysInvtLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"FA Ledger Entry", FALedgEntry.FIELDNO("Global Dimension 1 Code"), FALedgEntry.FIELDNO("Global Dimension 2 Code"), FALedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Maintenance Ledger Entry", MaintenanceLedgEntry.FIELDNO("Global Dimension 1 Code"), MaintenanceLedgEntry.FIELDNO("Global Dimension 2 Code"), MaintenanceLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Ins. Coverage Ledger Entry", InsCovLedgEntry.FIELDNO("Global Dimension 1 Code"), InsCovLedgEntry.FIELDNO("Global Dimension 2 Code"), InsCovLedgEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Ledger Entry", ServiceLedgerEntry.FIELDNO("Global Dimension 1 Code"), ServiceLedgerEntry.FIELDNO("Global Dimension 2 Code"), ServiceLedgerEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Warranty Ledger Entry", WarrantyLedgerEntry.FIELDNO("Global Dimension 1 Code"), WarrantyLedgerEntry.FIELDNO("Global Dimension 2 Code"), WarrantyLedgerEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Gen. Journal Line", GenJnlLine.FIELDNO("Shortcut Dimension 1 Code"), GenJnlLine.FIELDNO("Shortcut Dimension 2 Code"), GenJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Item Journal Line", ItemJnlLine.FIELDNO("Shortcut Dimension 1 Code"), ItemJnlLine.FIELDNO("Shortcut Dimension 2 Code"), ItemJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Res. Journal Line", ResJnlLine.FIELDNO("Shortcut Dimension 1 Code"), ResJnlLine.FIELDNO("Shortcut Dimension 2 Code"), ResJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Job Journal Line", JobJnlLine.FIELDNO("Shortcut Dimension 1 Code"), JobJnlLine.FIELDNO("Shortcut Dimension 2 Code"), JobJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Gen. Jnl. Allocation", GenJnlAlloc.FIELDNO("Shortcut Dimension 1 Code"), GenJnlAlloc.FIELDNO("Shortcut Dimension 2 Code"), GenJnlAlloc.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Requisition Line", ReqLine.FIELDNO("Shortcut Dimension 1 Code"), ReqLine.FIELDNO("Shortcut Dimension 2 Code"), ReqLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"FA Journal Line", FAJnlLine.FIELDNO("Shortcut Dimension 1 Code"), FAJnlLine.FIELDNO("Shortcut Dimension 2 Code"), FAJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Insurance Journal Line", InsuranceJnlLine.FIELDNO("Shortcut Dimension 1 Code"), InsuranceJnlLine.FIELDNO("Shortcut Dimension 2 Code"), InsuranceJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Planning Component", PlanningComponent.FIELDNO("Shortcut Dimension 1 Code"), PlanningComponent.FIELDNO("Shortcut Dimension 2 Code"), PlanningComponent.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Standard General Journal Line", StdGenJnlLine.FIELDNO("Shortcut Dimension 1 Code"), StdGenJnlLine.FIELDNO("Shortcut Dimension 2 Code"), StdGenJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Standard Item Journal Line", StdItemJnlLine.FIELDNO("Shortcut Dimension 1 Code"), StdItemJnlLine.FIELDNO("Shortcut Dimension 2 Code"), StdItemJnlLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Header", SalesHeader.FIELDNO("Shortcut Dimension 1 Code"), SalesHeader.FIELDNO("Shortcut Dimension 2 Code"), SalesHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Line", SalesLine.FIELDNO("Shortcut Dimension 1 Code"), SalesLine.FIELDNO("Shortcut Dimension 2 Code"), SalesLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purchase Header", PurchHeader.FIELDNO("Shortcut Dimension 1 Code"), PurchHeader.FIELDNO("Shortcut Dimension 2 Code"), PurchHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purchase Line", PurchLine.FIELDNO("Shortcut Dimension 1 Code"), PurchLine.FIELDNO("Shortcut Dimension 2 Code"), PurchLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Standard Sales Line", StdSalesLine.FIELDNO("Shortcut Dimension 1 Code"), StdSalesLine.FIELDNO("Shortcut Dimension 2 Code"), StdSalesLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Standard Purchase Line", StdPurchLine.FIELDNO("Shortcut Dimension 1 Code"), StdPurchLine.FIELDNO("Shortcut Dimension 2 Code"), StdPurchLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Reminder Header", ReminderHeader.FIELDNO("Shortcut Dimension 1 Code"), ReminderHeader.FIELDNO("Shortcut Dimension 2 Code"), ReminderHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Finance Charge Memo Header", FinChrgMemoHeader.FIELDNO("Shortcut Dimension 1 Code"), FinChrgMemoHeader.FIELDNO("Shortcut Dimension 2 Code"), FinChrgMemoHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Header", ServHeader.FIELDNO("Shortcut Dimension 1 Code"), ServHeader.FIELDNO("Shortcut Dimension 2 Code"), ServHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Item Line", ServItemLine.FIELDNO("Shortcut Dimension 1 Code"), ServItemLine.FIELDNO("Shortcut Dimension 2 Code"), ServItemLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Line", ServLine.FIELDNO("Shortcut Dimension 1 Code"), ServLine.FIELDNO("Shortcut Dimension 2 Code"), ServLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Header Archive", SalesHeaderArchive.FIELDNO("Shortcut Dimension 1 Code"), SalesHeaderArchive.FIELDNO("Shortcut Dimension 2 Code"), SalesHeaderArchive.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purchase Header Archive", PurchHeaderArchive.FIELDNO("Shortcut Dimension 1 Code"), PurchHeaderArchive.FIELDNO("Shortcut Dimension 2 Code"), PurchHeaderArchive.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Transfer Header", TransferHeader.FIELDNO("Shortcut Dimension 1 Code"), TransferHeader.FIELDNO("Shortcut Dimension 2 Code"), TransferHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Transfer Line", TransferLine.FIELDNO("Shortcut Dimension 1 Code"), TransferLine.FIELDNO("Shortcut Dimension 2 Code"), TransferLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Standard Service Line", StdServLine.FIELDNO("Shortcut Dimension 1 Code"), StdServLine.FIELDNO("Shortcut Dimension 2 Code"), StdServLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Production Order", ProdOrder.FIELDNO("Shortcut Dimension 1 Code"), ProdOrder.FIELDNO("Shortcut Dimension 2 Code"), ProdOrder.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Prod. Order Line", ProdOrderLine.FIELDNO("Shortcut Dimension 1 Code"), ProdOrderLine.FIELDNO("Shortcut Dimension 2 Code"), ProdOrderLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Prod. Order Component", ProdOrderComp.FIELDNO("Shortcut Dimension 1 Code"), ProdOrderComp.FIELDNO("Shortcut Dimension 2 Code"), ProdOrderComp.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Shipment Header", SalesShptHeader.FIELDNO("Shortcut Dimension 1 Code"), SalesShptHeader.FIELDNO("Shortcut Dimension 2 Code"), SalesShptHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Shipment Line", SaleShptLine.FIELDNO("Shortcut Dimension 1 Code"), SaleShptLine.FIELDNO("Shortcut Dimension 2 Code"), SaleShptLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Invoice Header", SalesInvHeader.FIELDNO("Shortcut Dimension 1 Code"), SalesInvHeader.FIELDNO("Shortcut Dimension 2 Code"), SalesInvHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Invoice Line", SalesInvLine.FIELDNO("Shortcut Dimension 1 Code"), SalesInvLine.FIELDNO("Shortcut Dimension 2 Code"), SalesInvLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Return Receipt Header", ReturnRcptHeader.FIELDNO("Shortcut Dimension 1 Code"), ReturnRcptHeader.FIELDNO("Shortcut Dimension 2 Code"), ReturnRcptHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Return Receipt Line", ReturnRcptLine.FIELDNO("Shortcut Dimension 1 Code"), ReturnRcptLine.FIELDNO("Shortcut Dimension 2 Code"), ReturnRcptLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Cr.Memo Header", SalesCrMemoHeader.FIELDNO("Shortcut Dimension 1 Code"), SalesCrMemoHeader.FIELDNO("Shortcut Dimension 2 Code"), SalesCrMemoHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Cr.Memo Line", SalesCrMemoLine.FIELDNO("Shortcut Dimension 1 Code"), SalesCrMemoLine.FIELDNO("Shortcut Dimension 2 Code"), SalesCrMemoLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Shipment Header", ServShptHeader.FIELDNO("Shortcut Dimension 1 Code"), ServShptHeader.FIELDNO("Shortcut Dimension 2 Code"), ServShptHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Shipment Line", ServShptLine.FIELDNO("Shortcut Dimension 1 Code"), ServShptLine.FIELDNO("Shortcut Dimension 2 Code"), ServShptLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Invoice Header", ServInvHeader.FIELDNO("Shortcut Dimension 1 Code"), ServInvHeader.FIELDNO("Shortcut Dimension 2 Code"), ServInvHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Invoice Line", ServInvLine.FIELDNO("Shortcut Dimension 1 Code"), ServInvLine.FIELDNO("Shortcut Dimension 2 Code"), ServInvLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Cr.Memo Header", ServCrMemoHeader.FIELDNO("Shortcut Dimension 1 Code"), ServCrMemoHeader.FIELDNO("Shortcut Dimension 2 Code"), ServCrMemoHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Sales Cr.Memo Line", ServCrMemoLine.FIELDNO("Shortcut Dimension 1 Code"), ServCrMemoLine.FIELDNO("Shortcut Dimension 2 Code"), ServCrMemoLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purch. Rcpt. Header", PurchRcptHeader.FIELDNO("Shortcut Dimension 1 Code"), PurchRcptHeader.FIELDNO("Shortcut Dimension 2 Code"), PurchRcptHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purch. Rcpt. Line", PurchRcptLine.FIELDNO("Shortcut Dimension 1 Code"), PurchRcptLine.FIELDNO("Shortcut Dimension 2 Code"), PurchRcptLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purch. Inv. Header", PurchInvHeader.FIELDNO("Shortcut Dimension 1 Code"), PurchInvHeader.FIELDNO("Shortcut Dimension 2 Code"), PurchInvHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purch. Inv. Line", PurchInvLine.FIELDNO("Shortcut Dimension 1 Code"), PurchInvLine.FIELDNO("Shortcut Dimension 2 Code"), PurchInvLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Return Shipment Header", ReturnShptHeader.FIELDNO("Shortcut Dimension 1 Code"), ReturnShptHeader.FIELDNO("Shortcut Dimension 2 Code"), ReturnShptHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Return Shipment Line", ReturnShptLine.FIELDNO("Shortcut Dimension 1 Code"), ReturnShptLine.FIELDNO("Shortcut Dimension 2 Code"), ReturnShptLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purch. Cr. Memo Hdr.", PurchCrMemoHeader.FIELDNO("Shortcut Dimension 1 Code"), PurchCrMemoHeader.FIELDNO("Shortcut Dimension 2 Code"), PurchCrMemoHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Purch. Cr. Memo Line", PurchCrMemoLine.FIELDNO("Shortcut Dimension 1 Code"), PurchCrMemoLine.FIELDNO("Shortcut Dimension 2 Code"), PurchCrMemoLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Issued Reminder Header", IssuedReminderHeader.FIELDNO("Shortcut Dimension 1 Code"), IssuedReminderHeader.FIELDNO("Shortcut Dimension 2 Code"), IssuedReminderHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Issued Fin. Charge Memo Header", IssuedFinChrgMemoHeader.FIELDNO("Shortcut Dimension 1 Code"), IssuedFinChrgMemoHeader.FIELDNO("Shortcut Dimension 2 Code"), IssuedFinChrgMemoHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Transfer Shipment Header", TransferShipmentHeader.FIELDNO("Shortcut Dimension 1 Code"), TransferShipmentHeader.FIELDNO("Shortcut Dimension 2 Code"), TransferShipmentHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Transfer Shipment Line", TransferShipmentLine.FIELDNO("Shortcut Dimension 1 Code"), TransferShipmentLine.FIELDNO("Shortcut Dimension 2 Code"), TransferShipmentLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Transfer Receipt Header", TransferReceiptHeader.FIELDNO("Shortcut Dimension 1 Code"), TransferReceiptHeader.FIELDNO("Shortcut Dimension 2 Code"), TransferReceiptHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Transfer Receipt Line", TransferReceiptLine.FIELDNO("Shortcut Dimension 1 Code"), TransferReceiptLine.FIELDNO("Shortcut Dimension 2 Code"), TransferReceiptLine.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"G/L Budget Entry", GLBudgetEntry.FIELDNO("Global Dimension 1 Code"), GLBudgetEntry.FIELDNO("Global Dimension 2 Code"), GLBudgetEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"FA Allocation", FAAlloc.FIELDNO("Global Dimension 1 Code"), FAAlloc.FIELDNO("Global Dimension 2 Code"), FAAlloc.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Service Contract Header", ServCtrHeader.FIELDNO("Shortcut Dimension 1 Code"), ServCtrHeader.FIELDNO("Shortcut Dimension 2 Code"), ServCtrHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Filed Service Contract Header", FiledServCtrHeader.FIELDNO("Shortcut Dimension 1 Code"), FiledServCtrHeader.FIELDNO("Shortcut Dimension 2 Code"), FiledServCtrHeader.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Job WIP Entry", JobWIPEntry.FIELDNO("Global Dimension 1 Code"), JobWIPEntry.FIELDNO("Global Dimension 2 Code"), JobWIPEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Job WIP G/L Entry", JobWIPGLEntry.FIELDNO("Global Dimension 1 Code"), JobWIPGLEntry.FIELDNO("Global Dimension 2 Code"), JobWIPGLEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Item Budget Entry", ItemBudgetEntry.FIELDNO("Global Dimension 1 Code"), ItemBudgetEntry.FIELDNO("Global Dimension 2 Code"), ItemBudgetEntry.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Cartera Doc.", CarteraDoc.FIELDNO("Global Dimension 1 Code"), CarteraDoc.FIELDNO("Global Dimension 2 Code"), CarteraDoc.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Posted Cartera Doc.", PostedCarteraDoc.FIELDNO("Global Dimension 1 Code"), PostedCarteraDoc.FIELDNO("Global Dimension 2 Code"), PostedCarteraDoc.FIELDNO("Dimension Set ID"));
        AddToDimSetTempTable(DATABASE::"Closed Cartera Doc.", ClosedCarteraDoc.FIELDNO("Global Dimension 1 Code"), ClosedCarteraDoc.FIELDNO("Global Dimension 2 Code"), ClosedCarteraDoc.FIELDNO("Dimension Set ID"));
    end;
    local procedure AddingDefaultValueDim()
    begin
        AddToDefaultDimTempTable(DATABASE::"G/L Account", GLAcc.FIELDNO("Global Dimension 1 Code"), GLAcc.FIELDNO("Global Dimension 2 Code"), GLAcc.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::Customer, Cust.FIELDNO("Global Dimension 1 Code"), Cust.FIELDNO("Global Dimension 2 Code"), Cust.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::Vendor, Vend.FIELDNO("Global Dimension 1 Code"), Vend.FIELDNO("Global Dimension 2 Code"), Vend.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::Item, Item.FIELDNO("Global Dimension 1 Code"), Item.FIELDNO("Global Dimension 2 Code"), Item.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::"Resource Group", ResGr.FIELDNO("Global Dimension 1 Code"), ResGr.FIELDNO("Global Dimension 2 Code"), ResGr.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::Resource, Res.FIELDNO("Global Dimension 1 Code"), Res.FIELDNO("Global Dimension 2 Code"), Res.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::Job, Job.FIELDNO("Global Dimension 1 Code"), Job.FIELDNO("Global Dimension 2 Code"), Job.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::"Bank Account", BankAcc.FIELDNO("Global Dimension 1 Code"), BankAcc.FIELDNO("Global Dimension 2 Code"), BankAcc.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::Employee, Employee.FIELDNO("Global Dimension 1 Code"), Employee.FIELDNO("Global Dimension 2 Code"), Employee.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::"Fixed Asset", FA.FIELDNO("Global Dimension 1 Code"), FA.FIELDNO("Global Dimension 2 Code"), FA.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::Insurance, Insurance.FIELDNO("Global Dimension 1 Code"), Insurance.FIELDNO("Global Dimension 2 Code"), Insurance.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::"Responsibility Center", RespCenter.FIELDNO("Global Dimension 1 Code"), RespCenter.FIELDNO("Global Dimension 2 Code"), RespCenter.FIELDNO(Code));
        AddToDefaultDimTempTable(DATABASE::"Salesperson/Purchaser", SalespersonPurchaser.FIELDNO("Global Dimension 1 Code"), SalespersonPurchaser.FIELDNO("Global Dimension 2 Code"), SalespersonPurchaser.FIELDNO(Code));
        AddToDefaultDimTempTable(DATABASE::Campaign, Campaign.FIELDNO("Global Dimension 1 Code"), Campaign.FIELDNO("Global Dimension 2 Code"), Campaign.FIELDNO("No."));
        AddToDefaultDimTempTable( // SAR  -  2024 19 01  -  Correcion de tabla Customer Templ.
        DATABASE::"Customer Templ.", CustomerTemplate.FIELDNO("Global Dimension 1 Code"), // SAR  -  2024 19 01  -  Correcion de tabla Customer Templ. END
 CustomerTemplate.FIELDNO("Global Dimension 2 Code"), CustomerTemplate.FIELDNO(Code));
        AddToDefaultDimTempTable(DATABASE::"Item Charge", ItemCharge.FIELDNO("Global Dimension 1 Code"), ItemCharge.FIELDNO("Global Dimension 2 Code"), ItemCharge.FIELDNO("No."));
        AddToDefaultDimTempTable(DATABASE::"Work Center", WorkCenter.FIELDNO("Global Dimension 1 Code"), WorkCenter.FIELDNO("Global Dimension 2 Code"), WorkCenter.FIELDNO("No."));
    end;
}
