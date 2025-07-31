codeunit 52004 "Eventos Active AT"
{
    trigger OnRun()
    begin
    end;
    var Text002: Label 'El campo nombre no puede estar vacio.';
    [EventSubscriber(ObjectType::Table, 349, 'OnAfterInsertEvent', '', false, false)]
    local procedure Table349_OnAfterInsert_NombreValorDimensionRelleno(var Rec: Record 349; RunTrigger: Boolean)
    begin
        IF Rec.Name = '' THEN ERROR(Text002);
    end;
    [EventSubscriber(ObjectType::Table, 156, 'OnAfterInsertEvent', '', false, false)]
    local procedure Table152_OnInsert(var Rec: Record 156; RunTrigger: Boolean)
    var
        Confrecursos: Record 314;
    begin
        Confrecursos.Get();
        Rec.VALIDATE("Base Unit of Measure", Confrecursos."Base Unit of Measure Gener AT");
        Rec.VALIDATE("Gen. Prod. Posting Group", Confrecursos."Gen. Prod. Ptg. Group Gener AT");
    end;
}
