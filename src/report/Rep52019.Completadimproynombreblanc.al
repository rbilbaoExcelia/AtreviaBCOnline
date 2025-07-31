report 52019 "Completa dim proy nombre blanc"
{
    ProcessingOnly = true;
    Caption = 'Completa dim proy nombre blanc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Dimension Value";349)
        {
            DataItemTableView = SORTING("Dimension Code", Code)ORDER(Ascending)WHERE("Dimension Code"=CONST('PROYECTO'), Name=FILTER(''));

            trigger OnAfterGetRecord()
            begin
                CLEAR(Proyector);
                IF Proyector.GET("Dimension Value".Code)THEN BEGIN
                    CLEAR(Dimvaluer);
                    Dimvaluer.COPY("Dimension Value");
                    Dimvaluer.Name:=COPYSTR(Proyector.Description, 1, MAXSTRLEN(Dimvaluer.Name));
                    Dimvaluer.Modify();
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
        MESSAGE('Finito.');
    end;
    var Dimvaluer: Record 349;
    Proyector: Record Job;
}
