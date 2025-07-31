report 52058 "REG HORAS CONSULTOR"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Hours consulting AT"; "Hours consulting AT")
        {
            DataItemTableView = SORTING("No. consultor", "No. proyecto", Fecha)WHERE(Fecha=FILTER('01-05-17..31-05-17'), "No. proyecto"=FILTER(000000005));

            trigger OnAfterGetRecord()
            var
                Hoursconsulting: Record "Hours consulting AT";
            begin
                ResLedgerEntry.SETRANGE("Posting Date", "Hours consulting AT".Fecha);
                ResLedgerEntry.SETRANGE(ResLedgerEntry."Resource No.", "Hours consulting AT"."No. consultor");
                ResLedgerEntry.SETRANGE(ResLedgerEntry."Job No.", "Hours consulting AT"."No. proyecto");
                ResLedgerEntry.SETRANGE(ResLedgerEntry.Quantity, "Hours consulting AT".Horas);
                IF NOT ResLedgerEntry.FIND('-')THEN BEGIN
                    Hoursconsulting:="Hours consulting AT";
                    Hoursconsulting.Registrado:=FALSE;
                    Hoursconsulting.Modify();
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
        MESSAGE('Fin');
    end;
    var ResLedgerEntry: Record 203;
}
