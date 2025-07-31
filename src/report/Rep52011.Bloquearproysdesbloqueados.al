report 52011 "Bloquear proys desbloqueados <"
{
    ProcessingOnly = true;
    Caption = 'Bloquear proys desbloqueados';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1100225000; "Proy bloqueados")
        {
            trigger OnAfterGetRecord()
            begin
                CurrReport.Skip();
            /*
                IF "Proy bloqueados".Tabla =167 THEN BEGIN
                  IF job.GET("Proy bloqueados"."Cod Proy") THEN BEGIN
                    job.Blocked := 2;
                    job.Modify();
                  END;
                
                END ELSE IF "Proy bloqueados".Tabla =27 THEN BEGIN
                
                  IF producto.GET("Proy bloqueados"."Cod Proy") THEN BEGIN
                        producto.Blocked := TRUE;
                        producto.Modify();
                  END;
                
                END ELSE IF "Proy bloqueados".Tabla =156 THEN BEGIN
                
                  IF recurso.GET("Proy bloqueados"."Cod Proy") THEN BEGIN
                        recurso.Blocked := TRUE;
                        recurso.Modify();
                  END;
                END;
                */
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.Skip();
            end;
        }
        dataitem(Job1;167)
        {
            trigger OnAfterGetRecord()
            var
                Job2: Record Job;
            begin
                IF Job1.Status = Job1.Status::Completed THEN BEGIN
                    Job2:=Job1;
                    Job2.VALIDATE(Blocked, Job2.Blocked::All);
                    Job2.Modify();
                END;
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
        MESSAGE('finalizado');
    end;
    var job: Record Job;
    producto: Record 27;
    recurso: Record 156;
    codproy: Code[20];
}
