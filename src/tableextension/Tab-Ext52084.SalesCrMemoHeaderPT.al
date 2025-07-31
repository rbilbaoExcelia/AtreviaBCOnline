tableextension 52084 "SalesCrMemoHeaderPT" extends "Sales Cr.Memo Header"
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
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Cr.Memo Line"."Job No." WHERE("Document No."=FIELD("No."), "Job No."=FILTER(<>'')));
            Caption = 'Job No.';
            Description = '-056';
        }
        field(52006; "Job Name"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Name';
            FieldClass = FlowField;
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
    }
    trigger OnBeforeDelete()
    begin
        //123
        ERROR(Text50000);
    //123
    end;
    procedure IsSingleCustomerSelected(): Boolean var
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
        EXIT(SelectedCount = CustomerCount);
    end;
    procedure CheckDocumentSendingProfileIsSupported(VAR TempDocumentSendingProfile: Record "Document Sending Profile" temporary)
    begin
        IF(COUNT > 1) AND (TempDocumentSendingProfile."Electronic Document" <> TempDocumentSendingProfile."Electronic Document"::No)THEN ERROR(CannotSendMultipleCrMemosElectronicallyErr);
    end;
    procedure SendRecords2()
    var
        DocumentSendingProfile: Record 60;
        TempDocumentSendingProfile: Record 60 temporary;
        ReportDistributionManagement: Codeunit 452;
        SalesCrInvLines: Record 115;
    begin
        //052
        Rec2:=Rec;
        Rec2.SETRANGE("No.", "No.");
        SalesCrInvLines.Reset();
        SalesCrInvLines.SETRANGE("Document No.", "No.");
        SalesCrInvLines.SETFILTER("Job No.", '<>%1', '');
        IF NOT SalesCrInvLines.FindFirst()then EXIT;
        DocumentSendingProfile.GetDefaultForJob(SalesCrInvLines."Job No.", DocumentSendingProfile);
        Commit();
        TempDocumentSendingProfile.Init();
        //TempDocumentSendingProfile.Code := DocumentSendingProfile.Code;
        TempDocumentSendingProfile.COPY(DocumentSendingProfile); //NEW
        TempDocumentSendingProfile.VALIDATE("One Related Party Selected", IsSingleCustomerSelected);
        TempDocumentSendingProfile.SetDocumentUsage(Rec2);
        TempDocumentSendingProfile.Insert();
        //IF PAGE.RUNMODAL(PAGE::"Select Sending Options",TempDocumentSendingProfile) = ACTION::LookupOK THEN BEGIN
        CheckDocumentSendingProfileIsSupported(TempDocumentSendingProfile);
    //Todo: no existe SendDocumentReport
    //ReportDistributionManagement.SendDocumentReport(TempDocumentSendingProfile, Rec2);
    //END;
    //052
    end;
    var CannotSendMultipleCrMemosElectronicallyErr: Label 'You can only send one electronic credit memo at a time.';
    Rec2: Record 114;
    Text50000: Label 'No es posible eliminar documentos registrados';
}
