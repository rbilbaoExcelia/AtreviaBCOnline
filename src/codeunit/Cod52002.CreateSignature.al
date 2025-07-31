codeunit 52002 "Create Signature"
{
    // 003 OS.MIR  07/06/2016  FIN.003   Fichero SAF-T Portugal
    trigger OnRun()
    begin
    end;
    var PrivateKeyVersion: Integer;
    Text001: Label '<RSAKeyValue><Modulus>rfSscSWtt3QIRUqvTeoEisLqZBColy6Z8WCDTVDDhskgBovUIFWfsW6O06hbvvPhdohfNI87oUt06efnYXWGgsUEaoEqaiUrLoRSfyzY/L00oWf5ta7Bhm7VWvAI5HuRuNUqfoTqnAgBV6F8DXCh7zQE24WQS0mgNhFTSwx01EU=</Modulus><Exponent>AQAB</Exponent><P>3rrj8MLKfu6ckxx8frxAT0w0bpx4RB+vUb5nPOvMu9w/x4MdWOtdKSH9W3m1SaY9cvdI5apcn+sn/5WeWrimuQ==</P><Q>x/CsdO2XSTtOn45IckqbJddn5KxqG8qpslLoD2RY/u4yRI4LcuXjJZVgOWesneP3mt+6UM0uefZqtPP2wtjT7Q==</Q><DP>oo/zeDEkDLrpSrIa54FMytPK3QSU/tvFYTtALIXKGz8oydyXmePHThNB0Pcm6wdLiFKWQRIzooDG49N3Da4B+Q==</DP><DQ>MRAcIa1T3IKTLpApsvIf1E9hjTnJ5/v5XGr/yxcix5wH9c6tfIpxDP302OFZ+HzCe9y+yakv6HnRgYoEWZf/mQ==</DQ><InverseQ>vB61hwdw1AYc8c6tbz3J9S6yYYVIPiLuyUlkJPmirUjEm0faZftYGGTdQLX0Cqx8aNTw78jlE/0nZFptDat6Bw==</InverseQ><D>PQyZWDw48yEtpePIEjgG0AwH5oZSJHyeWi/c5M1rUWpUave3woFKQiLizTVQvXsprUe+4dtCuiCZL13LvlBYnAfidukdssGxJ8cIbjuAS13XW0kfpYkNy0qk8tDKjWdqiFUbJxKG68HjTHYP8hNy2El93WQk843OAdcWk1r7PwE=</D></RSAKeyValue>';
    Text002: Label 'Processed by Certified Program No.';
    procedure GetHash(Type: Option; DocumentDate: Date; DocumentNo: Code[20]; NoSeries: Code[10]; CurrencyCode: Code[10]; CurrencyFactor: Decimal; AmountInclVAT: Decimal; LastHashUsed: Text[172]; SystemEntryDate: Date; SystemEntryTime: Time)RetVal: Text[172]var
        DataForSigningL: Text[330];
    begin
        DataForSigningL:=GetDataForSigning(Type, DocumentDate, DocumentNo, NoSeries, CurrencyCode, CurrencyFactor, ABS(AmountInclVAT), LastHashUsed, SystemEntryDate, SystemEntryTime);
        ////RetVal := GetHashDotNet(DataForSigningL);
        //BC Code for hash
        RetVal:=GethashBC(DataForSigningL);
        EXIT(RetVal);
    end;
    /* Obsoleto ver si se necesita
    local procedure GetHashDotNet(DataForSigningP: Text[330]) RetVal: Text[172]
    var
        SigningComponentL: Automation;
        SigningComponent2: DotNet SignatureProvider;
    begin
        //090517
        SigningComponent2 := SigningComponent2.SignatureProvider;

        //RetVal := SigningComponentL.CreateSignature(DataForSigningP,Text001);
        RetVal := SigningComponent2.CreateSignature(DataForSigningP, Text001);
        EXIT(RetVal);
        //090517
    end; */
    procedure GethashBC(lcadena: text /*<- Contiene el texto a firmar.*/): Text var
        lhash: text; // Hash generado.
        ltempblobnavi: Codeunit "Temp Blob"; // <- Esta es una tabla con un campo BLOB que hemos creado nosotros. Se puede utilizar la cdu estándar “Temp BLOB” en su lugar.
        lostream: OutStream;
        listream: InStream;
        //lconfcert: record "Configuración CertificaE"; <- Donde guardamos previamente a través de importación la “Clave privada”.
        lXMLString: Text; //<- “Clave privada” en formato XML
        cducripto: codeunit "Cryptography Management";
        cduconversor: codeunit "Base64 Convert";
        lconfcert: Codeunit "Temp Blob";
        PVTempBlob: Codeunit "Temp Blob";
        PrivateKey: OutStream;
    begin
        clear(ltempblobnavi);
        ltempblobnavi.CreateOutStream(lostream);
        //Falta tabla con campos
        //lconfcert.CalcFields("Clave Privada");
        //lconfcert."Clave Privada".CreateInStream(listream);
        //Nuevo codigo
        Clear(PVTempBlob);
        Clear(PrivateKey);
        PVTempBlob.CreateOutStream(PrivateKey);
        PrivateKey.WriteText(Text001);
        PVTempBlob.CreateInStream(listream);
        listream.ReadText(lXMLString);
        clear(cducripto);
        clear(cduconversor);
        cducripto.SignData(lcadena, lXMLString, "Hash Algorithm"::SHA1, lostream);
        //ltempblobnavi.insert;
        //ltempblobnavi.CalcFields(blob)
        ltempblobnavi.CreateInStream(listream);
        lhash:=cduconversor.ToBase64(listream);
        exit(lhash);
    end;
    local procedure GetDataForSigning(Type: Option; DocumentDate: Date; DocumentNo: Code[20]; NoSeries: Code[10]; CurrencyCode: Code[10]; CurrencyFactor: Decimal; AmountInclVAT: Decimal; LastHashUsed: Text[200]; SystemEntryDate: Date; SystemEntryTime: Time): Text[330]begin
        EXIT(FormatDate(DocumentDate) + ';' + FormatDateTime(SystemEntryDate, SystemEntryTime) + ';' + GetDocumentNo(Type, DocumentNo, NoSeries) + ';' + FormatAmount(CurrencyCode, CurrencyFactor, AmountInclVAT) + ';' + LastHashUsed);
    end;
    local procedure FormatDate(PostingDate: Date): Text[10]begin
        EXIT(FORMAT(PostingDate, 0, 9));
    end;
    local procedure FormatDateTime(DateParam: Date; TimeParam: Time): Text[19]begin
        EXIT(FORMAT(DateParam, 0, 9) + 'T' + FORMAT(TimeParam, 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>'));
    end;
    local procedure GetDocumentNo(Type: Option; DocumentNo: Code[20]; NoSeries: Code[10]): Text[35]var
        DocumentType: Text[4];
    begin
        DocumentType:=GetDocumentType(Type);
        EXIT(DocumentType + NoSeries + '/' + DocumentNo);
    end;
    local procedure FormatAmount(CurrencyCode: Code[10]; CurrencyFactor: Decimal; AmountInclVAT: Decimal): Text[20]var
        DocFactor: Decimal;
    begin
        IF CurrencyCode <> '' THEN DocFactor:=CurrencyFactor
        ELSE
            DocFactor:=1;
        EXIT(FORMAT(ROUND(AmountInclVAT / DocFactor, 0.01), 0, '<Precision,2:2><Standard Format,9>'))end;
    procedure GetPrivateKeyVersion(): Text[40]begin
        PrivateKeyVersion:=1;
        EXIT(FORMAT(PrivateKeyVersion));
    end;
    procedure GetFourCharFromSignature(Hash: Text[172]): Text[60]var
        CompanyInfo: Record 79;
        FourChars: Text[4];
    begin
        CompanyInfo.Get();
        FourChars:=COPYSTR(Hash, 1, 1) + COPYSTR(Hash, 11, 1) + COPYSTR(Hash, 21, 1) + COPYSTR(Hash, 31, 1);
        EXIT(FourChars + '-' + Text002 + CompanyInfo."Soft. Certificate Number PT");
    end;
    local procedure GetDocumentType(Type: Option): Text[4]var
        DocumentType: Option Invoice, "Credit Memo", Shipment, "Transfer Shipment", "Return Shipment", "Warehouse Shipment";
    begin
        CASE Type OF DocumentType::Invoice: EXIT('FAC ');
        DocumentType::"Credit Memo": EXIT('NCR ');
        DocumentType::Shipment: EXIT('GRM ');
        DocumentType::"Transfer Shipment": EXIT('ETR ');
        DocumentType::"Return Shipment": EXIT('EDV ');
        DocumentType::"Warehouse Shipment": EXIT('EAR ');
        END end;
    //3688 - APR - 2022 06 01
    procedure SetNoSeriesLineFilter(VAR NoSeriesLine: Record "No. Series Line"; NoSeriesCode: Code[10]; StartDate: Date)
    begin
        if StartDate = 0D then StartDate:=WORKDATE;
        NoSeriesLine.RESET;
        NoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        NoSeriesLine.SETRANGE("Series Code", NoSeriesCode);
        NoSeriesLine.SETRANGE("Starting Date", 0D, StartDate);
        //NoSeriesLine.SetFilter("Last Hash Used", '<>%1', '');
        if NoSeriesLine.FINDLAST then begin
            NoSeriesLine.SETRANGE("Starting Date", NoSeriesLine."Starting Date");
            NoSeriesLine.SETRANGE(Open, TRUE);
        end;
    end;
    procedure SetNoSeriesLineFilter2(VAR NoSeriesLine: Record "No. Series Line"; NoSeriesCode: Code[10]; StartDate: Date)
    begin
        if StartDate = 0D then StartDate:=WORKDATE;
        NoSeriesLine.RESET;
        NoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        NoSeriesLine.SETRANGE("Series Code", NoSeriesCode);
        NoSeriesLine.SETRANGE("Starting Date", 0D, StartDate);
        NoSeriesLine.SetFilter("Last Hash Used", '<>%1', '');
        if NoSeriesLine.FINDLAST then;
    //NoSeriesLine.SETRANGE("Starting Date", NoSeriesLine."Starting Date");
    //NoSeriesLine.SETRANGE(Open, TRUE);
    //end;
    end;
    procedure GetLastHashUsed(NoSeries: Code[10]; PostingDate: Date; ModifySeries: Boolean): Text[172]var
        NoSeriesLine: Record "No. Series Line";
    begin
        if ModifySeries then NoSeriesLine.LOCKTABLE;
        SetNoSeriesLineFilter2(NoSeriesLine, NoSeries, PostingDate);
        EXIT(NoSeriesLine."Last Hash Used");
    end;
    procedure UpdateLastHashandNoPosted(NoSeries: Code[10]; PostingDate: Date; Hash: Text[172]; LastNoPosted: Code[20])
    var
        NoSeriesLine: Record "No. Series Line";
    begin
        SetNoSeriesLineFilter(NoSeriesLine, NoSeries, PostingDate);
        NoSeriesLine."Last Hash Used":=Hash;
        NoSeriesLine."Last No. Posted":=LastNoPosted;
        NoSeriesLine.Modify(false);
    end;
//3688 - APR - 2022 06 01 END
}
