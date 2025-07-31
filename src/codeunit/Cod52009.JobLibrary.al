codeunit 52009 "Job Library"
{
    trigger OnRun()
    begin
    end;
    procedure GetJobNo(RecRef: RecordRef): Code[20]var
        rSalesHeader: Record 36;
        rSalesInvHeader: Record 112;
        rPurchHeader: Record 38;
        rPurchInvHeader: Record 122;
        rSalesLine: Record 37;
        rSalesInvLine: Record 113;
        rPurchLine: Record 39;
        rPurchInvLine: Record 123;
    begin
        //RecordRef.GETTABLE(rec);
        CASE RecRef.NUMBER OF DATABASE::"Purchase Header": BEGIN
            RecRef.SETTABLE(rPurchHeader);
            rPurchLine.SETRANGE("Document No.", rPurchHeader."No.");
            rPurchLine.SETFILTER("Job No.", '<>%1', '');
            IF rPurchLine.FindFirst()then EXIT(rPurchLine."Job No.");
        END;
        DATABASE::"Sales Header": BEGIN
            RecRef.SETTABLE(rSalesHeader);
            rSalesLine.SETRANGE("Document No.", rSalesHeader."No.");
            rSalesLine.SETFILTER("Job No.", '<>%1', '');
            IF rSalesLine.FIND('-')THEN EXIT(rSalesLine."Job No.");
        END;
        DATABASE::"Purch. Inv. Header": BEGIN
            RecRef.SETTABLE(rPurchInvHeader);
            rPurchInvLine.SETRANGE("Document No.", rPurchInvHeader."No.");
            rPurchInvLine.SETFILTER("Job No.", '<>%1', '');
            IF rPurchInvLine.FindFirst()then EXIT(rPurchInvLine."Job No.");
        END;
        DATABASE::"Sales Invoice Header": BEGIN
            RecRef.SETTABLE(rSalesInvHeader);
            rSalesInvLine.SETRANGE("Document No.", rSalesInvHeader."No.");
            rSalesInvLine.SETFILTER("Job No.", '<>%1', '');
            IF rSalesInvLine.FindFirst()then EXIT(rSalesInvLine."Job No.");
        END;
        END;
    end;
}
