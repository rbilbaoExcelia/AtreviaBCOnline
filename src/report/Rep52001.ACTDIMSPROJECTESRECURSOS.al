report 52001 "ACT DIMS PROJECTES,RECURSOS"
{
    ProcessingOnly = true;
    Caption = 'ACT DIMS PROJECTES, RECURSOS';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Job;167)
        {
            trigger OnAfterGetRecord()
            begin
            /*
                //Recuperamos los valores de dimension departamento
                Mapeo1.Reset();
                IF NOT Mapeo1.GET('DEPARTAMENTO',Job."Old Dimension 1") THEN
                  Mapeo1.Init();
                
                Job."Global Dimension 1 Code" := Mapeo1."Dim Code 1";
                Job."Global Dimension 2 Code" := Mapeo1."Dim Code 2";
                
                //En caso de n informarse una de las dos recuperamos de la tabla de proyectos
                IF (Job."Global Dimension 1 Code" = '') OR (Job."Global Dimension 2 Code" = '') THEN BEGIN
                  Mapeo2.Reset();
                  IF NOT Mapeo2.GET(Job."Old Dimension 2") THEN
                    Mapeo2.Init();
                
                  IF Job."Global Dimension 1 Code" = '' THEN
                    Job."Global Dimension 1 Code" := Mapeo2.Dim1;
                  IF Job."Global Dimension 2 Code" = '' THEN
                    Job."Global Dimension 2 Code" := Mapeo2.dim2;
                END;
                Job.Modify();
                
                DimMgt.SaveDefaultDim(DATABASE::Job,Job."No.",1,Job."Global Dimension 1 Code");
                DimMgt.SaveDefaultDim(DATABASE::Job,Job."No.",2,Job."Global Dimension 2 Code");
                
                //IF (Job."Bill-to Customer No."='') AND (Job."Creation Date"<20170501D) THEN BEGIN
                //  Job."Bill-to Customer No." := 'MIGRACION';
                //  Job.Modify();
                //END;
                */
            end;
        }
        dataitem("MOVS PROYECTOS"; "MOVS PROYECTOS")
        {
            DataItemTableView = SORTING("Posting Date")WHERE("Posting Date"=FILTER('01-01-16..'));

            trigger OnAfterGetRecord()
            begin
                w.UPDATE(1, "MOVS PROYECTOS"."Posting Date");
                //Recuperamos los valores de dimension departamento
                Mapeo1.Reset();
                IF NOT Mapeo1.GET('DEPARTAMENTO', "MOVS PROYECTOS".Dim1)THEN Mapeo1.Init();
                "MOVS PROYECTOS"."Global Dimension 1 Code":=Mapeo1."Dim Code 1";
                "MOVS PROYECTOS"."Global Dimension 2 Code":=Mapeo1."Dim Code 2";
                //En caso de n informarse una de las dos recuperamos de la tabla de proyectos
                /*
                IF ("MOVS PROYECTOS"."Global Dimension 1 Code" = '') OR ("MOVS PROYECTOS"."Global Dimension 2 Code" = '') THEN BEGIN
                  Mapeo2.Reset();
                  IF NOT Mapeo2.GET("MOVS PROYECTOS".Dim2) THEN
                    Mapeo2.Init();
                
                  IF "MOVS PROYECTOS"."Global Dimension 1 Code" = '' THEN
                    "MOVS PROYECTOS"."Global Dimension 1 Code" := Mapeo2.Dim1;
                  IF "MOVS PROYECTOS"."Global Dimension 2 Code" = '' THEN
                    "MOVS PROYECTOS"."Global Dimension 2 Code" := Mapeo2.dim2;
                END;
                */
                "MOVS PROYECTOS".Modify();
            end;
            trigger OnPreDataItem()
            begin
                "MOVS PROYECTOS".SETRANGE("MOVS PROYECTOS"."Posting Date", 20170501D, 20171231D);
            end;
        }
        dataitem(Resource;156)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;

            trigger OnAfterGetRecord()
            begin
            //Recuperamos los valores de dimension departamento
            /*
                Mapeo1.Reset();
                IF NOT Mapeo1.GET('DEPARTAMENTO',Resource."Old Dimension 1 Code") THEN
                  Mapeo1.Init();
                
                Resource."Global Dimension 1 Code" := Mapeo1."Dim Code 1";
                Resource."Global Dimension 2 Code" := Mapeo1."Dim Code 2";
                
                //En caso de n informarse una de las dos recuperamos de la tabla de proyectos
                IF (Resource."Global Dimension 1 Code" = '') OR (Resource."Global Dimension 2 Code" = '') THEN BEGIN
                  Mapeo2.Reset();
                  IF NOT Mapeo2.GET(Resource."Old Dimension 2 Code") THEN
                    Mapeo2.Init();
                
                  IF Resource."Global Dimension 1 Code" = '' THEN
                    Resource."Global Dimension 1 Code" := Mapeo2.Dim1;
                  IF Resource."Global Dimension 2 Code" = '' THEN
                    Resource."Global Dimension 2 Code" := Mapeo2.dim2;
                END;
                Resource.Modify();
                
                DimMgt.SaveDefaultDim(DATABASE::Resource,Resource."No.",1,Resource."Global Dimension 1 Code");
                DimMgt.SaveDefaultDim(DATABASE::Resource,Resource."No.",2,Resource."Global Dimension 2 Code");
                */
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
        w.Close();
        MESSAGE('Finalizado');
    end;
    trigger OnPreReport()
    begin
        w.OPEN(TXT001);
    end;
    var Mapeo1: Record "MAPEO DIM to 2 DIMs AT";
    Mapeo2: Record "MAPEO PROY TO DIMS";
    DimValue: Record 349;
    //DimMgt: Codeunit DimensionManagement;
    w: Dialog;
    TXT001: Label 'Fecha: #1##########';
}
