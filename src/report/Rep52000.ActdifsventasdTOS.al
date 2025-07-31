report 52000 "Act difs ventas dTOS"
{
    ProcessingOnly = true;
    Caption = 'Act difs Ventas dTOS';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("MOVS PROYECTOS"; "MOVS PROYECTOS")
        {
            trigger OnAfterGetRecord()
            begin
                MOVSPROYECTOS:="MOVS PROYECTOS";
                MOVSPROYECTOS."Dif Vtas":="MOVS PROYECTOS".GetDifAmount;
                MOVSPROYECTOS.Modify();
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
    var MOVSPROYECTOS: Record "MOVS PROYECTOS";
}
