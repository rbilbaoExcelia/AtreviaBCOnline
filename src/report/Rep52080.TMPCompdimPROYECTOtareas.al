report 52080 "TMP Comp. dim PROYECTO tareas"
{
    ApplicationArea = All;
    Caption = 'TMP Comp. dim PROYECTO tareas';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Company; Company)
        {
            DataItemTableView = sorting(Name);
            RequestFilterFields = Name;

            dataitem(Job; Job)
            {
                DataItemTableView = sorting("No.");
                RequestFilterFields = "No.";

                dataitem("Job Task"; "Job Task")
                {
                    DataItemTableView = sorting("Job No.", "Job Task No.");
                    DataItemLink = "Job No."=field("No.");

                    trigger OnAfterGetRecord()
                    begin
                        v.Update(3, "Job Task"."Job Task No.");
                        RstDefDims.SetRange("No.", Job."No.");
                        if RstDefDims.FindFirst()then begin
                            if not RstTaskDims.get(RstDefDims."No.", "Job Task"."Job Task No.", RstDefDims."Dimension Code")then begin
                                RstTaskDims.Init();
                                RstTaskDims."Job No.":=RstDefDims."No.";
                                RstTaskDims."Job Task No.":="Job Task"."Job Task No.";
                                RstTaskDims."Dimension Code":=RstDefDims."Dimension Code";
                                RstTaskDims."Dimension Value Code":=RstDefDims."Dimension Value Code";
                                RstTaskDims.Insert(false);
                                DimsIns+=1;
                            end
                            else if RstTaskDims."Dimension Value Code" <> RstDefDims."Dimension Value Code" then begin
                                    RstTaskDims."Dimension Value Code":=RstDefDims."Dimension Value Code";
                                    RstTaskDims.Modify(false);
                                    DimsMods+=1;
                                end;
                        end;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    v.Update(2, Job."No.");
                end;
            }
            trigger OnPreDataItem()
            begin
                V.Open('Comprobando dimension PROYECTO en tareas........\' + 'Empresa:  #1###############################\' + 'Proyecto: #2###############################\' + 'Tarea:    #3###############################');
            end;
            trigger OnAfterGetRecord()
            begin
                v.Update(1, Company.Name);
                Job.ChangeCompany(Company.Name);
                RstDefDims.ChangeCompany(Company.Name);
                RstDefDims.SetRange("Table ID", Database::Job);
                RstDefDims.SetRange("Dimension Code", 'PROYECTO');
                "Job Task".ChangeCompany(Company.Name);
                RstTaskDims.ChangeCompany(Company.Name);
            end;
            trigger OnPostDataItem()
            begin
                v.Close();
                Message('Dimensiones insertadas: ' + format(DimsIns) + '\Dimensiones modificadas: ' + Format(DimsMods));
            end;
        }
    }
    var RstDefDims: Record "Default Dimension";
    RstTaskDims: record "Job Task Dimension";
    DimsMods: Integer;
    DimsIns: Integer;
    V: Dialog;
}
