report 52029 "Confirming La Caixa"
{
    // -999 jmenendez 30/11/2017 Adapto el confirming
    // -001 mleon     26/03/2018 Correcciones Confirming
    //                09/04/2018 Añadir Registro 019
    //                03/05/2018 Modificar el envío de Document No. a Documento externo.
    Caption = 'Confirming La Caixa';
    Permissions = TableData "Payment Order"=m;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Payment Order"; "Payment Order")
        {
            RequestFilterFields = "No.";

            dataitem("Cartera Doc."; "Cartera Doc.")
            {
                DataItemLink = "Bill Gr./Pmt. Order No."=FIELD("No.");
                DataItemTableView = SORTING(Type, "Bill Gr./Pmt. Order No.", "Category Code", "Currency Code", "Accepted", "Due Date")ORDER(Ascending)WHERE(Type=CONST(Payable));

                trigger OnAfterGetRecord()
                begin
                    TESTFIELD("Payment Method Code");
                    DocType2:=DocMisc.DocType2("Payment Method Code");
                    TESTFIELD("Account No.");
                    Vendor.GET("Account No.");
                    //-001
                    Vendor.TESTFIELD("E-Mail");
                    CALCFIELDS("Documento Externo");
                    //+001
                    VATRegVend:=Vendor."VAT Registration No.";
                    VATRegVend:=PADSTR('', MAXSTRLEN(VATRegVend) - STRLEN(VATRegVend), ' ') + VATRegVend;
                    RmgAmount:=PADSTR('', MAXSTRLEN(RmgAmount) - STRLEN(RmgAmount), '0') + RmgAmount;
                    CLEAR(txtProveedorNoResidente);
                    IF(Vendor."Country/Region Code" = '') OR (Vendor."Country/Region Code" = 'ES')THEN txtProveedorNoResidente:='N'
                    ELSE
                        txtProveedorNoResidente:='S';
                    CLEAR(txtIndicadorConfirmacion);
                    txtIndicadorConfirmacion:=' ';
                    CLEAR(txtPaisDestino);
                    CLEAR(recPais);
                    IF recPais.GET(Vendor."Country/Region Code")THEN BEGIN
                        txtPaisDestino:=UPPERCASE(recPais.Name);
                        txtPaisDestino:=PADSTR(txtPaisDestino, 9, ' ');
                    END;
                    CLEAR(txtFormaPago);
                    txtFormaPago:='T'; // Los posibles valores son C=Cheque, T=Transferencia
                    CLEAR(txtFechaFactura);
                    IF "Posting Date" = 0D THEN txtFechaFactura:=PADSTR('', 6, '0')
                    ELSE
                        txtFechaFactura:=FORMAT("Posting Date", 0, Text1100002);
                    CLEAR(txtFechaVtoFactura);
                    IF "Due Date" = 0D THEN txtFechaVtoFactura:=PADSTR('', 6, '0')
                    ELSE
                        txtFechaVtoFactura:=FORMAT("Due Date", 0, Text1100002);
                    CLEAR(txtNumeroFactura);
                    //txtNumeroFactura := PADSTR("Document No.",15,' ');
                    //-001
                    txtNumeroFactura:=PADSTR("Documento Externo", 15, ' ');
                    //+001
                    CLEAR(txtTelefonoProveedor);
                    txtTelefonoProveedor:=PADSTR(Vendor."Phone No.", 15, ' ');
                    CLEAR(txtFaxProveedor);
                    txtFaxProveedor:=PADSTR(Vendor."Fax No.", 15, ' ');
                    CASE TRUE OF // es0003.begin
 // LCY = LCY::Peseta:
                    // IF IsEuro THEN BEGIN
                    // TotalAmount := TotalAmount + "Remaining Amount";
                    // RmgAmount := EuroAmount ("Remaining Amount");
                    // END ELSE BEGIN
                    // RmgAmount := FORMAT("Remaining Amt. (LCY)" * 100,12,Text1100000);
                    // TotalAmount := TotalAmount + "Remaining Amount";
                    // END;
                    // es0003.end
                    LCY = LCY::Euro: IF IsEuro THEN BEGIN
                            TotalAmount:=TotalAmount + "Remaining Amount";
                            RmgAmount:=EuroAmount("Remaining Amount");
                        END
                        ELSE
                        BEGIN
                            RmgAmount:=FORMAT("Remaining Amount" * 100, 12, Text1100000);
                            TotalAmount:=TotalAmount + "Remaining Amount";
                        END;
                    LCY = LCY::Other: IF IsEuro THEN BEGIN
                            TotalAmount:=TotalAmount + "Remaining Amount";
                            RmgAmount:=EuroAmount("Remaining Amount");
                        END
                        ELSE
                        BEGIN
                            RmgAmount:=FORMAT("Remaining Amount" * 100, 12, Text1100000);
                            TotalAmount:=TotalAmount + "Remaining Amount" * 100;
                        END;
                    END;
                    IF DocType2 = '4' THEN BEGIN
                        VendBankAccCode:="Cust./Vendor Bank Acc. Code";
                        IF VendBankAcc.GET("Account No.", VendBankAccCode)THEN BEGIN
                            VendCCCAccNo:=VendBankAcc."CCC Bank Account No.";
                            VendCCCControlDigits:=VendBankAcc."CCC Control Digits";
                            Vendor2:=VendBankAcc."CCC Bank No.";
                            VendCCCBankBranchNo:=VendBankAcc."CCC Bank Branch No.";
                        END
                        ELSE
                        BEGIN
                            VendCCCAccNo:='';
                            VendCCCControlDigits:='';
                            Vendor2:='';
                            VendCCCBankBranchNo:='';
                        END;
                    END
                    ELSE
                    BEGIN
                        TESTFIELD("Cust./Vendor Bank Acc. Code");
                        VendBankAccCode:="Cust./Vendor Bank Acc. Code";
                        VendBankAcc.GET("Account No.", VendBankAccCode);
                        VendCCCAccNo:=VendBankAcc."CCC Bank Account No.";
                        VendCCCControlDigits:=VendBankAcc."CCC Control Digits";
                        Vendor2:=VendBankAcc."CCC Bank No.";
                        VendCCCBankBranchNo:=VendBankAcc."CCC Bank Branch No.";
                        /*
                        IF (Vendor2 = '') OR (VendCCCBankBranchNo = '') OR
                           (VendCCCControlDigits = '') OR (VendCCCAccNo = '')
                        THEN
                          ERROR(Text1100003,VendBankAcc."Vendor No.");
                        */
                        IF Vendor2 = '' THEN ERROR(Txt50201, VendBankAcc."Vendor No.", VendBankAcc.FIELDCAPTION("CCC Bank No."));
                        IF VendCCCBankBranchNo = '' THEN ERROR(Txt50201, VendBankAcc."Vendor No.", VendBankAcc.FIELDCAPTION("CCC Bank Branch No."));
                        IF VendCCCControlDigits = '' THEN ERROR(Txt50201, VendBankAcc."Vendor No.", VendBankAcc.FIELDCAPTION("CCC Control Digits"));
                        IF VendCCCAccNo = '' THEN ERROR(Txt50201, VendBankAcc."Vendor No.", VendBankAcc.FIELDCAPTION("CCC Bank Account No."));
                    END;
                    VendCCCAccNo:=PADSTR('', MAXSTRLEN(VendCCCAccNo) - STRLEN(VendCCCAccNo), '0') + VendCCCAccNo;
                    VendCCCControlDigits:=PADSTR('', MAXSTRLEN(VendCCCControlDigits) - STRLEN(VendCCCControlDigits), '0') + VendCCCControlDigits;
                    // ISO destino
                    CLEAR(txtISODestino);
                    txtISODestino:=PADSTR(Vendor."Country/Region Code", 2, ' ');
                    // Digito control IBAN: caracteres 3 y 4 del IBAN.
                    CLEAR(txtDigitoControlIBAN);
                    txtDigitoControlIBAN:=COPYSTR(VendBankAcc.IBAN, 3, 2);
                    txtDigitoControlIBAN:=PADSTR(txtDigitoControlIBAN, 2, ' ');
                    // BBAN
                    CLEAR(txtBBAN);
                    txtBBAN:=COPYSTR(VendBankAcc.IBAN, 5);
                    txtBBAN:=PADSTR(txtBBAN, 30);
                    IF IsEuro THEN IF DocType2 = '4' THEN DocType:='57'
                        ELSE
                        BEGIN
                            DocType:='56';
                            VendBankAcc.TESTFIELD("CCC Bank Account No.");
                        END
                    ELSE IF DocType2 = '4' THEN DocType:='07'
                        ELSE
                        BEGIN
                            DocType:='06';
                            VendBankAcc.TESTFIELD("CCC Bank Account No.");
                        END;
                    // AITNVAF - 27/11/2014 ->
                    // Se establece que la caixa es siempre 56 en Código Operación
                    DocType:='56';
                    // AITNVAF - 27/11/2014 <-
                    // REGISTROS DEL BENEFICIARIO
                    //-001
                    VATRegVend:=DELCHR(VATRegVend, '=', '-');
                    //+001
                    // Tipo de registro 10: OBLIGATORIO
                    CLEAR(OutText);
                    OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '010' + CONVERTSTR(RmgAmount, ' ', '0') + CONVERTSTR(PADSTR(Vendor2, 4, ' '), ' ', '0') + CONVERTSTR(PADSTR(VendCCCBankBranchNo, 4, ' '), ' ', '0') + CONVERTSTR(PADSTR(VendCCCAccNo, 10, ' '), ' ', '0') + '1' + '9' + PADSTR('', 2, ' ') + PADSTR(VendCCCControlDigits, 2, ' ') + txtProveedorNoResidente + txtIndicadorConfirmacion + 'EUR';
                    OutFile.WriteText(OutText);
                    OutFile.WriteText();
                    TotalReg:=TotalReg + 1;
                    TotalDocVend:=TotalDocVend + 1;
                    // Tipo de registro 43: OPCIONAL si el proveedor es residente, OBLIGATORIO si no es residente
                    IF txtProveedorNoResidente = 'S' THEN BEGIN
                        CLEAR(OutText);
                        OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '043' + txtISODestino + txtDigitoControlIBAN + txtBBAN + '7';
                        OutFile.WriteText(OutText);
                        OutFile.WriteText();
                        TotalReg:=TotalReg + 1;
                    END;
                    // Tipo de registro 44: OPCIONAL si el proveedor es residente, OBLIGATORIO si no es residente
                    IF txtProveedorNoResidente = 'S' THEN BEGIN
                        CLEAR(OutText);
                        OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '044' + '1' + txtISODestino + PADSTR('', 6, ' ') + PADSTR(VendBankAcc."SWIFT Code", 12, ' ');
                        OutFile.WriteText(OutText);
                        OutFile.WriteText();
                        TotalReg:=TotalReg + 1;
                    END;
                    // Tipo de registro 11: OBLIGATORIO
                    CLEAR(OutText);
                    OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '011' + UPPERCASE(PADSTR(Vendor.Name, 36, ' ')) + PADSTR('', 7, ' ');
                    OutFile.WriteText(OutText);
                    OutFile.WriteText();
                    TotalReg:=TotalReg + 1;
                    // Tipo de registro 12: OBLIGATORIO
                    CLEAR(OutText);
                    OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '012' + UPPERCASE(PADSTR(Vendor.Address, 36, ' ')) + PADSTR('', 7, ' ');
                    OutFile.WriteText(OutText);
                    OutFile.WriteText();
                    TotalReg:=TotalReg + 1;
                    // Tipo de registro 14: OBLIGATORIO
                    CLEAR(OutText);
                    OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '014' + PADSTR(Vendor."Post Code" + UPPERCASE(Vendor.City), 31, ' ') + PADSTR('', 7, ' ');
                    OutFile.WriteText(OutText);
                    OutFile.WriteText();
                    TotalReg:=TotalReg + 1;
                    // Tipo de registro 15: OPCIONAL si el proveedor es residente, OBLIGATORIO si no es residente
                    IF txtProveedorNoResidente = 'S' THEN BEGIN
                        CLEAR(OutText);
                        OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '015' + //PADSTR(Vendor."No.", 15, ' ') + '  ' + VATRegVend + ' ' +
 PADSTR(Vendor."No.", 15, ' ') + VATRegVend + //EX-RBF 030423
 PADSTR(Vendor."Country/Region Code", 2, ' ') + txtPaisDestino;
                        OutFile.WriteText(OutText);
                        OutFile.WriteText();
                        TotalReg:=TotalReg + 1;
                    END;
                    // Tipo de registro 16: OBLIGATORIO
                    CLEAR(OutText);
                    OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '016' + txtFormaPago + txtFechaFactura + txtNumeroFactura + txtFechaVtoFactura;
                    OutFile.WriteText(OutText);
                    OutFile.WriteText();
                    TotalReg:=TotalReg + 1;
                    // Tipo de registro 18: OPCIONAL si el proveedor es nacional, OBLIGATORIO si es internacional
                    IF txtProveedorNoResidente = 'S' THEN BEGIN
                        CLEAR(OutText);
                        OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '018' + txtTelefonoProveedor + txtFaxProveedor;
                        OutFile.WriteText(OutText);
                        OutFile.WriteText();
                        TotalReg:=TotalReg + 1;
                    END;
                    //-001
                    //Tipo registro 19: OPCIONAL
                    CLEAR(OutText);
                    OutText:='06' + DocType + VATRegNo + FncVacios(12 - STRLEN(VATRegVend)) + VATRegVend + '019' + UPPERCASE(PADSTR(Vendor."E-Mail", 36, ' ')) + PADSTR('', 7, ' ');
                    OutFile.WriteText(OutText);
                    OutFile.WriteText();
                    TotalReg:=TotalReg + 1;
                //+001
                //Tipo registro 019: OPCIONAL
                /*
                    OutText := '06' + DocType + VATRegNo + VATRegVend + '010' + CONVERTSTR(RmgAmount,' ','0') +
                      CONVERTSTR(PADSTR(Vendor2,4,' '),' ','0') + CONVERTSTR(PADSTR(VendCCCBankBranchNo,4,' '),' ','0') +
                      CONVERTSTR(PADSTR(VendCCCAccNo,10,' '),' ','0') +
                      '1' + '9' + PADSTR('',2,' ') + PADSTR(VendCCCControlDigits,2,' ') + PADSTR('',7,' ');
                    OutFile.WriteText(OutText);
                    
                    TotalReg := TotalReg + 1;
                    TotalDocVend := TotalDocVend + 1;
                    
                    OutText := '06' + DocType + VATRegNo + VATRegVend + '011' + PADSTR(Vendor.Name,36,' ')
                      + PADSTR('',7,' ');
                    OutFile.WriteText(OutText);
                    TotalReg := TotalReg + 1;
                    IF (DocType = '06') OR (DocType = '56') THEN BEGIN
                      OutText := '06' + DocType + VATRegNo + VATRegVend + '012' + PADSTR(Vendor.Address,36,' ')
                        + PADSTR('',7,' ');
                      OutFile.WriteText(OutText);
                    
                      TotalReg := TotalReg + 1;
                    
                      IF Vendor."Address 2" <> '' THEN BEGIN
                        OutText := '06' + DocType + VATRegNo + VATRegVend + '013' + PADSTR(Vendor."Address 2",36,' ')
                          + PADSTR('',7,' ');
                        OutFile.WriteText(OutText);
                    
                        TotalReg := TotalReg + 1;
                      END;
                    
                      OutText := '06' + DocType + VATRegNo + VATRegVend + '014' + PADSTR(Vendor."Post Code" + ' ' + Vendor.City,36,' ')
                        + PADSTR('',7,' ');
                      OutFile.WriteText(OutText);
                    
                      TotalReg := TotalReg + 1;
                    END;
                    */
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TESTFIELD("Bank Account No.");
                BankAcc.GET("Bank Account No.");
                CCCBankNo:=BankAcc."CCC Bank No.";
                CCCBankNo:=PADSTR('', MAXSTRLEN(CCCBankNo) - STRLEN(CCCBankNo), '0') + CCCBankNo;
                CCCBankBranchNo:=BankAcc."CCC Bank Branch No.";
                CCCBankBranchNo:=PADSTR('', MAXSTRLEN(CCCBankBranchNo) - STRLEN(CCCBankBranchNo), '0') + CCCBankBranchNo;
                CCCAccNo:=BankAcc."CCC Bank Account No.";
                CCCAccNo:=PADSTR('', MAXSTRLEN(CCCAccNo) - STRLEN(CCCAccNo), '0') + CCCAccNo;
                CCCControlDigits:=BankAcc."CCC Control Digits";
                CCCControlDigits:=PADSTR('', MAXSTRLEN(CCCControlDigits) - STRLEN(CCCControlDigits), '0') + CCCControlDigits;
                //-999 30/11/17
                //BankAcc.TESTFIELD("CCC Confirming Contract No.");   //-999 30/11/17 debe ser un campo específicio de eurocasa
                //txtNumeroContratoConf := BankAcc."CCC Confirming Contract No.";
                //+999
                //-001
                //CCCIBAN:= COPYSTR(BankAcc.IBAN,5);
                //CCCAccount1:= COPYSTR(BankAcc.IBAN,5,8);
                //CCCAccount2 := COPYSTR(BankAcc.IBAN,15,11);
                //txtNumeroContratoConf := CCCAccount1 + CCCAccount2;
                txtNumeroContratoConf:=BankAcc."Contrato Confirming";
                //+001
                txtNumeroContratoConf:=PADSTR('', MAXSTRLEN(txtNumeroContratoConf) - STRLEN(txtNumeroContratoConf), '0') + txtNumeroContratoConf;
                IF "Posting Date" = 0D THEN PostDate:=PADSTR('', 6, '0')
                ELSE
                    PostDate:=FORMAT("Posting Date", 0, Text1100002);
                // REGISTROS DE CABECERA
                // Tipo de registro 1: OBLIGATORIO
                CLEAR(OutText);
                OutText:='01' + RegisterString + VATRegNo + '  ' + PADSTR('', 10, ' ') + '001' + FORMAT(DeliveryDate, 0, Text1100002) + PADSTR('', 6, ' ') + //ALB ->  Contrato y sucursal
 /*
                           '2100' +
                           '6202' +      // VAF -> Yá incluido en el Número de contrato
                           */
                //ALB -> Se caambia el contrato a 18 posiciones que ya tendrá el banco y sucurssal
                txtNumeroContratoConf + '1' + 'EUR';
                OutFile.WriteText(OutText);
                OutFile.WriteText();
                TotalReg:=TotalReg + 1;
                // Tipo de registro 1 <-------------------------------------------
                // Tipo de registro 2: OBLIGATORIO
                CLEAR(OutText);
                OutText:='01' + RegisterString + VATRegNo + PADSTR('', 12, ' ') + '002' + txtNombreOrdenante;
                OutFile.WriteText(OutText);
                OutFile.WriteText();
                TotalReg:=TotalReg + 1;
                // Tipo de registro 2 <-------------------------------------------
                // Tipo de registro 3: OBLIGATORIO
                CLEAR(OutText);
                OutText:='01' + RegisterString + VATRegNo + PADSTR('', 12, ' ') + '003' + txtDomicilioOrdenante;
                OutFile.WriteText(OutText);
                OutFile.WriteText();
                TotalReg:=TotalReg + 1;
                // Tipo de registro 3 <-------------------------------------------
                // Tipo de registro 4: OBLIGATORIO
                OutText:='01' + RegisterString + VATRegNo + PADSTR('', 12, ' ') + '004' + txtPlazaOrdenante;
                OutFile.WriteText(OutText);
                OutFile.WriteText();
                TotalReg:=TotalReg + 1;
            // Tipo de registro 4 <-------------------------------------------
            /*
                OutText := '03' + RegisterString + VATRegNo + PADSTR('',12,' ') + '001' +
                  FORMAT(DeliveryDate,0,Text1100002) + PostDate +
                  CCCBankNo + CCCBankBranchNo + CCCAccNo + Relat + PADSTR('',3,' ') + CCCControlDigits + PADSTR('',7,' ');
                OutFile.WriteText(OutText);
                
                TotalReg := TotalReg + 1;
                
                OutText := '03' + RegisterString + VATRegNo + PADSTR('',12,' ') + '002' +
                  PADSTR(CompanyInfo.Name,36,' ') + PADSTR('',7,' ');
                OutFile.WriteText(OutText);
                
                TotalReg := TotalReg + 1;
                
                OutText := '03' + RegisterString + VATRegNo + PADSTR('',12,' ') + '003' +
                  PADSTR(CompanyInfo.Address,36,' ') + PADSTR('',7,' ');
                OutFile.WriteText(OutText);
                
                TotalReg := TotalReg + 1;
                
                OutText := '03' + RegisterString + VATRegNo + PADSTR('',12,' ') + '004' +
                  PADSTR(CompanyInfo."Post Code" + ' ' + CompanyInfo.City,36,' ') + PADSTR('',7,' ');
                OutFile.WriteText(OutText);
                
                TotalReg := TotalReg + 1;
                */
            end;
            trigger OnPreDataItem()
            begin
                GLSetup.Get();
                IF CheckErrors THEN Relat:='1'
                ELSE
                    Relat:='0';
                FINDFIRST;
                IsEuro:=DocMisc.GetRegisterCode("Currency Code", RegisterCode, RegisterString);
                // AITNVAF - 27/11/2014 ->
                // Según especificaciones de la Caixa todo es Código de Operación 56
                /*
                IF RegisterCode <> 0 THEN
                  RegisterString := '56'
                ELSE
                  RegisterString := '06';
                */
                RegisterString:='56';
            // AITNVAF - 27/11/2014 <-
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(crelation; CheckErrors)
                    {
                        ToolTip = 'Check Errors';
                        ApplicationArea = All;
                        Caption = 'Relation';
                    }
                    field(DeliveryDate; DeliveryDate)
                    {
                        ToolTip = 'Delivery Date';
                        ApplicationArea = All;
                        Caption = 'Delivery Date';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            IF ExternalFile = '' THEN // es0007.begin
 ExternalFile:='C:\' + Text10702;
            // es0007.end
            IF DeliveryDate = 0D THEN DeliveryDate:=TODAY;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.TESTFIELD("VAT Registration No.");
        VATRegNo:=INSSTR(PADSTR('', MAXSTRLEN(VATRegNo) - STRLEN(CompanyInfo."VAT Registration No."), ' '), CompanyInfo."VAT Registration No.", 1 + MAXSTRLEN(VATRegNo) - STRLEN(CompanyInfo."VAT Registration No."));
        txtNombreOrdenante:=UPPERCASE(CompanyInfo.Name);
        txtNombreOrdenante:=PADSTR(txtNombreOrdenante, 36, ' ');
        txtDomicilioOrdenante:=UPPERCASE(CompanyInfo.Address);
        txtDomicilioOrdenante:=PADSTR(txtDomicilioOrdenante, 36, ' ');
        txtPlazaOrdenante:=UPPERCASE(CompanyInfo."Post Code" + ' ' + CompanyInfo.City);
        txtPlazaOrdenante:=PADSTR(txtPlazaOrdenante, 36, ' ');
    end;
    trigger OnPostReport()
    begin
        TotalReg:=TotalReg + 1;
        CASE TRUE OF LCY = LCY::Euro: IF IsEuro THEN DocAmount:=EuroAmount(TotalAmount)
            ELSE
                DocAmount:=CONVERTSTR(FORMAT(TotalAmount, 12, Text1100000), ' ', '0');
        LCY = LCY::Other: IF IsEuro THEN DocAmount:=EuroAmount(TotalAmount)
            ELSE
                DocAmount:=CONVERTSTR(FORMAT(TotalAmount, 12, Text1100000), ' ', '0');
        END;
        OutText:='08' + RegisterString + VATRegNo + PADSTR('', 15, ' ') + DocAmount + // ES0008.begin
 (PADSTR('', 8 - STRLEN(FORMAT(TotalDocVend)), '0') + FORMAT(TotalDocVend, 0, 1)) + (PADSTR('', 10 - STRLEN(FORMAT(TotalReg)), '0') + FORMAT(TotalReg, 0, 1)) + // ES0008.end
 PADSTR('', 13, ' ');
        OutFile.WriteText(OutText);
        //OutFile.Close();
        // es0006.begin
        // es0007.begin
        TempBlob.CreateInStream(InFile);
        DownloadFromStream(InFile, Text10702, 'C:', Text10701, ToFile);
    // es0007.end
    // es0006.end
    end;
    trigger OnPreReport()
    begin
        //OutFile.TEXTMODE := TRUE;
        //OutFile.WRITEMODE := TRUE;
        //ExternalFile := FileMgt.ServerTempFileName('');
        ToFile:=Text10702;
        TempBlob.CreateOutStream(OutFile);
    end;
    var FileMgt: Codeunit "File Management";
    TempBlob: Codeunit "Temp Blob";
    Text1100000: Label '<Integer>', Locked = true;
    Text1100002: Label '<Day,2><month,2><year>', Locked = true;
    Text1100003: Label 'Some data from the Bank Account of Vendor %1 are missing.';
    CompanyInfo: Record 79;
    Vendor: Record 23;
    BankAcc: Record 270;
    VendBankAcc: Record 288;
    GLSetup: Record 98;
    DocMisc: Codeunit "Document-Misc";
    InFile: InStream;
    OutFile: OutStream;
    ExternalFile: Text[1024];
    CheckErrors: Boolean;
    VATRegNo: Text[10];
    CCCBankNo: Text[4];
    VATRegVend: Text[12];
    VendCCCBankBranchNo: Text[4];
    CCCBankBranchNo: Text[4];
    VendCCCControlDigits: Text[2];
    CCCControlDigits: Text[2];
    CCCAccNo: Text[10];
    VendCCCAccNo: Text[10];
    Vendor2: Text[4];
    TotalReg: Decimal;
    TotalDocVend: Decimal;
    TotalAmount: Decimal;
    OutText: Text[85];
    DeliveryDate: Date;
    Relat: Text[1];
    DocType2: Code[10];
    DocType: Text[2];
    RmgAmount: Text[12];
    VendBankAccCode: Code[20];
    PostDate: Text[6];
    LCY: Option Euro, Other;
    IsEuro: Boolean;
    RegisterCode: Integer;
    RegisterString: Text[2];
    DocAmount: Text[12];
    ToFile: Text[1024];
    Text10701: Label 'ASC Files (*.asc)|*.asc|All Files (*.*)|*.*';
    Text10702: Label 'ORDENPAGO.ASC';
    txtNombreOrdenante: Text[50];
    txtDomicilioOrdenante: Text[50];
    txtPlazaOrdenante: Text[50];
    txtNumeroContratoConf: Text[18];
    txtProveedorNoResidente: Text[1];
    txtIndicadorConfirmacion: Text[1];
    txtPaisDestino: Text[50];
    recPais: Record 9;
    txtFormaPago: Text[1];
    txtFechaFactura: Text[6];
    txtFechaVtoFactura: Text[6];
    txtNumeroFactura: Text[15];
    txtTelefonoProveedor: Text[15];
    txtFaxProveedor: Text[15];
    txtISODestino: Text[2];
    txtDigitoControlIBAN: Text[2];
    txtBBAN: Text[30];
    Txt50201: Label 'Falta alguna información sobre el banco del proveedor %1: %2.';
    CCCIBAN: Text[20];
    CCCAccount1: Text;
    CCCAccount2: Text;
    VATRegVend2: Text;
    procedure EuroAmount(Amount: Decimal): Text[12]var
        TextAmount: Text[15];
    begin
        TextAmount:=CONVERTSTR(FORMAT(Amount), ' ', '0');
        IF STRPOS(TextAmount, ',') = 0 THEN TextAmount:=TextAmount + '00'
        ELSE
        BEGIN
            IF STRLEN(COPYSTR(TextAmount, STRPOS(TextAmount, ','), STRLEN(TextAmount))) = 2 THEN TextAmount:=TextAmount + '0';
            TextAmount:=DELCHR(TextAmount, '=', ',');
        END;
        IF STRPOS(TextAmount, '.') = 0 THEN TextAmount:=TextAmount
        ELSE
            TextAmount:=DELCHR(TextAmount, '=', '.');
        WHILE STRLEN(TextAmount) < 12 DO TextAmount:='0' + TextAmount;
        EXIT(TextAmount);
    end;
    procedure FncVacios(pNumVacios: Integer)vVacios: Text[268]begin
        IF pNumVacios < 0 THEN pNumVacios:=0;
        vVacios:=PADSTR('', pNumVacios, ' ');
        EXIT(vVacios);
    end;
}
