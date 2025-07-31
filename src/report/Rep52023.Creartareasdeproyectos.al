report 52023 "Crear tareas de proyectos"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Crear tareas de proyectos';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Job;167)
        {
            trigger OnAfterGetRecord()
            var
                recjobtask: Record 1001;
            begin
                w.UPDATE(1, Job."No.");
                recjobtask."Job No.":=Job."No.";
                recjobtask."Job Task No.":=Job."No.";
                recjobtask."Job Task Type":=recjobtask."Job Task Type"::Posting;
                IF recjobtask.Insert()then;
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Finalizado');
            end;
            trigger OnPreDataItem()
            begin
                w.OPEN('Procesando #1############\');
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
    var w: Dialog;
}
