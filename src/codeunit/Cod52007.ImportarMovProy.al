codeunit 52007 "Importar Mov. Proy."
{
    trigger OnRun()
    begin
        w.OPEN(txt001);
        Archivo.Reset();
        Archivo.SETRANGE(Path, 'C:\Temp\DATOS_MIGR\');
        //Archivo.SETRANGE(Path,'C:\Users\susanapuig\Desktop\MIGRACION_OS\Movs_Proyecto\2016_NEW\');
        Archivo.SETRANGE("Is a file", TRUE);
        Archivo.SETFILTER(Name, TXTFILTRO);
        Archivo.FindSet();
        REPEAT w.UPDATE(1, Archivo.Name);
            FileXML.BLOBImport(TempBlob, Archivo.Path + Archivo.Name);
            TempBlob.CREATEINSTREAM(varInputStream);
            XMLPORT.IMPORT(XMLPORT::"MOVS PROYECTOS", varInputStream);
        //FileXML.Close();
        //CLEAR(xMovProy);
        //xMovProy.FILENAME(Archivo.Path + Archivo.Name);
        //xMovProy.IMPORT;
        //xMovProy.Run();
        UNTIL Archivo.Next() = 0;
        w.Close();
    end;
    var xMovProy: XMLport "MOVS PROYECTOS";
    Archivo: Record "File Atrevia";
    TempBlob: Codeunit "Temp Blob";
    TXTFILTRO: Label '*.txt*';
    varInputStream: InStream;
    FileXML: Codeunit "File Management";
    w: Dialog;
    txt001: Label 'Fichero: #1#################';
}
