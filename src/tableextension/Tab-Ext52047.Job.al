tableextension 52047 "Job" extends Job
{
    fields
    {
        field(52000; "Business Office Code AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Office Code';
            Description = '-011';
            TableRelation = "Business Office AT";
        }
        field(52001; "Expenses Surcharge % AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses Surcharge %';
            Description = '-011';
        }
        field(52002; "Billable Expenses AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Billable Expenses';
            Description = '-011';
        }
        field(52003; "Expenses on same Invoice AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses on same invoice';
            Description = '-011';
        }
        field(52004; "Expenses Text AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses Text';
            Description = '-011';
        }
        field(52005; "Multiple Customers AT"; Boolean)
        {
            Caption = 'Multiple Customers';
            FieldClass = FlowField;
            CalcFormula = Exist("Job Customer AT" WHERE("Job No."=FIELD("No."), "Customer No."=FILTER(<>'')));
            Description = '-030';
            Editable = false;
        }
        field(52006; "Multiple Customers2 AT"; Integer)
        {
            CalcFormula = Count("Job Planning Line" WHERE("Job No."=FIELD("No."), "Customer No. AT"=FILTER(<>'')));
            Caption = 'Múltiples clientes2';
            Description = '-030';
            FieldClass = FlowField;
        }
        field(52010; "External Job Document No. AT"; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'External Job Document No.';
            Description = '-027';
        }
        field(52011; "Document Sending Profile AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Sending Profile';
            Description = '-052';
            TableRelation = "Document Sending Profile".Code;
        }
        field(52050; "Contact Mail 1 AT"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Mail 1';
            Description = '-028';
            ExtendedDatatype = EMail;
        }
        field(52051; "Contact Mail 2 AT"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Mail 2';
            Description = '-028';
            ExtendedDatatype = EMail;
        }
        field(52052; "Contact Mail 3 AT"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Mail 3';
            Description = '-028';
            ExtendedDatatype = EMail;
        }
        field(52053; "Contact Mail 4 AT"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Mail 4';
            Description = '-028';
            ExtendedDatatype = EMail;
        }
        field(52054; "Contact Mail 5 AT"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Mail 5';
            Description = '-028';
            ExtendedDatatype = EMail;
        }
        field(52055; "Origen AT"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Origin';
            Description = '2636';
            TableRelation = "Origen AT";
        }
        field(52056; "Tipo de Origen AT"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Origin Type';
            Description = '2636';
            TableRelation = "Tipo de Origen AT";
        }
        field(52057; "No. Recurso AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource No.';
            Description = '2636';
            TableRelation = Resource."No.";
        }
        field(52100; "Job Type AT"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Type';
            Description = '-025';
            OptionCaption = ',Internal,"One Off",Periodical,Salon,Seminar,,,,,,,a revisar';
            OptionMembers = , Internal, "One Off", Periodical, Salon, Seminar, , , , , , , "a revisar";
        }
        field(52101; "Closed AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Closed';
            Description = '-025';
        }
        field(52102; "Creation User AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Creation User';
            Description = '-025';
        }
        field(52103; "Modification User AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Modification User';
            Description = '-025';
        }
        field(52104; "Word File AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Word File';
            Description = '-025';
        }
        field(52105; "Mandatory Purch. Order AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mandatory Purch. Order';
            Description = '-025';
        }
        field(52106; "New Customer Current Year AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'New Customer Current Year';
            Description = '-025';
        }
        field(52107; "First Invoice Day AT"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'First Invoice Day';
            Description = '-025';
        }
        field(52108; "Billing Frequency AT"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Billing Frequency';
            Description = '-025';
        }
        field(52109; "Invoice Text 1 AT"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 1';
            Description = '-025';
        }
        field(52110; "Invoice Text 2 AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 2';
            Description = '-025';
        }
        field(52111; "Invoice Text 3 AT"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 3';
            Description = '-025';
        }
        field(52112; "Intranet Status AT"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Intranet Status';
            Description = '-025';
            OptionCaption = 'Presupuesto,Oferta,Pedido,Terminado,Anulado';
            OptionMembers = Budget, Quote, "Order", Finished, Canceled;
        }
        field(52113; "Sector 1 AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector 1';
            Description = '-025';
        }
        field(52114; "Sector 2 AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector 2';
            Description = '-025';
        }
        field(52115; "Sector 3 AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sector 3';
            Description = '-025';
        }
        field(52116; "Purch. Order No. AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purch. Order No.';
            Description = '-025';
        }
        field(52117; "IPC Text AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'IPC Text';
            Description = '-025';
        }
        field(52118; "1st Press Conference Incld. AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1st Press Conference Included';
            Description = '-025';
        }
        field(52119; "Billing Company AT"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Billing Company';
            Description = '-025';
        }
        field(52120; "Invoice Amt. (DL) AT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Amt. (DL)';
            Description = '-025';
        }
        field(52121; "Billing Concept AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Billing Concept';
            Description = '-011';
        }
        field(52122; "Production Expenses 10% AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Production Expenses 10%';
            Description = '-011';
        }
        field(52123; "Old Dimension 1 AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Old Dimension 1';
        }
        field(52124; "Old Dimension 2 AT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Old Dimension 2';
        }
        field(52125; "Template AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Template';
            Description = 'NM06';

            trigger OnValidate()
            begin
                IF xRec."Template AT" <> Rec."Template AT" THEN IF Rec."Template AT" THEN VALIDATE(Status, Status::Planning);
            end;
        }
        field(52126; "Blocked Template AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked Template';
            Description = 'NM06';
        }
        field(52127; OmmitMultipleCreation; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Immit multiple creation';
        }
        //EX-RBF 220922 Inicio
        field(52128; "Cod Cliente Final"; Code[20])
        {
            Caption = 'Cód Cliente Final';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger onValidate()
            var
                myInt: Integer;
            begin
                CalcFields("Nombre Cliente Final");
            end;
        }
        field(52129; "Nombre Cliente Final"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No."=field("Cod Cliente Final")));
        }
        //EX-RBF 220922 Fin
        //EX-RBF 300523 Inicio
        modify(Status)
        {
        trigger OnAfterValidate()
        var
            cEventSubAT: Codeunit "EventSuscribers AT";
        begin
            if Rec.Status <> xRec.Status then cEventSubAT.Job_OnAfterModifyEvent(rec, rec, true);
        end;
        }
        //EX-RBF 300523 Fin
        //EX-RBF 050324 Inicio
        modify(Description)
        {
        trigger OnAfterValidate()
        var
            myInt: Integer;
        begin
            CreateJobDimension();
        end;
        }
    }
    trigger OnBeforeDelete()
    begin
        ERROR('No pueden borrarse los proyectos.\Páselo a estado bloqueado');
    end;
    trigger OnBeforeInsert()
    begin
    //ERROR('Los proyectos deben darse de alta desde la intranet');
    end;
    //Unsupported feature: Code Modification on "UpdateCust(PROCEDURE 4)".
    //Modification moved to EventSuscribers
    //procedure UpdateCust();
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Bill-to Customer No." <> '' THEN BEGIN
      Cust.GET("Bill-to Customer No.");
      Cust.TESTFIELD("2ustomer Posting Group");
      //064
      //Cust.TESTFIELD("2ill-to Customer No.",'');
      IF (Cust."Bill-to Customer No."<>'')  AND (Cust."Bill-to Customer No."<> Cust."No.") THEN
          ERROR(Text50000, Cust."No.");
      //064
      #6..30
    END ELSE BEGIN
    #33..44
      VALIDATE("Bill-to Contact No.",'');
    END;
    */
    //end;
    //procedure TestBlocked()2
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeTestBlocked(R2c);

    if Blocked = Blocked::" " then
      exit;
    Error(TestBlockedErr,TableCaption,"No.",Blocked);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Blocked = Blocked::" " THEN
      EXIT;
    //ERROR(Text008,TABLECAPTION,"No.",Blocked);  /////////////////////////////
    */
    //end;
    procedure CreateJobDimension()
    var
        DefaultDim: Record "Default Dimension";
        DimValue: Record "Dimension Value";
    begin
        //<New Job Dimension
        IF NOT DimValue.GET('PROYECTO', "No.")THEN BEGIN
            DimValue.Init();
            DimValue.VALIDATE("Dimension Code", 'PROYECTO');
            DimValue.Code:="No.";
            DimValue.Name:=Description;
            DimValue.INSERT(TRUE);
            IF NOT DefaultDim.GET(167, "No.", 'PROYECTO')THEN BEGIN
                DefaultDim.Init();
                DefaultDim.VALIDATE("Table ID", 167);
                DefaultDim.VALIDATE("No.", "No.");
                DefaultDim.VALIDATE("Dimension Code", 'PROYECTO');
                DefaultDim.VALIDATE("Dimension Value Code", "No.");
                DefaultDim.VALIDATE("Value Posting", DefaultDim."Value Posting"::"Same Code");
                DefaultDim.Insert();
            END
            ELSE
            BEGIN
                DefaultDim.VALIDATE("Dimension Value Code", "No.");
                DefaultDim.Modify();
            END;
        END;
    //New job Dimension>
    end;
}
