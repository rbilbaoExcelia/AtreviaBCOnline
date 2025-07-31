xmlport 52011 "SAF - T PT PT"
{
    // 003 OS.MIR  07/06/2016  FIN.003   Fichero SAF-T Portugal
    // EX-SGG 280518 CORRECCIONES.
    //        181218 CANTIDADES SIEMPRE EL POSITIVO AL NO PERMITIRLO SAFT.
    //               NUEVOS ELEMENTOS DebitAmount y CreditAmount EN LAS LINEAS DE LOS DOCUMENTOS DE FACTURA Y ABONO RESPECTIVAMENTE.
    //               NUEVA FUNCION FormatearImporte PARA ESTABLECER DebitAmount O CreditAmount DEPENDIENDO DEL SIGNO.
    //               ASIGNACION DE IMPORTES EN OnAfterGetRecord DE LAS LINEAS.
    //        191218 NO EXPORTO ELEMENTO DebitAmount y CreditAmount SI SU VALOR ES '0'
    Caption = 'SAF - T PT';
    Direction = Export;
    //DefaultFieldsValidation = true;
    //Format = Xml;
    Encoding = UTF8;
    //XMLVersionNo = V10;
    //FormatEvaluate = Legacy; //<C/SIDE Format/Evaluate>;
    //UseDefaultNamespace = false;
    //DefaultNamespace = 'urn:microsoft-dynamics-nav/xmlports/x52011';
    //InlineSchema = false;
    //UseLax = false;
    //UseRequestPage = true;
    //TransactionType = UpdateNoLocks;
    //PreserveWhiteSpace = false;
    Description = 'OLIVIA,003,EX-SGG';
    Namespaces = "" = 'urn:OECD:StandardAuditFile-Tax:PT_1.04_01', xsi = 'http://www.w3.org/2001/XMLSchema-instance';

    //Namespaces = xmlns = 'urn:OECD:StandardAuditFile-Tax:PT_1.04_01';    
    schema
    {
    textelement(AuditFile)
    {
    MaxOccurs = Once;
    MinOccurs = Once;

    /*
            textattribute(xmlns)
            {
            }
            textattribute(xmlns)
            {
                XmlName = 'xmlns';
                NamespacePrefix = 'xmlns';
                TextType = Text;

                //trigger OnAfterAssignVariable()
                //begin
                //    xmlns := 'urn:OECD:StandardAuditFile-Tax:PT_1.04_01';
                //end;

                //trigger OnBeforePassVariable()
                //begin
                //IF ISSERVICETIER THEN
                //    currXMLport.Skip()
                //ELSE
                //  xmlns := 'urn:OECD:StandardAuditFile-Tax:PT_1.04_01';

                //end;

            }
            
            textattribute(xmlnsxsi)
            {
                //XmlName = 'xmlns:xsi';
                //TextType = Text;
                NamespacePrefix = 'xmlns:xsi';

                trigger OnBeforePassVariable()
                begin
                    //IF ISSERVICETIER THEN
                    //    currXMLport.Skip()
                    //ELSE
                    //xmlnsxsi := 'http://www.w3.org/2001/XMLSchema-instance';
                end;

            }
            */
    textelement(Header)
    {
    MaxOccurs = Once;
    MinOccurs = Once;

    textelement(AuditFileVersion)
    {
    MaxOccurs = Once;

    trigger OnBeforePassVariable()
    begin
        AuditFileVersion:='1.04_01';
    end;
    }
    textelement(CompanyID)
    {
    trigger OnBeforePassVariable()
    begin
        CompanyID:=CompanyInfo."Registration Authority PT" + CompanyInfo."Registration No.";
    end;
    }
    textelement(TaxRegistrationNumber)
    {
    trigger OnBeforePassVariable()
    begin
        TaxRegistrationNumber:=CompanyInfo."VAT Registration No.";
    end;
    }
    textelement(TaxAccountingBasis)
    {
    trigger OnBeforePassVariable()
    begin
        TaxAccountingBasis:='F'; //INF.P02
    end;
    }
    textelement(mcompanyname)
    {
    XmlName = 'CompanyName';

    trigger OnBeforePassVariable()
    begin
        mCompanyName:=CompanyInfo.Name;
    end;
    }
    textelement(BusinessName)
    {
    trigger OnBeforePassVariable()
    begin
        BusinessName:=CompanyInfo."Business Name PT";
    end;
    }
    textelement(CompanyAddress)
    {
    textelement(AddressDetail)
    {
    trigger OnBeforePassVariable()
    begin
        AddressDetail:=CompanyInfo.Address + ' ' + CompanyInfo."Address 2";
        IF STRLEN(AddressDetail) > 60 THEN AddressDetail:=PADSTR(AddressDetail, 60);
    end;
    }
    textelement(City)
    {
    trigger OnBeforePassVariable()
    begin
        City:=CompanyInfo.City;
    end;
    }
    textelement(PostalCode)
    {
    trigger OnBeforePassVariable()
    begin
        PostalCode:=CompanyInfo."Post Code";
    end;
    }
    textelement(companycountry)
    {
    XmlName = 'Country';

    trigger OnBeforePassVariable()
    begin
        CompanyCountry:='PT';
    end;
    }
    }
    textelement(FiscalYear)
    {
    trigger OnBeforePassVariable()
    begin
        FiscalYear:=FORMAT(FiscalYear2, 0);
    end;
    }
    textelement(StartDate)
    {
    trigger OnBeforePassVariable()
    begin
        //StartDate := FORMAT(StartDate2,0,9);    //INF.P05
        StartDate:=FORMAT(StartDate3, 0, 9); //INF.P05
    end;
    }
    textelement(EndDate)
    {
    trigger OnBeforePassVariable()
    begin
        //EndDate := FORMAT(EndFiscalDate2,0,9);  //INF.P05
        EndDate:=FORMAT(EndDate2, 0, 9); //INF.P05
    end;
    }
    textelement(CurrencyCode)
    {
    trigger OnBeforePassVariable()
    begin
        CurrencyCode:='EUR';
    end;
    }
    textelement(DateCreated)
    {
    trigger OnBeforePassVariable()
    begin
        DateCreated:=FORMAT(TODAY, 0, 9);
    end;
    }
    textelement(TaxEntity)
    {
    trigger OnBeforePassVariable()
    begin
        //TaxEntity := 'Sede';      //INF.P02
        TaxEntity:='Global'; //INF.P02
    end;
    }
    textelement(ProductCompanyTaxID)
    {
    trigger OnBeforePassVariable()
    begin
        ProductCompanyTaxID:=CompanyInfo."Software Vendor VAT PT";
    end;
    }
    textelement(SoftwareCertificateNumber)
    {
    trigger OnBeforePassVariable()
    begin
        IF CompanyInfo."Soft. Certificate Number PT" = '' THEN SoftwareCertificateNumber:='0'
        ELSE
            SoftwareCertificateNumber:=CompanyInfo."Soft. Certificate Number PT";
    end;
    }
    textelement(ProductID)
    {
    trigger OnBeforePassVariable()
    begin
        ProductID:='Microsoft Dynamics NAV/Microsoft';
    end;
    }
    textelement(ProductVersion)
    {
    trigger OnBeforePassVariable()
    begin
        ProductVersion:=AppManagement.ApplicationVersion() + ' C';
    end;
    }
    trigger OnBeforePassVariable()
    begin
        Window.UPDATE(1, Text1110002);
    end;
    }
    textelement(MasterFiles)
    {
    MaxOccurs = Once;
    MinOccurs = Once;

    tableelement(customer;
    18)
    {
    MinOccurs = Zero;
    XmlName = 'Customer';

    fieldelement(CustomerID;
    Customer."No.")
    {
    }
    textelement(accountidcust)
    {
    XmlName = 'AccountID';

    trigger OnBeforePassVariable()
    var
        CustPostingGr: Record 92;
    begin
        AccountIDCust:='Desconhecido';
        IF CustPostingGr.GET(Customer."Customer Posting Group")THEN IF CustPostingGr."Receivables Account" <> '' THEN AccountIDCust:=CustPostingGr."Receivables Account";
    end;
    }
    textelement(customertaxid)
    {
    XmlName = 'CustomerTaxID';

    trigger OnBeforePassVariable()
    begin
        IF Customer."VAT Registration No." <> '' THEN CustomerTaxID:=Customer."VAT Registration No."
        ELSE
            CustomerTaxID:='0';
    end;
    }
    fieldelement(CompanyName;
    Customer.Name)
    {
    }
    textelement(billingaddress_c)
    {
    XmlName = 'BillingAddress';

    textelement(addressdetail_billtoc)
    {
    XmlName = 'AddressDetail';

    trigger OnBeforePassVariable()
    begin
        IF Customer."Bill-to Customer No." <> '' THEN AddressDetail_BillToC:=BillToCust.Address + ' ' + BillToCust."Address 2"
        ELSE
            AddressDetail_BillToC:=Customer.Address + ' ' + Customer."Address 2";
        IF STRLEN(AddressDetail_BillToC) > 60 THEN AddressDetail_BillToC:=PADSTR(AddressDetail_BillToC, 60);
    end;
    }
    textelement(city_billtoc)
    {
    XmlName = 'City';

    trigger OnBeforePassVariable()
    begin
        IF Customer."Bill-to Customer No." <> '' THEN City_BilltoC:=BillToCust.City
        ELSE
            City_BilltoC:=Customer.City;
    end;
    }
    textelement(postalcode_billtoc)
    {
    XmlName = 'PostalCode';

    trigger OnBeforePassVariable()
    begin
        IF Customer."Bill-to Customer No." <> '' THEN PostalCode_BillToC:=BillToCust."Post Code"
        ELSE
            PostalCode_BillToC:=Customer."Post Code";
    end;
    }
    textelement(country_billtoc)
    {
    XmlName = 'Country';

    trigger OnBeforePassVariable()
    begin
        IF Customer."Bill-to Customer No." <> '' THEN Country_BillToC:=GetCountry(BillToCust."Country/Region Code", TRUE)
        ELSE
            Country_BillToC:=GetCountry(Customer."Country/Region Code", TRUE);
    end;
    }
    }
    textelement(shiptoadress_c)
    {
    XmlName = 'ShipToAddress';

    textelement(adressdetail_shiptoc)
    {
    XmlName = 'AddressDetail';

    trigger OnBeforePassVariable()
    begin
        AdressDetail_ShipToC:=Customer.Address + ' ' + Customer."Address 2";
        IF STRLEN(AdressDetail_ShipToC) > 60 THEN AdressDetail_ShipToC:=PADSTR(AdressDetail_ShipToC, 60);
    end;
    }
    fieldelement(City;
    Customer.City)
    {
    }
    fieldelement(PostalCode;
    Customer."Post Code")
    {
    }
    textelement(country_shiptoc)
    {
    XmlName = 'Country';

    trigger OnBeforePassVariable()
    begin
        Country_ShipToC:=GetCountry(Customer."Country/Region Code", TRUE); //INF.P04
    end;
    }
    }
    textelement(selfbillingindicatorcust)
    {
    XmlName = 'SelfBillingIndicator';

    trigger OnBeforePassVariable()
    begin
        SelfBillingIndicatorCust:='0';
    end;
    }
    trigger OnAfterGetRecord()
    begin
        //<INF.P02
        RevisaFactura.Reset();
        RevisaFactura.SETRANGE("Bill-to Customer No.", Customer."No.");
        RevisaFactura.SETRANGE("Posting Date", StartDate3, EndDate2);
        IF RevisaFactura.ISEMPTY THEN BEGIN
            RevisaAbono.Reset();
            RevisaAbono.SETRANGE("Bill-to Customer No.", Customer."No.");
            RevisaAbono.SETRANGE("Posting Date", StartDate3, EndDate2);
            IF RevisaAbono.ISEMPTY THEN currXMLport.Skip();
        END;
        //INF.P02>
        Window.UPDATE(2, Customer."No.");
        IF Customer."Bill-to Customer No." <> '' THEN BillToCust.GET(Customer."Bill-to Customer No.");
    end;
    trigger OnPreXmlItem()
    begin
        Window.UPDATE(1, Text1110004);
    end;
    }
    tableelement(product;
    27)
    {
    XmlName = 'Product';

    textelement(producttype)
    {
    XmlName = 'ProductType';

    trigger OnBeforePassVariable()
    begin
        ProductType:='S';
    end;
    trigger OnAfterAssignVariable()
    begin
        ProductType:='S';
    end;
    }
    fieldelement(ProductCode;
    Product."No.")
    {
    }
    fieldelement(ProductDescription;
    Product.Description)
    {
    }
    fieldelement(ProductNumberCode;
    Product."No.")
    {
    }
    }
    textelement(TaxTable)
    {
    tableelement(vatpostingsetup;
    Integer)
    {
    MinOccurs = Zero;
    XmlName = 'TaxTableEntry';

    textelement(vatpostingsetuptaxtype)
    {
    XmlName = 'TaxType';

    trigger OnBeforePassVariable()
    begin
        VATPostingSetupTaxType:='IVA';
    end;
    }
    textelement(vatpostingsettaxcoutreg)
    {
    XmlName = 'TaxCountryRegion';

    trigger OnBeforePassVariable()
    begin
        //<INF.P03
        Pais.GET(CompanyInfo."Country/Region Code");
        VATPostingSetTaxcoutReg:=Pais."EU Country/Region Code"; //CompanyInfo."Country Code";
    //INF.P03>
    end;
    }
    textelement(vatpostingsetuptaxcode)
    {
    XmlName = 'TaxCode';
    }
    textelement(vatpostingsetupdescription)
    {
    XmlName = 'Description';
    }
    textelement(vatpostingsetuptaxper)
    {
    XmlName = 'TaxPercentage';
    }
    trigger OnAfterGetRecord()
    begin
        VATPostingSetupTaxCode:=GetSAFTVatCode(VATSetupBuffer."SAF-T PT VAT Code PT");
        VATPostingSetupDescription:=GetSAFTVatTypeDescription(VATSetupBuffer."SAF-T PT VAT Type Descr. PT");
        VATPostingSetupTaxPer:=FORMAT(VATSetupBuffer."VAT %", 0, 9);
        VATSetupBuffer.NEXT;
    end;
    trigger OnPreXmlItem()
    begin
        VATSetupBuffer.Reset();
        VATSetupBuffer.SETCURRENTKEY("SAF-T PT VAT Type Descr. PT", "SAF-T PT VAT Code PT");
        VATPostingSetup.SETRANGE(Number, 1, VATSetupBuffer.COUNT);
        IF VATSetupBuffer.FindFirst()then;
        Window.UPDATE(1, Text1110007);
        Window.UPDATE(2, '');
    end;
    }
    tableelement(selotaxgeneraltablepr;
    "Selo Tax General Table")
    {
    MinOccurs = Zero;
    XmlName = 'TaxTableEntry';
    SourceTableView = SORTING("No.")WHERE("Tax value type"=FILTER(0));

    textelement(selotaxtypepr)
    {
    MinOccurs = Once;
    XmlName = 'TaxType';

    trigger OnBeforePassVariable()
    begin
        SeloTaxTypePr:='IS';
    end;
    }
    textelement(selotaxcountryregionpr)
    {
    XmlName = 'TaxCountryRegion';

    trigger OnBeforePassVariable()
    begin
        //<INF.P03
        Pais.GET(CompanyInfo."Country/Region Code");
        SeloTaxcountryRegionPr:=Pais."EU Country/Region Code"; //CompanyInfo."Country Code";
    //INF.P03>
    end;
    }
    fieldelement(TaxCode;
    SeloTaxGeneralTablePr."No.")
    {
    }
    fieldelement(Description;
    SeloTaxGeneralTablePr.Description)
    {
    }
    textelement(selotaxpercentage)
    {
    XmlName = 'TaxPercentage';

    trigger OnBeforePassVariable()
    begin
        SeloTaxPercentage:=FORMAT(SeloTaxGeneralTablePr.Amount, 0, 9);
    end;
    }
    }
    tableelement(selotaxgeneraltableamt;
    "Selo Tax General Table")
    {
    MinOccurs = Zero;
    XmlName = 'TaxTableEntry';
    SourceTableView = SORTING("No.")WHERE("Tax value type"=FILTER(1));

    textelement(selotaxtypeamt)
    {
    MinOccurs = Once;
    XmlName = 'TaxType';

    trigger OnBeforePassVariable()
    begin
        SeloTaxTypeAmt:='IS';
    end;
    }
    textelement(selotaxcountryregionamt)
    {
    XmlName = 'TaxCountryRegion';

    trigger OnBeforePassVariable()
    begin
        //<INF.P03
        Pais.GET(CompanyInfo."Country/Region Code");
        SeloTaxcountryRegionAmt:=Pais."EU Country/Region Code"; //CompanyInfo."Country Code";
    //INF.P03>
    end;
    }
    fieldelement(TaxCode;
    SeloTaxGeneralTableAmt."No.")
    {
    }
    fieldelement(Description;
    SeloTaxGeneralTableAmt.Description)
    {
    }
    textelement(selotaxamount)
    {
    XmlName = 'TaxAmount';

    trigger OnBeforePassVariable()
    begin
        SeloTaxAmount:=FORMAT(SeloTaxGeneralTableAmt.Amount, 0, 9);
    end;
    }
    }
    }
    }
    textelement(SourceDocuments)
    {
    textelement(docssalesinvoice)
    {
    XmlName = 'SalesInvoices';

    textelement(numberofdocs)
    {
    XmlName = 'NumberOfEntries';

    trigger OnBeforePassVariable()
    begin
        NumberOfDocs:=FORMAT(TotalDocs, 0, 9);
    end;
    }
    textelement(docstotaldebit)
    {
    XmlName = 'TotalDebit';

    trigger OnBeforePassVariable()
    begin
        DocsTotalDebit:=FORMAT(TotalDebitDocs, 0, 9);
    end;
    }
    textelement(docstotalcredit)
    {
    XmlName = 'TotalCredit';

    trigger OnBeforePassVariable()
    begin
        DocsTotalCredit:=FORMAT(TotalCreditDocs, 0, 9);
    end;
    }
    tableelement(salesinvoiceheader;
    112)
    {
    MinOccurs = Zero;
    XmlName = 'Invoice';

    textelement(salesinvno)
    {
    XmlName = 'InvoiceNo';

    trigger OnBeforePassVariable()
    begin
        //>>INF.P01
        //  IF SalesInvoiceHeader."Prepayment Invoice" THEN
        //    SalesInvNo :=
        //      GetDocumentType(TRUE) + SalesInvoiceHeader."Prepayment No. Series" + '/' + SalesInvoiceHeader."No."
        //  ELSE
        //<<INF.P01
        //<INF.P04
        //SalesInvNo := GetDocumentType(TRUE) + SalesInvoiceHeader."No. Series" + '/' + SalesInvoiceHeader."No." ;
        SalesInvNo:=GetDocumentType(TRUE) + FormatSerie(SalesInvoiceHeader."No. Series") + '/' + FormatCod(SalesInvoiceHeader."No.");
    //INF.P04>
    end;
    }
    textelement(ATCUD)
    {
    trigger OnBeforePassVariable()
    begin
        ATCUD:='0';
    end;
    }
    tableelement(docstatusinvinteger;
    Integer)
    {
    XmlName = 'DocumentStatus';
    SourceTableView = WHERE(Number=CONST(1));

    textelement(invinvoicestatus)
    {
    XmlName = 'InvoiceStatus';

    trigger OnBeforePassVariable()
    begin
        IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN InvInvoiceStatus:='A'
        ELSE
            InvInvoiceStatus:='N';
    end;
    }
    textelement(invoicestatusdateinv)
    {
    XmlName = 'InvoiceStatusDate';

    trigger OnBeforePassVariable()
    begin
        InvoiceStatusDateInv:=GetInvCreationDT;
    end;
    }
    textelement(sourceidinv)
    {
    XmlName = 'SourceID';

    trigger OnBeforePassVariable()
    begin
        SourceIDInv:=SalesInvoiceHeader."User ID";
    end;
    }
    textelement(invsourcebilling)
    {
    XmlName = 'SourceBilling';

    trigger OnBeforePassVariable()
    begin
        InvSourceBilling:='P';
    end;
    }
    }
    textelement(invhash)
    {
    XmlName = 'Hash';

    trigger OnBeforePassVariable()
    begin
        InvHash:='0';
        IF SalesInvoiceHeader.Hash <> '' THEN InvHash:=SalesInvoiceHeader.Hash end;
    }
    textelement(invhashcontrol)
    {
    XmlName = 'HashControl';

    trigger OnBeforePassVariable()
    begin
        InvHashControl:='0';
        IF SalesInvoiceHeader.Hash <> '' THEN InvHashControl:=SalesInvoiceHeader."Private Key Version" end;
    }
    textelement(invoicedate)
    {
    XmlName = 'InvoiceDate';

    trigger OnBeforePassVariable()
    begin
        InvoiceDate:=FORMAT(SalesInvoiceHeader."Document Date", 0, 9);
    end;
    }
    textelement(invoicetype)
    {
    XmlName = 'InvoiceType';

    trigger OnBeforePassVariable()
    begin
        InvoiceType:='FT';
    end;
    }
    tableelement(specialregimesinv;
    Integer)
    {
    XmlName = 'SpecialRegimes';
    SourceTableView = WHERE(Number=CONST(1));

    textelement(invselfbillingindicator)
    {
    XmlName = 'SelfBillingIndicator';

    trigger OnBeforePassVariable()
    begin
        InvSelfBillingIndicator:='0';
    end;
    }
    textelement(invcashvatscheme)
    {
    XmlName = 'CashVATSchemeIndicator';

    trigger OnBeforePassVariable()
    begin
        InvCashVATScheme:='0';
    end;
    }
    textelement(invihirdpartiesbilling)
    {
    XmlName = 'ThirdPartiesBillingIndicator';

    trigger OnBeforePassVariable()
    begin
        InvIhirdPartiesBilling:='0';
    end;
    }
    }
    textelement(invsourceid)
    {
    XmlName = 'SourceID';

    trigger OnBeforePassVariable()
    begin
        InvSourceID:=SalesInvoiceHeader."User ID";
    end;
    }
    textelement(invoicesystementrydate)
    {
    XmlName = 'SystemEntryDate';

    trigger OnBeforePassVariable()
    begin
        /*
                                IF SalesInvoiceHeader."Creation Date" <> 0D THEN
                                  InvoiceSystemEntryDate := FormatDateTime(SalesInvoiceHeader."Creation Date",SalesInvoiceHeader."Creation Time")
                                ELSE BEGIN
                                  IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN
                                    InvoiceSystemEntryDate := FormatDateTime(SalesInvoiceHeader."Posting Date",0T)
                                  ELSE BEGIN
                                    IF SalesInvoiceHeader."Bill-to Customer No." <> '' THEN
                                      InvoiceSystemEntryDate := GetEntryDocDateTime(TRUE,SalesInvoiceHeader."No.",SalesInvoiceHeader."Bill-to Customer No.")
                                    ELSE
                                      InvoiceSystemEntryDate := GetEntryDocDateTime(TRUE,SalesInvoiceHeader."No.",SalesInvoiceHeader."Sell-to Customer No.");
                                  END;
                                END;
                                */
        InvoiceSystemEntryDate:=GetInvCreationDT;
    end;
    }
    textelement(invtransactionid)
    {
    XmlName = 'TransactionID';

    trigger OnBeforePassVariable()
    begin
        IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN InvTransactionID:=FORMAT(FORMAT(SalesInvoiceHeader."Document Date", 0, 9) + ' ' + SalesInvoiceHeader."Source Code" + ' ' + SalesInvoiceHeader."No.")
        ELSE
            InvTransactionID:=FORMAT(FORMAT(SalesInvoiceHeader."Posting Date", 0, 9) + ' ' + SalesInvoiceHeader."Source Code" + ' ' + SalesInvoiceHeader."No.");
    end;
    }
    textelement(invcustormerid)
    {
    XmlName = 'CustomerID';

    trigger OnBeforePassVariable()
    begin
        IF SalesInvoiceHeader."Bill-to Customer No." <> '' THEN InvCustormerID:=SalesInvoiceHeader."Bill-to Customer No."
        ELSE
            InvCustormerID:=SalesInvoiceHeader."Sell-to Customer No.";
    end;
    }
    textelement(salesinvshipto)
    {
    MinOccurs = Zero;
    XmlName = 'ShipTo';

    //Fix
    fieldelement(DeliveryID;
    SalesInvoiceHeader."Ship-to Code")
    {
    trigger OnBeforePassField()
    begin
        if SalesInvoiceHeader."Ship-to Code" = '' then currXMLport.Skip();
    end;
    }
    textelement(salesinvdeliverydate)
    {
    XmlName = 'DeliveryDate';

    trigger OnBeforePassVariable()
    begin
        SalesInvDeliveryDate:=FORMAT(SalesInvoiceHeader."Shipment Date", 0, 9);
        if SalesInvDeliveryDate = '' then currXMLport.Skip();
    end;
    }
    tableelement(integer_addrdetailsalesinv;
    Integer)
    {
    XmlName = 'Address';

    textelement(salesinvshipaddressdetail)
    {
    XmlName = 'AddressDetail';

    trigger OnBeforePassVariable()
    begin
        SalesInvShipAddressDetail:=GetAddress(SalesInvoiceHeader."Ship-to Address", SalesInvoiceHeader."Ship-to Address 2");
        SalesInvShiptoCity:=SalesInvoiceHeader."Ship-to City";
        SalesInvPostalCode:=SalesInvoiceHeader."Ship-to Post Code";
        SalesInvCountry:=SalesInvoiceHeader."Ship-to Country/Region Code";
    end;
    }
    textelement(salesinvshiptocity)
    {
    XmlName = 'City';
    }
    textelement(salesinvpostalcode)
    {
    XmlName = 'PostalCode';
    }
    textelement(salesinvcountry)
    {
    XmlName = 'Country';

    trigger OnBeforePassVariable()
    begin
        SalesInvCountry:=GetCountry(SalesInvCountry, TRUE); //INF.P04
    end;
    }
    trigger OnPreXmlItem()
    begin
        IF CheckAddressDetails(SalesInvoiceHeader."Ship-to Address", SalesInvoiceHeader."Ship-to Address 2", SalesInvoiceHeader."Ship-to City", SalesInvoiceHeader."Ship-to Post Code", SalesInvoiceHeader."Ship-to Country/Region Code")THEN Integer_AddrDetailSalesInv.SETRANGE(Number, 1, 1)
        ELSE
            currXMLport.Break();
    end;
    }
    }
    textelement(salesinvshipfrom)
    {
    XmlName = 'ShipFrom';

    //Fix
    fieldelement(DeliveryID;
    SalesInvoiceHeader."Location Code")
    {
    trigger OnBeforePassField()
    begin
        if SalesInvoiceHeader."Location Code" = '' then currXMLport.Skip();
    end;
    }
    textelement(salesinvdeliverydate_loc)
    {
    XmlName = 'DeliveryDate';

    trigger OnBeforePassVariable()
    begin
        SalesInvDeliveryDate_Loc:=FORMAT(SalesInvoiceHeader."Shipment Date", 0, 9);
        if SalesInvDeliveryDate_Loc = '' then currXMLport.Skip();
    end;
    }
    tableelement(salesinvlocation;
    14)
    {
    XmlName = 'Address';

    textelement(salesinvaddressdetail_loc)
    {
    XmlName = 'AddressDetail';

    trigger OnBeforePassVariable()
    begin
        SalesInvAddressDetail_Loc:=GetAddress(SalesInvLocation.Address, SalesInvLocation."Address 2");
    end;
    }
    fieldelement(City;
    SalesInvLocation.City)
    {
    }
    fieldelement(PostalCode;
    SalesInvLocation."Post Code")
    {
    }
    fieldelement(Country;
    SalesInvLocation."Country/Region Code")
    {
    }
    trigger OnPreXmlItem()
    begin
        IF SalesInvoiceHeader."Location Code" <> '' THEN SalesInvLocation.SETRANGE(Code, SalesInvoiceHeader."Location Code")
        ELSE
            currXMLport.Break();
    end;
    }
    }
    tableelement("sales invoice line";
    113)
    {
    LinkTable = SalesInvoiceHeader;
    XmlName = 'Line';

    textelement(invlnno)
    {
    XmlName = 'LineNumber';

    trigger OnBeforePassVariable()
    begin
        InvLnNo:=FORMAT(LineNo, 0, 9);
    end;
    }
    tableelement(integer_orderrefsalesinv;
    Integer)
    {
    XmlName = 'OrderReferences';

    textelement(salesinvoriginatingon)
    {
    XmlName = 'OriginatingON';

    trigger OnBeforePassVariable()
    begin
        if SalesInvOriginatingON = '' then currXMLport.Skip();
    end;
    }
    textelement(salesinvorderdate)
    {
    XmlName = 'OrderDate';
    }
    trigger OnPreXmlItem()
    begin
        IF "Sales Invoice Line"."Shipment No." <> '' THEN BEGIN
            SalesInvOriginatingON:="Sales Invoice Line"."Shipment No.";
            SalesInvOrderDate:=FORMAT("Sales Invoice Line"."Shipment Date", 0, 9);
        END
        ELSE
        BEGIN
            SalesInvOriginatingON:=SalesInvoiceHeader."Order No.";
            SalesInvOrderDate:=FORMAT(SalesInvoiceHeader."Order Date", 0, 9);
        END;
        IF(SalesInvOriginatingON <> '') OR (SalesInvOrderDate <> '')THEN Integer_OrderRefSalesInv.SETRANGE(Number, 1, 1)
        ELSE
            currXMLport.Break();
    end;
    }
    textelement(invlnproductcode)
    {
    XmlName = 'ProductCode';

    trigger OnBeforePassVariable()
    begin
        IF "Sales Invoice Line".Type IN["Sales Invoice Line".Type::Item, "Sales Invoice Line".Type::Resource, "Sales Invoice Line".Type::"Charge (Item)"]THEN InvLnProductCode:="Sales Invoice Line"."No."
        ELSE IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" THEN InvLnProductCode:='CONTA'
            ELSE IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::"Fixed Asset" THEN InvLnProductCode:='ACTIVOFIXO';
        IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN InvLnProductCode:='ANULADO';
    end;
    }
    textelement(invlnproductdescription)
    {
    XmlName = 'ProductDescription';

    trigger OnBeforePassVariable()
    begin
        //        InvLnProductDescription := Item.Description;
        //    END;
        //  "Sales Invoice Line".Type::Resource:
        //    BEGIN
        //        InvLnProductDescription := Resource.Name;
        //    END;
        //  "Sales Invoice Line".Type::"Charge (Item)":
        //    BEGIN
        //        InvLnProductDescription := ItemCharge.Description;
        //    END;
        //  ELSE
        //    InvLnProductDescription := '';
        //END;
        CASE "Sales Invoice Line".Type OF "Sales Invoice Line".Type::Item: IF Item.GET("Sales Invoice Line"."No.")THEN InvLnProductDescription:=Item.Description;
        "Sales Invoice Line".Type::Resource: IF Resource.GET("Sales Invoice Line"."No.")THEN InvLnProductDescription:=Resource.Name;
        "Sales Invoice Line".Type::"Charge (Item)": IF ItemCharge.GET("Sales Invoice Line"."No.")THEN InvLnProductDescription:=ItemCharge.Description;
        ELSE
            InvLnProductDescription:="Sales Invoice Line".Description;
        END;
        IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN InvLnProductDescription:='0';
    end;
    }
    textelement(invquantity)
    {
    XmlName = 'Quantity';

    trigger OnBeforePassVariable()
    begin
        //InvQuantity := FORMAT("Sales Invoice Line".Quantity,0,9); //EX-SGG 181218 COMENTO.
        InvQuantity:=FORMAT(ABS("Sales Invoice Line".Quantity), 0, 9); //EX-SGG 181218
    end;
    }
    textelement(invunitofmeasure)
    {
    XmlName = 'UnitOfMeasure';

    trigger OnBeforePassVariable()
    begin
        IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN InvUnitofMeasure:='0'
        ELSE IF "Sales Invoice Line"."Unit of Measure" <> '' THEN InvUnitofMeasure:="Sales Invoice Line"."Unit of Measure"
            ELSE
                InvUnitofMeasure:='UNIDADE';
    end;
    }
    textelement(invlnunitprice)
    {
    XmlName = 'UnitPrice';

    trigger OnBeforePassVariable()
    begin
        IF "Sales Invoice Line".Quantity = 0 THEN InvLnUnitPrice:='0'
        ELSE
            InvLnUnitPrice:=FORMAT(("Sales Invoice Line".Amount / "Sales Invoice Line".Quantity) / DocFactor, 0, 9);
    end;
    }
    textelement(invlntaxpointdate)
    {
    XmlName = 'TaxPointDate';

    trigger OnBeforePassVariable()
    begin
        IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN InvLnTaxPointDate:=FORMAT(SalesInvoiceHeader."Posting Date", 0, 9)
        ELSE IF "Sales Invoice Line"."Shipment Date" <> 0D THEN InvLnTaxPointDate:=FORMAT("Sales Invoice Line"."Shipment Date", 0, 9)
            ELSE
                InvLnTaxPointDate:=FORMAT(SalesInvoiceHeader."Document Date", 0, 9)end;
    }
    textelement(invlndescription)
    {
    XmlName = 'Description';

    trigger OnBeforePassVariable()
    begin
        IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN InvLnDescription:='0'
        ELSE IF "Sales Invoice Line".Description = '' THEN InvLnDescription:=InvLnProductDescription
            ELSE
                InvLnDescription:="Sales Invoice Line".Description;
    end;
    }
    textelement(invdebitamount)
    {
    XmlName = 'DebitAmount';

    trigger OnBeforePassVariable()
    begin
        IF InvDebitAmount = '0' THEN currXMLport.Skip(); //EX-SGG 191218
    end;
    }
    textelement(invcreditamount)
    {
    XmlName = 'CreditAmount';

    trigger OnBeforePassVariable()
    begin
        //EX-SGG 181218 COMENTO
        /*
                                    InvCreditAmount := FORMAT(ROUND("Sales Invoice Line".Amount / DocFactor,0.01),0,
                                      '<Precision,2:2><Standard Format,9>');
                                    */
        IF InvCreditAmount = '0' THEN currXMLport.Skip(); //EX-SGG 191218
    end;
    }
    textelement(invtax)
    {
    XmlName = 'Tax';

    textelement(invtaxtype)
    {
    XmlName = 'TaxType';

    trigger OnBeforePassVariable()
    begin
        InvTaxType:='IVA';
    end;
    }
    textelement(invtaxcountryregion)
    {
    XmlName = 'TaxCountryRegion';

    trigger OnBeforePassVariable()
    begin
        //<INF.P03
        Pais.GET(CompanyInfo."Country/Region Code");
        InvTaxCountryRegion:=Pais."EU Country/Region Code"; //CompanyInfo."Country Code";
    //INF.P03>
    end;
    }
    textelement(invtaxcode)
    {
    XmlName = 'TaxCode';

    trigger OnBeforePassVariable()
    begin
        IF "Sales Invoice Line"."VAT Bus. Posting Group" + "Sales Invoice Line"."VAT Prod. Posting Group" <> '' THEN InvTaxCode:=GetTaxType("Sales Invoice Line"."VAT Bus. Posting Group", "Sales Invoice Line"."VAT Prod. Posting Group", FALSE)
        ELSE
            InvTaxCode:='OUT';
    end;
    }
    textelement(salesinvtaxpercentage)
    {
    XmlName = 'TaxPercentage';

    trigger OnBeforePassVariable()
    begin
        SalesInvTaxPercentage:=FORMAT("Sales Invoice Line"."VAT %", 0, 9);
    end;
    }
    }
    textelement(invtaxexemptionreason)
    {
    MaxOccurs = Once;
    MinOccurs = Zero;
    XmlName = 'TaxExemptionReason';

    trigger OnBeforePassVariable()
    begin
        InvTaxExemptionReason:=GetTaxExemptionReason("Sales Invoice Line"."VAT Bus. Posting Group", "Sales Invoice Line"."VAT Prod. Posting Group");
        IF(InvTaxExemptionReason = '') OR ("Sales Invoice Line"."VAT %" <> 0)THEN //InvTaxExemptionReason := '0';
 InvTaxExemptionReason:='';
        if invtaxexemptionreason = '' then currXMLport.Skip();
    end;
    }
    textelement(invtaxexemptioncode)
    {
    XmlName = 'TaxExemptionCode';

    trigger OnBeforePassVariable()
    begin
        InvTaxExemptionCode:=GetTaxExemptionCode("Sales Invoice Line"."VAT Bus. Posting Group", "Sales Invoice Line"."VAT Prod. Posting Group");
        IF(InvTaxExemptionCode = '') OR ("Sales Invoice Line"."VAT %" <> 0)THEN InvTaxExemptionCode:='';
        if InvTaxExemptionCode = '' then currXMLport.Skip();
    end;
    }
    textelement(invsettlementamount)
    {
    XmlName = 'SettlementAmount';

    trigger OnBeforePassVariable()
    begin
        InvSettlementAmount:=FORMAT(ROUND((("Sales Invoice Line"."Line Discount Amount" + "Sales Invoice Line"."Inv. Discount Amount") / DocFactor), 0.01), 0, 9);
        InvSettlementAmount:='0'; //<INF.P08
    end;
    }
    trigger OnAfterGetRecord()
    begin
        LineNo+=1;
        FormatearImporte(InvDebitAmount, InvCreditAmount, "Sales Invoice Line".Amount); //EX-SGG 181218
    end;
    trigger OnPreXmlItem()
    begin
        "Sales Invoice Line".Reset();
        "Sales Invoice Line".SETRANGE("Document No.", SalesInvoiceHeader."No.");
        "Sales Invoice Line".SETFILTER(Type, '<>%1', "Sales Invoice Line".Type::" ");
        "Sales Invoice Line".SETFILTER("No.", '<>%1', '');
        LineNo:=0;
    end;
    }
    textelement(invdocumenttotals)
    {
    XmlName = 'DocumentTotals';

    textelement(invtaxpayable)
    {
    XmlName = 'TaxPayable';

    trigger OnBeforePassVariable()
    begin
        InvTaxPayable:=FORMAT(ROUND((SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount) / DocFactor, 0.01), 0, 9);
    end;
    }
    textelement(invnettotal)
    {
    XmlName = 'NetTotal';

    trigger OnBeforePassVariable()
    begin
        InvNetTotal:=FORMAT(ROUND(SalesInvoiceHeader.Amount / DocFactor, 0.01), 0, 9);
    end;
    }
    textelement(invgrosstotal)
    {
    XmlName = 'GrossTotal';

    trigger OnBeforePassVariable()
    begin
        InvGrossTotal:=FORMAT(ROUND(SalesInvoiceHeader."Amount Including VAT" / DocFactor, 0.01), 0, 9);
    end;
    }
    tableelement(currency_salesinv;
    Currency)
    {
    LinkFields = "Code"=FIELD("Currency Code");
    LinkTable = SalesInvoiceHeader;
    MinOccurs = Zero;
    XmlName = 'Currency';

    fieldelement(CurrencyCode;
    Currency_SalesInv.Code)
    {
    }
    textelement(salesinvcurrcreditamt)
    {
    XmlName = 'CurrencyCreditAmount';

    trigger OnBeforePassVariable()
    begin
        SalesInvoiceHeader.CALCFIELDS("Amount Including VAT");
        SalesInvCurrCreditAmt:=FORMAT(SalesInvoiceHeader."Amount Including VAT" * SalesInvoiceHeader."Currency Factor", 0, 9);
    end;
    }
    }
    tableelement(salesinvinteger;
    Integer)
    {
    XmlName = 'Settlement';
    SourceTableView = WHERE(Number=CONST(0));

    textelement(salesinvsettlementdisc)
    {
    XmlName = 'SettlementDiscount';

    trigger OnBeforePassVariable()
    begin
        SalesInvoiceHeader.CALCFIELDS(Amount);
        GetSettlement(SalesInvSettlementDisc, SalesInvSettlementAmt, SalesInvSettlementDate, SalesInvoiceHeader."Payment Discount %", SalesInvoiceHeader."Pmt. Discount Date", SalesInvoiceHeader."Document Date", SalesInvoiceHeader.Amount, SalesInvoiceHeader."No.", SalesInvoiceHeader."Sell-to Customer No.");
        if SalesInvSettlementDisc = '' then currXMLport.Skip();
    end;
    }
    textelement(salesinvsettlementamt)
    {
    XmlName = 'SettlementAmount';

    trigger OnBeforePassVariable()
    begin
        if salesinvsettlementamt = '' then currXMLport.Skip();
    end;
    }
    textelement(salesinvsettlementdate)
    {
    XmlName = 'SettlementDate';

    trigger OnBeforePassVariable()
    begin
        if salesinvsettlementdate = '' then currXMLport.Skip();
    end;
    }
    textelement(salesinvpmtmechanism)
    {
    XmlName = 'PaymentMechanism';

    trigger OnBeforePassVariable()
    begin
        IF PaymentMethod.GET(SalesInvoiceHeader."Payment Method Code")THEN SalesInvPmtMechanism:=GetPaymentMechanism(PaymentMethod."Payment Mechanism PT")
        ELSE
            SalesInvPmtMechanism:='';
        SalesInvPmtMechanism:=''; //INF.P08
        if SalesInvPmtMechanism = '' then currXMLport.Skip();
    end;
    }
    trigger OnPreXmlItem()
    begin
        IF(SalesInvoiceHeader."Payment Discount %" <> 0) OR (SalesInvoiceHeader."Payment Method Code" <> '')THEN SalesInvInteger.SETRANGE(Number, 1, 1)
        ELSE
            currXMLport.Break();
    end;
    }
    }
    trigger OnAfterGetRecord()
    begin
        SalesInvoiceHeader.CALCFIELDS(Amount, "Amount Including VAT");
        Window.UPDATE(2, SalesInvoiceHeader."No.");
        IF SalesInvoiceHeader."Currency Code" <> '' THEN DocFactor:=SalesInvoiceHeader."Currency Factor"
        ELSE
            DocFactor:=1;
    end;
    trigger OnPreXmlItem()
    begin
        SalesInvoiceHeader.SETRANGE("Posting Date", StartDate3, EndDate2);
        Window.UPDATE(1, Text1110009);
    end;
    }
    tableelement(salescrmemoheader;
    114)
    {
    MinOccurs = Zero;
    XmlName = 'Invoice';

    textelement(salescrmemono)
    {
    XmlName = 'InvoiceNo';

    trigger OnBeforePassVariable()
    begin
        //>>INF.P01
        //IF SalesCrMemoHeader."Prepayment Credit Memo" THEN
        //  SalesCrMemoNo :=
        //    GetDocumentType(FALSE) + SalesCrMemoHeader."Prepmt. Cr. Memo No. Series" + '/' + SalesCrMemoHeader."No."
        //ELSE
        //<<INF.P01
        //<INF.P04
        //SalesCrMemoNo := GetDocumentType(FALSE) + SalesCrMemoHeader."No. Series" + '/' + SalesCrMemoHeader."No.";
        SalesCrMemoNo:=GetDocumentType(FALSE) + FormatSerie(SalesCrMemoHeader."No. Series") + '/' + FormatCod(SalesCrMemoHeader."No.");
    //INF.P04>
    end;
    }
    textelement(salescratcud)
    {
    XmlName = 'ATCUD';

    trigger OnBeforePassVariable()
    begin
        SalesCrATCUD:='0'; //EX-SGG 280518
    end;
    }
    tableelement(docstatuscrm;
    Integer)
    {
    XmlName = 'DocumentStatus';
    SourceTableView = WHERE(Number=CONST(1));

    textelement(crinvoicestatus)
    {
    XmlName = 'InvoiceStatus';

    trigger OnBeforePassVariable()
    begin
        IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN CrInvoiceStatus:='A'
        ELSE
            CrInvoiceStatus:='N';
    end;
    }
    textelement(invoicestatusdatecrm)
    {
    XmlName = 'InvoiceStatusDate';

    trigger OnBeforePassVariable()
    begin
        InvoiceStatusDateCrm:=GetCrMCreationDT;
    end;
    }
    textelement(sourceidcrm)
    {
    XmlName = 'SourceID';

    trigger OnBeforePassVariable()
    begin
        SourceIDCrm:=SalesCrMemoHeader."User ID";
    end;
    }
    textelement(crmsourcebilling)
    {
    XmlName = 'SourceBilling';

    trigger OnBeforePassVariable()
    begin
        CrmSourceBilling:='P';
    end;
    }
    }
    textelement(crhash)
    {
    XmlName = 'Hash';

    trigger OnBeforePassVariable()
    begin
        CrHash:='0';
        IF SalesCrMemoHeader.Hash <> '' THEN CrHash:=SalesCrMemoHeader.Hash end;
    }
    textelement(crhashcontrol)
    {
    XmlName = 'HashControl';

    trigger OnBeforePassVariable()
    begin
        CrHashControl:='0';
        IF SalesCrMemoHeader.Hash <> '' THEN CrHashControl:=SalesCrMemoHeader."Private Key Version";
    end;
    }
    textelement(crmemodate)
    {
    XmlName = 'InvoiceDate';

    trigger OnBeforePassVariable()
    begin
        CrMemoDate:=FORMAT(SalesCrMemoHeader."Document Date", 0, 9);
    end;
    }
    textelement(crmemotype)
    {
    XmlName = 'InvoiceType';

    trigger OnBeforePassVariable()
    begin
        CRMemoType:='NC';
    end;
    }
    tableelement(specialregimescrm;
    Integer)
    {
    XmlName = 'SpecialRegimes';
    SourceTableView = WHERE(Number=CONST(1));

    textelement(crselfbillingindicator)
    {
    XmlName = 'SelfBillingIndicator';

    trigger OnBeforePassVariable()
    begin
        CrSelfBillingIndicator:='0';
    end;
    }
    textelement(crcashvatscheme)
    {
    XmlName = 'CashVATSchemeIndicator';

    trigger OnBeforePassVariable()
    begin
        CrCashVATScheme:='0';
    end;
    }
    textelement(crthirdpartiesbilling)
    {
    XmlName = 'ThirdPartiesBillingIndicator';

    trigger OnBeforePassVariable()
    begin
        CrThirdPartiesBilling:='0';
    end;
    }
    }
    textelement(crmsourceid)
    {
    XmlName = 'SourceID';

    trigger OnBeforePassVariable()
    begin
        CrmSourceID:=SalesCrMemoHeader."User ID";
    end;
    }
    textelement(crmemosystementrydate)
    {
    XmlName = 'SystemEntryDate';

    trigger OnBeforePassVariable()
    begin
        /*
                                IF SalesCrMemoHeader."Creation Date" <> 0D THEN
                                  CrMemoSystemEntryDate := FormatDateTime(SalesCrMemoHeader."Creation Date",SalesCrMemoHeader."Creation Time")
                                ELSE BEGIN
                                  IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN
                                    CrMemoSystemEntryDate := FormatDateTime(SalesCrMemoHeader."Posting Date",0T)
                                  ELSE BEGIN
                                    IF SalesCrMemoHeader."Bill-to Customer No." <> '' THEN
                                      CrMemoSystemEntryDate := GetEntryDocDateTime(FALSE,SalesCrMemoHeader."No.",SalesCrMemoHeader."Bill-to Customer No.")
                                    ELSE
                                      CrMemoSystemEntryDate := GetEntryDocDateTime(FALSE,SalesCrMemoHeader."No.",SalesCrMemoHeader."Sell-to Customer No.");
                                  END;
                                END;
                                */
        CrMemoSystemEntryDate:=GetCrMCreationDT;
    end;
    }
    textelement(crmtransactionid)
    {
    XmlName = 'TransactionID';

    trigger OnBeforePassVariable()
    begin
        IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN CrMTransactionID:=FORMAT(FORMAT(SalesCrMemoHeader."Document Date", 0, 9) + ' ' + SalesCrMemoHeader."Source Code" + ' ' + SalesCrMemoHeader."No.")
        ELSE
            CrMTransactionID:=FORMAT(FORMAT(SalesCrMemoHeader."Posting Date", 0, 9) + ' ' + SalesCrMemoHeader."Source Code" + ' ' + SalesCrMemoHeader."No.")end;
    }
    textelement(crmcustormerid)
    {
    XmlName = 'CustomerID';

    trigger OnBeforePassVariable()
    begin
        IF SalesCrMemoHeader."Bill-to Customer No." <> '' THEN CrMCustormerID:=SalesCrMemoHeader."Bill-to Customer No."
        ELSE
            CrMCustormerID:=SalesCrMemoHeader."Sell-to Customer No.";
    end;
    }
    textelement(salescrmemoshipto)
    {
    MinOccurs = Zero;
    XmlName = 'ShipTo';

    fieldelement(DeliveryID;
    SalesCrMemoHeader."Ship-to Code")
    {
    trigger OnBeforePassField()
    begin
        if SalesCrMemoHeader."Ship-to Code" = '' then currXMLport.Skip();
    end;
    }
    textelement(salescrmemodeliverydate)
    {
    XmlName = 'DeliveryDate';

    trigger OnBeforePassVariable()
    begin
        SalesCrMemoDeliveryDate:=FORMAT(SalesCrMemoHeader."Shipment Date", 0, 9);
        if SalesCrMemoDeliveryDate = '' then currXMLport.Skip();
    end;
    }
    tableelement(integer_salescrmemoaddr;
    Integer)
    {
    XmlName = 'Address';

    textelement(salescrmemoshipaddressdetail)
    {
    XmlName = 'AddressDetail';

    trigger OnBeforePassVariable()
    begin
        SalesCrMemoShipAddressDetail:=GetAddress(SalesCrMemoHeader."Ship-to Address", SalesCrMemoHeader."Ship-to Address 2");
        SalesCrMemoShiptoCity:=SalesCrMemoHeader."Ship-to City";
        SalesCrMemoPostalCode:=SalesCrMemoHeader."Ship-to Post Code";
        SalesCrMemoCountry:=SalesCrMemoHeader."Ship-to Country/Region Code";
        IF SalesCrMemoCountry = 'PORTUGAL' THEN SalesCrMemoCountry:='PT'; //<INF.P08
    end;
    }
    textelement(salescrmemoshiptocity)
    {
    XmlName = 'City';
    }
    textelement(salescrmemopostalcode)
    {
    XmlName = 'PostalCode';
    }
    textelement(salescrmemocountry)
    {
    XmlName = 'Country';

    trigger OnBeforePassVariable()
    begin
        SalesCrMemoCountry:=GetCountry(SalesCrMemoCountry, TRUE); //INF.P04
    end;
    }
    trigger OnPreXmlItem()
    begin
        IF CheckAddressDetails(SalesCrMemoHeader."Ship-to Address", SalesCrMemoHeader."Ship-to Address 2", SalesCrMemoHeader."Ship-to City", SalesCrMemoHeader."Ship-to Post Code", SalesCrMemoHeader."Ship-to Country/Region Code")THEN Integer_SalesCrMemoAddr.SETRANGE(Number, 1, 1)
        ELSE
            currXMLport.Break();
    end;
    }
    }
    textelement(salescrmemoshipfrom)
    {
    XmlName = 'ShipFrom';

    fieldelement(DeliveryID;
    SalesCrMemoHeader."Location Code")
    {
    trigger OnBeforePassField()
    begin
        if SalesCrMemoHeader."Location Code" = '' then currXMLport.Skip();
    end;
    }
    textelement(salescrmemodeliverydate_loc)
    {
    XmlName = 'DeliveryDate';

    trigger OnBeforePassVariable()
    begin
        SalesCrMemoDeliveryDate_Loc:=FORMAT(SalesCrMemoHeader."Document Date", 0, 9);
        if SalesCrMemoDeliveryDate_Loc = '' then currXMLport.Skip();
    end;
    }
    tableelement(salescrmemolocation;
    14)
    {
    XmlName = 'Address';

    textelement(salescrmemoaddressdetail_loc)
    {
    XmlName = 'AddressDetail';

    trigger OnBeforePassVariable()
    begin
        SalesCrMemoAddressDetail_Loc:=GetAddress(SalesCrMemoLocation.Address, SalesCrMemoLocation."Address 2");
    end;
    }
    fieldelement(City;
    SalesCrMemoLocation.City)
    {
    }
    fieldelement(PostalCode;
    SalesCrMemoLocation."Post Code")
    {
    }
    fieldelement(Country;
    SalesCrMemoLocation."Country/Region Code")
    {
    }
    trigger OnPreXmlItem()
    begin
        IF SalesCrMemoHeader."Location Code" <> '' THEN SalesCrMemoLocation.SETRANGE(Code, SalesCrMemoHeader."Location Code")
        ELSE
            currXMLport.Break();
    end;
    }
    }
    tableelement("sales cr.memo line";
    115)
    {
    LinkTable = SalesCrMemoHeader;
    XmlName = 'Line';

    textelement(crmlnno)
    {
    XmlName = 'LineNumber';

    trigger OnBeforePassVariable()
    begin
        CrMLnNo:=FORMAT(LineNo, 0, 9);
    end;
    }
    textelement(orderreferencessalescrmemo)
    {
    XmlName = 'OrderReferences';

    textelement(salescrmemooriginatingon)
    {
    XmlName = 'OriginatingON';

    trigger OnBeforePassVariable()
    begin
        IF ISSERVICETIER THEN IF(SalesCrMemoOriginatingON = '')THEN currXMLport.Skip();
    end;
    }
    textelement(salescrmemoorderdate)
    {
    XmlName = 'OrderDate';

    trigger OnBeforePassVariable()
    begin
        IF ISSERVICETIER THEN IF(SalesCrMemoOrderDate = '')THEN currXMLport.Skip();
    end;
    }
    trigger OnBeforePassVariable()
    begin
        IF "Sales Cr.Memo Line"."Return Receipt No." <> '' THEN BEGIN
            SalesCrMemoOriginatingON:="Sales Cr.Memo Line"."Return Receipt No.";
            SalesCrMemoOrderDate:=FORMAT("Sales Cr.Memo Line"."Shipment Date", 0, 9);
        END
        ELSE
        BEGIN
            SalesCrMemoOriginatingON:=SalesCrMemoHeader."Return Order No.";
            SalesCrMemoOrderDate:=FORMAT(SalesCrMemoHeader."Shipment Date", 0, 9);
        END;
    end;
    }
    textelement(crmlnproductcode)
    {
    XmlName = 'ProductCode';

    trigger OnBeforePassVariable()
    begin
        IF "Sales Cr.Memo Line".Type IN["Sales Cr.Memo Line".Type::Item, "Sales Cr.Memo Line".Type::Resource, "Sales Cr.Memo Line".Type::"Charge (Item)"]THEN CrMLnProductCode:="Sales Cr.Memo Line"."No."
        ELSE IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"G/L Account" THEN CrMLnProductCode:='CONTA'
            ELSE IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"Fixed Asset" THEN CrMLnProductCode:='ACTIVOFIXO';
        IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN CrMLnProductCode:='ANULADO';
    end;
    }
    textelement(crmlnproductdescription)
    {
    XmlName = 'ProductDescription';

    trigger OnBeforePassVariable()
    begin
        //        CrmLnProductDescription := Item.Description;
        //    END;
        //  "Sales Cr.Memo Line".Type::Resource:
        //    BEGIN
        //        CrmLnProductDescription := Resource.Name;
        //    END;
        //  "Sales Cr.Memo Line".Type::"Charge (Item)":
        //    BEGIN
        //        CrmLnProductDescription := ItemCharge.Description;
        //    END;
        //  ELSE
        //    CrmLnProductDescription := '';
        //END;
        CASE "Sales Cr.Memo Line".Type OF "Sales Cr.Memo Line".Type::Item: IF Item.GET("Sales Cr.Memo Line"."No.")THEN CrmLnProductDescription:=Item.Description;
        "Sales Cr.Memo Line".Type::Resource: IF Resource.GET("Sales Cr.Memo Line"."No.")THEN CrmLnProductDescription:=Resource.Name;
        "Sales Cr.Memo Line".Type::"Charge (Item)": IF ItemCharge.GET("Sales Cr.Memo Line"."No.")THEN CrmLnProductDescription:=ItemCharge.Description;
        ELSE
            CrmLnProductDescription:="Sales Cr.Memo Line".Description;
        END;
        IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN CrmLnProductDescription:='0';
    end;
    }
    textelement(crmquantity)
    {
    XmlName = 'Quantity';

    trigger OnBeforePassVariable()
    begin
        //CrMQuantity := FORMAT("Sales Cr.Memo Line".Quantity,0,9); //EX-SGG 181218 COMENTO.
        CrMQuantity:=FORMAT(ABS("Sales Cr.Memo Line".Quantity), 0, 9); //EX-SGG 181218
    end;
    }
    textelement(crmunitofmeasure)
    {
    XmlName = 'UnitOfMeasure';

    trigger OnBeforePassVariable()
    begin
        IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN CrMUnitofMeasure:='0'
        ELSE IF "Sales Cr.Memo Line"."Unit of Measure" <> '' THEN CrMUnitofMeasure:="Sales Cr.Memo Line"."Unit of Measure"
            ELSE
                CrMUnitofMeasure:='UNIDADE';
    end;
    }
    textelement(crmlnunitprice)
    {
    XmlName = 'UnitPrice';

    trigger OnBeforePassVariable()
    begin
        IF "Sales Cr.Memo Line".Quantity = 0 THEN CrMLnUnitPrice:='0'
        ELSE
            CrMLnUnitPrice:=FORMAT(("Sales Cr.Memo Line".Amount / "Sales Cr.Memo Line".Quantity) / DocFactor, 0, 9);
    end;
    }
    textelement(crmlntaxpointdate)
    {
    XmlName = 'TaxPointDate';

    trigger OnBeforePassVariable()
    begin
        //ELSE
        //  CrMLnTaxPointDate := FORMAT("Sales Cr.Memo Line"."Shipment Date",0,9); // PT0001
        IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN CrMLnTaxPointDate:=FORMAT(SalesCrMemoHeader."Posting Date", 0, 9)
        ELSE IF "Sales Cr.Memo Line"."Shipment Date" <> 0D THEN CrMLnTaxPointDate:=FORMAT("Sales Cr.Memo Line"."Shipment Date", 0, 9)
            ELSE
                CrMLnTaxPointDate:=FORMAT(SalesCrMemoHeader."Document Date", 0, 9);
    end;
    }
    textelement(crmlndescription)
    {
    XmlName = 'Description';

    trigger OnBeforePassVariable()
    begin
        IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN CrMLnDescription:='0'
        ELSE IF "Sales Cr.Memo Line".Description = '' THEN CrMLnDescription:=CrmLnProductDescription
            ELSE
                CrMLnDescription:="Sales Cr.Memo Line".Description;
    end;
    }
    textelement(crmdebitamount)
    {
    XmlName = 'DebitAmount';

    trigger OnBeforePassVariable()
    begin
        //EX-SGG 181218 COMENTO.
        /*
                                    CrMDebitAmount := FORMAT(ROUND("Sales Cr.Memo Line".Amount / DocFactor,0.01),0,
                                      '<Precision,2:2><Standard Format,9>');
                                    */
        IF CrMDebitAmount = '0' THEN currXMLport.Skip(); //EX-SGG 191218
    end;
    }
    textelement(crmcreditamount)
    {
    XmlName = 'CreditAmount';

    trigger OnBeforePassVariable()
    begin
        IF CrMCreditAmount = '0' THEN currXMLport.Skip(); //EX-SGG 191218
    end;
    }
    textelement(crmtax)
    {
    XmlName = 'Tax';

    textelement(crmtaxtype)
    {
    XmlName = 'TaxType';

    trigger OnBeforePassVariable()
    begin
        CrMTaxType:='IVA';
    end;
    }
    textelement(crtaxcountryregionn)
    {
    XmlName = 'TaxCountryRegion';

    trigger OnBeforePassVariable()
    begin
        //<INF.P03
        Pais.GET(CompanyInfo."Country/Region Code");
        CrTaxCountryRegionn:=Pais."EU Country/Region Code"; //CompanyInfo."Country Code";
    //INF.P03>
    end;
    }
    textelement(crmtaxcode)
    {
    XmlName = 'TaxCode';

    trigger OnBeforePassVariable()
    begin
        IF "Sales Cr.Memo Line"."VAT Bus. Posting Group" + "Sales Cr.Memo Line"."VAT Prod. Posting Group" <> '' THEN CrMTaxCode:=GetTaxType("Sales Cr.Memo Line"."VAT Bus. Posting Group", "Sales Cr.Memo Line"."VAT Prod. Posting Group", FALSE)
        ELSE
            CrMTaxCode:='OUT' end;
    }
    textelement(salecrmemo_taxpercentage)
    {
    XmlName = 'TaxPercentage';

    trigger OnBeforePassVariable()
    begin
        SaleCrMemo_TaxPercentage:=FORMAT("Sales Cr.Memo Line"."VAT %", 0, 9);
    end;
    }
    }
    textelement(crtaxexemptionreason)
    {
    MaxOccurs = Once;
    MinOccurs = Zero;
    XmlName = 'TaxExemptionReason';

    trigger OnBeforePassVariable()
    begin
        CrTaxExemptionReason:=GetTaxExemptionReason("Sales Cr.Memo Line"."VAT Bus. Posting Group", "Sales Cr.Memo Line"."VAT Prod. Posting Group");
        IF(CrTaxExemptionReason = '') OR ("Sales Cr.Memo Line"."VAT %" <> 0)THEN //CrTaxExemptionReason := '0';
 CrTaxExemptionReason:='';
        if CrTaxExemptionReason = '' then currXMLport.Skip();
    end;
    }
    textelement(salescrtaxexemptioncode)
    {
    XmlName = 'TaxExemptionCode';

    trigger OnBeforePassVariable()
    begin
        //EX-SGG 280518
        SalesCrTaxExemptionCode:=GetTaxExemptionCode("Sales Cr.Memo Line"."VAT Bus. Posting Group", "Sales Cr.Memo Line"."VAT Prod. Posting Group");
        IF(SalesCrTaxExemptionCode = '') OR ("Sales Cr.Memo Line"."VAT %" <> 0)THEN SalesCrTaxExemptionCode:='';
        if SalesCrTaxExemptionCode = '' then currXMLport.Skip();
    end;
    }
    textelement(crmsettlementamount)
    {
    XmlName = 'SettlementAmount';

    trigger OnBeforePassVariable()
    begin
        CrMSettlementAmount:=FORMAT(ROUND((("Sales Cr.Memo Line"."Line Discount Amount" + "Sales Cr.Memo Line"."Inv. Discount Amount") / DocFactor), 0.01), 0, 9);
        CrMSettlementAmount:='0'; //INF.P08
    end;
    }
    trigger OnAfterGetRecord()
    begin
        LineNo+=1;
        FormatearImporte(CrMDebitAmount, CrMCreditAmount, -"Sales Cr.Memo Line".Amount); //EX-SGG 181218
    end;
    trigger OnPreXmlItem()
    begin
        "Sales Cr.Memo Line".Reset();
        "Sales Cr.Memo Line".SETRANGE("Document No.", SalesCrMemoHeader."No.");
        "Sales Cr.Memo Line".SETFILTER(Type, '<>%1', "Sales Cr.Memo Line".Type::" ");
        "Sales Cr.Memo Line".SETFILTER("No.", '<>%1', '');
        LineNo:=0;
    end;
    }
    textelement(crmdocumenttotals)
    {
    XmlName = 'DocumentTotals';

    textelement(crmtaxpayable)
    {
    XmlName = 'TaxPayable';

    trigger OnBeforePassVariable()
    begin
        CrmTaxPayable:=FORMAT(ROUND((SalesCrMemoHeader."Amount Including VAT" - SalesCrMemoHeader.Amount) / DocFactor, 0.01), 0, 9);
    end;
    }
    textelement(crmnettotal)
    {
    XmlName = 'NetTotal';

    trigger OnBeforePassVariable()
    begin
        CrMNetTotal:=FORMAT(ROUND(SalesCrMemoHeader.Amount / DocFactor, 0.01), 0, 9);
    end;
    }
    textelement(crmgrosstotal)
    {
    XmlName = 'GrossTotal';

    trigger OnBeforePassVariable()
    begin
        CrMGrossTotal:=FORMAT(ROUND(SalesCrMemoHeader."Amount Including VAT" / DocFactor, 0.01), 0, 9);
    end;
    }
    tableelement(currency_salescrmemo;
    Currency)
    {
    LinkFields = "Code"=FIELD("Currency Code");
    LinkTable = SalesCrMemoHeader;
    MinOccurs = Zero;
    XmlName = 'Currency';

    fieldelement(CurrencyCode;
    Currency_SalesCrMemo.Code)
    {
    }
    textelement(salescrmemocurrdebitamt)
    {
    XmlName = 'CurrencyDebitAmount';

    trigger OnBeforePassVariable()
    begin
        SalesCrMemoHeader.CALCFIELDS("Amount Including VAT");
        SalesCrMemoCurrDebitAmt:=FORMAT(SalesCrMemoHeader."Amount Including VAT" * SalesCrMemoHeader."Currency Factor", 0, 9);
    end;
    }
    }
    tableelement(salescrmemointeger;
    Integer)
    {
    MinOccurs = Zero;
    XmlName = 'Settlement';
    SourceTableView = WHERE(Number=CONST(0));

    textelement(salescrmemosettlementdisc)
    {
    XmlName = 'SettlementDiscount';

    trigger OnBeforePassVariable()
    begin
        SalesCrMemoHeader.CALCFIELDS(Amount);
        GetSettlement(SalesCrMemoSettlementDisc, SalesCrMemoSettlementAmt, SalesCrMemoSettlementDate, SalesCrMemoHeader."Payment Discount %", SalesCrMemoHeader."Pmt. Discount Date", SalesCrMemoHeader."Document Date", SalesCrMemoHeader.Amount, SalesCrMemoHeader."No.", SalesCrMemoHeader."Sell-to Customer No.");
    end;
    }
    textelement(salescrmemosettlementamt)
    {
    XmlName = 'SettlementAmount';
    }
    textelement(salescrmemosettlementdate)
    {
    XmlName = 'SettlementDate';
    }
    trigger OnPreXmlItem()
    begin
        IF SalesCrMemoHeader."Payment Discount %" <> 0 THEN SalesCrMemoInteger.SETRANGE(Number, 1, 1)
        ELSE
            currXMLport.Break();
    end;
    }
    }
    trigger OnAfterGetRecord()
    begin
        SalesCrMemoHeader.CALCFIELDS(Amount, "Amount Including VAT");
        Window.UPDATE(2, SalesCrMemoHeader."No.");
        IF SalesCrMemoHeader."Currency Code" <> '' THEN DocFactor:=SalesCrMemoHeader."Currency Factor"
        ELSE
            DocFactor:=1;
    end;
    trigger OnPreXmlItem()
    begin
        SalesCrMemoHeader.SETRANGE("Posting Date", StartDate3, EndDate2);
        Window.UPDATE(1, Text1110010);
    end;
    }
    }
    trigger OnBeforePassVariable()
    begin
        IF TotalDocs = 0 THEN currXMLport.Break()end;
    }
    trigger OnAfterAssignVariable()
    begin
    //xmlns := 'urn:OECD:StandardAuditFile-Tax:PT_1.04_01';
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
    trigger OnInitXmlPort()
    begin
        CompanyInfo.Get();
        DeletedDocSourceCode:=GetDeleteDocumentSourceCode;
    end;
    trigger OnPostXmlPort()
    begin
        Window.Close();
    end;
    trigger OnPreXmlPort()
    begin
        Window.OPEN(Text1110000 + '\\' + Text1110001);
    end;
    var CompanyInfo: Record 79;
    Period: Record 50;
    BillToCust: Record 18;
    PayToVendor: Record 23;
    VATSetupBuffer: Record 325 temporary;
    VATSetup: Record 325;
    GLReg: Record 45;
    GLEntry: Record 17;
    SourceCode: Record 230;
    SalesInvoice: Record 112;
    SalesCrMemo: Record 114;
    Item: Record 27;
    Resource: Record 156;
    ItemCharge: Record 5800;
    TempGLEntry: Record 17 temporary;
    TempGLEntry2: Record 17 temporary;
    PaymentMethod: Record 289;
    AppManagement: Codeunit "Application System Constants";
    DeletedDocSourceCode: Code[10];
    StartDate2: Date;
    StartDate3: Date;
    EndDate2: Date;
    EndFiscalDate2: Date;
    FiscalYear2: Integer;
    LineNo: Integer;
    TotalDebitEntries: Decimal;
    TotalCreditEntries: Decimal;
    TotalDebitDocs: Decimal;
    TotalCreditDocs: Decimal;
    TotalEntries: Integer;
    TotalDocs: Integer;
    DocFactor: Decimal;
    CheckOpenEntries: Decimal;
    Window: Dialog;
    SourceCodeSetup: Record 242;
    TempGLReg: Record 45 temporary;
    NoOfTransactions: Integer;
    RevisaFactura: Record 112;
    RevisaAbono: Record 114;
    Pais: Record 9;
    Text1110000: Label 'Block: #1##############';
    Text1110001: Label 'Record: #2##########################';
    Text1110002: Label 'Header';
    Text1110003: Label 'General Ledger';
    Text1110004: Label 'Customer';
    Text1110005: Label 'Items';
    Text1110006: Label 'Resources';
    Text1110007: Label 'Tax Table Entry';
    Text1110008: Label 'G/L Entries';
    Text1110009: Label 'Invoices';
    Text1110010: Label 'Credit Memos';
    Text1110011: Label 'Please define the first accounting period for next fiscal year.';
    Text1110012: Label 'Item Charges';
    Text000: Label 'Pmt. Dsc. %1% at %2 days';
    TextTag: Label '<TaxExemptionReason xmlns="urn:OECD:StandardAuditFile-Tax:PT_1.03_01"/>';
    //[Scope('Internal')]
    procedure SetData(EndDate: Date; StartDate: Date)
    var
        GLEntry2: Record 17;
        TempGLEntry3: Record 17 temporary;
    begin
        Period.Reset();
        Period.SETRANGE("New Fiscal Year", TRUE);
        Period.SETFILTER("Starting Date", '<=%1', EndDate);
        Period.FindLast();
        StartDate2:=Period."Starting Date";
        FiscalYear2:=DATE2DMY(StartDate2, 3);
        IF DATE2DMY(StartDate2, 2) <> 1 THEN FiscalYear2+=1;
        Period.SETFILTER("Starting Date", '>%1', EndDate);
        IF NOT Period.FindFirst()then;
        //ERROR(Text1110011);
        EndFiscalDate2:=CALCDATE('<-1D>', Period."Starting Date");
        EndDate2:=EndDate;
        StartDate3:=StartDate;
        GetVATSetup;
        // G/L Entries
        GLEntry.Reset();
        //>>INF.001
        //GLEntry.SETCURRENTKEY("G/L Account No.","Posting Date","Acc: cash-flow code");
        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
        //<<INF.001
        GLEntry.SETFILTER("Posting Date", '%1..%2', StartDate3, CLOSINGDATE(EndDate2));
        GLEntry.SETRANGE("Entry No.", -1); //INF.P02
        GLEntry.CALCSUMS(GLEntry."Debit Amount", GLEntry."Credit Amount");
        TotalDebitEntries+=GLEntry."Debit Amount";
        TotalCreditEntries+=GLEntry."Credit Amount";
        TotalEntries+=GLEntry.COUNT;
        GLEntry.Reset();
        // No. of transactions
        GetOpenGLRegister;
        TempGLEntry3.DeleteAll();
        IF SourceCode.FindSet()then REPEAT IF CheckGLReg THEN REPEAT CalcNoOfTransactions(TempGLReg."From Entry No.", TempGLReg."To Entry No.", TempGLEntry3);
                    UNTIL TempGLReg.Next() = 0;
            UNTIL SourceCode.Next() = 0;
        IF CheckGLRegBlankSourceCode THEN REPEAT CalcNoOfTransactions(TempGLReg."From Entry No.", TempGLReg."To Entry No.", TempGLEntry3);
            UNTIL TempGLReg.Next() = 0;
        // Sales Invoice Docs
        SalesInvoice.Reset();
        SalesInvoice.SETFILTER("Posting Date", '%1..%2', StartDate3, EndDate2);
        TotalDocs+=SalesInvoice.COUNT;
        IF SalesInvoice.FindFirst()then REPEAT //SalesInvoice.CALCFIELDS("Amount Including VAT");
 SalesInvoice.CALCFIELDS(Amount);
                IF SalesInvoice."Currency Code" <> '' THEN //TotalCreditDocs += ROUND(SalesInvoice."Amount Including VAT" / SalesInvoice."Currency Factor",0.01)
 TotalCreditDocs+=ROUND(SalesInvoice.Amount / SalesInvoice."Currency Factor", 0.01)
                ELSE
                    //TotalCreditDocs += SalesInvoice."Amount Including VAT";
                    TotalCreditDocs+=SalesInvoice.Amount;
            UNTIL SalesInvoice.Next() = 0;
        SalesInvoice.Reset();
        //>>INF.P01
        //ServiceInvoice.Reset();
        //ServiceInvoice.SETFILTER("Posting Date",'%1..%2',StartDate3,EndDate2);
        //TotalDocs += ServiceInvoice.COUNT;
        //IF ServiceInvoice.FindFirst() then
        //  REPEAT
        //    //ServiceInvoice.CALCFIELDS("Amount Including VAT");
        //    ServiceInvoice.CALCFIELDS(Amount);
        //    IF ServiceInvoice."Currency Code" <> '' THEN
        //      //TotalCreditDocs += ROUND(ServiceInvoice."Amount Including VAT" / ServiceInvoice."Currency Factor",0.01)
        //      TotalCreditDocs += ROUND(ServiceInvoice.Amount / ServiceInvoice."Currency Factor",0.01)
        //    ELSE
        //      //TotalCreditDocs += ServiceInvoice."Amount Including VAT";
        //      TotalCreditDocs += ServiceInvoice.Amount;
        //  UNTIL ServiceInvoice.Next() = 0;
        //ServiceInvoice.Reset();
        //<<INF.P01
        // Sales Cr. Memo Docs
        SalesCrMemo.Reset();
        SalesCrMemo.SETFILTER("Posting Date", '%1..%2', StartDate3, EndDate2);
        TotalDocs+=SalesCrMemo.COUNT;
        IF SalesCrMemo.FindFirst()then REPEAT //SalesCrMemo.CALCFIELDS("Amount Including VAT");
 SalesCrMemo.CALCFIELDS(Amount);
                IF SalesCrMemo."Currency Code" <> '' THEN //TotalDebitDocs += ROUND(SalesCrMemo."Amount Including VAT" / SalesCrMemo."Currency Factor",0.01)
 TotalDebitDocs+=ROUND(SalesCrMemo.Amount / SalesCrMemo."Currency Factor", 0.01)
                ELSE
                    //TotalDebitDocs += SalesCrMemo."Amount Including VAT";
                    TotalDebitDocs+=SalesCrMemo.Amount;
            UNTIL SalesCrMemo.Next() = 0;
        SalesCrMemo.Reset();
    //>>INF.P01
    //ServiceCrMemo.Reset();
    //ServiceCrMemo.SETFILTER("Posting Date",'%1..%2',StartDate3,EndDate2);
    //TotalDocs += ServiceCrMemo.COUNT;
    //IF ServiceCrMemo.FindFirst() then
    //  REPEAT
    //    //ServiceCrMemo.CALCFIELDS("Amount Including VAT");
    //    ServiceCrMemo.CALCFIELDS(Amount);
    //    IF ServiceCrMemo."Currency Code" <> '' THEN
    //      //TotalDebitDocs += ROUND(ServiceCrMemo."Amount Including VAT" / ServiceCrMemo."Currency Factor",0.01)
    //      TotalDebitDocs += ROUND(ServiceCrMemo.Amount / ServiceCrMemo."Currency Factor",0.01)
    //    ELSE
    //      //TotalDebitDocs += ServiceCrMemo."Amount Including VAT";
    //      TotalDebitDocs += ServiceCrMemo.Amount;
    //  UNTIL ServiceCrMemo.Next() = 0;
    //ServiceCrMemo.Reset();
    //<<INF.P01
    end;
    //[Scope('Internal')]
    procedure GetVATSetup()
    var
        VATDesc: Integer;
    begin
        VATDesc:=99;
        //      VATSetupBuffer2.Init();
        //      VATSetupBuffer2.TRANSFERFIELDS(VATSetup);
        //      VATSetupBuffer2.Insert();
        //    END;
        //      VATDesc := VATSetup."SAF-T PT VAT Type Descr. PT";
        //      VATSetupBuffer1.Init();
        //      VATSetupBuffer1.TRANSFERFIELDS(VATSetup);
        //      VATSetupBuffer1.Insert();
        //    END;
        //  UNTIL VATSetup.Next() = 0;
        VATSetup.SETCURRENTKEY("SAF-T PT VAT Type Descr. PT", "SAF-T PT VAT Code PT");
        IF VATSetup.FindFirst()then REPEAT VATSetupBuffer.Reset();
                VATSetupBuffer.SETCURRENTKEY("SAF-T PT VAT Type Descr. PT", "SAF-T PT VAT Code PT");
                VATSetupBuffer.SETRANGE("SAF-T PT VAT Type Descr. PT", VATSetup."SAF-T PT VAT Type Descr. PT");
                VATSetupBuffer.SETRANGE("SAF-T PT VAT Code PT", VATSetup."SAF-T PT VAT Code PT");
                VATSetupBuffer.SETRANGE("VAT %", VATSetup."VAT %");
                IF((VATSetup."SAF-T PT VAT Type Descr. PT" <> 0) OR (VATSetup."SAF-T PT VAT Code PT" <> 0)) AND NOT VATSetupBuffer.FindFirst()THEN BEGIN
                    VATSetupBuffer.Init();
                    VATSetupBuffer.TRANSFERFIELDS(VATSetup);
                    VATSetupBuffer.Insert();
                END;
            UNTIL VATSetup.Next() = 0;
    end;
    //[Scope('Internal')]
    procedure GetPeriod(GDate: Date): Integer begin
        IF GDate = CLOSINGDATE(EndFiscalDate2)THEN EXIT(13);
        IF DATE2DMY(GDate, 2) >= DATE2DMY(StartDate2, 2)THEN EXIT(DATE2DMY(GDate, 2) - DATE2DMY(StartDate2, 2) + 1)
        ELSE
            EXIT(DATE2DMY(GDate, 2) + 12 - DATE2DMY(StartDate2, 2) + 1);
    end;
    //[Scope('Internal')]
    procedure GetEntryDocDateTime(Invoice: Boolean; DocNo: Code[20]; DocCustNo: Code[20]): Text[19]var
        CustLedgEntry: Record 21;
        GLReg: Record 45;
    begin
        CustLedgEntry.Reset();
        CustLedgEntry.SETCURRENTKEY("Document No.");
        CustLedgEntry.SETRANGE("Document No.", DocNo);
        IF Invoice THEN CustLedgEntry.SETRANGE("Document Type", 2)
        ELSE
            CustLedgEntry.SETRANGE("Document Type", 3);
        CustLedgEntry.SETRANGE("Customer No.", DocCustNo);
        IF CustLedgEntry.FindFirst()then;
        GLReg.Reset();
        GLReg.SETFILTER("From Entry No.", '<=%1', CustLedgEntry."Entry No.");
        GLReg.SETFILTER("To Entry No.", '>=%1', CustLedgEntry."Entry No.");
        IF GLReg.FindFirst()then;
        EXIT(FormatDateTime(GLReg."Creation Date", GLReg."Creation Time"));
    end;
    //[Scope('Internal')]
    procedure GetTaxType(BussGroup: Code[10]; ProdGroup: Code[10]; Description: Boolean): Text[30]begin
        VATSetup.GET(BussGroup, ProdGroup);
        IF Description THEN EXIT(GetSAFTVatTypeDescription(VATSetup."SAF-T PT VAT Type Descr. PT"))
        ELSE
            EXIT(GetSAFTVatCode(VATSetup."SAF-T PT VAT Code PT"));
    end;
    //[Scope('Internal')]
    procedure GetCountry(CountryCode: Code[10]; CheckEU: Boolean): Text[30]var
        Country: Record 9;
    begin
        IF Country.GET(CountryCode)THEN EXIT(Country."ISO Code")
        ELSE
            EXIT('PT');
    end;
    //[Scope('Internal')]
    procedure GetSAFTVatTypeDescription(SAFTVatTypeDesc: Option " ", "VAT Portugal Mainland", "VAT Madeira", "VAT Azores", "VAT European Union", "VAT Exportation"): Text[30]begin
        CASE SAFTVatTypeDesc OF SAFTVatTypeDesc::"VAT Portugal Mainland": EXIT('IVACON');
        SAFTVatTypeDesc::"VAT Madeira": EXIT('IVARAM');
        SAFTVatTypeDesc::"VAT Azores": EXIT('IVARAA');
        SAFTVatTypeDesc::"VAT European Union": EXIT('IVAUE');
        SAFTVatTypeDesc::"VAT Exportation": EXIT('IVAEXPORT');
        END end;
    //[Scope('Internal')]
    procedure GetSAFTVatCode(GetSAFTVatCode: Option " ", "Intermediate tax rate", "Normal tax rate", "Reduced tax rate", "No tax rate", Others): Text[30]begin
        CASE GetSAFTVatCode OF GetSAFTVatCode::"Intermediate tax rate": EXIT('INT');
        GetSAFTVatCode::"Normal tax rate": EXIT('NOR');
        GetSAFTVatCode::"Reduced tax rate": EXIT('RED');
        GetSAFTVatCode::"No tax rate": EXIT('ISE');
        GetSAFTVatCode::Others: EXIT('OUT');
        END;
    end;
    //[Scope('Internal')]
    procedure GetDeleteDocumentSourceCode(): Code[10]begin
        SourceCodeSetup.Get();
        SourceCodeSetup.TESTFIELD("Deleted Document");
        EXIT(SourceCodeSetup."Deleted Document");
    end;
    //[Scope('Internal')]
    procedure GetOpenGLRegister()
    var
        GLReg: Record 45;
    begin
        TempGLReg.Reset();
        TempGLReg.DeleteAll();
        GLEntry.SETFILTER("Posting Date", '%1..%2', StartDate3, CLOSINGDATE(EndDate2));
        GLEntry.SETRANGE("Entry No.", -1); //INF.P02
        IF GLEntry.FindSet()then REPEAT GLReg.Reset();
                GLReg.SETFILTER("From Entry No.", '<=%1', GLEntry."Entry No.");
                GLReg.SETFILTER("To Entry No.", '>=%1', GLEntry."Entry No.");
                IF GLReg.FindFirst()then BEGIN
                    TempGLReg.SETRANGE(TempGLReg."No.", GLReg."No."); //"Period Trans. No.", GLReg."Period Trans. No.");
                    IF NOT TempGLReg.FindFirst()then BEGIN
                        TempGLReg:=GLReg;
                        TempGLReg.Insert();
                    END;
                END;
            UNTIL GLEntry.Next() = 0;
    end;
    //[Scope('Internal')]
    procedure GetGLEntries()
    var
        GLEntry3: Record 17;
    begin
        GLEntry3.Reset();
        GLEntry3.SETRANGE("Entry No.", TempGLReg."From Entry No.", TempGLReg."To Entry No.");
        IF GLEntry3.FindSet()then REPEAT TempGLEntry.Reset();
                TempGLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                TempGLEntry.SETRANGE("Document No.", GLEntry3."Document No.");
                TempGLEntry.SETRANGE("Posting Date", GLEntry3."Posting Date");
                IF NOT TempGLEntry.FindFirst()then InsertIntoTempGLEntry(GLEntry3);
                TempGLEntry2.Init();
                TempGLEntry2.TRANSFERFIELDS(GLEntry3);
                TempGLEntry2.Insert();
            UNTIL GLEntry3.Next() = 0;
    end;
    //[Scope('Internal')]
    procedure InsertIntoTempGLEntry(GLEntry: Record 17)
    begin
        TempGLEntry.Init();
        TempGLEntry.TRANSFERFIELDS(GLEntry);
        TempGLEntry.Insert();
    end;
    //[Scope('Internal')]
    procedure GetSupCustID(SourceType: Option " ", Customer, Vendor, "Bank Account", "Fixed Asset")
    begin
    /*
        EntriesSupplierID := '';
        EntriesCustomerID := '';
        WITH TempGLEntry2 DO BEGIN
          RESET;
          SETCURRENTKEY("Document No.","Posting Date");
          SETRANGE("Document No.",TempGLEntry."Document No.");
          SETRANGE("Posting Date",TempGLEntry."Posting Date");
          SETRANGE("Source Type",SourceType);
          IF FINDFIRST THEN
            IF SourceType = SourceType::Vendor THEN
              EntriesSupplierID := "Source No."
            ELSE
              EntriesCustomerID := "Source No.";
        END;
        */
    end;
    //[Scope('Internal')]
    procedure GetTaxExemptionReason(VatBusGroup: Code[10]; VatProdGroup: Code[10]): Text[60]begin
        IF VATSetup.GET(VatBusGroup, VatProdGroup)THEN EXIT(VATSetup."Exempt Legal Precept PT");
    end;
    //[Scope('Internal')]
    procedure GetGLentryCreationDateTime(EntryNo: Integer): Text[19]var
        GLReg2: Record 45;
    begin
        GLReg2.Reset();
        GLReg2.SETFILTER("From Entry No.", '<=%1', EntryNo);
        GLReg2.SETFILTER("To Entry No.", '>=%1', EntryNo);
        IF GLReg2.FindFirst()then;
        EXIT(FormatDateTime(GLReg2."Creation Date", GLReg2."Creation Time"));
    end;
    //[Scope('Internal')]
    procedure CheckGLReg(): Boolean begin
        TempGLReg.Reset();
        TempGLReg.SETFILTER("Posting Date", '%1..%2', StartDate3, CLOSINGDATE(EndDate2));
        TempGLReg.SETRANGE("Source Code", SourceCode.Code);
        EXIT(TempGLReg.FINDFIRST);
    end;
    //[Scope('Internal')]
    procedure ClearTempRec()
    begin
        TempGLEntry.Reset();
        TempGLEntry2.Reset();
        TempGLEntry2.DeleteAll();
        TempGLEntry.DeleteAll();
    end;
    //[Scope('Internal')]
    procedure ApplyFilters()
    begin
        TempGLEntry2.Reset();
        TempGLEntry2.SETCURRENTKEY("Document No.", "Posting Date");
        TempGLEntry2.SETRANGE("Document No.", TempGLEntry."Document No.");
        TempGLEntry2.SETRANGE("Posting Date", TempGLEntry."Posting Date");
    end;
    //[Scope('Internal')]
    procedure GetDocumentType(Invoice: Boolean): Text[4]begin
        IF Invoice THEN EXIT('FAC ');
        EXIT('NCR ')end;
    procedure ModifyNameSpaceOnPrem(FileName: Text[250])
    var
        XMLDOMMgmt: Codeunit "XML DOM Management";
        xmlDoc: XmlDocument;
        xmlDec: XmlDeclaration;
        xmlElem: XmlElement;
        xmlElem2: XmlElement;
        TempBlob: Codeunit "Temp Blob";
        outStr: OutStream;
        inStr: InStream;
        TempFile: File;
    begin
    end;
    //[Scope('Internal')]
    /* Obseleto evaluar si se necesita
    procedure ModifyNameSpace(FileName: Text[250])
    var
        XMLDOMMgmt: Codeunit "XML DOM Management";
        XMLDOM: Automation;
        XMLRootNode: Automation;
        XMLDOM2: DotNet XmlDocument;
        XMLRootNode2: DotNet XmlNode;
    begin
        IF ISCLEAR(XMLDOM) THEN
            CREATE(XMLDOM, FALSE, TRUE);
        XMLDOMMgmt.SetNormalCase;
        IF XMLDOM.load(FileName) THEN BEGIN
            XMLRootNode := XMLDOM.documentElement;
            XMLDOMMgmt.AddAttribute(XMLRootNode, 'xmlns', 'urn:OECD:StandardAuditFile-Tax:PT_1.04_01');
            XMLDOMMgmt.AddAttribute(XMLRootNode, 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
            XMLDOM.save(FileName);
        END;
        ClearDefaultNameSpace(FileName);
        /*
        //XMLDOM2.CreateElement(''); ///XXXXXXXXXXXXX
        XMLDOM2.XmlDocument := XMLDOM2.XmlDocument();
        
        XMLDOM2.Load(FileName);
        XMLRootNode2 := XMLDOM2.DocumentElement;
        XMLDOMMgmt.AddAttribute(XMLRootNode2,'xmlns','urn:OECD:StandardAuditFile-Tax:PT_1.01_01');
        XMLDOMMgmt.AddAttribute(XMLRootNode2,'xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
        XMLDOM2.Save(FileName);
        
        ClearDefaultNameSpace(FileName);
        */
    //end;
    //[Scope('Internal')]
    /* Obsoleto ver si es necesario
    procedure ClearDefaultNameSpace(FileName: Text[250])
    var
        XMLFile: File;
        XMLFile2: File;
        SpaceChar: Char;
        LineText: Text[1024];
        TempFileName: Text[250];
        DefaultNameSpace: Text[250];
        DefaultNameSpacePos: Integer;
        SpaceCharPos: Integer;
    begin
        DefaultNameSpace := 'urn:OECD:StandardAuditFile-Tax:PT_1.01_01';
        SpaceChar := 32;
        XMLFile.TEXTMODE(TRUE);
        XMLFile.WRITEMODE(TRUE);
        XMLFile.OPEN(FileName);
        XMLFile2.TEXTMODE(TRUE);
        XMLFile2.WRITEMODE(TRUE);
        //>>INF.P01
        //TempFileName := TierMgt.ServerTempFileName('','.xml');
        TempFileName := ServerTempFileName('', '.xml');
        //<<INF.P01
        XMLFile2.CREATE(TempFileName);
        REPEAT
            XMLFile.READ(LineText);
            DefaultNameSpacePos := STRPOS(LineText, DefaultNameSpace);
            IF DefaultNameSpacePos <> 0 THEN BEGIN
                SpaceCharPos := STRPOS(LineText, FORMAT(SpaceChar));
                LineText := DELSTR(LineText, SpaceCharPos, DefaultNameSpacePos - SpaceCharPos + STRLEN(DefaultNameSpace) + 1);
            END;
            XMLFile2.WRITE(LineText);
        UNTIL XMLFile.POS = XMLFile.LEN;
        FileName := TempFileName;
    end;    */
    local procedure FormatDateTime(DateParam: Date; TimeParam: Time): Text[19]begin
        IF TimeParam = 0T THEN TimeParam:=000000T;
        EXIT(FORMAT(DateParam, 0, 9) + 'T' + FORMAT(TimeParam, 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>'));
    end;
    local procedure CalcNoOfTransactions(FromEntryNo: Integer; ToEntryNo: Integer; var TempGLEntry: Record 17)
    var
        GLEntry: Record 17;
    begin
        GLEntry.Reset();
        GLEntry.SETRANGE("Entry No.", TempGLReg."From Entry No.", TempGLReg."To Entry No.");
        IF GLEntry.FindSet()then REPEAT TempGLEntry.Reset();
                TempGLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                TempGLEntry.SETRANGE("Document No.", GLEntry."Document No.");
                TempGLEntry.SETRANGE("Posting Date", GLEntry."Posting Date");
                TempGLEntry.SETRANGE("Source Code", GLEntry."Source Code");
                IF NOT TempGLEntry.FindFirst()then BEGIN
                    NoOfTransactions+=1;
                    TempGLEntry.Init();
                    TempGLEntry.TRANSFERFIELDS(GLEntry);
                    TempGLEntry.Insert();
                END;
            UNTIL GLEntry.Next() = 0;
    end;
    local procedure CheckGLRegBlankSourceCode(): Boolean begin
        TempGLReg.Reset();
        TempGLReg.SETFILTER("Posting Date", '%1..%2', StartDate3, CLOSINGDATE(EndDate2));
        TempGLReg.SETRANGE("Source Code", '');
        EXIT(TempGLReg.FINDFIRST);
    end;
    //[Scope('Internal')]
    procedure GetAddress(Address: Text[50]; Address2: Text[50]): Text[60]begin
        IF(Address <> '') OR (Address2 <> '')THEN BEGIN
            IF STRLEN(Address + ' ' + Address2) > 60 THEN EXIT(COPYSTR(Address + ' ' + Address2, 1, 60));
            EXIT(Address + ' ' + Address2);
        END;
    end;
    //[Scope('Internal')]
    procedure GetPaymentMechanism(PaymentMethodCode: Option Cash, Check, "Debit Card", "Credit Card", "Bank Transfer", "Restaurant Ticket"): Code[10]begin
        CASE PaymentMethodCode OF PaymentMethodCode::Cash: EXIT('NU');
        PaymentMethodCode::Check: EXIT('CH');
        PaymentMethodCode::"Debit Card": EXIT('CD');
        PaymentMethodCode::"Credit Card": EXIT('CC');
        PaymentMethodCode::"Bank Transfer": EXIT('TB');
        PaymentMethodCode::"Restaurant Ticket": EXIT('TR');
        END;
    end;
    //[Scope('Internal')]
    procedure GetSettlement(var SettlementDisc: Text[30]; var SettlementAmt: Text[30]; var SettlementDate: Text[30]; PaymentDiscount: Decimal; PaymentDiscDate: Date; DocumentDate: Date; Amount: Decimal; DocumentNo: Code[20]; CustomerNo: Code[20])
    var
        CustLedgerEntry: Record 21;
    begin
        IF PaymentDiscount <> 0 THEN BEGIN
            SettlementDisc:=STRSUBSTNO(Text000, PaymentDiscount, PaymentDiscDate - DocumentDate);
            CustLedgerEntry.SETCURRENTKEY("Document Type", "Document No.", "Customer No.");
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Document No.", DocumentNo);
            CustLedgerEntry.SETRANGE("Customer No.", CustomerNo);
            IF CustLedgerEntry.FindFirst()then BEGIN
                IF CustLedgerEntry."Original Pmt. Disc. Possible" <> 0 THEN SettlementAmt:=FORMAT(CustLedgerEntry."Original Pmt. Disc. Possible", 0, 9)
                ELSE
                    SettlementAmt:=FORMAT(CustLedgerEntry."Pmt. Disc. Given (LCY)", 0, 9);
            END;
            SettlementDate:=FORMAT(PaymentDiscDate, 0, 9);
        END
        ELSE
        BEGIN
            SettlementDisc:='';
            SettlementAmt:='';
            SettlementDate:='';
        END;
    end;
    //[Scope('Internal')]
    procedure CheckAddressDetails(Address: Text[50]; Address2: Text[50]; City: Text[30]; PostalCode: Code[20]; CountryRegion: Code[10]): Boolean begin
        IF Address <> '' THEN EXIT(TRUE);
        IF Address2 <> '' THEN EXIT(TRUE);
        IF City <> '' THEN EXIT(TRUE);
        IF PostalCode <> '' THEN EXIT(TRUE);
        IF CountryRegion <> '' THEN EXIT(TRUE);
        EXIT(FALSE);
    end;
    //[Scope('Internal')]
    procedure ">> INF.001 fun"()
    begin
    end;
    //[Scope('Internal')]
    /* Obsoleto ver si es necesario
    procedure ServerTempFileName(PassedString: Text[250]; FileExtension: Text[250]) FileName: Text[1024]
    var
        TempFile: File;
    begin
        TempFile.CREATETEMPFILE;
        FileName := TempFile.NAME + '.' + FileExtension;
        TempFile.Close();
    end;
    */
    //[Scope('Internal')]
    procedure "<< INF.001 fun"()
    begin
    end;
    //[Scope('Internal')]
    procedure FormatCod(parTexto: Text[150]): Text[150]begin
        EXIT(DELCHR(parTexto, '=', '/ABCDEFGHIJKLMNÙOPQRSTUVWXYZabcdefghigklmnÙopqrstuvwxyz-_\|'));
    end;
    //[Scope('Internal')]
    procedure FormatSerie(parTexto: Text[150]): Text[150]begin
        EXIT(DELCHR(parTexto, '=', '/-_\|'));
    end;
    //[Scope('Internal')]
    procedure GetCrMCreationDT(): Text[30]begin
        IF SalesCrMemoHeader."Creation Date" <> 0D THEN EXIT(FormatDateTime(SalesCrMemoHeader."Creation Date", SalesCrMemoHeader."Creation Time"))
        ELSE
        BEGIN
            IF SalesCrMemoHeader."Source Code" = DeletedDocSourceCode THEN EXIT(FormatDateTime(SalesCrMemoHeader."Posting Date", 0T))
            ELSE
            BEGIN
                IF SalesCrMemoHeader."Bill-to Customer No." <> '' THEN EXIT(GetEntryDocDateTime(FALSE, SalesCrMemoHeader."No.", SalesCrMemoHeader."Bill-to Customer No."))
                ELSE
                    EXIT(GetEntryDocDateTime(FALSE, SalesCrMemoHeader."No.", SalesCrMemoHeader."Sell-to Customer No."));
            END;
        END;
    end;
    //[Scope('Internal')]
    procedure GetInvCreationDT(): Text[30]begin
        IF SalesInvoiceHeader."Creation Date" <> 0D THEN EXIT(FormatDateTime(SalesInvoiceHeader."Creation Date", SalesInvoiceHeader."Creation Time"))
        ELSE
        BEGIN
            IF SalesInvoiceHeader."Source Code" = DeletedDocSourceCode THEN EXIT(FormatDateTime(SalesInvoiceHeader."Posting Date", 0T))
            ELSE
            BEGIN
                IF SalesInvoiceHeader."Bill-to Customer No." <> '' THEN EXIT(GetEntryDocDateTime(TRUE, SalesInvoiceHeader."No.", SalesInvoiceHeader."Bill-to Customer No."))
                ELSE
                    EXIT(GetEntryDocDateTime(TRUE, SalesInvoiceHeader."No.", SalesInvoiceHeader."Sell-to Customer No."));
            END;
        END;
    end;
    //[Scope('Internal')]
    procedure GetTaxExemptionCode(VatBusGroup: Code[10]; VatProdGroup: Code[10]): Text[60]begin
        IF VATSetup.GET(VatBusGroup, VatProdGroup)THEN EXIT(VATSetup."SAF-T Exempt Code PT");
    end;
    local procedure "--EX-SGG"()
    begin
    end;
    local procedure FormatearImporte(var lImpDebe: Text; var lImpHaber: Text; lImporte: Decimal)
    begin
        //EX-SGG 181218
        lImpHaber:=FORMAT(0, 0, 9);
        lImpDebe:=FORMAT(0, 0, 9);
        CASE TRUE OF lImporte > 0: lImpHaber:=FORMAT(ROUND(lImporte / DocFactor, 0.01), 0, '<Precision,2:2><Standard Format,9>');
        lImporte < 0: lImpDebe:=FORMAT(ROUND(-lImporte / DocFactor, 0.01), 0, '<Precision,2:2><Standard Format,9>');
        END;
        IF lImporte = 0 THEN lImpDebe:=FORMAT(ROUND(0, 0.01), 0, '<Precision,2:2><Standard Format,9>');
    end;
}
