tableextension 52051 "JobPlanningLineInvoice" extends "Job Planning Line Invoice"
{
    fields
    {
        field(52000; "SQL Synchronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';
            Description = '-025';
        }
        field(52107; "Job Assistant"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Asistente';
            Description = '-030';
        }
    }
    local procedure UpdateJobCust()
    var
        JobCust: Record "Job Customer AT";
    begin
        JobCust.SETRANGE("Job No.", Rec."Job No.");
        JobCust.SETRANGE("SQL Synchronized", TRUE);
        IF Rec."Document Type" = Rec."Document Type"::"Posted Credit Memo" THEN BEGIN
            JobCust.SETRANGE(JobCust."Line No.", Rec."Job Planning Line No." - 1);
            IF JobCust.FIND('-')THEN BEGIN
                JobCust."SQL Synchronized":=FALSE;
                JobCust.Modify();
            END;
        END;
    end;
}
