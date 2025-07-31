codeunit 52003 "Documentation"
{
    // 001 OS.MIR  07/06/2016  FIN.001   Gastos refacturables en Plan de Cuentas
    // 002 OS.MIR  07/06/2016  FIN.002   Clientes continuados vs. puntuales
    // 003 OS.MIR  07/06/2016  FIN.003   Fichero SAF-T Portugal
    // 004 OS.MIR  07/06/2016  FIN.004   Cuentas bloqueadas en Plan de Cuentas
    // 005 OS.MIR  07/06/2016  FIN.005   Años amortización en Grupos Contables de Activos
    // 
    // 007 OS.MIR  14/06/2016  FIN.007   Previsión de facturación de proyectos en los flujos de efectivo
    // 008 OS.MIR  14/07/2016  FIN.008   Formatos Impreso Venta
    // 010 OS.MIR  20/06/2016  FIN.009   Funcionalidad filiales
    // 011 OS.SPG  01/02/2017  FIN.010   Gastos de caja con imputaciones en proyectos.
    //                                   Marcar lineas de tipo gasto al crear facturas de venta
    // 
    // 023 OS.MIR  30/08/2016  VEN.001   Tipo Facturación Cliente
    // 024 OS.MIR  21/06/2016  COM.001   Módulo IRPF OS
    // 025 OS.SPG  29/06/2016  COM.002   Texto descriptivo timming a pedidos de compra (Sincronización SQL)
    // 026 OS.MIR  14/06/2016  PROY.001  Añadir "Refacturable" en tarea de proyecto
    // 027 OS.MIR  14/06/2016  PROY.002  Añadir "Nº documento externo" en proyecto
    // 028 OS.MIR  27/07/2017  PROY.003  Añadir 5 "Mail contacto" en Proyectos
    // 029 OS.SPG  14/06/2016  PROY.004  Generar abono de venta desde factura registrada con imputación a proyectos
    // 030 OS.SPG  20/06/2016  PROY.005  Facturación multicliente desde proyecto
    // 
    // 040 OS.SPG  28/10/2016  FIN.020   Exportar a Excel esquema de cuentas con todas las combinaciones de dimensiones.
    //                                   Exportar a Excel con separador de miles.
    // 041 OS.SPG  14/12/2016  COM.003   Mostrar desde Factura registrada el pedido origen (archivado)
    // 045 OS.SPG  19/12/2016  COM.002   Importe Acción (importe+margen) desde timming a pedidos de compra (Sincronización SQL)
    //                                   Transferir automáticamente los movs. proyecto a lín. planific. (facturar a cliente).
    // 046 OS.SPG  20/12/2016  VEN.002   Nueva pila en role Proc.Pedidos Venta: Líneas de planif. pdtes facturar
    // 047 OS.SPG  05/12/2017  FIN.012   Asignación de costes asignando centros y objetos de coste a la vez.
    // 050 OS.SPG  23/01/2017  HIST.001  Movs historicos clientes y proveedores.
    // 051 OS.SPG  27/01/2017  PROY.003  Definir tipo emisión factura venta desde el proyecto
    // 051 OS.SPG  01/02/2017  PROY.007  Funcionalidad horas consultor
    // 052 OS.SPG  20/02/2017  PROY.003  Envío facturas según perfil de envío de proyectos
    // 053 OS.SPG  27/02/2018  Gestionar (crear/eliminar) líneas descripción en las líneas de facturas de venta correspondiente a:
    //                         1) conceptos de facturación de Timing
    //                         2) descripción Web de los pedidos de compra
    // 054 OS.SPG  06/03/2017  Sólo facturar los conceptos "confirmados" y controlando si requieren tener informada orden de compra s/cab proyecto
    // 055 OS.SPG  10/03/2017  Crear línea de planific. desde pedido compra al num. de cuenta indicado en nuevo campo lín.compra ("Job Line Account No.")
    //     OS.SPG  15/03/2017  Al validar campo "No." en purch.line, que informe el campo JobLineAccountNo s/configuración de Sectores
    //                         Al validar la línea de tipo "contrato" en linea planific, que el %dto línea= -%recargo del proy.
    // 056 OS.SPG  23/03/2017  Mostrar Nº Proyecto en las cabeceras de los documentos de compras y ventas
    // 057 OS.SPG  27/03/2017  Trasladar asistente en movs. proyecto
    // 060 OS.SPG  03/04/2017  Facturacion por lotes
    // 061 OS.SPG  24/04/2017  Familias de clientes
    // 062 OS.XM   10/05/2017  Activos a proyectos
    // 064 OS.SPG  11/05/2017  Desbloq. en PROY que en ficha cliente el cliente facturacion = ''
    // 
    // 070 OS.SPG  08/05/2017  Permitir realizar pagos en diario pagos liquidando facturas registradas a fecha futura.
    // 075 OS.SPG  17/05/2017  Guarda en mov.proy la empresa que lo origina
    // 079 OS.SPG  25/05/2017  Modificar la numeració de les línies de planif. que es generin desde NAV (diferenciar de les sincro desde WEB)
    // 080 OS.SPG  26/05/2017  Trasladar el num pedido compra cliente de lin. planif a lin. vta
    // 081 OS.SPG  26/05/2017  No permitir registro si requiere "Nº pedido compra cliente" y no lo tiene informado en la cabecera
    // 082 OS.SPG  31/05/2017  Los grupos de IVA se validan solo por el número cta en la linea de planificación, no por su grupo contable prod IVA existente en la línea.
    // 083 OS.SPG  15/05/2017  Guardar empresa en el mov. proyecto
    // 999 OS.MIR  29/06/2016  DataPerCompany = No
    //     OS.MIR  29/06/2016  AsciiToAnsii Codeunit
    //     OS.MIR  21/07/2016  Permite importar registros de "Record Link" mediante RapidStartServices
    // 123 OS.SPG  22/02/2017  Personalizaciones simples
    // 
    // //INFORMES 140 .. 160
    // 140 OS.RM   25/05/2017  Modificaciones en Report 52050 - "Payment Order - Test"
    // 141 OS.RM   07/06/2017  Informe Ranking Facturación Neta
    //                         Informe Ranking Facturación Neta por Oficina/Departamento
    // 142 OS.RM   07/06/2017  Informe Ranking Rentabilidad Proyecto
    // 143 OS.RM   07/06/2017  Rentabilidad por Proyecto Agr.
    // 144 OS.RM   07/06/2017  Rentabilidad por Proyecto Diseño
    // 145 OS.RM   07/06/2017  Informe Control Horas Recursos
    // 146 OS.RM   07/06/2017  Control Gastos
    // 147 OS.RM   07/06/2017  Informe Invoice Expenses Detail
    //                         Informe Posted Invoice Expenses Detail
    // 148 OS.RM   07/06/2017  Informe factura venta
    //                         Informe abono venta
    //                         Informe factura proforma
    // 149 OS.RM   07/06/2017  Ficha Vacaciones Empleados
    // 150 OS.RM   07/06/2017  Facturación - Proyecto
    // 151 OS.RM   07/06/2017  Crosseling Clientes
    // 152 OS.RM   07/06/2017  Previsión Ventas Netas Agr.
    // 153 OS.RM   07/06/2017  Informe dedicación recurso
    //                         Informe dedicación recurso por departamento
    // 154 OS.RM   07/06/2017  Aged Accounts Receivable
    //                         Aged Accounts Payable
    // 155 OS.RM   07/06/2017  Customer - Labels
    trigger OnRun()
    begin
    end;
}
