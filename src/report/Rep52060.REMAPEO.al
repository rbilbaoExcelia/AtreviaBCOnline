report 52060 "REMAPEO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/REMAPEO.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry";17)
        {
            trigger OnAfterGetRecord()
            begin
                /*
                IF  ("G/L Entry"."G/L Account No." = '6230000011') OR
                    (COPYSTR("G/L Entry"."G/L Account No.",1,3)= '640') OR
                    (COPYSTR("G/L Entry"."G/L Account No.",1,3)= '641') OR
                    (COPYSTR("G/L Entry"."G/L Account No.",1,3)= '642') OR
                    (COPYSTR("G/L Entry"."G/L Account No.",1,3)= '649') THEN
                    CurrReport.Skip();
                */
                /*
                UpdGLEntry:="G/L Entry";
                UpdGLEntry."Global Dimension 1 Code" :='';
                UpdGLEntry."Global Dimension 2 Code" :='';
                
                WITH "G/L Entry" DO BEGIN
                  IF COPYSTR("Job No.",1,1)='0' THEN BEGIN
                     IF ("G/L Entry"."Job No."<> '000000029') AND
                        ("G/L Entry"."Job No."<> '001000019') AND
                        ("G/L Entry"."Job No."<> '001000020') AND
                        ("G/L Entry"."Job No."<> '001000076') AND
                        ("G/L Entry"."Job No."<> '002010015') THEN BEGIN  //GASTOS
                
                        MapeoDim.Reset();
                        UpdGLEntry.CALCFIELDS("Old Dimension Value");
                        IF NOT MapeoDim.GET('DEPARTAMENTO',UpdGLEntry."Old Dimension Value") THEN
                            MapeoDim.Init();
                
                        UpdGLEntry."Global Dimension 1 Code" := MapeoDim."Dim Code 1";
                        UpdGLEntry."Global Dimension 2 Code" := MapeoDim."Dim Code 2";
                
                     END ELSE BEGIN
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdGLEntry."Job No.") THEN
                          MapeoProy.Init();
                          UpdGLEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                          UpdGLEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                     END;
                
                  END ELSE BEGIN //PROYECTOS DE CLIENTE
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdGLEntry."Job No.") THEN
                          MapeoProy.Init();
                          UpdGLEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                          UpdGLEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                  END;
                  UpdGLEntry.Modify();
                
                  //DimMgt.SaveDefaultDim(DATABASE::"G/L Entry",UpdGLEntry."Entry No.",1,UpdGLEntry."Global Dimension 1 Code");
                  //DimMgt.SaveDefaultDim(DATABASE::"G/L Entry",UpdGLEntry."Entry No.",2,UpdGLEntry."Global Dimension 2 Code");
                END;
                */
                NewDim1:='';
                NewDim2:='';
                IF COPYSTR("G/L Entry"."Job No.", 1, 1) = '0' THEN BEGIN
                    IF("G/L Entry"."Job No." <> '000000029') AND ("G/L Entry"."Job No." <> '001000019') AND ("G/L Entry"."Job No." <> '001000020') AND ("G/L Entry"."Job No." <> '001000076') AND ("G/L Entry"."Job No." <> '002010015')THEN BEGIN //GASTOS
                        MapeoDim.Reset();
                        "G/L Entry".CALCFIELDS("Old Dimension Value");
                        IF NOT MapeoDim.GET('DEPARTAMENTO', "G/L Entry"."Old Dimension Value")THEN MapeoDim.Init();
                        NewDim1:=MapeoDim."Dim Code 1";
                        NewDim2:=MapeoDim."Dim Code 2";
                    END
                    ELSE
                    BEGIN
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET("G/L Entry"."Job No.")THEN MapeoProy.Init();
                        NewDim1:=MapeoProy.Dim1;
                        NewDim2:=MapeoProy.dim2;
                    END;
                END
                ELSE
                BEGIN //PROYECTOS DE CLIENTE
                    MapeoProy.Reset();
                    IF NOT MapeoProy.GET("G/L Entry"."Job No.")THEN MapeoProy.Init();
                    NewDim1:=MapeoProy.Dim1;
                    NewDim2:=MapeoProy.dim2;
                END;
                IF recSetDimValueNew.FindSet()then recSetDimValueNew.DeleteAll();
                recSetDimValueNew.Init();
                recSetDimValueNew."Dimension Code":='AREA GEOGRAFICA';
                recSetDimValueNew."Dimension Value Code":=NewDim1;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValueNew."Dimension Code":='DEPARTAMENTO';
                recSetDimValueNew."Dimension Value Code":=NewDim2;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValue.SETRANGE("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                IF recSetDimValue.FindSet()then REPEAT recSetDimValueNew."Dimension Code":=recSetDimValue."Dimension Code";
                        recSetDimValueNew."Dimension Value Code":=recSetDimValue."Dimension Value Code";
                        ValorDim.GET(recSetDimValue."Dimension Code", recSetDimValue."Dimension Value Code");
                        recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                        IF recSetDimValueNew.Insert()then;
                    UNTIL recSetDimValue.Next() = 0;
                "G/L Entry"."Global Dimension 1 Code":=NewDim1;
                "G/L Entry"."Global Dimension 2 Code":=NewDim2;
                "G/L Entry"."Dimension Set ID":=DimMgmt.GetDimensionSetID(recSetDimValueNew);
                "G/L Entry".MODIFY(TRUE);
            end;
        }
        dataitem("Job Ledger Entry";169)
        {
            trigger OnAfterGetRecord()
            begin
                /*
                UpdJobEntry:="Job Ledger Entry";
                UpdJobEntry."Global Dimension 1 Code" :='';
                UpdJobEntry."Global Dimension 2 Code" :='';
                
                WITH "Job Ledger Entry" DO BEGIN
                  IF COPYSTR("Job No.",1,1)='0' THEN BEGIN
                     IF ("Job No."<> '000000029') AND
                        ("Job No."<> '001000019') AND
                        ("Job No."<> '001000020') AND
                        ("Job No."<> '001000076') AND
                        ("Job No."<> '002010015') THEN BEGIN  //GASTOS
                
                        MapeoDim.Reset();
                        IF NOT MapeoDim.GET('DEPARTAMENTO',UpdJobEntry."Old Dimension Value") THEN
                            MapeoDim.Init();
                
                        UpdJobEntry."Global Dimension 1 Code" := MapeoDim."Dim Code 1";
                        UpdJobEntry."Global Dimension 2 Code" := MapeoDim."Dim Code 2";
                
                     END ELSE BEGIN
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdJobEntry."Job No.") THEN
                          MapeoProy.Init();
                        UpdJobEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                        UpdJobEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                     END;
                
                  END ELSE BEGIN //PROYECTOS DE CLIENTE
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdJobEntry."Job No.") THEN
                          MapeoProy.Init();
                        UpdJobEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                        UpdJobEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                  END;
                  UpdJobEntry.Modify();
                
                  DimMgt.SaveDefaultDim(DATABASE::"Job Ledger Entry",UpdJobEntry."No.",1,UpdJobEntry."Global Dimension 1 Code");
                  DimMgt.SaveDefaultDim(DATABASE::"Job Ledger Entry",UpdJobEntry."No.",2,UpdJobEntry."Global Dimension 2 Code");
                END;
                */
                NewDim1:='';
                NewDim2:='';
                IF COPYSTR("Job Ledger Entry"."Job No.", 1, 1) = '0' THEN BEGIN
                    IF("Job Ledger Entry"."Job No." <> '000000029') AND ("Job Ledger Entry"."Job No." <> '001000019') AND ("Job Ledger Entry"."Job No." <> '001000020') AND ("Job Ledger Entry"."Job No." <> '001000076') AND ("Job Ledger Entry"."Job No." <> '002010015')THEN BEGIN //GASTOS
                        MapeoDim.Reset();
                        "Job Ledger Entry".CALCFIELDS("Old Dimension Value");
                        IF NOT MapeoDim.GET('DEPARTAMENTO', "Job Ledger Entry"."Old Dimension Value")THEN MapeoDim.Init();
                        NewDim1:=MapeoDim."Dim Code 1";
                        NewDim2:=MapeoDim."Dim Code 2";
                    END
                    ELSE
                    BEGIN
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET("Job Ledger Entry"."Job No.")THEN MapeoProy.Init();
                        NewDim1:=MapeoProy.Dim1;
                        NewDim2:=MapeoProy.dim2;
                    END;
                END
                ELSE
                BEGIN //PROYECTOS DE CLIENTE
                    MapeoProy.Reset();
                    IF NOT MapeoProy.GET("Job Ledger Entry"."Job No.")THEN MapeoProy.Init();
                    NewDim1:=MapeoProy.Dim1;
                    NewDim2:=MapeoProy.dim2;
                END;
                IF recSetDimValueNew.FindSet()then recSetDimValueNew.DeleteAll();
                recSetDimValueNew.Init();
                recSetDimValueNew."Dimension Code":='AREA GEOGRAFICA';
                recSetDimValueNew."Dimension Value Code":=NewDim1;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValueNew."Dimension Code":='DEPARTAMENTO';
                recSetDimValueNew."Dimension Value Code":=NewDim2;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValue.SETRANGE("Dimension Set ID", "Job Ledger Entry"."Dimension Set ID");
                IF recSetDimValue.FindSet()then REPEAT recSetDimValueNew."Dimension Code":=recSetDimValue."Dimension Code";
                        recSetDimValueNew."Dimension Value Code":=recSetDimValue."Dimension Value Code";
                        ValorDim.GET(recSetDimValue."Dimension Code", recSetDimValue."Dimension Value Code");
                        recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                        IF recSetDimValueNew.Insert()then;
                    UNTIL recSetDimValue.Next() = 0;
                "Job Ledger Entry"."Global Dimension 1 Code":=NewDim1;
                "Job Ledger Entry"."Global Dimension 2 Code":=NewDim2;
                "Job Ledger Entry"."Dimension Set ID":=DimMgmt.GetDimensionSetID(recSetDimValueNew);
                "Job Ledger Entry".MODIFY(TRUE);
            end;
        }
        dataitem("Res. Ledger Entry";203)
        {
            trigger OnAfterGetRecord()
            begin
                /*
                UpdResEntry:="Res. Ledger Entry";
                UpdResEntry."Global Dimension 1 Code" :='';
                UpdResEntry."Global Dimension 2 Code" :='';
                
                WITH "Res. Ledger Entry" DO BEGIN
                  IF COPYSTR("Job No.",1,1)='0' THEN BEGIN
                     IF ("Job No."<> '000000029') AND
                        ("Job No."<> '001000019') AND
                        ("Job No."<> '001000020') AND
                        ("Job No."<> '001000076') AND
                        ("Job No."<> '002010015') THEN BEGIN  //GASTOS
                
                        MapeoDim.Reset();
                        //IF NOT MapeoDIM.GET('DEPARTAMENTO',UpdResEntry."Old Dimension Value") THEN
                            MapeoDim.Init();
                
                        UpdResEntry."Global Dimension 1 Code" := MapeoDim."Dim Code 1";
                        UpdResEntry."Global Dimension 2 Code" := MapeoDim."Dim Code 2";
                
                     END ELSE BEGIN
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdResEntry."Job No.") THEN
                          MapeoProy.Init();
                        UpdResEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                        UpdResEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                     END;
                
                  END ELSE BEGIN //PROYECTOS DE CLIENTE
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdResEntry."Job No.") THEN
                          MapeoProy.Init();
                        UpdResEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                        UpdResEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                  END;
                  UpdResEntry.Modify();
                
                  //DimMgt.SaveDefaultDim(DATABASE::"Res. Ledger Entry",UpdResEntry.,1,UpdResEntry."Global Dimension 1 Code");
                  //DimMgt.SaveDefaultDim(DATABASE::"Res. Ledger Entry",UpdResEntry."No.",2,UpdResEntry."Global Dimension 2 Code");
                END;
                */
                NewDim1:='';
                NewDim2:='';
                IF COPYSTR("Res. Ledger Entry"."Job No.", 1, 1) = '0' THEN BEGIN
                    IF("Res. Ledger Entry"."Job No." <> '000000029') AND ("Res. Ledger Entry"."Job No." <> '001000019') AND ("Res. Ledger Entry"."Job No." <> '001000020') AND ("Res. Ledger Entry"."Job No." <> '001000076') AND ("Res. Ledger Entry"."Job No." <> '002010015')THEN BEGIN //GASTOS
                        MapeoDim.Reset();
                        //"Res. Ledger Entry".CALCFIELDS("Old Dimension Value");
                        //IF NOT MapeoDim.GET('DEPARTAMENTO',"Res. Ledger Entry"."Old Dimension Value") THEN
                        MapeoDim.Init();
                        NewDim1:=MapeoDim."Dim Code 1";
                        NewDim2:=MapeoDim."Dim Code 2";
                    END
                    ELSE
                    BEGIN
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET("Res. Ledger Entry"."Job No.")THEN MapeoProy.Init();
                        NewDim1:=MapeoProy.Dim1;
                        NewDim2:=MapeoProy.dim2;
                    END;
                END
                ELSE
                BEGIN //PROYECTOS DE CLIENTE
                    MapeoProy.Reset();
                    IF NOT MapeoProy.GET("Res. Ledger Entry"."Job No.")THEN MapeoProy.Init();
                    NewDim1:=MapeoProy.Dim1;
                    NewDim2:=MapeoProy.dim2;
                END;
                IF recSetDimValueNew.FindSet()then recSetDimValueNew.DeleteAll();
                recSetDimValueNew.Init();
                recSetDimValueNew."Dimension Code":='AREA GEOGRAFICA';
                recSetDimValueNew."Dimension Value Code":=NewDim1;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValueNew."Dimension Code":='DEPARTAMENTO';
                recSetDimValueNew."Dimension Value Code":=NewDim2;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValue.SETRANGE("Dimension Set ID", "Res. Ledger Entry"."Dimension Set ID");
                IF recSetDimValue.FindSet()then REPEAT recSetDimValueNew."Dimension Code":=recSetDimValue."Dimension Code";
                        recSetDimValueNew."Dimension Value Code":=recSetDimValue."Dimension Value Code";
                        ValorDim.GET(recSetDimValue."Dimension Code", recSetDimValue."Dimension Value Code");
                        recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                        IF recSetDimValueNew.Insert()then;
                    UNTIL recSetDimValue.Next() = 0;
                "Res. Ledger Entry"."Global Dimension 1 Code":=NewDim1;
                "Res. Ledger Entry"."Global Dimension 2 Code":=NewDim2;
                "Res. Ledger Entry"."Dimension Set ID":=DimMgmt.GetDimensionSetID(recSetDimValueNew);
                "Res. Ledger Entry".MODIFY(TRUE);
            end;
        }
        dataitem("Cust. Ledger Entry";21)
        {
            trigger OnAfterGetRecord()
            begin
                /*
                UpdCustEntry:="Cust. Ledger Entry";
                UpdCustEntry."Global Dimension 1 Code" :='';
                UpdCustEntry."Global Dimension 2 Code" :='';
                
                WITH "Cust. Ledger Entry" DO BEGIN
                  IF COPYSTR("Job No.",1,1)='0' THEN BEGIN
                     IF ("Job No."<> '000000029') AND
                        ("Job No."<> '001000019') AND
                        ("Job No."<> '001000020') AND
                        ("Job No."<> '001000076') AND
                        ("Job No."<> '002010015') THEN BEGIN  //GASTOS
                        {
                        MapeoDIM.Reset();
                        IF NOT MapeoDIM.GET('DEPARTAMENTO',UpdCustEntry."Old Dimension Value") THEN
                            MapeoDim.Init();
                
                        UpdCustEntry."Global Dimension 1 Code" := MapeoDim."Dim Code 1";
                        UpdCustEntry."Global Dimension 2 Code" := MapeoDim."Dim Code 2";
                        }
                     END ELSE BEGIN
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdCustEntry."Job No.") THEN
                          MapeoProy.Init();
                        UpdCustEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                        UpdCustEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                     END;
                
                  END ELSE BEGIN //PROYECTOS DE CLIENTE
                        MapeoProy.Reset();
                        IF NOT MapeoProy.GET(UpdCustEntry."Job No.") THEN
                          MapeoProy.Init();
                        UpdCustEntry."Global Dimension 1 Code" := MapeoProy.Dim1;
                        UpdCustEntry."Global Dimension 2 Code" := MapeoProy.dim2;
                  END;
                  UpdCustEntry.Modify();
                
                  DimMgt.SaveDefaultDim(DATABASE::"Job Ledger Entry",UpdCustEntry."No.",1,UpdCustEntry."Global Dimension 1 Code");
                  DimMgt.SaveDefaultDim(DATABASE::"Job Ledger Entry",UpdCustEntry."No.",2,UpdCustEntry."Global Dimension 2 Code");
                END;
                */
                NewDim1:='';
                NewDim2:='';
                JobNo:="Cust. Ledger Entry".CalcJobNo;
                //TODOS PROYECTOS SON DE CLIENTE
                MapeoProy.Reset();
                IF NOT MapeoProy.GET(JobNo)THEN MapeoProy.Init();
                NewDim1:=MapeoProy.Dim1;
                NewDim2:=MapeoProy.dim2;
                IF recSetDimValueNew.FindSet()then recSetDimValueNew.DeleteAll();
                recSetDimValueNew.Init();
                recSetDimValueNew."Dimension Code":='AREA GEOGRAFICA';
                recSetDimValueNew."Dimension Value Code":=NewDim1;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValueNew."Dimension Code":='DEPARTAMENTO';
                recSetDimValueNew."Dimension Value Code":=NewDim2;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValue.SETRANGE("Dimension Set ID", "Cust. Ledger Entry"."Dimension Set ID");
                IF recSetDimValue.FindSet()then REPEAT recSetDimValueNew."Dimension Code":=recSetDimValue."Dimension Code";
                        recSetDimValueNew."Dimension Value Code":=recSetDimValue."Dimension Value Code";
                        ValorDim.GET(recSetDimValue."Dimension Code", recSetDimValue."Dimension Value Code");
                        recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                        IF recSetDimValueNew.Insert()then;
                    UNTIL recSetDimValue.Next() = 0;
                "Cust. Ledger Entry"."Global Dimension 1 Code":=NewDim1;
                "Cust. Ledger Entry"."Global Dimension 2 Code":=NewDim2;
                "Cust. Ledger Entry"."Dimension Set ID":=DimMgmt.GetDimensionSetID(recSetDimValueNew);
                "Cust. Ledger Entry".MODIFY(TRUE);
            end;
        }
        dataitem("Vendor Ledger Entry";25)
        {
            trigger OnAfterGetRecord()
            begin
                NewDim1:='';
                NewDim2:='';
                JobNo:="Vendor Ledger Entry".CalcJobNo;
                //TODOS PROYECTOS SON DE CLIENTE
                MapeoProy.Reset();
                IF NOT MapeoProy.GET(JobNo)THEN MapeoProy.Init();
                NewDim1:=MapeoProy.Dim1;
                NewDim2:=MapeoProy.dim2;
                IF recSetDimValueNew.FindSet()then recSetDimValueNew.DeleteAll();
                recSetDimValueNew.Init();
                recSetDimValueNew."Dimension Code":='AREA GEOGRAFICA';
                recSetDimValueNew."Dimension Value Code":=NewDim1;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValueNew."Dimension Code":='DEPARTAMENTO';
                recSetDimValueNew."Dimension Value Code":=NewDim2;
                ValorDim.GET(recSetDimValueNew."Dimension Code", recSetDimValueNew."Dimension Value Code");
                recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                IF recSetDimValueNew.Insert()then;
                recSetDimValue.SETRANGE("Dimension Set ID", "Vendor Ledger Entry"."Dimension Set ID");
                IF recSetDimValue.FindSet()then REPEAT recSetDimValueNew."Dimension Code":=recSetDimValue."Dimension Code";
                        recSetDimValueNew."Dimension Value Code":=recSetDimValue."Dimension Value Code";
                        ValorDim.GET(recSetDimValue."Dimension Code", recSetDimValue."Dimension Value Code");
                        recSetDimValueNew."Dimension Value ID":=ValorDim."Dimension Value ID";
                        IF recSetDimValueNew.Insert()then;
                    UNTIL recSetDimValue.Next() = 0;
                "Vendor Ledger Entry"."Global Dimension 1 Code":=NewDim1;
                "Vendor Ledger Entry"."Global Dimension 2 Code":=NewDim2;
                "Vendor Ledger Entry"."Dimension Set ID":=DimMgmt.GetDimensionSetID(recSetDimValueNew);
                "Vendor Ledger Entry".MODIFY(TRUE);
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
    var MapeoDim: Record "MAPEO DIM to 2 DIMs AT";
    MapeoProy: Record "MAPEO PROY TO DIMS";
    DimMgt: Codeunit DimensionManagement;
    "------------": Integer;
    recSetDimValue: Record 480;
    recSetDimValueNew: Record 480 temporary;
    DimMgmt: Codeunit 408;
    ValorDim: Record 349;
    NewDim1: Code[20];
    NewDim2: Code[20];
    JobNo: Code[20];
}
