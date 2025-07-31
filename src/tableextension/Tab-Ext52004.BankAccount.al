tableextension 52004 "BankAccount" extends "Bank Account"
{
    fields
    {
        //modify("IBAN")
        //{
        //    trigger OnAfterValidate()
        //    begin
        //        //++SEPA
        //        //SplitIBAN;
        //        //--SEPA
        //    end;
        //}
        //modify("CCC Bank No.")
        //{
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        "CCC Bank No." := PrePadString("CCC Bank No.",MAXSTRLEN("CCC Bank No."));
        //        //<SEPA.001
        //        //BuildCCC;
        //        BuildIBAN;
        //        GetBIC;
        //        //SEPA.001>
        //        */
        //    //end;
        //    trigger OnAfterValidate()
        //    begin
        //        //<SEPA.001
        //        //BuildCCC; --- Cannot prevent BuildCCC
        //        BuildIBAN();
        //        GetBIC();
        //        //SEPA.001>
        //    end;
        //}
        //modify("CCC Bank Branch No.")
        //{
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        "CCC Bank Branch No." := PrePadString("CCC Bank Branch No.",MAXSTRLEN("CCC Bank Branch No."));
        //        //<SEPA.001
        //        //BuildCCC;
        //        BuildIBAN;
        //        //SEPA.001>
        //    */
        //    //end;
        //    trigger OnAfterValidate()
        //    begin
        //        //<SEPA.001
        //        //BuildCCC; -- Cannot prevent BuildCCC
        //        BuildIBAN();
        //        //SEPA.001>
        //    end;
        //}
        //modify("CCC Control Digits")
        //{
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        "CCC Control Digits" := PrePadString("CCC Control Digits",MAXSTRLEN("CCC Control Digits"));
        //        //<SEPA.001
        //        //BuildCCC;
        //        BuildIBAN;
        //        //SEPA.001>
        //    */
        //    //end;
        //    trigger OnAfterValidate()
        //    begin
        //        //<SEPA.001
        //        //BuildCCC;
        //        BuildIBAN;
        //        //SEPA.001>
        //    end;
        //}
        //modify("CCC Bank Account No.")
        //{
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        "CCC Bank Account No." := PrePadString("CCC Bank Account No.",MAXSTRLEN("CCC Bank Account No."));
        //
        //        //<SEPA.001
        //        //BuildCCC;
        //        BuildIBAN;
        //        //SEPA.001>
        //    */
        //    //end;
        //    trigger OnAfterValidate()
        //    begin
        //        //<SEPA.001
        //        //BuildCCC; -- Cannot Prevent BuildCCC
        //        BuildIBAN();
        //        //SEPA.001>
        //    end;
        //}
        field(52000; "Contrato Confirming"; Text[30])
        {
            DataClassification = CustomerContent;
            Description = '-001  Report "DELETE Vendors';
        }
    }
    procedure BuildIBAN()
    var
        Letter1: Code[1];
        Letter2: Code[1];
        NumLetter1: Code[2];
        NumLetter2: Code[2];
        IBANAuxL: Code[26];
        RestL: Integer;
        DifferenceL: Integer;
        DCL: Code[2];
        AccountNo: Code[50];
        CompanyInfo: Record 79;
    begin
        //<SEPA.001
        "CCC No.":="CCC Bank No." + "CCC Bank Branch No." + "CCC Control Digits" + "CCC Bank Account No.";
        IF "CCC No." <> '' THEN Rec.TESTFIELD("Bank Account No.", '');
        IF "CCC No." <> '' THEN AccountNo:="CCC No."
        ELSE
            AccountNo:="Bank Account No.";
        IF CompanyInfo.CalculateIBAN("Country/Region Code", AccountNo, IBAN)THEN VALIDATE(IBAN);
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
        "CCC Bank Branch No.":=COPYSTR(IBAN, 9, 4);
        "CCC Control Digits":=COPYSTR(IBAN, 13, 2);
        "CCC Bank Account No.":=COPYSTR(IBAN, 15, 23);
        GetBIC;
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
//Unsupported feature: Property Modification (Subtype) on "ClosedBillGr(Variable 1100003)".
//var
//>>>> ORIGINAL VALUE:
//ClosedBillGr : "Closed Bill Group";
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//ClosedBillGr : 7000007;
//Variable type has not been exported.
//Unsupported feature: Property Modification (Subtype) on "PostedPmtOrd(Variable 1100002)".
//var
//>>>> ORIGINAL VALUE:
//PostedPmtOrd : "Posted Payment Order";
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//PostedPmtOrd : 7000021;
//Variable type has not been exported.
//Unsupported feature: Property Modification (Subtype) on "ClosedPmtOrd(Variable 1100001)".
//var
//>>>> ORIGINAL VALUE:
//ClosedPmtOrd : "Closed Payment Order";
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//ClosedPmtOrd : 7000022;
//Variable type has not been exported.
//Unsupported feature: Property Modification (Subtype) on "Suffix(Variable 1100000)".
//var
//>>>> ORIGINAL VALUE:
//Suffix : Suffix;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Suffix : 7000024;
//Variable type has not been exported.
}
