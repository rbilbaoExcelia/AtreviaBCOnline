tableextension 52014 "CompanyInformation" extends "Company Information"
{
    fields
    {
        field(52000; "Use SAF-T"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use SAF-T';
            Description = '-003';
        }
        field(52001; "Registration Authority PT"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Registration Authority';
            Description = '-003,310123';
        }
        field(52002; "Business Name PT"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Name';
            Description = '-003,310123';
        }
        field(52003; "Software Vendor VAT PT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Software Vendor VAT';
            Description = '-003,310123';
        }
        field(52004; "Soft. Certificate Number PT"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Soft. Certificate Number';
            Description = '-003,310123';
        }
        field(52005; "Soft. Certificate Number 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Soft. Certificate Number';
            Description = '-003';
        }
        field(52010; "Consolidated Company"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Consolidated Company';
            Description = '-010';
        }
        field(52020; "SQL Sychronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Sychronized';
            Description = '-025';
        }
        field(52021; "Invoice Text 1"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 1';
            Description = '-025';
        }
        field(52022; "Invoice Text 2"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 2';
            Description = '-025';
        }
        field(52023; "Invoice Text 3"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 3';
            Description = '-025';
        }
        field(52024; "Invoice Text 4"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 4';
            Description = '-025';
        }
        field(52025; "Invoice Text 5"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Text 5';
            Description = '-025';
        }
        field(52026; "Commercial Register Text"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Commercial Register Text';
            Description = '-025';
        }
        field(52027; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = '-025';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(52030; "Main Company"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Main Company';
            Description = '-025';
            TableRelation = Company.Name;
        }
        field(52031; "Invoice Down Picture"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Down Picture';
            Description = '-034';
            SubType = Bitmap;
        }
        field(52032; "Invoice Right Picture"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Right Picture';
            Description = '-034';
            SubType = Bitmap;
        }
        field(52089; "Ignorar en WS"; Boolean)
        {
            DataClassification = CustomerContent;
            CaptionML = ENU = 'Ignore in WS', ESP = 'Ignorar en WS';
            Description = '-Cuadro de mando';
        }
        field(52090; "Consolidated"; Boolean)
        {
            DataClassification = CustomerContent;
            CaptionML = ENU = 'Consolidated', ESP = 'Consolidada';
            Description = '-010';
        }
        field(52091; "NOC Filter"; Code[10])
        {
            Description = '-010';
            FieldClass = FlowFilter;
            TableRelation = "Reason Code" WHERE("Not Commercial Operation AT"=CONST(true));
        }
        field(52092; "Date Filter"; Date)
        {
            CaptionML = ENU = 'Date Filter', ESP = 'Filtro fecha';
            Description = '-010';
            FieldClass = FlowFilter;
        }
        field(52093; "NOC Periodic Filter"; Boolean)
        {
            CaptionML = ENU = 'NOC Periodic Filter', ESP = 'Filtro ONC periódico';
            Description = '-010';
            FieldClass = FlowFilter;
        }
        field(52094; "Job Consolidation"; Boolean)
        {
            DataClassification = CustomerContent;
            CaptionML = ENU = 'Job Consolidation', ESP = 'Consolidación proyectos';
            Description = '-010';
        }
        field(52095; "Omite Comparticion Datos"; Boolean)
        {
            DataClassification = CustomerContent;
            CaptionML = ENU = 'Omite Compartición Datos', ESP = 'Omite Compartición Datos';
        }
    }
    trigger OnAfterModify()
    begin
    //"SQL Sychronized" := FALSE;   //025
    end;
    procedure BuildIBAN()
    var
        CompanyInfo: Record 79;
        AccountNo: Code[100];
    begin
        IF "CCC No." <> '' THEN AccountNo:="CCC No."
        ELSE
            AccountNo:="Bank Account No.";
        IF CalculateIBAN(Rec."Country/Region Code", AccountNo, IBAN)THEN VALIDATE(IBAN);
    end;
    procedure CalculateIBAN(CountryCode: Code[10]; AccountNo: Code[100]; var IbanNo: Code[100]): Boolean var
        Modulus97: Integer;
        tmpIBAN: Code[100];
        I: Integer;
        Checksum: Code[2];
        Ch: Code[1];
    begin
        IF IbanNo <> '' THEN //OS.SPG
 IF NOT CONFIRM('Desea actualizar el IBAN?')THEN EXIT(FALSE);
        AccountNo:=DELCHR(AccountNo);
        IF ISOAccLen(CountryISO(CountryCode)) <> (STRLEN(AccountNo) + 4)THEN EXIT(FALSE);
        FOR I:=1 TO STRLEN(AccountNo)DO BEGIN
            Ch:=COPYSTR(AccountNo, I, 1);
            IF NOT(((Ch >= '0') AND (Ch <= '9')) OR ((Ch >= 'A') AND (Ch <= 'Z')))THEN EXIT(FALSE);
        END;
        AccountNo:=DELCHR(AccountNo);
        Modulus97:=97;
        tmpIBAN:=CountryISO(CountryCode) + '00' + AccountNo;
        ConvertIBAN(tmpIBAN);
        WHILE STRLEN(tmpIBAN) > 6 DO tmpIBAN:=CalcModulus(COPYSTR(tmpIBAN, 1, 6), Modulus97) + COPYSTR(tmpIBAN, 7);
        EVALUATE(I, tmpIBAN);
        I:=98 - (I MOD Modulus97);
        IF I < 10 THEN Checksum:='0' + FORMAT(I, 1)
        ELSE
            Checksum:=FORMAT(I, 2);
        tmpIBAN:=CountryISO(CountryCode) + Checksum + AccountNo;
        IF NOT CheckIBAN_Batch(tmpIBAN)THEN EXIT(FALSE);
        IbanNo:=tmpIBAN;
        EXIT(TRUE);
    end;
    procedure ISOAccLen(IsoCode: Code[10]): Integer begin
        CASE UPPERCASE(IsoCode)OF 'AD': EXIT(24); // Andorra
        'AE': EXIT(23); // United Arab Emirates
        'AL': EXIT(28); // Albania
        'AO': EXIT(25); // Angola
        'AT': EXIT(20); // Austria
        'AZ': EXIT(28); // Azerbaijan
        'BA': EXIT(20); // Bosnia and Herzegovina
        'BE': EXIT(16); // Belgium
        'BF': EXIT(27); // Burkina Faso
        'BG': EXIT(22); // Bulgaria
        'BH': EXIT(22); // Bahrain
        'BI': EXIT(16); // Burundi
        'BJ': EXIT(28); // Benin
        'CG': EXIT(27); // Congo
        'CH': EXIT(21); // Switzerland
        'CI': EXIT(28); // Ivory Coast
        'CM': EXIT(27); // Cameroon
        'CR': EXIT(21); // Costa Rica
        'CV': EXIT(25); // Cape Verde
        'CY': EXIT(28); // Cyprus
        'CZ': EXIT(24); // Czech Republic
        'DE': EXIT(22); // Germany
        'DK': EXIT(18); // Denmark
        'DO': EXIT(28); // Dominican Republic
        'EE': EXIT(20); // Estonia
        'ES': EXIT(24); // Spain
        'FI': EXIT(18); // Finland
        'FO': EXIT(18); // Faroe Islands
        'FR': EXIT(27); // France
        'GB': EXIT(22); // United Kingdom
        'GE': EXIT(22); // Georgia
        'GI': EXIT(23); // Gibraltar
        'GL': EXIT(18); // Greenland
        'GR': EXIT(27); // Greece
        'GT': EXIT(28); // Guatemala
        'HR': EXIT(21); // Croatia
        'HU': EXIT(28); // Hungary
        'IE': EXIT(22); // Ireland
        'IL': EXIT(23); // Israel
        'IR': EXIT(26); // Iran
        'IS': EXIT(26); // Iceland
        'IT': EXIT(27); // Italy
        'KW': EXIT(30); // Kuwait
        'KZ': EXIT(20); // Kazakhstan
        'LB': EXIT(28); // Lebanon
        'LI': EXIT(21); // Liechtenstein
        'LT': EXIT(20); // Lithuania
        'LU': EXIT(20); // Luxembourg
        'LV': EXIT(21); // Latvia
        'MC': EXIT(27); // Monaco
        'MD': EXIT(24); // Moldova
        'ME': EXIT(22); // Montenegro
        'MG': EXIT(27); // Madagascar
        'MK': EXIT(19); // Macedonia
        'ML': EXIT(28); // Mali
        'MR': EXIT(27); // Mauritania
        'MT': EXIT(31); // Malta
        'MU': EXIT(30); // Mauritius
        'MZ': EXIT(25); // Mozambique
        'NL': EXIT(18); // Netherlands
        'NO': EXIT(15); // Norway
        'PL': EXIT(28); // Poland
        'PS': EXIT(29); // Palestinian Territory
        'PT': EXIT(25); // Portugal
        'RO': EXIT(24); // Romania
        'RS': EXIT(22); // Serbia
        'SA': EXIT(24); // Saudi Arabia
        'SE': EXIT(24); // Sweden
        'SI': EXIT(19); // Slovenia
        'SK': EXIT(24); // Slovakia
        'SM': EXIT(27); // San Marino
        'SN': EXIT(28); // Senegal
        'TN': EXIT(24); // Tunisia
        'TR': EXIT(26); // Turkey
        'VG': EXIT(24); // British Virgin Islands
        ELSE
            EXIT(0);
        END;
    end;
    procedure CountryISO(CountryCode: Code[10]): Code[10]var
        Country: Record 9;
    begin
        IF CountryCode = '' THEN CountryCode:='ES';
        //IF NOT Country.GET(CountryCode) THEN
        Country.SETRANGE("ISO Code", CountryCode);
        IF NOT Country.FIND('-')THEN EXIT('');
        EXIT(Country."ISO Code");
    end;
    procedure CheckIBAN_Batch(IBANCode: Code[100]): Boolean var
        Modulus97: Integer;
        I: Integer;
    begin
        IF IBANCode = '' THEN EXIT;
        IBANCode:=DELCHR(IBANCode);
        Modulus97:=97;
        IF(STRLEN(IBANCode) <= 5) OR (STRLEN(IBANCode) > 34)THEN EXIT(FALSE);
        IF STRLEN(IBANCode) <> ISOAccLen(COPYSTR(IBANCode, 1, 2))THEN EXIT(FALSE);
        ConvertIBAN(IBANCode);
        WHILE STRLEN(IBANCode) > 6 DO IBANCode:=CalcModulus(COPYSTR(IBANCode, 1, 6), Modulus97) + COPYSTR(IBANCode, 7);
        EVALUATE(I, IBANCode);
        EXIT((I MOD Modulus97) = 1)end;
    procedure ConvertIBAN(VAR IBANCode: Code[100])
    var
        I: Integer;
    begin
        IBANCode:=COPYSTR(IBANCode, 5) + COPYSTR(IBANCode, 1, 4);
        I:=0;
        WHILE I < STRLEN(IBANCode)DO BEGIN
            I:=I + 1;
            IF ConvertLetter(IBANCode, COPYSTR(IBANCode, I, 1), I)THEN I:=0;
        END;
    end;
    procedure CalcModulus(Number: Code[10]; Modulus97: Integer): Code[10]var
        I: Integer;
    begin
        EVALUATE(I, Number);
        I:=I MOD Modulus97;
        IF I = 0 THEN EXIT('');
        EXIT(FORMAT(I));
    end;
    procedure ConvertLetter(VAR IBANCode: Code[100]; Letter: Code[1]; LetterPlace: Integer): Boolean var
        Letter2: Code[2];
    begin
        IF(Letter >= 'A') AND (Letter <= 'Z')THEN BEGIN
            CASE Letter OF 'A': Letter2:='10';
            'B': Letter2:='11';
            'C': Letter2:='12';
            'D': Letter2:='13';
            'E': Letter2:='14';
            'F': Letter2:='15';
            'G': Letter2:='16';
            'H': Letter2:='17';
            'I': Letter2:='18';
            'J': Letter2:='19';
            'K': Letter2:='20';
            'L': Letter2:='21';
            'M': Letter2:='22';
            'N': Letter2:='23';
            'O': Letter2:='24';
            'P': Letter2:='25';
            'Q': Letter2:='26';
            'R': Letter2:='27';
            'S': Letter2:='28';
            'T': Letter2:='29';
            'U': Letter2:='30';
            'V': Letter2:='31';
            'W': Letter2:='32';
            'X': Letter2:='33';
            'Y': Letter2:='34';
            'Z': Letter2:='35';
            END;
            IF LetterPlace = 1 THEN IBANCode:=Letter2 + COPYSTR(IBANCode, 2)
            ELSE
            BEGIN
                IF LetterPlace = STRLEN(IBANCode)THEN IBANCode:=COPYSTR(IBANCode, 1, LetterPlace - 1) + Letter2
                ELSE
                    IBANCode:=COPYSTR(IBANCode, 1, LetterPlace - 1) + Letter2 + COPYSTR(IBANCode, LetterPlace + 1);
            END;
            EXIT(TRUE);
        END;
        IF(Letter >= '0') AND (Letter <= '9')THEN EXIT(FALSE);
        IBANError;
    end;
    procedure IBANError()
    begin
        IF NOT CONFIRM(Text000)THEN ERROR('');
    end;
    var Text000: TextConst ENU = 'The number that you entered may not be a valid International Bank Account Number (IBAN). Do you want to continue?', ESP = 'Es posible que el número que ha introducido no sea un número de cuenta bancaria internacional (IBAN) válido. ¿Confirma que desea continuar?';
}
