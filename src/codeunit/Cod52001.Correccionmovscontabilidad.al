codeunit 52001 "Correccion movs. contabilidad"
{
    // Esta 'codeunit' corrige el registro de movimientos de contabilidad que se ha descuadrado con los movimientos
    // de contabilidad propiamente dichos, así como los movimientos de IVA.
    trigger OnRun()
    begin
        IF CONFIRM('¿Desea lanzar la corrección del registro de movimientos de contabilidad e IVA?')THEN IF CONFIRM('Este es un proceso IRREVERSIBLE que BORRA la tabla\' + 'de registro de movimientos y regenera los datos.\\' + '¿Está SEGURO de que desea CONTINUAR?')THEN EjecutaCorreccion;
    end;
    var pMovsCont: Record 17;
    pRegMovsCont: Record 45;
    pRegMovsTemp: Record 45 temporary;
    pMovsIVA: Record 254;
    pCorreccionRegMov: Record 45;
    Dialogo: Dialog;
    iTotalAsientos: Integer;
    iTotalMovs: Integer;
    iMovIVADesde: Integer;
    iMovIVAHasta: Integer;
    procedure EjecutaCorreccion()
    begin
        pMovsCont.Reset();
        pRegMovsCont.Reset();
        pCorreccionRegMov.Reset();
        pMovsIVA.Reset();
        Dialogo.OPEN('#1################################\Procesando nº            #2#######\@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        Dialogo.UPDATE(1, 'Guardando asientos en tabla temporal');
        // Guardar asientos
        pRegMovsCont.Reset();
        pRegMovsTemp.Reset();
        iTotalAsientos:=pRegMovsCont.COUNT;
        IF pRegMovsCont.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pRegMovsCont."No.");
                Dialogo.UPDATE(3, ROUND((pRegMovsCont."No." / iTotalAsientos) * 10000, 1));
                // Guardamos copia del registro en la tabla de backup
                pRegMovsTemp.TRANSFERFIELDS(pRegMovsCont);
                pRegMovsTemp.INSERT(TRUE);
            UNTIL pRegMovsCont.Next() = 0;
        // Borrar asientos
        Dialogo.UPDATE(1, 'Borrando asientos');
        pCorreccionRegMov.Reset();
        iTotalAsientos:=pCorreccionRegMov.COUNT;
        IF pCorreccionRegMov.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pCorreccionRegMov."No.");
                Dialogo.UPDATE(3, ROUND((pCorreccionRegMov."No." / iTotalAsientos) * 10000, 1));
                pCorreccionRegMov.DELETE(TRUE);
            UNTIL pCorreccionRegMov.Next() = 0;
        // Recorrerse la tabla de movimientos de contabilidad y regenerar los registros
        Dialogo.UPDATE(1, 'Procesando movimientos y regenerando registro');
        pMovsCont.Reset();
        iTotalMovs:=pMovsCont.COUNT;
        IF pMovsCont.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pMovsCont."Entry No.");
                Dialogo.UPDATE(3, ROUND((pMovsCont."Entry No." / iTotalMovs) * 10000, 1));
                pCorreccionRegMov.Init();
                pCorreccionRegMov."No.":=pMovsCont."Transaction No.";
                pCorreccionRegMov."Source Code":=pMovsCont."Source Code";
                pCorreccionRegMov."User ID":=pMovsCont."User ID";
                pCorreccionRegMov."Journal Batch Name":=pMovsCont."Journal Batch Name";
                pCorreccionRegMov."Posting Date":=pMovsCont."Posting Date";
                IF pCorreccionRegMov.Insert()then;
            UNTIL pMovsCont.Next() = 0;
        // Reasignar los nºs de movimiento
        Dialogo.UPDATE(1, 'Reasignando los nºs de movimiento');
        pMovsCont.Reset();
        pCorreccionRegMov.Reset();
        iTotalAsientos:=pCorreccionRegMov.COUNT;
        IF pCorreccionRegMov.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pCorreccionRegMov."No.");
                Dialogo.UPDATE(3, ROUND((pCorreccionRegMov."No." / iTotalAsientos) * 10000, 1));
                pMovsCont.SETRANGE(pMovsCont."Transaction No.", pCorreccionRegMov."No.");
                IF pMovsCont.FIND('-')THEN pCorreccionRegMov."From Entry No.":=pMovsCont."Entry No.";
                IF pMovsCont.FIND('+')THEN pCorreccionRegMov."To Entry No.":=pMovsCont."Entry No.";
                pCorreccionRegMov.Modify();
            UNTIL pCorreccionRegMov.Next() = 0;
        // Reasignar los nºs de IVA
        Dialogo.UPDATE(1, 'Reasignando los nºs de IVA');
        pMovsIVA.Reset();
        pCorreccionRegMov.Reset();
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
                pCorreccionRegMov.Modify();
            UNTIL pCorreccionRegMov.Next() = 0;
        // Recuperar las fechas de creación
        Dialogo.UPDATE(1, 'Recuperando fechas de creación');
        pCorreccionRegMov.Reset();
        pRegMovsTemp.Reset();
        iTotalAsientos:=pCorreccionRegMov.COUNT;
        IF pCorreccionRegMov.FIND('-')THEN REPEAT Dialogo.UPDATE(2, pCorreccionRegMov."No.");
                Dialogo.UPDATE(3, ROUND((pCorreccionRegMov."No." / iTotalAsientos) * 10000, 1));
                IF pRegMovsTemp.GET(pCorreccionRegMov."No.")THEN pCorreccionRegMov."Creation Date":=pRegMovsTemp."Creation Date"
                ELSE
                    pCorreccionRegMov."Creation Date":=pRegMovsTemp."Creation Date";
                pCorreccionRegMov.Modify();
            UNTIL pCorreccionRegMov.Next() = 0;
        Dialogo.Close();
    end;
}
