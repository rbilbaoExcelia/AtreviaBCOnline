tableextension 52037 "GenJournalLine" extends "Gen. Journal Line"
{
    fields
    {
        /*  modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                //190717 EX-JVN SII
                "SII Fecha envío a control" := "Posting Date";
            end;
        } 
        //Unsupported feature: Code Modification on ""Job No."(Field 42).OnValidate".

        //trigger "(Field 42)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        if "Job No." = xRec."Job No." then
          exit;

        SourceCodeSetup.Get();
        if "Source Code" <> SourceCodeSetup."Job G/L WIP" then
          Validate("Job Task No.",'');
        if "Job No." = '' then begin
          CreateDim(
            DATABASE::Job,"Job No.",
            DimMgt.TypeToTableID1("Account Type"),"Account No.",
            DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::Campaign,"Campaign No.");
          exit;
        end;

        Rec.TESTFIELD("Account Type","Account Type"::"G/L Account");

        if "Bal. Account No." <> '' then
          if not ("Bal. Account Type" in ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"]) then
            Error(Text016,FieldCaption("Bal. Account Type"));

        Job.Get("Job No.");
        Job.TestBlocked;
        "Job Currency Code" := Job."Currency Code";

        CreateDim(
          DATABASE::Job,"Job No.",
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Job No." = xRec."Job No." THEN
          EXIT;

        SourceCodeSetup.Get();
        IF "Source Code" <> SourceCodeSetup."Job G/L WIP" THEN
          VALIDATE("Job Task No.",'');
        IF "Job No." = '' THEN BEGIN
        #8..13
          EXIT;
        END;

        Rec.TESTFIELD("Account Type","Account Type"::"G/L Account");

        IF "Bal. Account No." <> '' THEN
          IF NOT ("Bal. Account Type" IN ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"]) THEN
            ERROR(Text016,FIELDCAPTION("Bal. Account Type"));

        Job.GET("Job No.");
        Job.TestBlocked;
        "Job Currency Code" := Job."Currency Code";
        //<
        // VALIDATE("Job Task No." , "Job No.");
        VALIDATE("Job Quantity" , 1);
        //>
        #27..32
        */
        //end;
        modify("Correction")
        {
        trigger OnAfterValidate()
        begin
            VALIDATE(Amount);
            //271017
            IF "Journal Batch Name" = 'FILIALES' THEN "Reversed subsidiary AT":=Correction;
        //271017
        end;
        }
        modify("Job No.")
        {
        trigger OnAfterValidate()
        begin
            VALIDATE("Job Quantity", 1);
        end;
        }
        field(52000; Billable; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Billable';
            Description = '-026';
        }
        field(52001; "Expenses Surcharge %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses Surcharge %';
            Description = '-011';
        }
        field(52002; "Job Name"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Name';
            FieldClass = FlowField;
        }
        field(52005; "Reversed subsidiary AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Revertido fililales';
        }
        field(52010; "Old Dimension"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Old Dimension';
        }
        field(52012; "Job Line Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Line Account No.';
            Description = '-055';
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            var
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(52111; "Confirmed AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed';
            Description = '-055';
        }
    }
    //procedure CheckGLAcc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLAcc.CheckGLAcc;
    if GLAcc."Direct Posting" or ("Journal Template Name" = '') or "System-Created Entry" then
      exit;
    if "Posting Date" <> 0D then
      if "Posting Date" = ClosingDate("Posting Date") then
        exit;

    CheckDirectPosting(GLAcc);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GLAcc.CheckGLAcc;
    IF GLAcc."Direct Posting" OR ("Journal Template Name" = '') OR "System-Created Entry" THEN
      EXIT;
    IF "Posting Date" <> 0D THEN
      IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
        EXIT;
      IF Rec."Journal Batch Name"<>'MIGRACION' THEN
        GLAcc.TESTFIELD("Direct Posting",TRUE);  ///////////////////////
    */
    //end;
    var JnLine: Record "Gen. Journal Line";
    toTypeSII: Integer;
    //DatosSIIDoc: Record 50603;
    Text003: Label 'The %1 in the %2 will be changed from %3 to %4.\Do you want to continue?';
    Text005: Label 'The update has been interrupted to respect the warning.';
    Text017: Label 'Credit card %1 has already been performed for this %2, but posting failed. You must complete posting of the document of type %2 with the number %3.';
    GLAcc: Record 15;
    Cust: Record Customer;
    Vend: Record Vendor;
    ICPartner: Record "IC Partner";
    BankAcc: Record Item;
    BankAcc2: Record Item;
    BankAcc3: Record Item;
    FA: Record "Fixed Asset";
    FASetup: Record "FA Setup";
    FADeprBook: Record "FA Depreciation Book";
    JobJnlLine: Record "Job Journal Line" temporary;
    FromCurrencyCode: Code[10];
    ToCurrencyCode: Code[10];
//RecSIITablaMaestraValores: Record "SII- Tablas valores SII";
}
