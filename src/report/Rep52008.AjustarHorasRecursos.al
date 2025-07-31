report 52008 "AjustarHorasRecursos"
{
    ProcessingOnly = true;
    Caption = 'Ajustar Horas Recursos';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Job Ledger Entry";169)
        {
            DataItemTableView = SORTING("Job No.", "Posting Date")WHERE("Posting Date"=FILTER(>='20-03-17'), Type=FILTER(Resource), Quantity=FILTER(>=25|<=-25));

            trigger OnAfterGetRecord()
            begin
                "Job Ledger Entry".Quantity:="Job Ledger Entry".Quantity / 100;
                "Job Ledger Entry"."Quantity (Base)":="Job Ledger Entry"."Quantity (Base)" / 100;
                "Job Ledger Entry"."Total Cost (LCY)":="Job Ledger Entry"."Total Cost" / 100;
                "Job Ledger Entry"."Total Cost":="Job Ledger Entry"."Total Cost" / 100;
                "Job Ledger Entry"."Total Price":="Job Ledger Entry"."Total Price" / 100;
                "Job Ledger Entry"."Total Price (LCY)":="Job Ledger Entry"."Total Price (LCY)" / 100;
                "Job Ledger Entry".Modify();
            end;
        }
        dataitem("Res. Ledger Entry";203)
        {
            DataItemTableView = SORTING("Resource No.", "Posting Date")WHERE("Posting Date"=FILTER(>='20-03-17'), Quantity=FILTER(>=25|<=-25));

            trigger OnAfterGetRecord()
            begin
                "Res. Ledger Entry".Quantity:="Res. Ledger Entry".Quantity / 100;
                "Res. Ledger Entry"."Quantity (Base)":="Res. Ledger Entry"."Quantity (Base)" / 100;
                "Res. Ledger Entry"."Total Cost":="Res. Ledger Entry"."Total Cost" / 100;
                "Res. Ledger Entry"."Total Price":="Res. Ledger Entry"."Total Price" / 100;
                "Res. Ledger Entry".Modify();
            end;
        }
        dataitem("Hours consulting AT"; "Hours consulting AT")
        {
            DataItemTableView = SORTING("No. consultor", "No. proyecto", Fecha)WHERE(Fecha=FILTER(>='27-03-17'), Horas=FILTER(<=-25|>=25));

            trigger OnAfterGetRecord()
            begin
                "Hours consulting AT".Horas:="Hours consulting AT".Horas / 100;
                "Hours consulting AT"."Horas registradas":="Hours consulting AT"."Horas registradas" / 100;
                "Hours consulting AT".Modify();
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
}
