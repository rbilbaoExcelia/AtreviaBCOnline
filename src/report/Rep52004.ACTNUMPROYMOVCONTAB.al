report 52004 "ACT NUM PROY MOVCONTAB********"
{
    ProcessingOnly = true;
    Caption = 'ACT NUM PROY MOVCONTAB';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry";17)
        {
            DataItemTableView = SORTING("G/L Account No.", "Job No.", "Posting Date")WHERE("Job No."=FILTER(''), "Posting Date"=FILTER('01-01-16..30-09-16'));

            trigger OnAfterGetRecord()
            begin
                W.UPDATE(2, FORMAT(i) + ' DE ' + FORMAT("G/L Entry".COUNT));
                i+=1;
                MovContabl.SETRANGE(MovContabl."Posting Date", "G/L Entry"."Posting Date");
                MovContabl.SETRANGE(MovContabl."Document No.", "G/L Entry"."Document No.");
                MovContabl.SETRANGE(MovContabl."Document Type", "G/L Entry"."Document Type");
                MovContabl.SETRANGE(MovContabl.NewDim1, "G/L Entry"."Global Dimension 1 Code");
                MovContabl.SETRANGE(MovContabl.NewDim2, "G/L Entry"."Global Dimension 2 Code");
                MovContabl.SETRANGE(MovContabl."G/L Account No.", "G/L Entry"."G/L Account No.");
                MovContabl.SETRANGE(MovContabl.Quantity, "G/L Entry".Quantity);
                MovContabl.SETRANGE(MovContabl.Amount, "G/L Entry".Amount);
                IF MovContabl.FIND('-')THEN BEGIN
                    GLUpd:="G/L Entry";
                    GLUpd.VALIDATE("Job No.", MovContabl."Global Dimension 2 Code");
                    GLUpd.Modify();
                END;
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('FINALIZADO');
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
    end;
    trigger OnPreReport()
    begin
        W.OPEN(TXT002);
        i:=1;
    end;
    var MovContabl: Record "MOV.CONTAB";
    GLUpd: Record 17;
    TXT002: Label 'Registr #2##########';
    W: Dialog;
    i: Integer;
}
