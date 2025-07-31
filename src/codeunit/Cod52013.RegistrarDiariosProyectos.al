codeunit 52013 "Registrar Diarios Proyectos"
{
    trigger OnRun()
    begin
        JobBatch.Reset();
        JobBatch.SETRANGE("Journal Template Name", 'PROY');
        JobBatch.SETFILTER(Name, TXTFILTRO);
        JobBatch.FindSet();
        REPEAT JobJln.Reset();
            JobJln.SETRANGE("Journal Template Name", JobBatch."Journal Template Name");
            JobJln.SETRANGE("Journal Batch Name", JobBatch.Name);
            JobJln.FindSet();
            CLEAR(PostJnl);
            PostJnl.RunWithCheck(JobJln);
            Commit();
        UNTIL JobBatch.Next() = 0;
        MESSAGE('Finalizado.');
    end;
    var PostJnl: Codeunit 1012;
    JobJln: Record 210;
    JobBatch: Record 237;
    TXTFILTRO: Label 'MIG_*';
}
