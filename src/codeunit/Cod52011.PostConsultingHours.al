codeunit 52011 "Post Consulting Hours"
{
    TableNo = "Hours consulting AT";

    trigger OnRun()
    begin
        // ERROR('Proceso en revisión');
        IF NOT CONFIRM('¿Registrar horas consultor?', FALSE)THEN EXIT;
        Window.OPEN(Txt50000 + Txt50001 + Txt50002);
        RHoras.COPY(Rec);
        RHoras.SETCURRENTKEY(Registrado, "No. proyecto");
        RHoras.SETRANGE(Registrado, FALSE);
        IF RHoras.FIND('-')THEN REPEAT i+=1;
                xHoras:=RHoras;
                xHoras."Tipo error":=JobJnlPost;
                xHoras.Registrado:=xHoras."Tipo error" = '';
                xHoras.Modify();
            UNTIL RHoras.Next() = 0;
    //COMMIT;
    end;
    var Window: Dialog;
    JobJnlLine: Record 210;
    JobJnlPostLine: Codeunit 1012;
    JobSetup: Record 315;
    Item: Record 27;
    RHoras: Record "Hours consulting AT";
    xHoras: Record "Hours consulting AT";
    Job: Record Job;
    Resource: Record 156;
    bProyCerrado: Boolean;
    Txt50000: Label 'Registrando \';
    Txt50001: Label 'Proyecto #1############\';
    Txt50002: Label 'Fecha    #2############\';
    i: Integer;
    procedure JobJnlPost(): Text[30]begin
        IF Job."No." <> xHoras."No. proyecto" THEN BEGIN
            Window.UPDATE(1, xHoras."No. proyecto");
            IF NOT Job.GET(xHoras."No. proyecto")THEN EXIT('Proyecto no encontrado');
        END;
        Window.UPDATE(2, xHoras.Fecha);
        bProyCerrado:=Job.Status = Job.Status::Completed;
        IF bProyCerrado THEN BEGIN
            Job.Status:=Job.Status::Open;
            Job.Modify();
        END;
        IF Job.Blocked <> Job.Blocked::" " THEN EXIT('Proyecto bloqueado');
        IF Job.Status <> Job.Status::Open THEN EXIT('Proyecto no está en pedido');
        IF NOT Resource.GET(RHoras."No. consultor")THEN EXIT('Consultor no encontrado');
        IF Resource.Blocked THEN EXIT('Consultor bloqueado');
        JobJnlLine.Init();
        JobJnlLine.VALIDATE("Job No.", RHoras."No. proyecto");
        JobJnlLine.VALIDATE("Job Task No.", RHoras."No. proyecto");
        JobJnlLine."Posting Date":=RHoras.Fecha;
        JobJnlLine."Document No.":=RHoras."No. proyecto";
        JobJnlLine.Type:=JobJnlLine.Type::Resource;
        JobJnlLine.VALIDATE(JobJnlLine."No.", RHoras."No. consultor");
        IF Resource."Global Dimension 1 Code" <> '' THEN JobJnlLine.VALIDATE("Shortcut Dimension 1 Code", Resource."Global Dimension 1 Code");
        IF Job."Global Dimension 2 Code" <> '' THEN JobJnlLine.VALIDATE("Shortcut Dimension 2 Code", Job."Global Dimension 2 Code");
        JobJnlLine.VALIDATE(Quantity, RHoras.Horas);
        //JobJnlLine."Source Code" := 'HORAS';
        JobJnlLine."Source Code":=JobSetup."Expenses Source Code AT";
        JobJnlPostLine.RUN(JobJnlLine);
        IF bProyCerrado THEN BEGIN
            Job.Status:=Job.Status::Completed;
            Job.Modify();
        END;
        EXIT('');
        MESSAGE('Proceso finalizado');
    end;
}
