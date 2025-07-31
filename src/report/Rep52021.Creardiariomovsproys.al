report 52021 "Crear diario movs proys"
{
    ProcessingOnly = true;
    Caption = 'Crear diario movs proys';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(MOVSPROYECTO; "MOVS PROYECTOS")
        {
            DataItemTableView = SORTING("Posting Date")WHERE(Quantity=FILTER(<>0));

            trigger OnAfterGetRecord()
            begin
                /*
                IF NOT Job.GET(MOVSPROYECTO."Job No.") THEN BEGIN
                  JobBloq.Init();
                  JobBloq."Cod Proy" := MOVSPROYECTO."Job No.";
                  JobBloq.Tabla := 167;
                  JobBloq.dESC := 'No existe ' + MOVSPROYECTO."Job No.";
                  IF JobBloq.Insert() then;
                  CurrReport.Skip();
                END;
                
                IF Job.Blocked > 0 THEN BEGIN
                  JobBloq.Init();
                  JobBloq."Cod Proy" := Job."No.";
                  JobBloq.Tabla := 167;
                  IF JobBloq.Insert() then;
                
                  Job.Blocked := 0;
                  Job.Modify();
                END;
                
                IF Job."Bill-to Customer No." = '' THEN BEGIN
                  Job."Bill-to Customer No.":='MIGRACION';
                  Job.Modify();
                END;
                */
                /*
                //<productos bloqueados
                IF MOVSPROYECTO.Type = MOVSPROYECTO.Type::Item THEN BEGIN
                  Producto.GET(MOVSPROYECTO."No.");
                  IF Producto.Blocked THEN BEGIN
                    JobBloq.Init();
                    JobBloq."Cod Proy" := Producto."No.";
                    JobBloq.Tabla := 27;
                    IF JobBloq.Insert() then;
                
                    Producto.Blocked := FALSE;
                    Producto.Modify();
                  END;
                
                  IF Producto."Base Unit of Measure" = '' THEN BEGIN
                    Producto.VALIDATE("Base Unit of Measure",'UD.');
                    Producto.Modify();
                  END;
                END;
                */
                /*
                //<resource bloqueados
                IF MOVSPROYECTO.Type = MOVSPROYECTO.Type::Resource THEN BEGIN
                  Recurso.GET(MOVSPROYECTO."No.");
                  IF Recurso.Blocked THEN BEGIN
                    JobBloq.Init();
                    JobBloq."Cod Proy" := Recurso."No.";
                    JobBloq.Tabla := 156;
                    IF JobBloq.Insert() then;
                
                    Recurso.Blocked := FALSE;
                    Recurso.Modify();
                  END;
                END;
                */
                InsertJobJnlLine();
            end;
            trigger OnPreDataItem()
            var
                fechaini: Date;
                fechafin: Date;
            begin
                //JobLedEntry.SETRANGE("Posting Date",20160101D,20161231D);
                //JobLedEntry.DeleteAll();
                //MOVSPROYECTO.SETRANGE("Posting Date",20170101D,20170430D);
                MOVSPROYECTO.SETRANGE("Posting Date", 20170501D, 20171231D);
                //MOVSPROYECTO.SETRANGE(MOVSPROYECTO.Type, MOVSPROYECTO.Type::"G/L Account");
                MOVSPROYECTO.SETRANGE(MOVSPROYECTO.Type, MOVSPROYECTO.Type::Item);
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
    trigger OnPostReport()
    begin
        W.Close();
        MESSAGE('FINALIZADO');
    end;
    trigger OnPreReport()
    begin
        W.OPEN(TXT001 + TXT002);
        i:=1;
    end;
    var JobJnlLine: Record 210;
    JobTask: Record 1001;
    Job: Record Job;
    JobBloq: Record "Proy bloqueados";
    UM: Record 5404;
    DiarioName: Code[20];
    W: Dialog;
    TXT001: Label 'Fecha: #1##########\';
    TXT002: Label 'Registr #2##########';
    Recurso: Record 156;
    Producto: Record 27;
    GposConta: Record 252;
    i: Integer;
    JobLedEntry: Record 169;
    local procedure InsertJobJnlLine()
    begin
        JobTask.Init();
        JobTask."Job No.":=MOVSPROYECTO."Job No.";
        JobTask."Job Task No.":=MOVSPROYECTO."Job No.";
        JobTask.Description:='MIGRACION';
        IF JobTask.Insert()then;
        InsertLibro('MIG_' + FORMAT(CALCDATE('<+CM>', MOVSPROYECTO."Posting Date"), 0, '<day,2><month,2><year>'));
        W.UPDATE(1, MOVSPROYECTO."Posting Date");
        W.UPDATE(2, FORMAT(i) + ' DE ' + FORMAT(MOVSPROYECTO.COUNT));
        i+=1;
        JobJnlLine.Init();
        JobJnlLine."Journal Template Name":='PROY';
        JobJnlLine."Journal Batch Name":=DiarioName;
        JobJnlLine."Line No.":=MOVSPROYECTO."Entry No.";
        JobJnlLine.VALIDATE("Entry Type", MOVSPROYECTO."Entry Type"); //NEW
        JobJnlLine.VALIDATE("Posting Date", MOVSPROYECTO."Posting Date");
        JobJnlLine."Document No.":=MOVSPROYECTO."Document No.";
        JobJnlLine.VALIDATE("Job No.", MOVSPROYECTO."Job No.");
        JobJnlLine."Job Task No.":=MOVSPROYECTO."Job No."; //TAREA!
        JobJnlLine.Type:=MOVSPROYECTO.Type;
        JobJnlLine.VALIDATE("No.", MOVSPROYECTO."No.");
        JobJnlLine.Description:=MOVSPROYECTO.Description;
        IF JobJnlLine.Description = '' THEN //  JobJnlLine.Description := 'MIG ' + FORMAT(CALCDATE('<+CM>',MOVSPROYECTO."Posting Date"),0,'<day,2>/<month,2>/<year>');
 JobJnlLine.VALIDATE("No.", MOVSPROYECTO."No.");
        GposConta.Init();
        GposConta."Gen. Bus. Posting Group":='';
        GposConta."Gen. Prod. Posting Group":=JobJnlLine."Gen. Prod. Posting Group";
        IF GposConta.Insert()then;
        //<crear um
        IF JobJnlLine.Type = JobJnlLine.Type::Item THEN BEGIN
            UM.Init();
            UM.VALIDATE("Item No.", JobJnlLine."No.");
            UM.VALIDATE(Code, MOVSPROYECTO."Unit of Measure Code");
            IF UM.Insert()then;
        END;
        //crear um>
        JobJnlLine.VALIDATE("Unit of Measure Code", MOVSPROYECTO."Unit of Measure Code");
        IF MOVSPROYECTO."Entry Type" = MOVSPROYECTO."Entry Type"::Sale THEN BEGIN
            JobJnlLine."Entry Type":=JobJnlLine."Entry Type"::Sale;
            JobJnlLine.VALIDATE(JobJnlLine.Quantity, -MOVSPROYECTO.Quantity) //NEW
        END
        ELSE
        BEGIN
            JobJnlLine."Entry Type":=JobJnlLine."Entry Type"::Usage;
            JobJnlLine.VALIDATE(JobJnlLine.Quantity, MOVSPROYECTO.Quantity);
        END;
        JobJnlLine.VALIDATE("Unit Cost", MOVSPROYECTO."Unit Cost"); //OJOOOOOOO000000000000000000OOOOOOOOOOOOO
        IF(MOVSPROYECTO."Unit Cost" = 0) AND (MOVSPROYECTO.TotalCost <> 0)THEN JobJnlLine.VALIDATE("Unit Cost", MOVSPROYECTO.TotalCost / MOVSPROYECTO.Quantity); //SPG
        JobJnlLine.VALIDATE("Unit Price", MOVSPROYECTO."Unit Price");
        IF(MOVSPROYECTO."Unit Price" = 0) AND (MOVSPROYECTO.TotalPrice <> 0)THEN JobJnlLine.VALIDATE("Unit Price", MOVSPROYECTO.TotalPrice / MOVSPROYECTO.Quantity); //SPG
        JobJnlLine.VALIDATE("Shortcut Dimension 1 Code", MOVSPROYECTO."Global Dimension 1 Code");
        JobJnlLine.VALIDATE("Shortcut Dimension 2 Code", MOVSPROYECTO."Global Dimension 2 Code");
        JobJnlLine.Insert(); //
    end;
    procedure InsertLibro(parDiario: Code[20])
    var
        Diario: Record 237;
    begin
        Diario.Init();
        Diario.VALIDATE("Journal Template Name", 'PROY');
        Diario.VALIDATE(Name, parDiario);
        IF Diario.Insert()then;
        DiarioName:=parDiario;
    end;
}
