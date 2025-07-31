report 52074 "UPD JobLedEntry DIMS"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Job Ledger Entry";169)
        {
            DataItemTableView = SORTING("Job No.", "Job Task No.", "Entry Type", "Posting Date");
            RequestFilterFields = "Posting Date", "Job No.";

            trigger OnAfterGetRecord()
            begin
                CurrReport.Skip();
            /*
                JobLedgerEntry := "Job Ledger Entry";
                
                IF "Job Ledger Entry"."Ledger Entry Type"= "Job Ledger Entry"."Ledger Entry Type"::"G/L Account" THEN BEGIN
                  IF GLEntry.GET("Job Ledger Entry"."Ledger Entry No.") THEN BEGIN
                    IF GLEntry."Document No."="Job Ledger Entry"."Document No." THEN BEGIN
                        JobLedgerEntry."Global Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                        JobLedgerEntry."Global Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                        JobLedgerEntry."Dimension Set ID" := GLEntry."Dimension Set ID";
                        JobLedgerEntry.Modify();
                    END;
                  END;
                
                END ELSE BEGIN
                  {
                  IF JobLedgerEntry."Global Dimension 1 Code"='REVISAR' THEN BEGIN
                    IF Job.GET("Job Ledger Entry"."Job No.") THEN BEGIN
                      JobLedgerEntry."Global Dimension 1 Code" := Job."Global Dimension 1 Code";
                      JobLedgerEntry."Global Dimension 2 Code" := Job."Global Dimension 2 Code";
                
                        CLEAR(TempDimSetEntry);
                        TempDimSetEntry.Reset(); //Dim 1
                        TempDimSetEntry.SETRANGE("Dimension Code",'AREA GEOGRAFICA');
                        IF TempDimSetEntry.FINDSET(TRUE,TRUE) THEN BEGIN
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 1 Code");
                          TempDimSetEntry.Modify();
                        END ELSE BEGIN
                          TempDimSetEntry.Init();
                          TempDimSetEntry.VALIDATE("Dimension Code",'AREA GEOGRAFICA');
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 1 Code");
                          TempDimSetEntry.Insert();
                        END;
                
                        TempDimSetEntry.Reset(); //Dim 2
                        TempDimSetEntry.SETRANGE("Dimension Code",'DEPARTAMENTO');
                        IF TempDimSetEntry.FINDSET(TRUE,TRUE) THEN BEGIN
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 2 Code");
                          TempDimSetEntry.Modify();
                        END ELSE BEGIN
                          TempDimSetEntry.Init();
                          TempDimSetEntry.VALIDATE("Dimension Code",'DEPARTAMENTO');
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 2 Code");
                          TempDimSetEntry.Insert();
                        END;
                
                        TempDimSetEntry.Reset(); //Dim 3
                        TempDimSetEntry.SETRANGE("Dimension Code",'PROYECTO');
                        IF TempDimSetEntry.FINDSET(TRUE,TRUE) THEN BEGIN
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."No.");
                          TempDimSetEntry.Modify();
                        END ELSE BEGIN
                          TempDimSetEntry.Init();
                          TempDimSetEntry.VALIDATE("Dimension Code",'PROYECTO');
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."No.");
                          TempDimSetEntry.Insert();
                        END;
                
                        CLEAR(DimMgt);
                        JobLedgerEntry."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                        JobLedgerEntry.Modify();
                    END;
                  END;
                  }
                END;
                */
            end;
            trigger OnPreDataItem()
            begin
                "Job Ledger Entry".SETFILTER("Posting Date", '>%1', 20170501D);
                //"Job Ledger Entry".SETRANGE("Job Ledger Entry"."Global Dimension 1 Code",'REVISAR');
                "Job Ledger Entry".SETRANGE("Job Ledger Entry"."Ledger Entry Type", "Job Ledger Entry"."Ledger Entry Type"::"G/L Account");
            end;
        }
        dataitem("G/L Entry";17)
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date");

            trigger OnAfterGetRecord()
            begin
                CurrReport.Skip();
            /*
                GLEntry := "G/L Entry";
                
                IF (GLEntry."Global Dimension 1 Code"='REVISAR') AND (GLEntry."Job No."<>'') THEN BEGIN
                  IF Job.GET(GLEntry."Job No.") THEN BEGIN
                
                    IF Job."Global Dimension 1 Code"<>'REVISAR' THEN BEGIN
                      GLEntry."Global Dimension 1 Code" := Job."Global Dimension 1 Code";
                      GLEntry."Global Dimension 2 Code" := Job."Global Dimension 2 Code";
                
                        CLEAR(TempDimSetEntry);
                        TempDimSetEntry.Reset(); //Dim 1
                        TempDimSetEntry.SETRANGE("Dimension Code",'AREA GEOGRAFICA');
                        IF TempDimSetEntry.FINDSET(TRUE,TRUE) THEN BEGIN
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 1 Code");
                          TempDimSetEntry.Modify();
                        END ELSE BEGIN
                          TempDimSetEntry.Init();
                          TempDimSetEntry.VALIDATE("Dimension Code",'AREA GEOGRAFICA');
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 1 Code");
                          TempDimSetEntry.Insert();
                        END;
                
                        TempDimSetEntry.Reset(); //Dim 2
                        TempDimSetEntry.SETRANGE("Dimension Code",'DEPARTAMENTO');
                        IF TempDimSetEntry.FINDSET(TRUE,TRUE) THEN BEGIN
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 2 Code");
                          TempDimSetEntry.Modify();
                        END ELSE BEGIN
                          TempDimSetEntry.Init();
                          TempDimSetEntry.VALIDATE("Dimension Code",'DEPARTAMENTO');
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."Global Dimension 2 Code");
                          TempDimSetEntry.Insert();
                        END;
                
                        TempDimSetEntry.Reset(); //Dim 3
                        TempDimSetEntry.SETRANGE("Dimension Code",'PROYECTO');
                        IF TempDimSetEntry.FINDSET(TRUE,TRUE) THEN BEGIN
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."No.");
                          TempDimSetEntry.Modify();
                        END ELSE BEGIN
                          TempDimSetEntry.Init();
                          TempDimSetEntry.VALIDATE("Dimension Code",'PROYECTO');
                          TempDimSetEntry.VALIDATE("Dimension Value Code",Job."No.");
                          TempDimSetEntry.Insert();
                        END;
                
                        CLEAR(DimMgt);
                        GLEntry."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                        GLEntry.Modify();
                    END;
                
                  END;
                END;
                */
            end;
            trigger OnPreDataItem()
            begin
                SETRANGE("Global Dimension 1 Code", 'REVISAR');
                CurrReport.Skip();
            end;
        }
        dataitem("MOVS PROYECTOS"; "MOVS PROYECTOS")
        {
            DataItemTableView = SORTING("Job No.");
            RequestFilterFields = "Job No.";

            trigger OnAfterGetRecord()
            begin
                "MOVS PROYECTOS".CALCFIELDS("No.mov JobLedgEntry");
                IF "No.mov JobLedgEntry" <> 0 THEN BEGIN
                    JobLedgerEntry.Init();
                    JobLedgerEntry.Reset();
                    JobLedgerEntry.SETRANGE(JobLedgerEntry."Entry No.", "No.mov JobLedgEntry");
                    JobLedgerEntry.SETRANGE(JobLedgerEntry."Line Amount", "MOVS PROYECTOS".TotalPrice);
                    JobLedgerEntry.SETRANGE(JobLedgerEntry."Total Cost", "MOVS PROYECTOS".TotalCost);
                    IF JobLedgerEntry.FIND('-')THEN BEGIN
                        IF("MOVS PROYECTOS"."Global Dimension 1 Code" <> '') AND ("MOVS PROYECTOS"."Global Dimension 2 Code" <> '')THEN BEGIN
                            JobLedgerEntry."Global Dimension 1 Code":="MOVS PROYECTOS"."Global Dimension 1 Code";
                            JobLedgerEntry."Global Dimension 2 Code":="MOVS PROYECTOS"."Global Dimension 2 Code";
                            CLEAR(TempDimSetEntry);
                            TempDimSetEntry.Reset(); //Dim 1
                            TempDimSetEntry.SETRANGE("Dimension Code", 'AREA GEOGRAFICA');
                            IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                                TempDimSetEntry.VALIDATE("Dimension Value Code", "MOVS PROYECTOS"."Global Dimension 1 Code");
                                TempDimSetEntry.Modify();
                            END
                            ELSE
                            BEGIN
                                TempDimSetEntry.Init();
                                TempDimSetEntry.VALIDATE("Dimension Code", 'AREA GEOGRAFICA');
                                TempDimSetEntry.VALIDATE("Dimension Value Code", "MOVS PROYECTOS"."Global Dimension 1 Code");
                                TempDimSetEntry.Insert();
                            END;
                            TempDimSetEntry.Reset(); //Dim 2
                            TempDimSetEntry.SETRANGE("Dimension Code", 'DEPARTAMENTO');
                            IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                                TempDimSetEntry.VALIDATE("Dimension Value Code", "MOVS PROYECTOS"."Global Dimension 2 Code");
                                TempDimSetEntry.Modify();
                            END
                            ELSE
                            BEGIN
                                TempDimSetEntry.Init();
                                TempDimSetEntry.VALIDATE("Dimension Code", 'DEPARTAMENTO');
                                TempDimSetEntry.VALIDATE("Dimension Value Code", "MOVS PROYECTOS"."Global Dimension 2 Code");
                                TempDimSetEntry.Insert();
                            END;
                            TempDimSetEntry.Reset(); //Dim 3
                            TempDimSetEntry.SETRANGE("Dimension Code", 'PROYECTO');
                            IF TempDimSetEntry.FINDSET(TRUE, TRUE)THEN BEGIN
                                TempDimSetEntry.VALIDATE("Dimension Value Code", "MOVS PROYECTOS"."Job No.");
                                TempDimSetEntry.Modify();
                            END
                            ELSE
                            BEGIN
                                TempDimSetEntry.Init();
                                TempDimSetEntry.VALIDATE("Dimension Code", 'PROYECTO');
                                TempDimSetEntry.VALIDATE("Dimension Value Code", "MOVS PROYECTOS"."Job No.");
                                TempDimSetEntry.Insert();
                            END;
                            CLEAR(DimMgt);
                            JobLedgerEntry."Dimension Set ID":=DimMgt.GetDimensionSetID(TempDimSetEntry);
                            JobLedgerEntry.Modify();
                        END;
                    END;
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
        MESSAGE('Finalizado');
    end;
    var GLEntry: Record 17;
    JobLedgerEntry: Record 169;
    Job: Record Job;
    DimMgt: Codeunit DimensionManagement;
    TempDimSetEntry: Record 480 temporary;
}
