tableextension 52088 "SalesInvoiceHeaderPT" extends "Sales Invoice Header"
{
    fields
    {
        field(52000; Hash; Text[172])
        {
            DataClassification = CustomerContent;
            Caption = 'Hash';
            Description = '-003';
        }
        field(52001; "Private Key Version"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Private Key Version';
            Description = '-003';
        }
        field(52002; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Time';
            Description = '-003';
        }
        field(52003; "Creation Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Time';
            Description = '-003';
        }
        field(52005; "Job No."; Code[20])
        {
            CalcFormula = Lookup("Sales Invoice Line"."Job No." WHERE("Document No."=FIELD("No."), "Job No."=FILTER(<>'')));
            Caption = 'Job No.';
            Description = '-056';
            FieldClass = FlowField;
        }
        field(52006; "Job Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Name';
        }
        field(52010; "External Job Document No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'External Job Document No.';
            Description = '-027';
        }
        field(52011; "Document sent"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = '-052';
        }
        field(52012; "Date Doc. sent"; DateTime)
        {
            DataClassification = CustomerContent;
            Description = '-052';
        }
        field(52810; "QR Image"; Blob) //EX-SGG 210322
        {
            Caption = 'QR Image';
            Description = 'EX-QR';
            DataClassification = CustomerContent;
        }
        field(52013; ATOrigEmail; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'AT Original Email';
        }
    }
    trigger OnBeforeDelete()
    begin
        //123
        ERROR(Text50000);
    //123
    end;
    //procedure SendRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentTypeTxt := ReportDistributionMgt.GetFullDocumentTypeText(Rec);

    IsHandled := false;
    OnBeforeSendRecords(DummyReportSelections,Rec,DocumentTypeTxt,IsHandled);
    if not IsHandled then
      DocumentSendingProfile.SendCustomerRecords(
        DummyReportSelections.Usage::"S.Invoice",Rec,DocumentTypeTxt,"Bill-to Customer No.","No.",
        FieldNo("Bill-to Customer No."),FieldNo("No."));
    */
    //end;
    //>>>> MODIFIED CODE:            ----------OnBeforeSendCustomerRecords
    //begin
    /*
    IF (COUNT > 1) AND
       (TempDocumentSendingProfile."Electronic Document" <> TempDocumentSendingProfile."Electronic Document"::No)
    THEN
      ERROR(CannotSendMultipleInvoicesElectronicallyErr);
    */
    //end;
    //----OLIVIA
    procedure CreateCreditMemo(InvToCredit: Record 112)
    var
        CopyInvLines: Report "Copy Sales Document";
        SalesMemo: Record 36;
        //------------------------
        SalesInvLine: Record 113;
        Job: Record Job;
        Txt001: Label 'Proyecto nº %1 no existe';
        Txt002: Label 'Proyecto nº %1 bloqueado';
        TempNewPlannLines: Record 1003 temporary;
        JobCreateMultInvoice: Codeunit "Job-Create Multiple Custs. Inv";
        NewPlannLines: Record 1003;
    begin
        //<029
        /*
        SalesMemo.Init();
        SalesMemo."Document Type" := SalesMemo."Document Type"::"Credit Memo";
        SalesMemo.INSERT(TRUE);
        SalesMemo.VALIDATE("Bill-to Customer No.",InvToCredit."Bill-to Customer No.");
        SalesMemo.Modify();
        //COMMIT;
        CopyInvLines.SetSalesHeader(SalesMemo);
        CopyInvLines.SetParameters(InvToCredit."No.");
        CopyInvLines.USEREQUESTPAGE(FALSE);
        CopyInvLines.RUNMODAL;
        */
        TempNewPlannLines.DeleteAll();
        SalesInvLine.SETRANGE("Document No.", InvToCredit."No.");
        SalesInvLine.SETFILTER(Type, '<>%1', SalesInvLine.Type::" "); //240317
        IF SalesInvLine.FindFirst()then REPEAT IF NOT Job.GET(SalesInvLine."Job No.")THEN ERROR(Txt001, SalesInvLine."Job No.");
                IF Job.Blocked <> Job.Blocked::" " THEN ERROR(Txt002, Job."No.");
                NewPlannLines."Job No.":=SalesInvLine."Job No.";
                NewPlannLines."Job Task No.":=SalesInvLine."Job No.";
                NewPlannLines."Line No.":=GetPlannLineNo(Job);
                NewPlannLines."Planning Date":=Job."Creation Date";
                ///
                 //NewPlannLines.VALIDATE(Description,  SalesInvLine.Description); //170517
                NewPlannLines."Mandatory Purch. Order AT":=Job."Mandatory Purch. Order AT";
                IF SalesInvLine.Type = SalesInvLine.Type::"G/L Account" THEN NewPlannLines.VALIDATE(Type, NewPlannLines.Type::"G/L Account")
                ELSE IF SalesInvLine.Type = SalesInvLine.Type::Item THEN NewPlannLines.VALIDATE(Type, NewPlannLines.Type::Item)
                    ELSE IF SalesInvLine.Type = SalesInvLine.Type::Resource THEN NewPlannLines.VALIDATE(Type, NewPlannLines.Type::Resource);
                NewPlannLines.VALIDATE("No.", SalesInvLine."No.");
                //<029
                NewPlannLines.VALIDATE(Description, SalesInvLine.Description); //170517
                NewPlannLines.VALIDATE("Document No.", SalesInvLine."Document No.");
                //NewPlannLines.VALIDATE("Document No.", 'ABONO FRA');
                //029>
                NewPlannLines.VALIDATE("Customer No. AT", InvToCredit."Bill-to Customer No.");
                NewPlannLines.VALIDATE(Quantity, -SalesInvLine.Quantity);
                NewPlannLines.VALIDATE("Unit Cost", SalesInvLine."Unit Cost");
                NewPlannLines.VALIDATE("Unit Price", SalesInvLine."Unit Price");
                NewPlannLines.VALIDATE("Line Discount %", SalesInvLine."Line Discount %");
                NewPlannLines."ToCredit AT":=TRUE;
                NewPlannLines."Job Assistant AT":=SalesInvLine."Job Assistant";
                NewPlannLines.VALIDATE("Customer No. AT", InvToCredit."Bill-to Customer No."); //240317
                NewPlannLines.VALIDATE("Line Type", NewPlannLines."Line Type"::Billable);
                NewPlannLines."Billable AT":=TRUE;
                //190517
                NewPlannLines."Job Cntr. Entry No. to Cred AT":=SalesInvLine."Job Contract Entry No.";
                //190517
                NewPlannLines.INSERT(TRUE);
                TempNewPlannLines.COPY(NewPlannLines);
                TempNewPlannLines.Insert();
            UNTIL SalesInvLine.Next() = 0;
        JobCreateMultInvoice.CreateSalesInvoice(TempNewPlannLines, TRUE);
    //029>
    end;
    local procedure GetPlannLineNo(Job: Record 167): Integer var
        rPlanLines: Record 1003;
        LineNo: Integer;
    begin
        //079
        rPlanLines.SETRANGE("Job No.", Job."No.");
        rPlanLines.SETRANGE("Job Task No.", Job."No.");
        IF rPlanLines.FindLast()then LineNo:=rPlanLines."Line No." + 100
        ELSE
            LineNo:=1000;
        //079
        EXIT(LineNo);
    end;
    //3660 - ED
    procedure CheckDocumentSendingProfileIsSupported(VAR TempDocumentSendingProfile: Record "Document Sending Profile" temporary)
    begin
        IF(COUNT > 1) AND (TempDocumentSendingProfile."Electronic Document" <> TempDocumentSendingProfile."Electronic Document"::No)THEN ERROR(CannotSendMultipleInvoicesElectronicallyErr);
    end;
    //3660 - ED END
    procedure SendRecords2()
    var
        //3660  - APR - 2022 05 26
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        SalesInvLines: Record "Sales Invoice Line";
        ReportDistributionMgt: Codeunit "Report Distribution Management";
        DocumentTypeTxt: Text[50];
        IsHandled: Boolean;
        OrigEmail: Text[250];
        UpdSalesInvoiceHeader: Codeunit UpdateSalesInvHrd;
    //3660  - APR - 2022 05 26 END
    begin
        //052
        //3660  - APR - 2022 05 24
        //Rec2 := Rec;
        //Rec2.SETRANGE("No.", "No.");
        //3660  - APR - 2022 05 24 END
        //3660  - APR - 2022 05 26
        OrigEmail:=rec."Sell-to E-Mail"; //se guarda mail original
        //3660  - APR - 2022 05 26 ENDS
        SalesInvLines.Reset();
        SalesInvLines.SETRANGE("Document No.", Rec."No.");
        SalesInvLines.SETFILTER("Job No.", '<>%1', '');
        IF NOT SalesInvLines.FindFirst()then exit;
        //3660  - APR - 2022 05 26
        UpdSalesInvoiceHeader.UpdateEmailInvoice(rec, SalesInvLines."Job No.", ''); //llamamos a la funcion para poner el mail del proyecto
        //rec.SendRecords();
        DocumentTypeTxt:=ReportDistributionMgt.GetFullDocumentTypeText(Rec);
        IsHandled:=false;
        if not IsHandled then DocumentSendingProfile.SendCustomerRecords(DummyReportSelections.Usage::"S.Invoice".AsInteger(), Rec, DocumentTypeTxt, "Bill-to Customer No.", "No.", FieldNo("Bill-to Customer No."), FieldNo("No."));
    //UpdSalesInvoiceHeader.UpdateEmailInvoice(rec, SalesInvLines."Job No.", OrigEmail); //Poner mail original
    //3660  - APR - 2022 05 26 END
    /* 3660  - APR - 2022 05 24
        DocumentSendingProfile.GetDefaultForJob(SalesInvLines."Job No.", DocumentSendingProfile);
        Commit();

        TempDocumentSendingProfile.Init();

        //TempDocumentSendingProfile.Code := DocumentSendingProfile.Code;
        TempDocumentSendingProfile.COPY(DocumentSendingProfile); //NEW

        TempDocumentSendingProfile.VALIDATE("One Related Party Selected", IsSingleCustomerSelected);
        TempDocumentSendingProfile.SetDocumentUsage(Rec);// by default this uses the quote
        TempDocumentSendingProfile.Insert();

        IF PAGE.RUNMODAL(PAGE::"Select Sending Options", TempDocumentSendingProfile) = ACTION::LookupOK THEN BEGIN
            //TODO: Ver - no existe CheckDocumentSendingProfileIsSupported y SendDocumentReport
            //3660 - ED
            CheckDocumentSendingProfileIsSupported(TempDocumentSendingProfile);
            //ReportDistributionManagement.SendDocumentReport(TempDocumentSendingProfile, Rec2);
            DocumentTypeTxt := ReportDistributionManagement.GetFullDocumentTypeText(Rec);
            DocumentSendingProfile.SendCustomerRecords(
                TempDocumentSendingProfile.Usage::"Sales Invoice".AsInteger(), Rec, DocumentTypeTxt, "Bill-to Customer No.", "No.",
                FieldNo("Bill-to Customer No."), FieldNo("No."));
            //3660 - ED END
        END;
        //052
        3660  - APR - 2022 05 24 END */
    end;
    local procedure IsSingleCustomerSelected(): Boolean var
        SelectedCount: Integer;
        CustomerCount: Integer;
        BillToCustomerNoFilter: Text;
    begin
        SelectedCount:=COUNT;
        IF SelectedCount < 1 THEN EXIT(FALSE);
        IF SelectedCount = 1 THEN EXIT(TRUE);
        BillToCustomerNoFilter:=GETFILTER("Bill-to Customer No.");
        SETRANGE("Bill-to Customer No.", "Bill-to Customer No.");
        CustomerCount:=COUNT;
        SETFILTER("Bill-to Customer No.", BillToCustomerNoFilter);
        EXIT(SelectedCount = CustomerCount)end;
    var PostSalesLinesDelete: Codeunit "PostSales-Delete";
    CannotSendMultipleInvoicesElectronicallyErr: Label 'You can only send one electronic invoice at a time.';
    CheckLatestQst: Label 'Do you want to check the latest status of the electronic document?', Comment = '%1 is Document Exchange Status';
    //"-----------":
    Rec2: Record 112;
    Text50000: Label 'No es posible eliminar documentos registrados.';
}
