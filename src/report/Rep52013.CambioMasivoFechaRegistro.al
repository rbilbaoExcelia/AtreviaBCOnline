report 52013 "Cambio Masivo Fecha Registro"
{
    // INFO - LOG DE CAMBIOS
    // INFO.001 OS.XM 20170424
    //          Creación
    // EX-SGG 300920 CAMBIO DATAITEM DE User Setup A User.
    Caption = 'Cambio masivo fecha registro';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1100225000; User)
        {
            DataItemTableView = SORTING("User Name")ORDER(Ascending);
            RequestFilterFields = "User Name";

            trigger OnAfterGetRecord()
            var
                recCompany: Record Company;
                recUserSetup: Record 91;
            begin
                recCompany.Reset();
                IF recCompany.FindSet()then BEGIN
                    REPEAT recUserSetup.Reset();
                        recUserSetup.CHANGECOMPANY(recCompany.Name);
                        //IF recUserSetup.GET("User ID") THEN BEGIN
                        IF recUserSetup.GET("User Name")THEN BEGIN //EX-SGG 300920
                            recUserSetup."Allow Posting From":=g_datFechaDesde;
                            recUserSetup."Allow Posting To":=g_datFechaHasta;
                            recUserSetup.Modify();
                        END;
                    UNTIL recCompany.Next() = 0;
                END;
            end;
            trigger OnPostDataItem()
            begin
                MESSAGE('Cambio realizado.');
            end;
            trigger OnPreDataItem()
            var
                txtFiltro: Text;
                txtFechaDesde: Text;
                txtFechaHasta: Text;
            begin
                //txtFiltro := GETFILTER("User ID");
                txtFiltro:=GETFILTER("User Name"); //EX-SGG 300920
                IF txtFiltro = '' THEN ERROR('Debe seleccionarse un usuario o conjunto de usuarios.');
                txtFechaDesde:=FORMAT(g_datFechaDesde);
                txtFechaHasta:=FORMAT(g_datFechaHasta);
                IF(txtFechaDesde = '') OR (txtFechaHasta = '')THEN BEGIN
                    IF NOT CONFIRM('No se ha establecido fecha de inicio y/o fin. Continuar?')THEN ERROR('Proceso cancelado por el usuario.');
                END
                ELSE
                BEGIN
                    IF NOT CONFIRM(STRSUBSTNO('Se permitirá el registro en todas las empresas desde %1 a %2 para los usuarios seleccionados. Continuar?', txtFechaDesde, txtFechaHasta))THEN ERROR('Proceso cancelado por el usuario.');
                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(g_datFechaDesde; g_datFechaDesde)
                {
                    ToolTip = 'Permitir registro dese';
                    ApplicationArea = All;
                    Caption = 'Permite registro desde';
                }
                field(g_datFechaHasta; g_datFechaHasta)
                {
                    ToolTip = 'Permitir registro hasta';
                    ApplicationArea = All;
                    Caption = 'Permite registro hasta';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var g_datFechaDesde: Date;
    g_datFechaHasta: Date;
}
