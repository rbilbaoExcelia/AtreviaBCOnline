codeunit 52005 "EventSuscribers AT"
{
    Permissions = tabledata "Job"=rimd,
        tabledata "Job Task"=rimd,
        tabledata "Job Ledger Entry"=rimd,
        tabledata "Job Planning Line"=rimd,
        tabledata "Job Posting Group"=rimd,
        tabledata "Job Register"=rimd,
        tabledata "Jobs Setup"=rimd,
        tabledata Customer=rimd,
        tabledata "Customer Posting Group"=rimd,
        tabledata "Bank Account Posting Group"=rimd,
        tabledata "Vendor"=rimd,
        tabledata "Vendor Posting Group"=rimd,
        tabledata "G/L Account"=rimd,
        tabledata "Dimension Value"=rimd,
        tabledata "Currency Exchange Rate"=rimd,
        tabledata "Vendor Bank Account"=rimd,
        tabledata "Customer Bank Account"=rimd,
    //3630 - ED
        tabledata "Default Dimension"=rimd,
    //3630 - ED END
    //3688 - APR - 2022 06 01
        tabledata "Sales Invoice Header"=rm,
        tabledata "Sales Cr.Memo Header"=rm;

    //3688 - APR - 2022 06 01 END
    var CduGenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    //3698 - JS 2022 06 07
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateJobFields', '', true, true)]
    local procedure "Purchase Line_OnBeforeUpdateJobFields"(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        GLAccount: Record "G/L Account";
    begin
        IF GLAccount.Get(PurchLine."No.")THEN //055
 IF GLAccount."Expenses Billable AT" THEN BEGIN
                PurchLine."Job Line Type":=PurchLine."Job Line Type"::Billable;
                PurchLine."Job Line Account No.":=PurchLine.CalcJobLineAccountNo(PurchLine);
            END;
    //055
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignGLAccountValues', '', true, true)]
    local procedure "Purchase Line_OnAfterAssignGLAccountValues"(var PurchLine: Record "Purchase Line"; GLAccount: Record "G/L Account")
    begin
        //055
        IF GLAccount."Expenses Billable AT" THEN BEGIN
            PurchLine."Job Line Type":=PurchLine."Job Line Type"::Billable;
            PurchLine."Job Line Account No.":=PurchLine.CalcJobLineAccountNo(PurchLine);
        END;
    //055
    end;
    //3698 - JS 2022 06 07 END
    /*
    // 064 OS.SPG  11/05/2017
    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnBeforeValidateBillToCustomerNo', '', true, true)]
    local procedure "Job_OnBeforeValidateBillToCustomerNo"
    (
        var Job: Record "Job";
        var IsHandled: Boolean
    )
    var
        Cust: Record Customer;
        Text50000: Label 'El cliente de facturación del cliente %1 debe ser '''' o igual al mismo No. Cliente';
    begin
        if Job."Bill-to Customer No." <> '' then begin
            Cust.Get(Job."Bill-to Customer No.");
            //064
            //Cust.TESTFIELD("Bill-to Customer No.",'');
            if (Cust."Bill-to Customer No." <> '') AND (Cust."Bill-to Customer No." <> Cust."No.") then
                ERROR(Text50000, Cust."No.");
            //064
        end;
    end;

    // MIGR OS.SPG 21/03/2017 MIGRACION, conservar la dimension original
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"
    (
        var GLEntry: Record "G/L Entry";
        var GenJournalLine: Record "Gen. Journal Line"
    )
    begin
        //MIGR
        GLEntry."Old Dimension Value" := GenJournalLine."Old Dimension";
        //MIGR
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateJobPrices', '', true, true)]
    local procedure "Purchase Line_OnAfterUpdateJobPrices"
    (
        var PurchLine: Record "Purchase Line";
        JobJnlLine: Record "Job Journal Line";
        PurchRcptLine: Record "Purch. Rcpt. Line"
    )
    begin
        //055
        JobJnlLine.VALIDATE("Line Discount %", PurchLine."Job Line Discount %");
        //05.
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterCreateTempJobJnlLine', '', true, true)]
    local procedure "Purchase Line_OnAfterCreateTempJobJnlLine"
    (
        var JobJournalLine: Record "Job Journal Line";
        PurchLine: Record "Purchase Line";
        xPurchLine: Record "Purchase Line";
        GetPrices: Boolean;
        CurrFieldNo: Integer
    )
    begin
        if GetPrices then
            JobJournalLine.VALIDATE("Unit Price", PurchLine."Job Unit Price");//055
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeCheckIfPostingDateIsEarlier', '', true, true)]
    local procedure "Gen. Journal Line_OnBeforeCheckIfPostingDateIsEarlier"
    (
        GenJournalLine: Record "Gen. Journal Line";
        ApplyPostingDate: Date;
        ApplyDocType: Option;
        ApplyDocNo: Code[20];
        var IsHandled: Boolean
    )
    begin
        IsHandled := true;//070
    end;


    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnBeforeEarlierPostingDateError', '', true, true)]
    local procedure "Apply Customer Entries_OnBeforeEarlierPostingDateError"
    (
        ApplyingCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        var RaiseError: Boolean;
        CalcType: Option
    )
    begin
        //300517
        RaiseError := false;
        //300517
    end;

    // 070 OS.SPG 08/05/2017 Permitir registrar pagos desde el diario que liquiden a facturas de proveedor ya registradas con fecha futura.
    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnBeforeEarlierPostingDateError', '', true, true)]
    local procedure "Apply Vendor Entries_OnBeforeEarlierPostingDateError"
    (
        ApplyingVendLedgEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        var RaiseError: Boolean;
        CalcType: Option
    )
    begin
        //070
        RaiseError := false;
        //070
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', true, true)]
    local procedure "Purch.-Post_OnAfterPostPurchaseDoc"
    (
        var PurchaseHeader: Record "Purchase Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchRcpHdrNo: Code[20];
        RetShptHdrNo: Code[20];
        PurchInvHdrNo: Code[20];
        PurchCrMemoHdrNo: Code[20];
        CommitIsSupressed: Boolean
    )
    begin
        //123
        //IF NOT SaltarMensaje THEN BEGIN//EX-OMI 311019
        IF NOT PurchaseHeader."Facturas de Gastos" THEN BEGIN
            IF PurchaseHeader."No." <> '' THEN MESSAGE(PurchaseHeader."No.");
            IF PurchCrMemoHdrNo <> '' THEN MESSAGE(PurchCrMemoHdrNo);
        END;
        //123
    end;

    //Multi company changes
    #region Acc. Schedule Line DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Acc. Schedule Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Acc. Schedule Line_OnAfterOnInsert"
    (
        var Rec: Record "Acc. Schedule Line";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Acc. Schedule Line";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Acc. Schedule Line", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Acc. Schedule Line_OnAfterModifyEvent"
    (
        var Rec: Record "Acc. Schedule Line";
        var xRec: Record "Acc. Schedule Line";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Acc. Schedule Line";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Schedule Name", Rec."Schedule Name");
                    RecModify.SetRange("Schedule Name", Rec."Schedule Name");
                    RecModify.SetRange("Line No.", Rec."Line No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Acc. Schedule Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Acc. Schedule Line_OnAfterDeleteEvent"
    (
        var Rec: Record "Acc. Schedule Line";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Acc. Schedule Line";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Schedule Name", Rec."Schedule Name");
                    RecDelete.SetRange("Schedule Name", Rec."Schedule Name");
                    RecDelete.SetRange("Line No.", Rec."Line No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Acc. Schedule Line
    #region Acc. Schedule Name DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Acc. Schedule Name", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Acc. Schedule Name_OnAfterOnInsert"
    (
        var Rec: Record "Acc. Schedule Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Acc. Schedule Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Acc. Schedule Name", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Acc. Schedule Name_OnAfterModifyEvent"
    (
        var Rec: Record "Acc. Schedule Name";
        var xRec: Record "Acc. Schedule Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Acc. Schedule Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Name", Rec."Name");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Acc. Schedule Name", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Acc. Schedule Name_OnAfterDeleteEvent"
    (
        var Rec: Record "Acc. Schedule Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Acc. Schedule Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Name", Rec."Name");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Acc. Schedule Name
    #region Area DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Area", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Area_OnAfterOnInsert"
    (
        var Rec: Record "Area";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Area";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Area", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Area_OnAfterModifyEvent"
    (
        var Rec: Record "Area";
        var xRec: Record "Area";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Area";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Area", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Area_OnAfterDeleteEvent"
    (
        var Rec: Record "Area";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Area";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Area
    */
    #region Bank Account Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Bank Account Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Bank Account Posting Group_OnAfterOnInsert"(var Rec: Record "Bank Account Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Bank Account Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Reset();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.SetRange("Code", Rec."Code");
                        if not RecInsert.FindFirst()then begin
                            RecInsert.Init();
                            RecInsert.ChangeCompany(Company.Name);
                            RecInsert.TransferFields(Rec);
                            RecInsert.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Bank Account Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Bank Account Posting Group_OnAfterModifyEvent"(var Rec: Record "Bank Account Posting Group"; var xRec: Record "Bank Account Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Bank Account Posting Group";
        StartCompany: Text;
        RecCompanyInf: Record "Company Information";
        RecCompanyInf2: Record "Company Information";
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            RecCompanyInf2.Get();
            if not(RecCompanyInf2."Omite Comparticion Datos")then begin
                Company.Reset();
                if Company.FindSet()then repeat RecCompanyInf.Reset();
                        RecCompanyInf.ChangeCompany(Company.Name);
                        RecCompanyInf.Get();
                        if not(RecCompanyInf."Omite Comparticion Datos")then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);
                            RecModify.SetRange("Code", Rec."Code");
                            if RecModify.FindFirst()then begin
                                RecModify.TransferFields(Rec, false);
                                RecModify.Modify(false);
                            end
                            else
                            begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Bank Account Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Bank Account Posting Group_OnAfterDeleteEvent"(var Rec: Record "Bank Account Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Bank Account Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Code", Rec."Code");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Bank Account Posting Group
    /*
    #region Column Layout Name DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Column Layout Name", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Column Layout Name_OnAfterOnInsert"
    (
        var Rec: Record "Column Layout Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Column Layout Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Column Layout Name", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Column Layout Name_OnAfterModifyEvent"
    (
        var Rec: Record "Column Layout Name";
        var xRec: Record "Column Layout Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Column Layout Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Name", Rec."Name");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Column Layout Name", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Column Layout Name_OnAfterDeleteEvent"
    (
        var Rec: Record "Column Layout Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Column Layout Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Name", Rec."Name");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Column Layout Name
    #region Column Layout DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Column Layout", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Column Layout_OnAfterOnInsert"
    (
        var Rec: Record "Column Layout";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Column Layout";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Column Layout", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Column Layout_OnAfterModifyEvent"
    (
        var Rec: Record "Column Layout";
        var xRec: Record "Column Layout";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Column Layout";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Column Layout Name", Rec."Column Layout Name");
                    RecModify.SetRange("Line No.", Rec."Line No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Column Layout", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Column Layout_OnAfterDeleteEvent"
    (
        var Rec: Record "Column Layout";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Column Layout";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Column Layout Name", Rec."Column Layout Name");
                    RecDelete.SetRange("Line No.", Rec."Line No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Column Layout
    #region Country/Region DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Country/Region", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Country/Region_OnAfterOnInsert"
    (
        var Rec: Record "Country/Region";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Country/Region";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Country/Region", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Country/Region_OnAfterModifyEvent"
    (
        var Rec: Record "Country/Region";
        var xRec: Record "Country/Region";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Country/Region";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Country/Region", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Country/Region_OnAfterDeleteEvent"
    (
        var Rec: Record "Country/Region";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Country/Region";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Country/Region
    
    #region Currency DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Currency", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Currency_OnAfterOnInsert"
    (
        var Rec: Record "Currency";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Currency";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Currency", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Currency_OnAfterModifyEvent"
    (
        var Rec: Record "Currency";
        var xRec: Record "Currency";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Currency";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Currency", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Currency_OnAfterDeleteEvent"
    (
        var Rec: Record "Currency";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Currency";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Currency
    #region Customer Bank Account DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Customer Bank Account_OnAfterOnInsert"
    (
        var Rec: Record "Customer Bank Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Customer Bank Account";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Customer Bank Account_OnAfterModifyEvent"
    (
        var Rec: Record "Customer Bank Account";
        var xRec: Record "Customer Bank Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Customer Bank Account";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Customer No.", Rec."Customer No.");
                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Customer Bank Account_OnAfterDeleteEvent"
    (
        var Rec: Record "Customer Bank Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Customer Bank Account";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Customer No.", Rec."Customer No.");
                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Customer Bank Account
    */
    #region Customer Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Customer Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Customer Posting Group_OnAfterOnInsert"(var Rec: Record "Customer Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Customer Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Reset();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.SetRange("Code", Rec."Code");
                        if not RecInsert.FindFirst()then begin
                            RecInsert.Init();
                            RecInsert.ChangeCompany(Company.Name);
                            RecInsert.TransferFields(Rec);
                            if not RecInsert.get(Rec.code)then RecInsert.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Customer Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Customer Posting Group_OnAfterModifyEvent"(var Rec: Record "Customer Posting Group"; var xRec: Record "Customer Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Customer Posting Group";
        StartCompany: Text;
        RecCompanyInf: Record "Company Information";
        RecCompanyInf2: Record "Company Information";
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            RecCompanyInf2.Get();
            if not(RecCompanyInf2."Omite Comparticion Datos")then begin
                Company.Reset();
                if Company.FindSet()then repeat RecCompanyInf.Reset();
                        RecCompanyInf.ChangeCompany(Company.Name);
                        RecCompanyInf.Get();
                        if not(RecCompanyInf."Omite Comparticion Datos")then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);
                            RecModify.SetRange("Code", Rec."Code");
                            if RecModify.FindFirst()then begin
                                RecModify.TransferFields(Rec, false);
                                RecModify.Modify(false);
                            end
                            else
                            begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Customer Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Customer Posting Group_OnAfterDeleteEvent"(var Rec: Record "Customer Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Customer Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Code", Rec."Code");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Customer Posting Group
    #region Customer DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Customer_OnAfterOnInsert"(var Rec: Record "Customer"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Customer";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Reset();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.SetRange("No.", Rec."No.");
                        if not RecInsert.FindFirst()then begin
                            RecInsert.Init();
                            RecInsert.ChangeCompany(Company.Name);
                            RecInsert.TransferFields(Rec);
                            if not RecInsert.get(Rec."No.")then RecInsert.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Customer_OnAfterModifyEvent"(var Rec: Record "Customer"; var xRec: Record "Customer"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Customer";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("No.", Rec."No.");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Customer_OnAfterDeleteEvent"(var Rec: Record "Customer"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Customer";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("No.", Rec."No.");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Customer        
    //3630 - ED
    #region Default Dimension DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Default Dimension_OnAfterOnInsert"(var Rec: Record "Default Dimension"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Default Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            //if not GeneralLedgerSetup.OmmitAllCompanies then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.Get(Rec."Table ID", rec."No.", rec."Dimension Code")then RecInsert.Insert(false)
                        else
                            RecInsert.Modify();
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Default Dimension_OnAfterModifyEvent"(var Rec: Record "Default Dimension"; var xRec: Record "Default Dimension"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Default Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            GeneralLedgerSetup.get();
            //if not GeneralLedgerSetup.OmmitAllCompanies then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Table ID", Rec."Table ID");
                        RecModify.SetRange("No.", Rec."No.");
                        RecModify.SetRange("Dimension Code", Rec."Dimension Code");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        //end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Default Dimension_OnAfterDeleteEvent"(var Rec: Record "Default Dimension"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Default Dimension";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Table ID", Rec."Table ID");
                        RecDelete.SetRange("No.", Rec."No.");
                        RecDelete.SetRange("Dimension Code", Rec."Dimension Code");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Default Dimension
    //3630 - ED END
    /*
    #region Dimension Set Entry DataPerCompany    
    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Dimension Set Entry_OnAfterOnInsert"
    (
        var Rec: Record "Dimension Set Entry";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Dimension Set Entry";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Entry", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Dimension Set Entry_OnAfterModifyEvent"
    (
        var Rec: Record "Dimension Set Entry";
        var xRec: Record "Dimension Set Entry";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Dimension Set Entry";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                    RecModify.SetRange("Dimension Code", Rec."Dimension Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Entry", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Dimension Set Entry_OnAfterDeleteEvent"
    (
        var Rec: Record "Dimension Set Entry";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Dimension Set Entry";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                    RecDelete.SetRange("Dimension Code", Rec."Dimension Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Dimension Set Entry
    #region Dimension Set Tree Node DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Tree Node", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Dimension Set Tree Node_OnAfterOnInsert"
    (
        var Rec: Record "Dimension Set Tree Node";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Dimension Set Tree Node";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Tree Node", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Dimension Set Tree Node_OnAfterModifyEvent"
    (
        var Rec: Record "Dimension Set Tree Node";
        var xRec: Record "Dimension Set Tree Node";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Dimension Set Tree Node";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Parent Dimension Set ID", Rec."Parent Dimension Set ID");
                    RecModify.SetRange("Dimension Value ID", Rec."Dimension Value ID");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Tree Node", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Dimension Set Tree Node_OnAfterDeleteEvent"
    (
        var Rec: Record "Dimension Set Tree Node";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Dimension Set Tree Node";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Parent Dimension Set ID", Rec."Parent Dimension Set ID");
                    RecDelete.SetRange("Dimension Value ID", Rec."Dimension Value ID");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;    
    #endregion Dimension Set Tree Node
*/
    #region Dimension Value DataPerCompany    
    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Dimension Value_OnAfterOnInsert"(var Rec: Record "Dimension Value"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            GeneralLedgerSetup.get();
            //if not GeneralLedgerSetup.OmmitAllCompanies then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.Get(Rec."Dimension Code", rec.Code)then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        //end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Dimension Value_OnAfterModifyEvent"(var Rec: Record "Dimension Value"; var xRec: Record "Dimension Value"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            GeneralLedgerSetup.get();
            //if not GeneralLedgerSetup.OmmitAllCompanies then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Dimension Code", Rec."Dimension Code");
                        RecModify.SetRange("Code", Rec."Code");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            if RecModify.Modify(false)then;
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            if RecModify.Insert(false)then;
                        end;
                    end;
                until Company.Next() = 0;
        //end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Dimension Value_OnAfterDeleteEvent"(var Rec: Record "Dimension Value"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Dimension Value";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Dimension Code", Rec."Dimension Code");
                        RecDelete.SetRange("Code", Rec."Code");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Dimension Value
    /*
    #region Dimension DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Dimension", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Dimension_OnAfterOnInsert"
    (
        var Rec: Record "Dimension";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Dimension";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Dimension", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Dimension_OnAfterModifyEvent"
    (
        var Rec: Record "Dimension";
        var xRec: Record "Dimension";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            GeneralLedgerSetup.get();
            if not GeneralLedgerSetup.OmmitAllCompanies then begin
                StartCompany := CompanyName;
                Company.Reset();
                if Company.FindSet() then
                    repeat
                        if Company.Name <> StartCompany then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);

                            RecModify.SetRange("Code", Rec."Code");
                            if RecModify.FindFirst() then begin
                                RecModify.TransferFields(Rec);
                                RecModify.Modify(false);
                            end else begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Dimension", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Dimension_OnAfterDeleteEvent"
    (
        var Rec: Record "Dimension";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Dimension";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Dimension
    
    #region Gen. Business Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Gen. Business Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Gen. Business Posting Group_OnAfterOnInsert"
    (
        var Rec: Record "Gen. Business Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Gen. Business Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Business Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Gen. Business Posting Group_OnAfterModifyEvent"
    (
        var Rec: Record "Gen. Business Posting Group";
        var xRec: Record "Gen. Business Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Gen. Business Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Business Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Gen. Business Posting Group_OnAfterDeleteEvent"
    (
        var Rec: Record "Gen. Business Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Gen. Business Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Gen. Business Posting Group
    #region Gen. Product Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Gen. Product Posting Group_OnAfterOnInsert"
    (
        var Rec: Record "Gen. Product Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Gen. Product Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Gen. Product Posting Group_OnAfterModifyEvent"
    (
        var Rec: Record "Gen. Product Posting Group";
        var xRec: Record "Gen. Product Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Gen. Product Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Gen. Product Posting Group_OnAfterDeleteEvent"
    (
        var Rec: Record "Gen. Product Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Gen. Product Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Gen. Product Posting Group
    #region General Posting Setup DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"General Posting Setup", 'OnAfterInsertEvent', '', true, true)]
    local procedure "General Posting Setup_OnAfterOnInsert"
    (
        var Rec: Record "General Posting Setup";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "General Posting Setup";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"General Posting Setup", 'OnAfterModifyEvent', '', true, true)]
    local procedure "General Posting Setup_OnAfterModifyEvent"
    (
        var Rec: Record "General Posting Setup";
        var xRec: Record "General Posting Setup";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "General Posting Setup";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Gen. Bus. Posting Group", Rec."Gen. Bus. Posting Group");
                    RecModify.SetRange("Gen. Prod. Posting Group", Rec."Gen. Prod. Posting Group");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"General Posting Setup", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "General Posting Setup_OnAfterDeleteEvent"
    (
        var Rec: Record "General Posting Setup";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "General Posting Setup";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Gen. Bus. Posting Group", Rec."Gen. Bus. Posting Group");
                    RecDelete.SetRange("Gen. Prod. Posting Group", Rec."Gen. Prod. Posting Group");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion General Posting Setup
    #region Historic G/L Account DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Historic G/L Account", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Historic G/L Account_OnAfterOnInsert"
    (
        var Rec: Record "Historic G/L Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Historic G/L Account";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Historic G/L Account", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Historic G/L Account_OnAfterModifyEvent"
    (
        var Rec: Record "Historic G/L Account";
        var xRec: Record "Historic G/L Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Historic G/L Account";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("No.", Rec."No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Historic G/L Account", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Historic G/L Account_OnAfterDeleteEvent"
    (
        var Rec: Record "Historic G/L Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Historic G/L Account";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("No.", Rec."No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Historic G/L Account
    #region Inventory Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Inventory Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Inventory Posting Group_OnAfterOnInsert"
    (
        var Rec: Record "Inventory Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Inventory Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Inventory Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Inventory Posting Group_OnAfterModifyEvent"
    (
        var Rec: Record "Inventory Posting Group";
        var xRec: Record "Inventory Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Inventory Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Inventory Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Inventory Posting Group_OnAfterDeleteEvent"
    (
        var Rec: Record "Inventory Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Inventory Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Inventory Posting Group
    #region Item Category DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Item Category", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Item Category_OnAfterOnInsert"
    (
        var Rec: Record "Item Category";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Item Category";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Item Category", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Item Category_OnAfterModifyEvent"
    (
        var Rec: Record "Item Category";
        var xRec: Record "Item Category";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Item Category";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Item Category", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Item Category_OnAfterDeleteEvent"
    (
        var Rec: Record "Item Category";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Item Category";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Item Category
    #region Item Unit of Measure DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Item Unit of Measure_OnAfterOnInsert"
    (
        var Rec: Record "Item Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Item Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Item Unit of Measure_OnAfterModifyEvent"
    (
        var Rec: Record "Item Unit of Measure";
        var xRec: Record "Item Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Item Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Item No.", Rec."Item No.");
                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Item Unit of Measure_OnAfterDeleteEvent"
    (
        var Rec: Record "Item Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Item Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Item No.", Rec."Item No.");
                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Item Unit of Measure
    #region Item DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Item", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Item_OnAfterOnInsert"
    (
        var Rec: Record "Item";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Item";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Item", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Item_OnAfterModifyEvent"
    (
        var Rec: Record "Item";
        var xRec: Record "Item";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Item";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("No.", Rec."No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Item", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Item_OnAfterDeleteEvent"
    (
        var Rec: Record "Item";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Item";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("No.", Rec."No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Item*/
    #region Job Ledger Entry DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Job Ledger Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Job Ledger Entry_OnAfterOnInsert"(var Rec: Record "Job Ledger Entry"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Job Ledger Entry";
        StartCompany: Text;
    begin
        if not CduGenJnlPostPreview.IsActive()then if(RunTrigger)then begin
                StartCompany:=CompanyName;
                Company.Reset();
                if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                            RecInsert.Init();
                            RecInsert.ChangeCompany(Company.Name);
                            RecInsert.TransferFields(Rec);
                            if not RecInsert.Get(rec."Entry No.")then RecInsert.Insert(false);
                        end;
                    until Company.Next() = 0;
            end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Ledger Entry", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Job Ledger Entry_OnAfterModifyEvent"(var Rec: Record "Job Ledger Entry"; var xRec: Record "Job Ledger Entry"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Job Ledger Entry";
        StartCompany: Text;
    begin
        if not CduGenJnlPostPreview.IsActive()then if RunTrigger then begin
                StartCompany:=CompanyName;
                Company.Reset();
                if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);
                            RecModify.SetRange("Entry No.", Rec."Entry No.");
                            if RecModify.FindFirst()then begin
                                RecModify.TransferFields(Rec, false);
                                RecModify.Modify(false);
                            end
                            else
                            begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Ledger Entry", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Job Ledger Entry_OnAfterDeleteEvent"(var Rec: Record "Job Ledger Entry"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Job Ledger Entry";
        StartCompany: Text;
    begin
        if not CduGenJnlPostPreview.IsActive()then if RunTrigger then begin
                StartCompany:=CompanyName;
                Company.Reset();
                if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                            RecDelete.Reset();
                            RecDelete.ChangeCompany(Company.Name);
                            RecDelete.SetRange("Entry No.", Rec."Entry No.");
                            if RecDelete.FindFirst()then RecDelete.Delete(false);
                        end;
                    until Company.Next() = 0;
            end;
    end;
    #endregion Job Ledger Entry
    #region Job Planning Line DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Job Planning Line_OnAfterOnInsert"(var Rec: Record "Job Planning Line"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Job Planning Line";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.Get(Rec."Job No.", rec."Job Task No.", rec."Line No.")then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Job Planning Line_OnAfterModifyEvent"(var Rec: Record "Job Planning Line"; var xRec: Record "Job Planning Line"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Job Planning Line";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Job No.", Rec."Job No.");
                        RecModify.SetRange("Job Task No.", Rec."Job Task No.");
                        RecModify.SetRange("Line No.", Rec."Line No.");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Job Planning Line_OnAfterDeleteEvent"(var Rec: Record "Job Planning Line"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Job Planning Line";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Job No.", Rec."Job No.");
                        RecDelete.SetRange("Job Task No.", Rec."Job Task No.");
                        RecDelete.SetRange("Line No.", Rec."Line No.");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Job Planning Line
    #region Job Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Job Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Job Posting Group_OnAfterOnInsert"(var Rec: Record "Job Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Job Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.get(Rec.Code)then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Job Posting Group_OnAfterModifyEvent"(var Rec: Record "Job Posting Group"; var xRec: Record "Job Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Job Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Code", Rec."Code");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Job Posting Group_OnAfterDeleteEvent"(var Rec: Record "Job Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Job Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Code", Rec."Code");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Job Posting Group
    #region Job Register DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Job Register", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Job Register_OnAfterOnInsert"(var Rec: Record "Job Register"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Job Register";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.get(rec."No.")then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Register", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Job Register_OnAfterModifyEvent"(var Rec: Record "Job Register"; var xRec: Record "Job Register"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Job Register";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("No.", Rec."No.");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Register", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Job Register_OnAfterDeleteEvent"(var Rec: Record "Job Register"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Job Register";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("No.", Rec."No.");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Job Register
    #region Jobs Setup DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Jobs Setup", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Jobs Setup_OnAfterOnInsert"(var Rec: Record "Jobs Setup"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Jobs Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.get(rec."Primary Key")then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Jobs Setup", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Jobs Setup_OnAfterModifyEvent"(var Rec: Record "Jobs Setup"; var xRec: Record "Jobs Setup"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Jobs Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Primary Key", Rec."Primary Key");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Jobs Setup", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Jobs Setup_OnAfterDeleteEvent"(var Rec: Record "Jobs Setup"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Jobs Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Primary Key", Rec."Primary Key");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Jobs Setup
    /*#region No. Series DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"No. Series", 'OnAfterInsertEvent', '', true, true)]
    local procedure "No. Series_OnAfterOnInsert"
    (
        var Rec: Record "No. Series";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "No. Series";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"No. Series", 'OnAfterModifyEvent', '', true, true)]
    local procedure "No. Series_OnAfterModifyEvent"
    (
        var Rec: Record "No. Series";
        var xRec: Record "No. Series";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "No. Series";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"No. Series", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "No. Series_OnAfterDeleteEvent"
    (
        var Rec: Record "No. Series";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "No. Series";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion No. Series
    #region Non-Payment Period DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Non-Payment Period", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Non-Payment Period_OnAfterOnInsert"
    (
        var Rec: Record "Non-Payment Period";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Non-Payment Period";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Non-Payment Period", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Non-Payment Period_OnAfterModifyEvent"
    (
        var Rec: Record "Non-Payment Period";
        var xRec: Record "Non-Payment Period";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Non-Payment Period";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Table Name", Rec."Table Name");
                    RecModify.SetRange("Code", Rec."Code");
                    RecModify.SetRange("From Date", Rec."From Date");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Non-Payment Period", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Non-Payment Period_OnAfterDeleteEvent"
    (
        var Rec: Record "Non-Payment Period";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Non-Payment Period";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Table Name", Rec."Table Name");
                    RecDelete.SetRange("Code", Rec."Code");
                    RecDelete.SetRange("From Date", Rec."From Date");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Non-Payment Period
    #region Payment Day DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Payment Day", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Payment Day_OnAfterOnInsert"
    (
        var Rec: Record "Payment Day";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Payment Day";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Payment Day", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Payment Day_OnAfterModifyEvent"
    (
        var Rec: Record "Payment Day";
        var xRec: Record "Payment Day";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Payment Day";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Table Name", Rec."Table Name");
                    RecModify.SetRange("Code", Rec."Code");
                    RecModify.SetRange("Day of the month", Rec."Day of the month");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Payment Day", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Payment Day_OnAfterDeleteEvent"
    (
        var Rec: Record "Payment Day";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Payment Day";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Table Name", Rec."Table Name");
                    RecDelete.SetRange("Code", Rec."Code");
                    RecDelete.SetRange("Day of the month", Rec."Day of the month");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Payment Day
    #region Payment Method DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Payment Method", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Payment Method_OnAfterOnInsert"
    (
        var Rec: Record "Payment Method";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Payment Method";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Payment Method", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Payment Method_OnAfterModifyEvent"
    (
        var Rec: Record "Payment Method";
        var xRec: Record "Payment Method";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Payment Method";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Payment Method", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Payment Method_OnAfterDeleteEvent"
    (
        var Rec: Record "Payment Method";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Payment Method";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Payment Method
    #region Payment Terms DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Payment Terms", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Payment Terms_OnAfterOnInsert"
    (
        var Rec: Record "Payment Terms";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Payment Terms";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Payment Terms", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Payment Terms_OnAfterModifyEvent"
    (
        var Rec: Record "Payment Terms";
        var xRec: Record "Payment Terms";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Payment Terms";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Payment Terms", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Payment Terms_OnAfterDeleteEvent"
    (
        var Rec: Record "Payment Terms";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Payment Terms";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Payment Terms
    #region Post Code DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Post Code", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Post Code_OnAfterOnInsert"
    (
        var Rec: Record "Post Code";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Post Code";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Post Code", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Post Code_OnAfterModifyEvent"
    (
        var Rec: Record "Post Code";
        var xRec: Record "Post Code";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Post Code";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    RecModify.SetRange("City", Rec."City");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Post Code", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Post Code_OnAfterDeleteEvent"
    (
        var Rec: Record "Post Code";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Post Code";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    RecDelete.SetRange("City", Rec."City");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Post Code
    #region Res. Ledger Entry DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Res. Ledger Entry_OnAfterOnInsert"
    (
        var Rec: Record "Res. Ledger Entry";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Res. Ledger Entry";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Res. Ledger Entry_OnAfterModifyEvent"
    (
        var Rec: Record "Res. Ledger Entry";
        var xRec: Record "Res. Ledger Entry";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Res. Ledger Entry";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Entry No.", Rec."Entry No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Res. Ledger Entry_OnAfterDeleteEvent"
    (
        var Rec: Record "Res. Ledger Entry";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Res. Ledger Entry";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Entry No.", Rec."Entry No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Res. Ledger Entry
    #region Resource Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Resource Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Resource Group_OnAfterOnInsert"
    (
        var Rec: Record "Resource Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Resource Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Resource Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Resource Group_OnAfterModifyEvent"
    (
        var Rec: Record "Resource Group";
        var xRec: Record "Resource Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Resource Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("No.", Rec."No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Resource Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Resource Group_OnAfterDeleteEvent"
    (
        var Rec: Record "Resource Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Resource Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("No.", Rec."No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Resource Group
    #region Resource Register DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Resource Register", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Resource Register_OnAfterOnInsert"
    (
        var Rec: Record "Resource Register";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Resource Register";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Resource Register", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Resource Register_OnAfterModifyEvent"
    (
        var Rec: Record "Resource Register";
        var xRec: Record "Resource Register";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Resource Register";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("No.", Rec."No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Resource Register", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Resource Register_OnAfterDeleteEvent"
    (
        var Rec: Record "Resource Register";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Resource Register";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("No.", Rec."No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Resource Register
    #region Resource Unit of Measure DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Resource Unit of Measure", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Resource Unit of Measure_OnAfterOnInsert"
    (
        var Rec: Record "Resource Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Resource Unit of Measure";
        RecModify: Record "Resource Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Resource No.", Rec."Resource No.");
                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Resource Unit of Measure", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Resource Unit of Measure_OnAfterModifyEvent"
    (
        var Rec: Record "Resource Unit of Measure";
        var xRec: Record "Resource Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Resource Unit of Measure";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        GeneralLedgerSetup.get();
        if not GeneralLedgerSetup.OmmitAllCompanies then begin
            StartCompany := CompanyName;
            Company.Reset();
            if Company.FindSet() then
                repeat
                    if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);

                        RecModify.SetRange("Resource No.", Rec."Resource No.");
                        RecModify.SetRange("Code", Rec."Code");
                        if RecModify.FindFirst() then begin
                            RecModify.TransferFields(Rec);
                            RecModify.Modify(false);
                        end else begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Resource Unit of Measure", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Resource Unit of Measure_OnAfterDeleteEvent"
    (
        var Rec: Record "Resource Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Resource Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Resource No.", Rec."Resource No.");
                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Resource Unit of Measure
    */
    //3619 - ED
    #region Resource DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Resource_OnAfterOnInsert"(var Rec: Record "Resource"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Resource";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            GeneralLedgerSetup.get();
            if not GeneralLedgerSetup.OmmitAllCompanies then begin
                StartCompany:=CompanyName;
                Company.Reset();
                if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);
                            RecModify.SetRange("No.", Rec."No.");
                            if RecModify.FindFirst()then begin
                                RecModify.TransferFields(Rec, false);
                                RecModify.Modify(false);
                            end
                            else
                            begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Resource_OnAfterModifyEvent"(var Rec: Record "Resource"; var xRec: Record "Resource"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Resource";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            GeneralLedgerSetup.get();
            if not GeneralLedgerSetup.OmmitAllCompanies then begin
                StartCompany:=CompanyName;
                Company.Reset();
                if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);
                            RecModify.SetRange("No.", Rec."No.");
                            if RecModify.FindFirst()then begin
                                RecModify.TransferFields(Rec, false);
                                RecModify.Modify(false);
                            end
                            else
                            begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Resource_OnAfterDeleteEvent"(var Rec: Record "Resource"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Resource";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("No.", Rec."No.");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Resource
    //3619 - ED END
    /*
    #region Territory DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Territory", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Territory_OnAfterOnInsert"
    (
        var Rec: Record "Territory";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Territory";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Territory", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Territory_OnAfterModifyEvent"
    (
        var Rec: Record "Territory";
        var xRec: Record "Territory";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Territory";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Territory", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Territory_OnAfterDeleteEvent"
    (
        var Rec: Record "Territory";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Territory";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Territory
    #region Unit of Measure DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Unit of Measure", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Unit of Measure_OnAfterOnInsert"
    (
        var Rec: Record "Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Unit of Measure", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Unit of Measure_OnAfterModifyEvent"
    (
        var Rec: Record "Unit of Measure";
        var xRec: Record "Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Unit of Measure", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Unit of Measure_OnAfterDeleteEvent"
    (
        var Rec: Record "Unit of Measure";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "Unit of Measure";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Unit of Measure
    #region VAT Business Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"VAT Business Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "VAT Business Posting Group_OnAfterOnInsert"
    (
        var Rec: Record "VAT Business Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "VAT Business Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Business Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "VAT Business Posting Group_OnAfterModifyEvent"
    (
        var Rec: Record "VAT Business Posting Group";
        var xRec: Record "VAT Business Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "VAT Business Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Business Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "VAT Business Posting Group_OnAfterDeleteEvent"
    (
        var Rec: Record "VAT Business Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "VAT Business Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion VAT Business Posting Group
    #region VAT Product Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"VAT Product Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "VAT Product Posting Group_OnAfterOnInsert"
    (
        var Rec: Record "VAT Product Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "VAT Product Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Product Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "VAT Product Posting Group_OnAfterModifyEvent"
    (
        var Rec: Record "VAT Product Posting Group";
        var xRec: Record "VAT Product Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "VAT Product Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Code", Rec."Code");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Product Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "VAT Product Posting Group_OnAfterDeleteEvent"
    (
        var Rec: Record "VAT Product Posting Group";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "VAT Product Posting Group";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Code", Rec."Code");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion VAT Product Posting Group
    #region VAT Statement Line DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure "VAT Statement Line_OnAfterOnInsert"
    (
        var Rec: Record "VAT Statement Line";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "VAT Statement Line";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Line", 'OnAfterModifyEvent', '', true, true)]
    local procedure "VAT Statement Line_OnAfterModifyEvent"
    (
        var Rec: Record "VAT Statement Line";
        var xRec: Record "VAT Statement Line";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "VAT Statement Line";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Statement Template Name", Rec."Statement Template Name");
                    RecModify.SetRange("Statement Name", Rec."Statement Name");
                    RecModify.SetRange("Line No.", Rec."Line No.");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "VAT Statement Line_OnAfterDeleteEvent"
    (
        var Rec: Record "VAT Statement Line";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "VAT Statement Line";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Statement Template Name", Rec."Statement Template Name");
                    RecDelete.SetRange("Statement Name", Rec."Statement Name");
                    RecDelete.SetRange("Line No.", Rec."Line No.");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion VAT Statement Line
    #region VAT Statement Name DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Name", 'OnAfterInsertEvent', '', true, true)]
    local procedure "VAT Statement Name_OnAfterOnInsert"
    (
        var Rec: Record "VAT Statement Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "VAT Statement Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Name", 'OnAfterModifyEvent', '', true, true)]
    local procedure "VAT Statement Name_OnAfterModifyEvent"
    (
        var Rec: Record "VAT Statement Name";
        var xRec: Record "VAT Statement Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "VAT Statement Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Statement Template Name", Rec."Statement Template Name");
                    RecModify.SetRange("Name", Rec."Name");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Name", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "VAT Statement Name_OnAfterDeleteEvent"
    (
        var Rec: Record "VAT Statement Name";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "VAT Statement Name";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Statement Template Name", Rec."Statement Template Name");
                    RecDelete.SetRange("Name", Rec."Name");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion VAT Statement Name
    #region VAT Statement Template DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Template", 'OnAfterInsertEvent', '', true, true)]
    local procedure "VAT Statement Template_OnAfterOnInsert"
    (
        var Rec: Record "VAT Statement Template";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "VAT Statement Template";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecInsert.Init();
                    RecInsert.ChangeCompany(Company.Name);
                    RecInsert.TransferFields(Rec);
                    RecInsert.Insert(false);
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Template", 'OnAfterModifyEvent', '', true, true)]
    local procedure "VAT Statement Template_OnAfterModifyEvent"
    (
        var Rec: Record "VAT Statement Template";
        var xRec: Record "VAT Statement Template";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "VAT Statement Template";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecModify.Reset();
                    RecModify.ChangeCompany(Company.Name);

                    RecModify.SetRange("Name", Rec."Name");
                    if RecModify.FindFirst() then begin
                        RecModify.TransferFields(Rec);
                        RecModify.Modify(false);
                    end else begin
                        RecModify.Init();
                        RecModify.TransferFields(Rec);
                        RecModify.Insert(false);
                    end;
                end;
            until Company.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"VAT Statement Template", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "VAT Statement Template_OnAfterDeleteEvent"
    (
        var Rec: Record "VAT Statement Template";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "VAT Statement Template";
        StartCompany: Text;
    begin
        StartCompany := CompanyName;
        Company.Reset();
        if Company.FindSet() then
            repeat
                if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);

                    RecDelete.SetRange("Name", Rec."Name");
                    if RecDelete.FindFirst() then
                        RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion VAT Statement Template
    
    */
    #region Vendor Posting Group DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Vendor Posting Group", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Vendor Posting Group_OnAfterOnInsert"(var Rec: Record "Vendor Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Vendor Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Reset();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.SetRange("Code", Rec."Code");
                        if not RecInsert.FindFirst()then begin
                            RecInsert.Init();
                            RecInsert.ChangeCompany(Company.Name);
                            RecInsert.TransferFields(Rec);
                            if not RecInsert.get(Rec.Code)then RecInsert.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Vendor Posting Group", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Vendor Posting Group_OnAfterModifyEvent"(var Rec: Record "Vendor Posting Group"; var xRec: Record "Vendor Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Vendor Posting Group";
        StartCompany: Text;
        RecCompanyInf: Record "Company Information";
        RecCompanyInf2: Record "Company Information";
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            RecCompanyInf2.Get();
            if not(RecCompanyInf2."Omite Comparticion Datos")then begin
                Company.Reset();
                if Company.FindSet()then repeat RecCompanyInf.Reset();
                        RecCompanyInf.ChangeCompany(Company.Name);
                        RecCompanyInf.Get();
                        if not(RecCompanyInf."Omite Comparticion Datos")then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);
                            RecModify.SetRange("Code", Rec."Code");
                            if RecModify.FindFirst()then begin
                                RecModify.TransferFields(Rec, false);
                                RecModify.Modify(false);
                            end
                            else
                            begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Vendor Posting Group", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Vendor Posting Group_OnAfterDeleteEvent"(var Rec: Record "Vendor Posting Group"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Vendor Posting Group";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Code", Rec."Code");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Vendor Posting Group
    #region Vendor DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Vendor", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Vendor_OnAfterOnInsert"(var Rec: Record "Vendor"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Vendor";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Reset();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.SetRange("No.", Rec."No.");
                        if not RecInsert.FindFirst()then begin
                            RecInsert.Init();
                            RecInsert.ChangeCompany(Company.Name);
                            RecInsert.TransferFields(Rec);
                            if not RecInsert.Get(rec."No.")then RecInsert.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Vendor", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Vendor_OnAfterModifyEvent"(var Rec: Record "Vendor"; var xRec: Record "Vendor"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Vendor";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("No.", Rec."No.");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec, false);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Vendor", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Vendor_OnAfterDeleteEvent"(var Rec: Record "Vendor"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Vendor";
        StartCompany: Text;
    begin
        StartCompany:=CompanyName;
        Company.Reset();
        if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                    RecDelete.Reset();
                    RecDelete.ChangeCompany(Company.Name);
                    RecDelete.SetRange("No.", Rec."No.");
                    if RecDelete.FindFirst()then RecDelete.Delete(false);
                end;
            until Company.Next() = 0;
    end;
    #endregion Vendor
    #region G/L Account DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterInsertEvent', '', true, true)]
    local procedure "G/L Account_OnAfterOnInsert"(var Rec: Record "G/L Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        CompanyInfoToChange: Record "Company Information";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            if CompanyInfo.Get()then;
            if not(CompanyInfo."Omite Comparticion Datos")then begin
                Company.Reset();
                if Company.FindSet()then repeat CompanyInfoToChange.Reset();
                        CompanyInfoToChange.ChangeCompany(Company.Name);
                        CompanyInfoToChange.Get();
                        if not(CompanyInfoToChange."Omite Comparticion Datos")then begin
                            RecInsert.Init();
                            RecInsert.ChangeCompany(Company.Name);
                            RecInsert.TransferFields(Rec);
                            if not RecInsert.Get(rec."No.")then RecInsert.Insert(false);
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterModifyEvent', '', true, true)]
    local procedure "G/L Account_OnAfterModifyEvent"(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        CompanyInfoToChange: Record "Company Information";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            if CompanyInfo.Get()then;
            if not(CompanyInfo."Omite Comparticion Datos")then begin
                Company.Reset();
                if Company.FindSet()then repeat CompanyInfoToChange.Reset();
                        CompanyInfoToChange.ChangeCompany(Company.Name);
                        CompanyInfoToChange.Get();
                        if not(CompanyInfoToChange."Omite Comparticion Datos")then begin
                            RecModify.Reset();
                            RecModify.ChangeCompany(Company.Name);
                            RecModify.SetRange("No.", Rec."No.");
                            if RecModify.FindFirst()then begin
                                RecModify.TransferFields(Rec);
                                RecModify.Modify(false);
                            end
                            else
                            begin
                                RecModify.Init();
                                RecModify.TransferFields(Rec);
                                RecModify.Insert(false);
                            end;
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "G/L Account_OnAfterDeleteEvent"(var Rec: Record "G/L Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        CompanyInfoToChange: Record "Company Information";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            if CompanyInfo.Get()then;
            if not(CompanyInfo."Omite Comparticion Datos")then begin
                Company.Reset();
                if Company.FindSet()then repeat CompanyInfoToChange.Reset();
                        CompanyInfoToChange.ChangeCompany(Company.Name);
                        CompanyInfoToChange.Get();
                        if not(CompanyInfoToChange."Omite Comparticion Datos")then begin
                            RecDelete.Reset();
                            RecDelete.ChangeCompany(Company.Name);
                            RecDelete.SetRange("No.", Rec."No.");
                            if RecDelete.FindFirst()then RecDelete.Delete(false);
                        end;
                    until Company.Next() = 0;
            end;
        end;
    end;
    //TODO > Omitir GLAccount de compartición de datos > ORIGINAL
    /*
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterInsertEvent', '', true, true)]
    local procedure "G/L Account_OnAfterOnInsert"
    (
        var Rec: Record "G/L Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecInsert: Record "G/L Account";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany := CompanyName;
            Company.Reset();
            if Company.FindSet() then
                repeat
                    if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.Get(rec."No.") then
                            RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterModifyEvent', '', true, true)]
    local procedure "G/L Account_OnAfterModifyEvent"
    (
        var Rec: Record "G/L Account";
        var xRec: Record "G/L Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecModify: Record "G/L Account";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany := CompanyName;
            Company.Reset();
            if Company.FindSet() then
                repeat
                    if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);

                        RecModify.SetRange("No.", Rec."No.");
                        if RecModify.FindFirst() then begin
                            RecModify.TransferFields(Rec);
                            RecModify.Modify(false);
                        end else begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "G/L Account_OnAfterDeleteEvent"
    (
        var Rec: Record "G/L Account";
        RunTrigger: Boolean
    )
    var
        Company: Record Company;
        RecDelete: Record "G/L Account";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany := CompanyName;
            Company.Reset();
            if Company.FindSet() then
                repeat
                    if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);

                        RecDelete.SetRange("No.", Rec."No.");
                        if RecDelete.FindFirst() then
                            RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    */
    #endregion G/L Account
    #region Job DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Job_OnAfterOnInsert"(var Rec: Record "Job"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Job";
        StartCompany: Text;
    begin
        if(RunTrigger)then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.Get(rec."No.")then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnAfterModifyEvent', '', true, true)]
    procedure "Job_OnAfterModifyEvent"(var Rec: Record "Job"; var xRec: Record "Job"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Job";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            GeneralLedgerSetup.Get();
            //if not GeneralLedgerSetup.OmmitAllCompanies then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("No.", Rec."No.");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        //end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Job_OnAfterDeleteEvent"(var Rec: Record "Job"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Job";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("No.", Rec."No.");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Job
    #region Job Task DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Job Task", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Job Task_OnAfterOnInsert"(var Rec: Record "Job Task"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Job Task";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.Get(rec."Job No.", rec."Job Task No.")then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Task", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Job Task_OnAfterModifyEvent"(var Rec: Record "Job Task"; var xRec: Record "Job Task"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Job Task";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Job No.", Rec."Job No.");
                        RecModify.SetRange("Job Task No.", Rec."Job Task No.");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Task", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Job Task_OnAfterDeleteEvent"(var Rec: Record "Job Task"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Job Task";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Job No.", Rec."Job No.");
                        RecDelete.SetRange("Job Task No.", Rec."Job Task No.");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Job Task
    #region Currency Exchange Rate DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Currency Exchange Rate", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Currency Exchange Rate_OnAfterOnInsert"(var Rec: Record "Currency Exchange Rate"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Currency Exchange Rate";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.get(rec."Currency Code", rec."Starting Date")then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Currency Exchange Rate", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Currency Exchange Rate_OnAfterModifyEvent"(var Rec: Record "Currency Exchange Rate"; var xRec: Record "Currency Exchange Rate"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Currency Exchange Rate";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Currency Code", Rec."Currency Code");
                        RecModify.SetRange("Starting Date", Rec."Starting Date");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec);
                            RecModify.Modify(false);
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            RecModify.Insert(false);
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Currency Exchange Rate", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Currency Exchange Rate_OnAfterDeleteEvent"(var Rec: Record "Currency Exchange Rate"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Currency Exchange Rate";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Currency Code", Rec."Currency Code");
                        RecDelete.SetRange("Starting Date", Rec."Starting Date");
                        if RecDelete.FindFirst()then RecDelete.Delete(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Currency Exchange Rate
    //Multi company changes END    
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnPostInvoiceContractLineOnBeforeCheckBillToCustomer', '', true, true)]
    local procedure "Job Post-Line_OnPostInvoiceContractLineOnBeforeCheckBillToCustomer"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var JobPlanningLine: Record "Job Planning Line"; var IsHandled: Boolean)
    var
        JobPlanningLineLocal: Record "Job Planning Line";
    begin
        JobPlanningLineLocal.SETCURRENTKEY("Job Contract Entry No.");
        JobPlanningLineLocal.SETRANGE("Job Contract Entry No.", SalesLine."Job Contract Entry No.");
        //123
        JobPlanningLineLocal.SETRANGE(JobPlanningLineLocal."Billing Company AT", COMPANYNAME);
        JobPlanningLineLocal.SETRANGE(JobPlanningLineLocal."Job No.", SalesLine."Job No.");
        //123
        JobPlanningLineLocal.FINDFIRST();
        JobPlanningLine:=JobPlanningLineLocal;
        IsHandled:=true;
    end;
    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnBeforeCheckCurrency', '', true, true)]
        local procedure "Job Post-Line_OnBeforeCheckCurrency"
        (
            Job: Record "Job";
            SalesHeader: Record "Sales Header";
            JobPlanningLine: Record "Job Planning Line";
            var IsHandled: Boolean
        )
        var
            SalesLine: Record "Sales Line";
        begin
            SalesLine.Reset();
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetFilter();
        end;
    */
    #region Vendor Bank Account DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Vendor Bank Account_OnAfterOnInsert"(var Rec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Vendor Bank Account";
        StartCompany: Text;
    begin
        if(RunTrigger)then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.Get(Rec."Vendor No.", rec.Code)then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Vendor Bank Account_OnAfterModifyEvent"(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Vendor Bank Account";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Vendor No.", Rec."Vendor No.");
                        RecModify.SetRange("Code", Rec."Code");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec);
                            if RecModify.Modify(false)then;
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            if RecModify.Insert(false)then;
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Vendor Bank Account_OnAfterDeleteEvent"(var Rec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Vendor Bank Account";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Vendor No.", Rec."Vendor No.");
                        RecDelete.SetRange("Code", Rec."Code");
                        if RecDelete.FindFirst()then if RecDelete.Delete(false)then;
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Vendor Bank Account
    #region Customer Bank Account DataPerCompany
    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnAfterInsertEvent', '', true, true)]
    local procedure "Customer Bank Account_OnAfterInsertEvent"(var Rec: Record "Customer Bank Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecInsert: Record "Customer Bank Account";
        StartCompany: Text;
    begin
        if(RunTrigger)then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecInsert.Init();
                        RecInsert.ChangeCompany(Company.Name);
                        RecInsert.TransferFields(Rec);
                        if not RecInsert.get(rec."Customer No.", rec.Code)then RecInsert.Insert(false);
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnAfterModifyEvent', '', true, true)]
    local procedure "Customer Bank Account_OnAfterModifyEvent"(var Rec: Record "Customer Bank Account"; var xRec: Record "Customer Bank Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecModify: Record "Customer Bank Account";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecModify.Reset();
                        RecModify.ChangeCompany(Company.Name);
                        RecModify.SetRange("Customer No.", Rec."Customer No.");
                        RecModify.SetRange("Code", Rec."Code");
                        if RecModify.FindFirst()then begin
                            RecModify.TransferFields(Rec);
                            if RecModify.Modify(false)then;
                        end
                        else
                        begin
                            RecModify.Init();
                            RecModify.TransferFields(Rec);
                            if RecModify.Insert(false)then;
                        end;
                    end;
                until Company.Next() = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnAfterDeleteEvent', '', true, true)]
    local procedure "Customer Bank Account_OnAfterDeleteEvent"(var Rec: Record "Customer Bank Account"; RunTrigger: Boolean)
    var
        Company: Record Company;
        RecDelete: Record "Customer Bank Account";
        StartCompany: Text;
    begin
        if RunTrigger then begin
            StartCompany:=CompanyName;
            Company.Reset();
            if Company.FindSet()then repeat if Company.Name <> StartCompany then begin
                        RecDelete.Reset();
                        RecDelete.ChangeCompany(Company.Name);
                        RecDelete.SetRange("Customer No.", Rec."Customer No.");
                        RecDelete.SetRange("Code", Rec."Code");
                        if RecDelete.FindFirst()then if RecDelete.Delete(false)then;
                    end;
                until Company.Next() = 0;
        end;
    end;
    #endregion Customer Bank Account    
    procedure UpdateBankVC()
    var
        VendorBC: Record "Vendor Bank Account";
        CustomerBC: Record "Customer Bank Account";
        Company: Record Company;
    begin
        if Confirm('Esta seguro que desea continuar?', false)then begin
            Company.Reset();
            if Company.FindSet()then repeat VendorBC.Reset();
                    VendorBC.ChangeCompany(Company.Name);
                    if VendorBC.FindSet()then repeat VendorBC.Modify(true);
                        //Sleep(100);
                        until VendorBC.Next() = 0;
                    CustomerBC.Reset();
                    CustomerBC.ChangeCompany(Company.Name);
                    if CustomerBC.FindSet()then repeat CustomerBC.Modify(true);
                        //Sleep(100);
                        until CustomerBC.Next() = 0;
                until Company.Next() = 0;
            Message('End');
        end;
    end;
    //3600  -  JX  -  2022 04 20
    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnBeforeEarlierPostingDateError', '', true, true)]
    local procedure "Apply Vendor Entries_OnBeforeEarlierPostingDateError"(ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; VendorLedgerEntry: Record "Vendor Ledger Entry"; var RaiseError: Boolean; CalcType: Option; PmtDiscAmount: Decimal)
    begin
        if RaiseError then RaiseError:=false;
    end;
    //3600  -  JX  -  2022 04 20 END
    //3658  -  MRF  -  2022 05 03
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckCorrectedInvoice', '', true, true)]
    local procedure "Sales-Post_OnBeforeCheckCorrectedInvoice"(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        customer: Record Customer;
    begin
        customer.Reset();
        customer.SetCurrentKey("No.");
        customer.SetRange("No.", SalesHeader."Bill-to Customer No.");
        if(customer.FindFirst())then if(customer."Mandatory Purch. Order")then SalesHeader.Testfield("Your Reference");
    end;
    //3658  -  MRF  -  2022 05 03 END
    //3597 - ED
    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Entry", 'OnGetDimensionSetIDOnBeforeInsertTreeNode', '', true, true)]
    local procedure "Dimension Set Entry_OnGetDimensionSetIDOnBeforeInsertTreeNode"(var DimensionSetEntry: Record "Dimension Set Entry"; var Found: Boolean)
    begin
        Found:=false;
    end;
    //3597 - ED END
    //3689 - APR - 2022 06 03
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', true, true)]
    local procedure "Document-Mailing_OnBeforeSendEmail"(var TempEmailItem: Record "Email Item"; var IsFromPostedDoc: Boolean; var PostedDocNo: Code[20]; var HideDialog: Boolean; var ReportUsage: Integer; var EmailSentSuccesfully: Boolean; var IsHandled: Boolean; EmailDocName: Text[250]; SenderUserID: Code[50]; EmailScenario: Enum "Email Scenario")
    var
        SalesInvHeader: Record "Sales Invoice Header";
        Job: Record Job;
        UpdSalesInvoiceHeader: Codeunit UpdateSalesInvHrd;
        TextMails: Text[250];
        lLstSourceTbls: List of[Integer];
        lLstSourceIDs: List of[Guid];
        lLstRelationTypes: List of[Integer];
        lRelation: Integer;
        lEnumRelationType: enum "Email Relation Type";
        li: Integer;
        lx: Integer;
        lRstDocAttach: record "Document Attachment";
        lRstRef: RecordRef;
        lFieldRef: FieldRef;
        lOutStr: OutStream;
        lInStr: InStream;
        lCduBlob: Codeunit "Temp Blob";
    begin
        TempEmailItem.SetBodyText(BodyText(PostedDocNo));
        //3662 - APR - 2022 06 06
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", PostedDocNo);
        if SalesInvHeader.FindFirst()then begin
            if SalesInvHeader.GET(PostedDocNo)then begin
                SalesInvHeader.CALCFIELDS(SalesInvHeader."Job No.");
                Job.Reset();
                Job.SetRange("No.", SalesInvHeader."Job No.");
                if Job.FindFirst()then begin
                    UpdSalesInvoiceHeader.UpdateEmailInvoice(SalesInvHeader, Job."No.", '');
                    TextMails:=SalesInvHeader."Sell-to E-Mail";
                    if Job."Contact Mail 2 AT" <> '' then if((strlen(TextMails) + StrLen(Job."Contact Mail 2 AT")) < 250)then TextMails:=TextMails + '; ' + Job."Contact Mail 2 AT";
                    if Job."Contact Mail 3 AT" <> '' then if((strlen(TextMails) + StrLen(Job."Contact Mail 3 AT")) < 250)then TextMails:=TextMails + '; ' + Job."Contact Mail 3 AT";
                    if Job."Contact Mail 4 AT" <> '' then if((strlen(TextMails) + StrLen(Job."Contact Mail 4 AT")) < 250)then TextMails:=TextMails + '; ' + Job."Contact Mail 4 AT";
                    if Job."Contact Mail 5 AT" <> '' then if((strlen(TextMails) + StrLen(Job."Contact Mail 5 AT")) < 250)then TextMails:=TextMails + '; ' + Job."Contact Mail 5 AT";
                    TempEmailItem."Send to":=TextMails; //SalesInvHeader."Sell-to E-Mail"; //Job."Contact Mail 1 AT";
                end;
            end;
        end;
        //3662 - APR - 2022 06 06 END
        TempEmailItem.GetSourceDocuments(lLstSourceTbls, lLstSourceIDs, lLstRelationTypes);
        li:=lLstRelationTypes.IndexOf(lEnumRelationType::"Primary Source".AsInteger());
        if lLstSourceTbls.Get(li)in[Database::"Sales Invoice Header", Database::"Sales Cr.Memo Header"]then begin
            lRstRef.Open(lLstSourceTbls.Get(li));
            lRstRef.GetBySystemId(lLstSourceIDs.Get(li));
            for lx:=1 to lRstRef.FieldCount()do begin
                lFieldRef:=lRstRef.FieldIndex(lx);
                if lFieldRef.Name = 'No.' then lx:=lRstRef.FieldCount() + 1;
            end;
            lRstDocAttach.SetRange("Table ID", lLstSourceTbls.Get(li));
            lRstDocAttach.SetRange("No.", lFieldRef.Value);
            lRstRef.Close();
            if lRstDocAttach.FindSet()then begin
                lCduBlob.CreateOutStream(lOutStr);
                lRstDocAttach."Document Reference ID".ExportStream(lOutStr);
                lCduBlob.CreateInStream(lInStr);
                TempEmailItem.AddAttachment(lInStr, lRstDocAttach."File Name");
            end end;
    end;
    //3689 - APR - 2022 06 03 END
    //3662 - APR - 2022 06 06
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnAfterEmailSentSuccesfully', '', true, true)]
    local procedure "Document-Mailing_OnAfterEmailSentSuccesfully"(var TempEmailItem: Record "Email Item"; PostedDocNo: Code[20]; ReportUsage: Integer)
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", PostedDocNo);
        if SalesInvHeader.FindFirst()then begin
            if SalesInvHeader.GET(PostedDocNo)then begin
                SalesInvHeader."Date Doc. sent":=CurrentDateTime;
                SalesInvHeader.Modify();
            end;
        end;
    end;
    //3662 - APR - 2022 06 06 END
    //3689 - APR - 2022 06 03
    local procedure BodyText(DocNo: Code[20]): Text[500]var
        EmailBodyText1: Text[150];
        EmailBodyText2: Text[150];
        EmailBodyText3: Text[150];
        EmailBodyText4: Text[300];
        EmailBodyText5: Text[150];
        EmailBodyText6: Text[150];
        EmailBodyText7: Text[150];
        EmailBodyText8: Text[150];
        EmailBodyText9: Text[150];
        VarDate: Date;
        SalesInvHeader: Record "Sales Invoice Header";
        Job: Record Job;
        JobNo: Code[20];
    begin
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", DocNo);
        if SalesInvHeader.FindFirst()then begin
            EmailBodyText1:='Apreciados Srs.,';
            EmailBodyText2:='Adjunto les remitimos la/s factura/s de servicios a fecha ';
            EmailBodyText3:='Atentamente,';
            EmailBodyText4:='Por favor no conteste este email. Este es un correo electrónico generado  automáticamente. Cualquier consulta acerca de la/s factura/s recibida/s pueden dirigirla a la siguiente dirección de correo electrónico: mdelgado@atrevia.com';
            EmailBodyText5:='Rogamos realicen el pago anticipado, en caso de no haberlo realizado.';
            EmailBodyText6:='Formas de pago: ';
            EmailBodyText7:='- Transferencia bancaria al número de cuenta que aparece en la factura';
            EmailBodyText8:='- Con tarjeta VISA, AMEX y Mastercard (Comunicándonos el número y fecha de caducidad)';
            EmailBodyText9:='Gracias y un cordial saludo.';
            if SalesInvHeader.GET(DocNo)then begin
                VarDate:=SalesInvHeader."Posting Date";
                SalesInvHeader.CALCFIELDS(SalesInvHeader."Job No.");
                JobNo:=SalesInvHeader."Job No.";
                Job.Reset();
                Job.SetRange("No.", JobNo);
                if Job.FindFirst()then begin
                    if Job."Job Type AT" = Job."Job Type AT"::Salon then begin
                        exit(EmailBodyText1 + '<br><br>' + EmailBodyText2 + FORMAT(VarDate) + '<br><br>' + EmailBodyText5 + '<br><br><br><br><br><br>' + EmailBodyText6 + '<br><br>' + EmailBodyText7 + '<br><br>' + EmailBodyText8 + '<br><br><br><br>' + EmailBodyText9);
                    end
                    else
                    begin
                        exit(EmailBodyText1 + '<br><br>' + EmailBodyText2 + FORMAT(VarDate) + '<br><br>' + EmailBodyText3 + '<br><br><br><br><br><br>' + EmailBodyText4);
                    end;
                end;
            end;
        end;
    end;
    //3689 - APR - 2022 06 03 END
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJnlLineToLedgEntry', '', true, true)] //EX-SGG 080722 ISSUE #3
    local procedure OnAfterFromJnlLineToLedgEntryJobTransferLinea(var JobLedgerEntry: Record "Job Ledger Entry"; JobJournalLine: Record "Job Journal Line")
    begin
        JobLedgerEntry.Confirmed:=JobJournalLine.Confirmed;
        JobLedgerEntry."To Credit":=JobJournalLine."To Credit";
        JobLedgerEntry."Job Line Account No.":=JobJournalLine."Job Line Account No.";
        JobLedgerEntry."Job Assistant":=JobJournalLine."Job Assistant";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromPurchaseLineToJnlLine', '', true, true)] //EX-SGG 080722 ISSUE #3
    local procedure OnAfterFromPurchaseLineToJnlLineJobTransferLine(var JobJnlLine: Record "Job Journal Line"; PurchHeader: Record "Purchase Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; PurchLine: Record "Purchase Line"; SourceCode: Code[10])
    begin
        JobJnlLine.Confirmed:=TRUE;
        JobJnlLine."Job Line Account No.":=PurchLine."Job Line Account No.";
        if PurchHeader."Document Type" in[PurchHeader."Document Type"::"Return Order", PurchHeader."Document Type"::"Credit Memo"]then JobJnlLine."To Credit":=TRUE;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJobLedgEntryToPlanningLine', '', true, true)] //EX-SGG 080722 ISSUE #3
    local procedure OnAfterFromJobLedgEntryToPlanningLineJobTransferLine(var JobPlanningLine: Record "Job Planning Line"; JobLedgEntry: Record "Job Ledger Entry")
    begin
        IF JobLedgEntry."Job Line Account No." <> '' THEN JobPlanningLine."No.":=JobLedgEntry."Job Line Account No.";
        JobPlanningLine."Confirmed AT":=JobLedgEntry.Confirmed;
        JobPlanningLine."ToCredit AT":=JobLedgEntry."To Credit";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromGenJnlLineToJnlLine', '', true, true)] //EX-SGG 080722 ISSUE #3
    local procedure OnAfterFromGenJnlLineToJnlLineJobTransferLine(var JobJnlLine: Record "Job Journal Line"; GenJnlLine: Record "Gen. Journal Line")
    var
        lRstGLAcc: record "G/L Account";
        lRstJobTask: record "Job Task";
    begin
        IF JobJnlLine."Gen. Prod. Posting Group" = '' THEN IF lRstGLAcc.GET(GenJnlLine."Account No.")THEN JobJnlLine."Gen. Prod. Posting Group":=lRstGLAcc."Gen. Prod. Posting Group";
        JobJnlLine.Confirmed:=GenJnlLine."Confirmed AT";
        JobJnlLine."Job Line Account No.":=GenJnlLine."Job Line Account No.";
        lRstJobTask.GET(GenJnlLine."Job No.", GenJnlLine."Job Task No.");
        IF lRstJobTask."Billable AT" THEN BEGIN
            JobJnlLine.Billable:=TRUE;
            JobJnlLine."Line Type":=JobJnlLine."Line Type"::Billable;
        END;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceOnBeforeRunReport', '', true, true)] //EX-SGG 080722 ISSUE #4
    local procedure OnCreateSalesInvoiceOnBeforeRunReportJobCreateInvoice(var JobPlanningLine: Record "Job Planning Line"; var Done: Boolean; var NewInvoice: Boolean; var PostingDate: Date; var InvoiceNo: Code[20]; var IsHandled: Boolean; CrMemo: Boolean)
    var
        lRstJob: record Job;
    begin
    /*         lRstJob.get(JobPlanningLine."Job No.");
                lRstJob.TestField("Billing Company AT", CompanyName); */
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterValidateEvent', 'No.', false, false)] //EX-SGG 130722 ISSUE #6
    local procedure NoOnAfterValidateEventJobPlanningLine(var Rec: Record "Job Planning Line"; var xRec: Record "Job Planning Line"; CurrFieldNo: Integer)
    var
        lRstGlAcc: record "G/L Account";
        lRstJobUsageLink: Record "Job Usage Link";
        lAuxNo: code[20];
        lLinkedJobLedgerErr: Label 'You cannot change this value because linked job ledger entries exist.';
    begin
        //123
        IF(Rec.Type = Rec.Type::"G/L Account")THEN IF CONFIRM('¿Desea mantener la información existente de la línea ?')THEN IF lRstGlAcc.GET(Rec."No.")THEN BEGIN
                    lRstGlAcc.CheckGLAcc();
                    lRstGlAcc.TESTFIELD("Direct Posting", TRUE);
                    //+EX-SGG 130722
                    lAuxNo:=Rec."No.";
                    Rec.Get(Rec."Job No.", Rec."Job Task No.", Rec."Line No.");
                    Rec."No.":=lAuxNo;
                    /// local procedure ValidateModification(FieldChanged: Boolean)
                    if Rec."No." <> xRec."No." then begin
                        Rec.CalcFields("Qty. Transferred to Invoice");
                        Rec.TestField("Qty. Transferred to Invoice", 0);
                    end;
                    /// local procedure CheckUsageLinkRelations()
                    lRstJobUsageLink.SetRange("Job No.", Rec."Job No.");
                    lRstJobUsageLink.SetRange("Job Task No.", Rec."Job Task No.");
                    lRstJobUsageLink.SetRange("Line No.", Rec."Line No.");
                    if not lRstJobUsageLink.IsEmpty()then Error(lLinkedJobLedgerErr);
                    Rec.UpdateReservation(Rec.FieldNo("No."));
                    //-EX-SGG 130722
                    Rec."Gen. Bus. Posting Group":=lRstGlAcc."Gen. Bus. Posting Group";
                    Rec."Gen. Prod. Posting Group":=lRstGlAcc."Gen. Prod. Posting Group";
                    EXIT;
                END;
    //123
    end;
//EX-RBF 050324 Inicio
// [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterOnInsert', '', false, false)]
// local procedure OnAfterOnInsertJob(var Job: Record Job)
// var
//     lRecDimValue: Record "Dimension Value";
//     lRecDefaultDim: Record "Default Dimension";
// begin
//     lRecDimValue.Init();
//     lRecDimValue."Dimension Code" := Job."No.";
//     lRecDimValue."Code" := Job."No.";
//     lRecDimValue.Name := CopyStr(Job.Description, 1, 50);
//     lRecDimValue.Insert();
//     lRecDefaultDim.Init();
//     lRecDefaultDim."Table ID" := 167;
//     lRecDefaultDim."No." := Job."No.";
//     lRecDefaultDim."Dimension Code" := 'PROYECTO';
//     lRecDefaultDim."Dimension Value Code" := Job."No.";
//     lRecDefaultDim.Insert();
// end;
//EX-RBF 050324 Fin
}
