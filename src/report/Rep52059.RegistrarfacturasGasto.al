report 52059 "Registrar facturas Gasto"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/RegistrarfacturasGasto.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header";38)
        {
            DataItemTableView = SORTING("Document Type", "No.")ORDER(Ascending)WHERE("Facturas de Gastos"=FILTER(true));

            trigger OnAfterGetRecord()
            begin
                "Purchase Header"."Saltar Mensaje Final":=true;
                cod_purchpost.RUN("Purchase Header");
                contador+=1;
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Proceso Finalizado, se han registrado: %1', contador);
            end;
        }
    }
    var cod_purchpost: Codeunit 90;
    contador: Integer;
}
