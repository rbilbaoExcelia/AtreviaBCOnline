report 52064 "Resources Time Control"
{
    // 145 OS.RM  07/06/2017  FIN.011   Informe Control Horas Recursos
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ResourcesTimeControl.rdlc';
    Caption = 'Resources Time Control';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Resource;156)
        {
            DataItemTableView = SORTING("No.")WHERE("Without Time Control AT"=CONST(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(ResNo; Resource."No.")
            {
            }
            column(ResName; Resource.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CurrReport_Title; CurrReport_TitleLbl)
            {
            }
            column(ReportDate; ReportDate)
            {
            }
            column(CodeText; CodeTextLbl)
            {
            }
            column(NameText; NameTextLbl)
            {
            }
            column(DateText; DateTextLbl)
            {
            }
            column(IncidText; IncidTextLbl)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = SORTING("Period Type", "Period Start");

                column(SDate; Date."Period Start")
                {
                }
                column(SDateName; Date."Period Name")
                {
                }
                column(Accumulated; Accum)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CLEAR(Accum);
                    xResEntry.Reset();
                    xResEntry.SETCURRENTKEY(xResEntry."Resource No.", xResEntry."Posting Date");
                    xResEntry.SETRANGE(xResEntry."Resource No.", Resource."No.");
                    xResEntry.SETRANGE(xResEntry."Posting Date", Date."Period Start");
                    IF NOT xResEntry.FIND('-')THEN xResEntry.INIT
                    ELSE
                    BEGIN
                        REPEAT Accum:=Accum + xResEntry.Quantity;
                        UNTIL xResEntry.Next() = 0;
                    END;
                    //IF Accum <> 0 THEN
                    //  CurrReport.Skip();
                    //<
                    IF Accum = 0 THEN BEGIN
                        //>
                        IF SendMail THEN BEGIN
                            MemIntMail.Init();
                            MemIntMail."Cod 1":=Resource."No.";
                            MemIntMail."Cod 2":=FORMAT(Date."Period Start");
                            MemIntMail.Txt1:=Date."Period Name";
                            IF NOT MemIntMail.Insert()then;
                        END;
                        //<
                        CurrReport.Skip();
                    END;
                //>
                end;
                trigger OnPreDataItem()
                begin
                    IF(Resource."Incorporation Date AT" > Resource."Leaving Date AT") AND (Resource."Leaving Date AT" > 19800101D)THEN BEGIN
                        MemInt.Init();
                        MemInt."Cod 1":=Resource."No.";
                        MemInt.Txt1:=Resource.Name;
                        MemInt.Txt2:='Se deben revisar la fechas de alta y baja';
                        MemInt.Insert();
                    END;
                    IF FromDate < Resource."Incorporation Date AT" THEN FromDate2:=Resource."Incorporation Date AT"
                    ELSE
                        FromDate2:=FromDate;
                    IF(ToDate > Resource."Leaving Date AT") AND (Resource."Leaving Date AT" > 19800101D)THEN ToDate2:=Resource."Leaving Date AT"
                    ELSE
                        ToDate2:=ToDate;
                    Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                    Date.SETRANGE(Date."Period Start", FromDate2, ToDate2);
                    Date.SETFILTER(Date."Period No.", '1..5');
                    IF NOT Date.FIND('-')THEN Date.Init();
                end;
            }
            trigger OnPreDataItem()
            begin
                IF(FromDate = 0D) OR (ToDate = 0D)THEN ERROR('Se deben especificar las fechas para el control de horas');
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

            column(IncCode; MemInt."Cod 1")
            {
            }
            column(IncText1; MemInt.Txt1)
            {
            }
            column(IncText2; MemInt.Txt2)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number > 1 THEN IF MemInt.Next() = 0 THEN CurrReport.Break();
                MemInt.Find();
            end;
            trigger OnPreDataItem()
            begin
                IF NOT MemInt.FIND('-')THEN CurrReport.Break();
            end;
        }
        dataitem(SendingMail; Integer)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1));

            trigger OnAfterGetRecord()
            begin
            // IF Number > 1 THEN
            //  IF MemIntMail.Next() = 0 THEN BEGIN
            //    IF ResID <> '' THEN
            //      //CreateMail;
            //    CurrReport.Break();
            //  END;
            // MemIntMail.Find();
            //
            // IF MemIntMail."Cod.1" <> ResID THEN BEGIN
            //  CreateMail;
            //  ResID := GetResCode;
            //  HeaderTxt := '';
            //  //InitializeMail;
            //  HeaderTxt := 'Estimado/a ' + Resource.Name + ', para que la información remitida a Dirección sea fiable ' +
            //    'debes completar tu timing. Según consta en la web, faltan los siguientes días: <BR>';
            //
            // END;
            //
            // HeaderTxt := HeaderTxt + '<BR>' + MemIntMail.Txt1 + ' ' + FORMAT(MemIntMail."Cod.2") + ', ';
            end;
            trigger OnPreDataItem()
            begin
                IF NOT MemIntMail.FindFirst()then CurrReport.Break();
            /*Todo: ? 
                //CREATE(olApp,TRUE,TRUE);
                //olUserSend := olApp.GetNamespace('MAPI');
                Name := 'Victor';
                Subject := 'Urgente: Completa tu timing';
                Body := 'Estimado/a ' + Name + ', para que la información remitida a Dirección sea fiable ' +
                    'debes completar tu timing. Según consta en la web, faltan los siguientes días: ';
                Body := Body + ' Adios';
                Mail.CreateMessage('rm@olivia.es', '', '', Subject, Body, TRUE, FALSE);
                //Mail.NewMessage('vcruz@marquesolivia.com','','', Subject, Body, '', TRUE);
                Mail.AddBodyline(Body);
                Mail.Send;
                MESSAGE(FORMAT(Mail.TryInitializeOutlook));

                IF MemIntMail."Cod 1" <> ResID THEN BEGIN
                    ResID := GetResCode;
                    HeaderTxt := '';
                    //InitializeMail; 
            END;*/
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(FromDate; FromDate)
                    {
                        Caption = 'From Date';
                        ToolTip = 'From Date';
                        ApplicationArea = All;
                    }
                    field(ToDate; ToDate)
                    {
                        Caption = 'To Date';
                        ToolTip = 'To Date';
                        ApplicationArea = All;
                    }
                    field(SendMail; SendMail)
                    {
                        Caption = 'Send Mail';
                        ToolTip = 'Send Mail';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        MemInt.DeleteAll();
        MemIntMail.DeleteAll();
    end;
    trigger OnPreReport()
    begin
        MemInt.DeleteAll();
        MemIntMail.DeleteAll();
        ReportDate:=WorkDate();
    end;
    var LastFleldNo: Integer;
    FooterPrinted: Boolean;
    FromDate: Date;
    ToDate: Date;
    MemInt: Record MemIntFra temporary;
    xResEntry: Record 203;
    Accum: Decimal;
    Mail: Codeunit 397;
    MemIntMail: Record MemIntFra temporary;
    SendMail: Boolean;
    ResID: Code[20];
    HeaderTxt: Text[1024];
    ToDate2: Date;
    FromDate2: Date;
    CurrReport_TitleLbl: Label 'Net Revenue Ranking';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    ReportDate: Date;
    CodeTextLbl: Label 'Code';
    NameTextLbl: Label 'Name';
    DateTextLbl: Label 'Date';
    IncidTextLbl: Label 'Incidences';
    Subject: Text;
    Body: Text;
    email: Codeunit 397;
    Name: Text;
    procedure CreateMail()
    begin
    //HeaderTxt := HeaderTxt + '<P>Por favor, recuerda rellenar diariamente los partes, y en su defecto, introduce en la web las horas ' +
    //'de la semana los viernes a más faltar, y recuerda que si tienes problemas con la web el departamento de Administración ' +
    //'está a tu disposición para ayudarte.';
    //olMailNew.HTMLBody := HeaderTxt;
    //olMailNew.Display;
    //IF Resource."E-Mail" <> '' THEN
    //olMailNew.Send
    //ELSE
    //olMailNew.Save;
    end;
    procedure InitializeMail()
    begin
    //olUserSend.Logon('OUTLOOK', 'carles0702', TRUE, TRUE);
    //olMailNew := olApp.CreateItem(0);
    //olMailNew."To" := Resource."E-Mail";
    //olMailNew.Subject := 'Urgente: Completa tu timing';
    //olMailNew.BodyFormat(1);
    //HeaderTxt := 'Estimado/a ' + Resource.Name + ', para que la información remitida a Dirección sea fiable ' +
    //'debes completar tu timing. Según consta en la web, faltan los siguientes días: <BR>';
    end;
    procedure GetResCode()"Código": Code[20]begin
        Resource.GET(MemIntMail."Cod 1");
        EXIT(MemIntMail."Cod 1");
    end;
}
