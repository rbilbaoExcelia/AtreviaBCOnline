report 52042 "MandatoryDIMS"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Dimension Value";349)
        {
            DataItemTableView = SORTING("Dimension Code", Code)WHERE("Dimension Code"=FILTER('PROYECTO'));

            trigger OnAfterGetRecord()
            var
                Job: Record Job;
            begin
                IF Job.GET("Dimension Value".Code)THEN BEGIN
                    "Dimension Value".Name:=Job.Description;
                    Modify();
                END;
            end;
        }
        dataitem("Default Dimension";352)
        {
            DataItemTableView = SORTING("Table ID", "No.", "Dimension Code")WHERE("Table ID"=FILTER(167));

            trigger OnAfterGetRecord()
            begin
                DefDim:="Default Dimension";
                IF DefDim."Dimension Code" = 'PROYECTO' THEN //DefDim.VALIDATE("Value Posting",DefDim."Value Posting"::"Same Code")
 DefDim.VALIDATE("Value Posting", DefDim."Value Posting"::"Code Mandatory")
                ELSE
                    DefDim.VALIDATE("Value Posting", DefDim."Value Posting"::"Code Mandatory");
                DefDim.Modify();
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
        MESSAGE('Fin');
    end;
    var DefDim: Record 352;
}
