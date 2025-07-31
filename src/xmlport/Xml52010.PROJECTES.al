xmlport 52010 "PROJECTES"
{
    // IF Job."Billable Expenses" THEN Job."Billable Expenses" := TRUE ELSE Job."Billable Expenses":=FALSE;
    // IF Job."Expenses on same Invoice" THEN Job."Expenses on same Invoice":=TRUE ELSE Job."Expenses on same Invoice":=FALSE;
    // IF Job."Mandatory Purch. Order" THEN Job."Mandatory Purch. Order" := TRUE ELSE Job."Mandatory Purch. Order":=FALSE;
    // IF Job."New Customer Current Year" THEN Job."New Customer Current Year":=TRUE ELSE Job."New Customer Current Year":=FALSE;
    // IF Job."1st Press Conference Included" THEN Job."New Customer Current Year":=TRUE ELSE Job."New Customer Current Year":=FALSE;
    // IF Job."Production Expenses 10%" THEN Job."Production Expenses 10%":=TRUE ELSE Job."Production Expenses 10%":=FALSE;
    Direction = Import;
    FieldDelimiter = 'None';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement(Job;
    167)
    {
    AutoReplace = true;
    XmlName = 'Import';

    fieldelement("No.";
    Job."No.")
    {
    }
    fieldelement(SearchDescription;
    Job."Search Description")
    {
    }
    fieldelement(Description;
    Job.Description)
    {
    }
    fieldelement(Description2;
    Job."Description 2")
    {
    }
    fieldelement("Bill-toCustomerNo.";
    Job."Bill-to Customer No.")
    {
    FieldValidate = No;
    }
    fieldelement(CreationDate;
    Job."Creation Date")
    {
    }
    fieldelement(StartingDate;
    Job."Starting Date")
    {
    FieldValidate = No;
    }
    fieldelement(EndingDate;
    Job."Ending Date")
    {
    FieldValidate = No;
    }
    fieldelement(Status;
    Job.Status)
    {
    }
    fieldelement(PersonResponsible;
    Job."Person Responsible")
    {
    }
    fieldelement(Dimension1Code;
    Job."Old Dimension 1 AT")
    {
    }
    fieldelement(Dimension2Code;
    Job."Old Dimension 2 AT")
    {
    }
    fieldelement(JobPostingGroup;
    Job."Job Posting Group")
    {
    }
    fieldelement(Blocked;
    Job.Blocked)
    {
    }
    fieldelement(LastDateModified;
    Job."Last Date Modified")
    {
    }
    fieldelement("Bill-toName";
    Job."Bill-to Name")
    {
    }
    fieldelement("Bill-toAddress";
    Job."Bill-to Address")
    {
    }
    fieldelement("Bill-toAddress2";
    Job."Bill-to Address 2")
    {
    }
    fieldelement("Bill-toCity";
    Job."Bill-to City")
    {
    }
    fieldelement("Bill-toCounty";
    Job."Bill-to County")
    {
    }
    fieldelement("Bill-toPostCode";
    Job."Bill-to Post Code")
    {
    }
    fieldelement("Bill-toCountryRegionCode";
    Job."Bill-to Country/Region Code")
    {
    }
    fieldelement("Bill-toName2";
    Job."Bill-to Name 2")
    {
    }
    fieldelement(JobType;
    Job."Job Type AT")
    {
    }
    fieldelement(BusinessOfficeCode;
    Job."Business Office Code AT")
    {
    }
    fieldelement(Closed;
    Job."Closed AT")
    {
    }
    fieldelement(CreationUser;
    Job."Creation User AT")
    {
    }
    fieldelement(ModificationUser;
    Job."Modification User AT")
    {
    }
    fieldelement(WordFile;
    Job."Word File AT")
    {
    }
    fieldelement("MandatoryPurch.Order";
    Job."Mandatory Purch. Order AT")
    {
    }
    fieldelement(ExpensesSurchargePctg;
    Job."Expenses Surcharge % AT")
    {
    }
    fieldelement(FirstInvoiceDay;
    Job."First Invoice Day AT")
    {
    }
    fieldelement(BillingFrequency;
    Job."Billing Frequency AT")
    {
    }
    fieldelement(ConceptBillingConcept;
    Job."Billing Concept AT")
    {
    }
    fieldelement(InvoiceText1;
    Job."Invoice Text 1 AT")
    {
    }
    fieldelement(InvoiceText2;
    Job."Invoice Text 2 AT")
    {
    }
    fieldelement(InvoiceAmtDL;
    Job."Invoice Amt. (DL) AT")
    {
    trigger OnBeforePassField()
    begin
    /*
                        lTxtImporte := DELCHR(InvoiceAmtDL,'=',',');
                        lTxtImporte := CONVERTSTR(lTxtImporte,'.',',');
                        EVALUATE(nvoiceAmtDL,lTxtImporte);
                        */
    end;
    }
    fieldelement(InvoiceText3;
    Job."Invoice Text 3 AT")
    {
    }
    fieldelement(IntranetStatus;
    Job."Intranet Status AT")
    {
    }
    fieldelement(Sector1;
    Job."Sector 1 AT")
    {
    }
    fieldelement(Sector2;
    Job."Sector 2 AT")
    {
    }
    fieldelement(Sector3;
    Job."Sector 3 AT")
    {
    }
    fieldelement("Purch.OrderNo.";
    Job."Purch. Order No. AT")
    {
    }
    fieldelement(IPCText;
    Job."IPC Text AT")
    {
    }
    fieldelement(FirstPressConfIncluded;
    Job."1st Press Conference Incld. AT")
    {
    }
    fieldelement(BillableExpenses;
    Job."Billable Expenses AT")
    {
    }
    fieldelement(ExpensesOnsameInvoice;
    Job."Expenses on same Invoice AT")
    {
    }
    fieldelement(BillingCompany;
    Job."Billing Company AT")
    {
    }
    fieldelement(ProductionExpenses10;
    Job."Production Expenses 10% AT")
    {
    MinOccurs = Zero;
    }
    fieldelement(NewCustomerCurrentYear;
    Job."New Customer Current Year AT")
    {
    }
    trigger OnAfterInsertRecord()
    begin
        recJobTask."Job No.":=Job."No.";
        recJobTask."Job Task No.":=Job."No.";
        recJobTask."Job Task Type":=recJobTask."Job Task Type"::Posting;
        IF recJobTask.Insert()then;
    end;
    trigger OnBeforeInsertRecord()
    begin
        //Recuperamos los valores de dimension deparatmento
        NewDim1:='';
        NewDim2:='';
        /*
                    Mapeo1.Reset();
                    IF NOT Mapeo1.GET('DEPARTAMENTO',) THEN
                      Mapeo1.Init();
                    
                    NewDim1 := Mapeo1."Dim Code 1";
                    NewDim2 := Mapeo1."Dim Code 2";
                    
                    //En caso de n informarse una de las dos recuperamos de la tabla de proyectos
                    IF (NewDim1 = '') OR (NewDim2 = '') THEN BEGIN
                      Mapeo2.Reset();
                      IF NOT Mapeo2.GET(Dimension2Code) THEN
                        Mapeo2.Init();
                    
                      IF NewDim1 = '' THEN
                        NewDim1 := Mapeo2.Dim1;
                      IF NewDim2 = '' THEN
                        NewDim2 := Mapeo2.dim2;
                    END;
                    */
        IF NewDim1 = '' THEN NewDim1:='REVISAR';
        IF NewDim2 = '' THEN NewDim2:='REVISAR';
    //IF NOT Job.Insert() then Job.Modify();
    end;
    }
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
    trigger OnPostXmlPort()
    begin
        MESSAGE('Finalizado');
    end;
    var Mapeo1: Record "MAPEO DIM to 2 DIMs AT";
    Mapeo2: Record "MAPEO PROY TO DIMS";
    DimValue: Record 349;
    NewDim1: Code[20];
    NewDim2: Code[20];
    lTxtImporte: Text;
    recJobTask: Record 1001;
}
