report 52022 "Crear pedidos compra Web"
{
    Caption = 'Create Web Orders';
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Web Order"; "Web Order")
        {
            DataItemTableView = SORTING(NumPedido);

            trigger OnAfterGetRecord()
            var
                SectorsSetup: Record "Sectors and Payments Setup AT";
                OrderHeader: Record 38;
                OrderLine: Record 39;
                ExpenseType: Integer;
                Import: Text[250];
                xWebOrder: Record "Web Order";
                W: Dialog;
                "---": Integer;
                ArchiveManagement: Codeunit 5063;
            begin
                W.OPEN('#1######################\' + 'Procesando #2###########');
                W.UPDATE(1, OrderHeader.TABLECAPTION);
                OrderHeader.Init();
                OrderHeader.VALIDATE(OrderHeader."Document Type", OrderHeader."Document Type"::Order);
                OrderHeader.VALIDATE(OrderHeader."No.", NumPedido);
                OrderHeader.INSERT(TRUE);
                OrderHeader."Posting Date":=TODAY;
                OrderHeader."Expected Receipt Date":=FechaPrevista;
                OrderHeader."Due Date":=FechaPrevista;
                OrderHeader.VALIDATE(OrderHeader."Buy-from Vendor No.", NoProveedor);
                OrderHeader."Buy-from Vendor Name":=Nombre;
                OrderHeader."Buy-from Contact":=Contacto;
                OrderHeader."Buy-from Address":=Direccion;
                OrderHeader."Buy-from City":=Poblacion;
                OrderHeader."VAT Registration No.":=NIF;
                OrderHeader."Web Description AT":=Descripcion;
                OrderHeader."Action Amount AT":=ImporteAccion;
                OrderHeader.Modify();
                SectorsSetup.Reset();
                SectorsSetup.SETRANGE(SectorsSetup.Sector, Sector);
                SectorsSetup.SETRANGE(SectorsSetup."Payment Type", TipoGastos);
                OrderLine."Document Type":=OrderLine."Document Type"::Order;
                OrderLine."Document No.":=OrderHeader."No.";
                IF SectorsSetup.FindFirst()then BEGIN
                    OrderLine.Init();
                    OrderLine."Line No.":=10000;
                    OrderLine.VALIDATE(OrderLine.Type, OrderLine.Type::"G/L Account");
                    OrderLine.INSERT(TRUE);
                    OrderLine.VALIDATE(OrderLine."No.", SectorsSetup."G/L Account");
                    OrderLine.Description:=COPYSTR(Descripcion, 1, 50); //025
                    OrderLine."Description 2":=COPYSTR(Descripcion, 50, 100); //025
                    OrderLine.VALIDATE(OrderLine.Quantity, 1);
                    OrderLine."Direct Unit Cost":=Importe;
                    OrderLine.VALIDATE(OrderLine."Direct Unit Cost");
                    OrderLine.VALIDATE(OrderLine."Job No.", CodProyecto);
                    //045
                    //OrderLine.VALIDATE("Job Task No.",CodProyecto);
                    OrderLine."Job Task No.":=CodProyecto;
                    OrderLine."Job Line Type":=OrderLine."Job Line Type"::Billable;
                    OrderLine.VALIDATE("Job Unit Price", ImporteAccion);
                    //045
                    OrderLine.Modify();
                END
                ELSE
                    ERROR('No existe configuración del sector y tipo. Pedido: %1, Proveedor: %2, Sector y tipo de gasto: %3', OrderHeader."No.", OrderHeader."Buy-from Vendor No.", SectorsSetup.GETFILTERS);
                //xWebOrder.GET(NumPedido,Empresa);                 //OJO!!! ELIMINO RESTRICCION PARA JUEGO DE PRUEBAS XXXXXX
                xWebOrder.GET(NumPedido, "Web Order".Empresa);
                xWebOrder.Sincronizado:=TRUE;
                xWebOrder.Modify();
                ArchiveManagement.StorePurchDocument(OrderHeader, FALSE);
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Proceso finalizado');
            end;
            trigger OnPreDataItem()
            begin
                IF NOT CONFIRM(Txt50001)THEN EXIT;
                SETRANGE(Sincronizado, FALSE);
            //SETRANGE(Empresa,COMPANYNAME);  //OJO!!! ELIMINO RESTRICCION PARA JUEGO DE PRUEBAS XXXXXX
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
    var Txt50001: Label '¿Confirma que desea crear los pedidos de compra web?';
}
