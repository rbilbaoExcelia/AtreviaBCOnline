Codeunit 52019 "Correcion Reg mov contabilidad"
{
    Permissions = tabledata 45=rimd;

    trigger OnRun()
    begin
        IF CONFIRM('¨Desea lanzar la corrección del registro de movimientos de contabilidad e IVA?')THEN IF CONFIRM('Este es un proceso IRREVERSIBLE que BORRA la tabla\' + 'de registro de movimientos y regenera los datos.\\' + '¨Está SEGURO de que desea CONTINUAR?')THEN EjecutaCorreccion;
    end;
    var pMovsCont: Record "G/L Entry";
    pRegMovsCont: Record "G/L Register";
    pRegMovsTemp: Record "G/L Register" temporary;
    pMovsIVA: Record "VAT Entry";
    pCorreccionRegMov: Record "G/L Register";
    Dialogo: Dialog;
    iTotalAsientos: Integer;
    iTotalMovs: Integer;
    iMovIVADesde: Integer;
    iMovIVAHasta: Integer;
    PROCEDURE EjecutaCorreccion();
    BEGIN
        pMovsCont.RESET;
        pRegMovsCont.RESET;
        pCorreccionRegMov.RESET;
        pMovsIVA.RESET;
        Dialogo.OPEN('#1################################\Procesando Nº            #2#######\@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        Dialogo.UPDATE(1, 'Guardando asientos en tabla temporal');
        // Guardar asientos
        pRegMovsCont.RESET;
        pRegMovsTemp.RESET;
        iTotalAsientos:=pRegMovsCont.COUNT;
        IF pRegMovsCont.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pRegMovsCont."No.");
                Dialogo.UPDATE(3, ROUND((pRegMovsCont."No." / iTotalAsientos) * 10000, 1));
                // Guardamos copia del registro en la tabla de backup
                pRegMovsTemp.TRANSFERFIELDS(pRegMovsCont);
                pRegMovsTemp.INSERT(TRUE);
            UNTIL pRegMovsCont.NEXT = 0;
        // Borrar asientos
        Dialogo.UPDATE(1, 'Borrando asientos');
        pCorreccionRegMov.RESET;
        iTotalAsientos:=pCorreccionRegMov.COUNT;
        IF pCorreccionRegMov.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pCorreccionRegMov."No.");
                Dialogo.UPDATE(3, ROUND((pCorreccionRegMov."No." / iTotalAsientos) * 10000, 1));
                pCorreccionRegMov.DELETE(TRUE);
            UNTIL pCorreccionRegMov.NEXT = 0;
        // Recorrerse la tabla de movimientos de contabilidad y regenerar los registros
        Dialogo.UPDATE(1, 'Procesando movimientos y regenerando registro');
        pMovsCont.RESET;
        iTotalMovs:=pMovsCont.COUNT;
        IF pMovsCont.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pMovsCont."Entry No.");
                Dialogo.UPDATE(3, ROUND((pMovsCont."Entry No." / iTotalMovs) * 10000, 1));
                pCorreccionRegMov.INIT;
                pCorreccionRegMov."No.":=pMovsCont."Transaction No.";
                pCorreccionRegMov."Source Code":=pMovsCont."Source Code";
                pCorreccionRegMov."User ID":=pMovsCont."User ID";
                pCorreccionRegMov."Journal Batch Name":=pMovsCont."Journal Batch Name";
                pCorreccionRegMov."Posting Date":=pMovsCont."Posting Date";
                IF pCorreccionRegMov.INSERT THEN;
            UNTIL pMovsCont.NEXT = 0;
        // Reasignar los números de movimiento
        Dialogo.UPDATE(1, 'Reasignando los números de movimiento');
        pMovsCont.RESET;
        pCorreccionRegMov.RESET;
        iTotalAsientos:=pCorreccionRegMov.COUNT;
        IF pCorreccionRegMov.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pCorreccionRegMov."No.");
                Dialogo.UPDATE(3, ROUND((pCorreccionRegMov."No." / iTotalAsientos) * 10000, 1));
                pMovsCont.SETRANGE(pMovsCont."Transaction No.", pCorreccionRegMov."No.");
                IF pMovsCont.FIND('-')THEN pCorreccionRegMov."From Entry No.":=pMovsCont."Entry No.";
                IF pMovsCont.FIND('+')THEN pCorreccionRegMov."To Entry No.":=pMovsCont."Entry No.";
                pCorreccionRegMov.MODIFY;
            UNTIL pCorreccionRegMov.NEXT = 0;
        // Reasignar los números de IVA
        Dialogo.UPDATE(1, 'Reasignando los números de IVA');
        pMovsIVA.RESET;
        pCorreccionRegMov.RESET;
        iTotalAsientos:=pCorreccionRegMov.COUNT;
        IF pCorreccionRegMov.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pCorreccionRegMov."No.");
                Dialogo.UPDATE(3, ROUND((pCorreccionRegMov."No." / iTotalAsientos) * 10000, 1));
                pMovsIVA.SETRANGE(pMovsIVA."Transaction No.", pCorreccionRegMov."No.");
                IF pMovsIVA.FIND('-')THEN BEGIN
                    iMovIVADesde:=pMovsIVA."Entry No.";
                    pCorreccionRegMov."From VAT Entry No.":=iMovIVADesde;
                END
                ELSE
                    pCorreccionRegMov."From VAT Entry No.":=iMovIVAHasta + 1;
                IF pMovsIVA.FIND('+')THEN BEGIN
                    iMovIVAHasta:=pMovsIVA."Entry No.";
                    pCorreccionRegMov."To VAT Entry No.":=iMovIVAHasta;
                END
                ELSE
                    pCorreccionRegMov."To VAT Entry No.":=iMovIVAHasta;
                pCorreccionRegMov.MODIFY;
            UNTIL pCorreccionRegMov.NEXT = 0;
        // Recuperar las fechas de creación
        Dialogo.UPDATE(1, 'Recuperando fechas de creación');
        pCorreccionRegMov.RESET;
        pRegMovsTemp.RESET;
        iTotalAsientos:=pCorreccionRegMov.COUNT;
        IF pCorreccionRegMov.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pCorreccionRegMov."No.");
                Dialogo.UPDATE(3, ROUND((pCorreccionRegMov."No." / iTotalAsientos) * 10000, 1));
                pRegMovsTemp.SetRange("From Entry No.", pCorreccionRegMov."From Entry No.");
                pRegMovsTemp.SetRange("To Entry No.", pCorreccionRegMov."To Entry No.");
                IF pRegMovsTemp.FindLast()THEN // IF pRegMovsTemp.GET(pCorreccionRegMov."No.") THEN
 pCorreccionRegMov."Creation Date":=pRegMovsTemp."Creation Date"
                ELSE
                    pCorreccionRegMov."Creation Date":=pRegMovsTemp."Creation Date";
                pCorreccionRegMov.MODIFY;
            UNTIL pCorreccionRegMov.NEXT = 0;
        Dialogo.CLOSE;
    END;
}
