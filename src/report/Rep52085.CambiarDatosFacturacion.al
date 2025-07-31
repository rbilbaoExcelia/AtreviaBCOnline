report 52085 CambiarDatosFacturacion
{
    //EX-RBF 310123 Creación del informe
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata Job=rm,
        tabledata Customer=rm;

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            // column(ColumnName; SourceFieldName)
            // {
            // }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if JobNo <> '' then begin
                    if CustNo <> '' then if RecJob.Get(JobNo)then begin
                            If RecCustomer.get(CustNo)then;
                            RecCustomer.CheckBlockedCustOnDocs(RecCustomer, "Sales Document Type"::Order, false, false);
                            //validate Sell-to cust
                            RecJob."Sell-to Customer No.":=RecCustomer."No.";
                            RecJob."Sell-to Customer Name":=RecCustomer.Name;
                            RecJob."Sell-to Customer Name 2":=RecCustomer."Name 2";
                            RecJob."Sell-to Phone No.":=RecCustomer."Phone No.";
                            RecJob."Sell-to E-Mail":=RecCustomer."E-Mail";
                            RecJob."Sell-to Address":=RecCustomer.Address;
                            RecJob."Sell-to Address 2":=RecCustomer."Address 2";
                            RecJob."Sell-to City":=RecCustomer.City;
                            RecJob."Sell-to Post Code":=RecCustomer."Post Code";
                            RecJob."Sell-to County":=RecCustomer.County;
                            RecJob."Sell-to Country/Region Code":=RecCustomer."Country/Region Code";
                            RecJob.Reserve:=RecCustomer.Reserve;
                            if RecCustomer."Primary Contact No." <> '' then RecJob."Sell-to Contact No.":=RecCustomer."Primary Contact No."
                            else
                            begin
                                ContBusRel.Reset();
                                ContBusRel.SetCurrentKey("Link to Table", "No.");
                                ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
                                ContBusRel.SetRange("No.", CustNo);
                                if ContBusRel.FindFirst()then RecJob."Sell-to Contact No.":=ContBusRel."Contact No.";
                            end;
                            RecJob."Sell-to Contact":=RecCustomer.Contact;
                            //validate Bill-to cust
                            RecJob."Bill-to Customer No.":=RecCustomer."No.";
                            RecJob."Bill-to Name":=RecCustomer.Name;
                            RecJob."Bill-to Name 2":=RecCustomer."Name 2";
                            RecJob."Bill-to Address":=RecCustomer.Address;
                            RecJob."Bill-to Address 2":=RecCustomer."Address 2";
                            RecJob."Bill-to City":=RecCustomer.City;
                            RecJob."Bill-to Post Code":=RecCustomer."Post Code";
                            RecJob."Bill-to County":=RecCustomer.County;
                            RecJob."Bill-to Country/Region Code":=RecCustomer."Country/Region Code";
                            RecJob."Payment Method Code":=RecCustomer."Payment Method Code";
                            RecJob."Payment Terms Code":=RecCustomer."Payment Terms Code";
                            RecJob."Invoice Currency Code":=RecCustomer."Currency Code";
                            if RecJob."Invoice Currency Code" <> '' then RecJob.Validate("Currency Code", '');
                            RecJob."Customer Disc. Group":=RecCustomer."Customer Disc. Group";
                            RecJob."Customer Price Group":=RecCustomer."Customer Price Group";
                            RecJob."Language Code":=RecCustomer."Language Code";
                            RecJob.Modify();
                        end;
                    if Empresa <> '' then if RecJob.Get(JobNo)then begin
                            RecJob."Billing Company AT":=Empresa;
                            RecJob.Modify();
                        end;
                    if(CustNo <> '') OR (Empresa <> '')then cEventSubAT.Job_OnAfterModifyEvent(RecJob, RecJob, true); //EX-RBF 250523
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Datos)
                {
                    field(Proyecto; JobNo)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Cliente; CustNo)
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                    }
                    field(Empresa; Empresa)
                    {
                        ApplicationArea = All;
                        TableRelation = Company.Name;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Datos de facturación actualizados');
    end;
    procedure SetJobNo(lProyecto: Code[20])
    var
        myInt: Integer;
    begin
        JobNo:=lProyecto;
    end;
    var myInt: Integer;
    CustNo: Code[20];
    Empresa: Text[30];
    JobNo: Code[20];
    RecJob: Record Job;
    RecCustomer: Record Customer;
    ContBusRel: Record "Contact Business Relation";
    cEventSubAT: Codeunit "EventSuscribers AT";
}
