report 52034 "Get cost movs proy"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("MOVS PROYECTOS"; "MOVS PROYECTOS")
        {
            DataItemTableView = SORTING("Entry No.");

            trigger OnAfterGetRecord()
            var
                vCost: Decimal;
                xMovsProy: Record "MOVS PROYECTOS";
            begin
                IF "MOVS PROYECTOS"."Unit Cost" <> 0 THEN vCost:="MOVS PROYECTOS"."Unit Cost";
                IF "MOVS PROYECTOS"."Direct Unit Cost" <> 0 THEN vCost:="MOVS PROYECTOS"."Direct Unit Cost";
                xMovsProy:="MOVS PROYECTOS";
                xMovsProy.Cost:=vCost;
                xMovsProy.Modify();
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Finalizado');
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
}
