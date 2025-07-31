tableextension 52104 "VendorBankAccount" extends "Vendor Bank Account"
{
    fields
    {
        modify(IBAN)
        {
        trigger OnAfterValidate()
        var
            vendor: Record vendor;
        begin
            //
            SplitIBAN();
            //3590 - MEP - 2022 03 22 
            //se actualiza el iban del proveedor, ya que solo se estaba actualizando en la vendor bank account
            vendor.Reset();
            vendor.SetRange("No.", rec."Vendor No.");
            if vendor.FindFirst()then begin
                vendor.CalcFields(IBAN);
            end;
        //3590 - MEP - 2022 03 22
        //
        end;
        }
        modify("CCC Bank No.")
        {
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        //BuildCCC;
        //        BuildIBAN;
        //        GetBIC;
        //        //
        //    */
        //    //end;
        trigger OnAfterValidate()
        begin
            //"CCC Bank No." := PrePadString("CCC Bank No.",MAXSTRLEN("CCC Bank No."));
            //"CCC Bank No." := (PADSTR('', MAXSTRLEN("CCC Bank No.") - STRLEN("CCC Bank No."),'0') + "CCC Bank No.");
            //        //Cannot prevent BuildCCC
            BuildIBAN();
            GetBIC();
        end;
        }
        modify("CCC Bank Branch No.")
        {
        //    //end;
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        "CCC Bank Branch No." := PrePadString("CCC Bank Branch No.",MAXSTRLEN("CCC Bank Branch No."));
        //        //BuildCCC;
        //        BuildIBAN;
        //        //
        //    */
        //    //end;
        trigger OnAfterValidate()
        begin
            //        //Cannot prevent BuildCCC
            BuildIBAN();
        end;
        }
        modify("CCC Control Digits")
        {
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        "CCC Control Digits" := PrePadString("CCC Control Digits",MAXSTRLEN("CCC Control Digits"));
        //        //BuildCCC;
        //        BuildIBAN;
        //        //
        //    */
        //    //end;
        trigger OnAfterValidate()
        begin
            //        //Cannot prevent BuildCCC
            BuildIBAN;
        end;
        }
        ////end;
        modify("CCC Bank Account No.")
        {
        //    //end;
        //    //>>>> MODIFIED CODE:
        //    //begin
        //    /*
        //        "CCC Bank Account No." := PrePadString("CCC Bank Account No.",MAXSTRLEN("CCC Bank Account No."));
        //        //BuildCCC;
        //        BuildIBAN;
        //    //
        //    */
        //    //end;
        //
        trigger OnAfterValidate()
        begin
            //        //Cannot prevent BuildCCC
            BuildIBAN;
        end;
        }
    }
    trigger OnBeforeInsert()
    begin
        //123
        "Use For Electronic Payments":=TRUE;
    //123
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
        GetBIC();
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
    begin
        //<SEPA.001
        "CCC No.":="CCC Bank No." + "CCC Bank Branch No." + "CCC Control Digits" + "CCC Bank Account No.";
        IF "CCC No." <> '' THEN Rec.TESTFIELD("Bank Account No.", '');
        IF "CCC No." <> '' THEN AccountNo:="CCC No."
        ELSE
            AccountNo:="Bank Account No.";
        IF CompanyInfo.CalculateIBAN("Country/Region Code", AccountNo, IBAN)THEN VALIDATE(IBAN);
    end;
    var AccountNo: Code[30];
    CompanyInfo: Record 79;
}
