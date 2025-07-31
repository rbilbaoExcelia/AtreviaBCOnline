codeunit 52017 "UpdateSalesInvHrd"
{
    Permissions = TableData 112=rimd;

    procedure UpdateYourReference(FilterNo: Code[20]; NewYourReference: Text[35])
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", FilterNo);
        if SalesInvHeader.FindFirst()then begin
            SalesInvHeader."Your Reference":=NewYourReference;
            SalesInvHeader.Modify(false)end;
    end;
    //3660  - APR - 2022 05 26
    procedure UpdateEmailInvoice(var SalesInvHeader: Record "Sales Invoice Header"; pJobNo: Code[20]; pEmail: Text[250])
    var
        Job: Record Job;
    begin
        if pEmail = '' then begin
            job.Reset();
            job.SetRange("No.", pJobNo);
            if job.FindFirst()then begin
                SalesInvHeader.ATOrigEmail:=SalesInvHeader."Sell-to E-Mail";
                SalesInvHeader."Sell-to E-Mail":=job."Contact Mail 1 AT";
                SalesInvHeader.Modify(false);
            end;
        end
        else
        begin
            SalesInvHeader."Sell-to E-Mail":=pEmail;
            SalesInvHeader."Date Doc. sent":=CurrentDateTime;
            SalesInvHeader.Modify(false);
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnBeforeSendRecords', '', true, true)]
    local procedure "Sales Invoice Header_OnBeforeSendRecords"(var ReportSelections: Record "Report Selections"; var SalesInvoiceHeader: Record "Sales Invoice Header"; DocTxt: Text; var IsHandled: Boolean)
    var
        SalesInvLines: Record "Sales Invoice Line";
        UpdSalesInvoiceHeader: Codeunit UpdateSalesInvHrd;
    begin
        SalesInvLines.Reset();
        SalesInvLines.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvLines.SETFILTER("Job No.", '<>%1', '');
        IF SalesInvLines.FindFirst()then UpdSalesInvoiceHeader.UpdateEmailInvoice(SalesInvoiceHeader, SalesInvLines."Job No.", '');
    /*    
        if SalesInvoiceHeader.ATOrigEmail <> '' then begin
            SalesInvoiceHeader."Sell-to E-Mail" := SalesInvoiceHeader.ATOrigEmail;
            SalesInvoiceHeader.ATOrigEmail := '';
            SalesInvoiceHeader.Modify(false);
        end;
        */
    end;
//3660  - APR - 2022 05 26 END
}
