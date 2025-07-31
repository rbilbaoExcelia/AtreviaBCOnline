report 52005 "Act SINCR plann lines"
{
    ProcessingOnly = true;
    Caption = 'Act SINCR plann lines';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Job Planning Line Invoice";1022)
        {
            DataItemTableView = SORTING("Job No.", "Job Task No.", "Job Planning Line No.", "Document Type", "Document No.", "Line No.")WHERE("Document Type"=FILTER("Posted Invoice"));

            trigger OnAfterGetRecord()
            begin
                IF JobPlannLine.GET("Job No.", "Job Task No.", "Job Planning Line No.")THEN BEGIN
                    JobPlannLine."SQL Synchronized AT":=FALSE;
                    JobPlannLine.Modify();
                END;
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('FIn');
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
    var JobPlannLine: Record 1003;
}
