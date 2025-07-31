tableextension 52022 "CustomerBankAccount" extends "Customer Bank Account"
{
    fields
    {
    }
    // "---SEPA---"
    procedure BuildIBAN()
    var
        Letter1: Code[1];
        Letter2: Code[1];
        NumLetter1: Code[1];
        NumLetter2: Code[1];
        IBANAuxL: Code[26];
        RestL: Integer;
        DifferenceL: Integer;
        DCL: Code[2];
    begin
        //<SEPA.001
        "CCC No.":="CCC Bank No." + "CCC Bank Branch No." + "CCC Control Digits" + "CCC Bank Account No.";
        IF "CCC No." <> '' THEN Rec.TESTFIELD("Bank Account No.", '');
        IF "CCC No." <> '' THEN AccountNo:="CCC No."
        ELSE
            AccountNo:="Bank Account No.";
        IF CompanyInfo.CalculateIBAN("Country/Region Code", AccountNo, IBAN)THEN VALIDATE(IBAN);
    end;
    procedure SplitIBAN()
    var
        Letter1: Code[1];
        Letter2: Code[1];
        NumLetter1: Code[1];
        NumLetter2: Code[1];
        IBANAuxL: Code[26];
        RestL: Integer;
        DifferenceL: Integer;
        DCL: Code[2];
        CountryCodeL: Code[2];
        LText001: Label 'El IBAN introducido (%1) no es válido.';
    begin
        //<SEPA.001
        //"SWIFT Code" :=
        "CCC Bank No.":=COPYSTR(IBAN, 5, 4);
        //>INF.001
        IF("Country/Region Code" = '') OR ("Country/Region Code" = 'ES')THEN BEGIN
            "CCC Bank Branch No.":=COPYSTR(IBAN, 9, 4);
            "CCC Control Digits":=COPYSTR(IBAN, 13, 2);
            "CCC Bank Account No.":=COPYSTR(IBAN, 15, 23);
        END;
        //<INF.001
        GetBIC;
    //SEPA.001>
    end;
    procedure CalcModule(ChainP: Code[30]; DivisorP: Integer): Code[2]var
        RestCodeL: Code[30];
        StartL: Integer;
        EndL: Integer;
        OpResultL: Integer;
        RestNumL: Integer;
        BufferL: Integer;
    begin
        //<SEPA.001
        StartL:=1;
        EndL:=1;
        WHILE(EndL <= STRLEN(ChainP))DO BEGIN
            EVALUATE(BufferL, RestCodeL + COPYSTR(ChainP, StartL, EndL - StartL + 1));
            IF(BufferL >= DivisorP)THEN BEGIN
                OpResultL:=ROUND(BufferL / DivisorP, 1, '<');
                RestNumL:=BufferL - (OpResultL * DivisorP);
                RestCodeL:=FORMAT(RestNumL);
                StartL:=EndL + 1;
                EndL:=StartL;
            END
            ELSE
                EndL:=EndL + 1;
        END;
        IF STRLEN(RestCodeL) <= 1 THEN REPEAT RestCodeL:='0' + RestCodeL;
            UNTIL STRLEN(RestCodeL) = 2;
        /*
        IF (StartL <= STRLEN(ChainP)) THEN
          RestCodeL := RestCodeL + COPYSTR(ChainP,StartL);
        */
        EXIT(RestCodeL);
    //SEPA.001>
    end;
    procedure GetBIC()
    var
        BICCodes: Record "BIC Code";
    begin
        //<SEPA.001
        IF BICCodes.GET("CCC Bank No.")THEN "SWIFT Code":=BICCodes."BIC 11";
    //SEPA.001>
    end;
    var CompanyInfo: Record 79;
    AccountNo: Code[30];
}
