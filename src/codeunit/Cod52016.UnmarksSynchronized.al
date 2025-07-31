codeunit 52016 "Unmarks Synchronized"
{
    // 025 OS.MIR  29/06/2016  COM.002   Texto descriptivo timming a pedidos de compra (Sincronización SQL)
    trigger OnRun()
    begin
        GLSetup.Get();
        GLSetup.TESTFIELD(GLSetup."Global Dimension 2 Code");
        JobSetup.Get();
        JobSetup.TESTFIELD(JobSetup."Unit of Measure AT");
        JobSetup.TESTFIELD(JobSetup."Gen. Prod. Posting Group AT");
        JobSetup.TESTFIELD(JobSetup."Job Posting Group AT");
        CreateConn;
        ////Conn.Execute('update usuari set sincronizado = 0 from usuario');
        ////Conn.Close();
        ////CLEAR(Conn);
        MESSAGE('Proceso finalizado');
    end;
    var IsConn: Boolean;
    SqlText: array[3]of Text[260];
    T: Text[260];
    //Conn: Automation;
    W: Dialog;
    Quote: Text[1];
    T1: Text[260];
    T2: Text[260];
    T3: Text[260];
    TblN: Text[30];
    TblV: Text[30];
    FormatFrom: Text[260];
    FormatFromLine: Text[260];
    FormatTo: Text[260];
    F: File;
    //RsADO: Automation;
    //ADOFields: Automation;
    AllIn: Boolean;
    GLSetup: Record 98;
    JobSetup: Record 315;
    local procedure CreateConn()
    var
        JobSetupL: Record 315;
    begin
        IF IsConn THEN EXIT;
        ////CREATE(Conn, TRUE, TRUE);
        ////CREATE(RsADO, TRUE, TRUE);
        CLEAR(SqlText);
        JobSetupL.Get();
        JobSetupL.TESTFIELD(JobSetupL."SQL User AT");
        JobSetupL.TESTFIELD(JobSetupL."SQL Password AT");
        JobSetupL.TESTFIELD(JobSetupL."SQL IP AT");
        JobSetupL.TESTFIELD(JobSetupL."SQL Database AT");
        SqlText[1]:=STRSUBSTNO('data provider=MSDASQL;Driver={Sql Server};Server=%1;Database=%2', JobSetupL."SQL IP AT", JobSetupL."SQL Database AT");
        ////Conn.Open(SqlText[1], JobSetupL."SQL User", JobSetupL."SQL Password");
        Quote:='''';
        IsConn:=TRUE;
    end;
}
