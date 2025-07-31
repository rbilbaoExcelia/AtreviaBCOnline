report 52065 "Resumen IRPF Atrevia"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/ResumenIRPFAtrevia.rdlc';
    Permissions = TableData "MOV.CONTAB"=r;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(IRPF; "IRPF Atrevia")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "Account No.", "IRPF %", "Date Filter";

            column("IRPF_Código"; Code)
            {
            }
            column(IRPF_N__cuenta; "Account No.")
            {
            }
            column(IRPF_Filtro_fecha; "Date Filter")
            {
            }
            dataitem(Header; Integer)
            {
                DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=CONST(1));
                PrintOnlyIfDetail = true;

                column(USERID; USERID)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(TxtFilter; TxtFilter)
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column("IRPF_Descripción"; IRPF.Description)
                {
                }
                column(BaseCaption; BaseCaptionLbl)
                {
                }
                column(GLEntry__Document_No__Caption; GLEntry.FIELDCAPTION("Document No."))
                {
                }
                column(IRPFCaption; IRPFCaptionLbl)
                {
                }
                column(Importe_IRPFCaption; Importe_IRPFCaptionLbl)
                {
                }
                column(PROVEEDORCaption; PROVEEDORCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(RESUMEN_IRPFCaption; RESUMEN_IRPFCaptionLbl)
                {
                }
                column(GLEntry__External_Document_No__Caption; GLEntry.FIELDCAPTION("External Document No."))
                {
                }
                column(GLEntry__Posting_Date_Caption; GLEntry.FIELDCAPTION("Posting Date"))
                {
                }
                column(Header_Number; Number)
                {
                }
                column(FechaCap; FechaCap)
                {
                }
                column(DocExtCap; DocExtCap)
                {
                }
                dataitem(GLEntry;17)
                {
                    DataItemLink = "G/L Account No."=FIELD("Account No."), "Posting Date"=FIELD("Date Filter");
                    DataItemLinkReference = IRPF;
                    DataItemTableView = SORTING("G/L Account No.", "Posting Date")ORDER(Ascending)WHERE("Document Type"=FILTER(Invoice|"Credit Memo"));

                    column(GLEntry__Document_No__; "Document No.")
                    {
                    }
                    column(Vendor_Name; Vendor.Name)
                    {
                    }
                    column(PurchInv__Direct_Unit_Cost_; ROUND(PurchInv."Direct Unit Cost", 0.01))
                    {
                    }
                    column(Vendor__VAT_Registration_No__; Vendor."VAT Registration No.")
                    {
                    }
                    column(PurchInv_Quantity_100;-PurchInv.Quantity * 100)
                    {
                    }
                    column(GLEntry_Amount; Amount)
                    {
                    }
                    column(GLEntry__External_Document_No__; "External Document No.")
                    {
                    }
                    column(GLEntry__Posting_Date_; "Posting Date")
                    {
                    }
                    column(T_2_; T[2])
                    {
                    }
                    column(T_1_; T[1])
                    {
                    }
                    column(GLEntry_Entry_No_; "Entry No.")
                    {
                    }
                    column(GLEntry_G_L_Account_No_; "G/L Account No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        Amount:=-Amount;
                        IF NOT BuffVendor.GET("Source No.")THEN BEGIN
                            Vendor.GET("Source No.");
                            BuffVendor.TRANSFERFIELDS(Vendor);
                            BuffVendor.Insert();
                        END;
                        //IF FiltrarConfProv THEN                        //ANE.004
                        //IF BuffVendor."IRPF Code"<> IRPF.Code THEN //ANE.004  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        IF BuffVendor."IRPF Codigo" <> IRPF.Code THEN //ANE.004
 CurrReport.Skip(); //ANE.004
                        CASE GLEntry."Document Type" OF GLEntry."Document Type"::Invoice: BEGIN
                            PurchInv.SETRANGE("Document No.", GLEntry."Document No.");
                            PurchInv.SETRANGE(Type, PurchInv.Type::"G/L Account");
                            PurchInv.SETRANGE("No.", "G/L Account No.");
                            IF NOT PurchInv.FIND('-')THEN CurrReport.Skip();
                            PurchInvHeader.GET(GLEntry."Document No.");
                            //IF PurchInvHeader."VAT Registration No." <> '' THEN
                            //  Vendor."VAT Registration No." := PurchInvHeader."VAT Registration No.";
                            Vendor.Name:=PurchInvHeader."Buy-from Vendor Name";
                        END;
                        GLEntry."Document Type"::"Credit Memo": BEGIN
                            CMINv.SETRANGE("Document No.", GLEntry."Document No.");
                            CMINv.SETRANGE(Type, PurchInv.Type::"G/L Account");
                            CMINv.SETRANGE("No.", "G/L Account No.");
                            IF NOT CMINv.FIND('-')THEN CurrReport.Skip();
                            CMINvHeader.GET(GLEntry."Document No.");
                            IF CMINvHeader."VAT Registration No." <> '' THEN Vendor."VAT Registration No.":=CMINvHeader."VAT Registration No.";
                            Vendor.Name:=CMINvHeader."Buy-from Vendor Name";
                            PurchInv.TRANSFERFIELDS(CMINv);
                            PurchInv."Direct Unit Cost":=-PurchInv."Direct Unit Cost";
                            PurchInv.Quantity:=PurchInv.Quantity;
                            PurchInv."Line Amount":=-PurchInv."Line Amount";
                        END;
                        END;
                        Vendor:=BuffVendor;
                        IF PurchInv.Quantity > 0 THEN BEGIN //ANE.003
                            PurchInv."Direct Unit Cost"*=-1; //ANE.003
                            PurchInv.Quantity*=-1; //ANE.003
                        END; //ANE.003
                        //IF (PurchInv.Quantity IN [-1,1]) AND (Vendor."IRPF %" <> 0) THEN BEGIN  //ANE.002
                        IF(PurchInv.Quantity IN[-1, 1]) AND (Vendor."IRPF Pctg" <> 0)THEN BEGIN
                            //PurchInv.Quantity := -Vendor."IRPF %"/100;
                            PurchInv.Quantity:=-Vendor."IRPF Pctg" / 100; //ANE.002
                            PurchInv."Direct Unit Cost":=-Amount / PurchInv.Quantity; //ANE.002
                        END; //ANE.002
                        //ANE.002
                        IF PurchInv."Direct Unit Cost" * Amount < 0 THEN //ANE.002
 PurchInv."Direct Unit Cost":=-PurchInv."Direct Unit Cost"; //ANE.002
                        IF PurchInv."Direct Unit Cost" <> 0 THEN //ANE.002
 PurchInv.Quantity:=PurchInv.Amount / PurchInv."Direct Unit Cost"; //ANE.002
                        T[1]:=PurchInv."Direct Unit Cost";
                        T[2]:=Amount;
                        MemInt.Init();
                        MemInt."Cod 1":=Vendor."VAT Registration No.";
                        //
                        MemInt."Description 1":=Vendor.Address;
                        MemInt."Description 2":=Vendor."Post Code";
                        //
                        IF NOT MemInt.Find()then MemInt.Insert();
                        MemInt.Descripción:=Vendor.Name;
                        MemInt.Importe1+=PurchInv."Direct Unit Cost";
                        MemInt.Importe2:=PurchInv.Quantity;
                        MemInt.Importe3+=Amount;
                        MemInt.Importe4:=-PurchInv.Quantity * 100;
                        MemInt.Modify();
                    end;
                    trigger OnPreDataItem()
                    begin
                        CLEAR(T);
                    end;
                }
                dataitem(ShowCustomer; Integer)
                {
                    DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

                    column("MemInt_Descripción"; MemInt.Descripción)
                    {
                    }
                    column(MemInt_Importe1; MemInt.Importe1)
                    {
                    }
                    column(MemInt__Cod_1_; MemInt."Cod 1")
                    {
                    }
                    column(MemInt_Importe3; MemInt.Importe3)
                    {
                    }
                    column(MemInt_Importe3_Control1100007; MemInt.Importe3)
                    {
                    }
                    column(MemInt_Importe1_Control1100008; MemInt.Importe1)
                    {
                    }
                    column(BaseCaption_Control1100010; BaseCaption_Control1100010Lbl)
                    {
                    }
                    column(Importe_IRPFCaption_Control1100013; Importe_IRPFCaption_Control1100013Lbl)
                    {
                    }
                    column(PROVEEDyORCaption_Control1100014; PROVEEDORCaption_Control1100014Lbl)
                    {
                    }
                    column(RESUMEN_IRPFCaption_Control1100020; RESUMEN_IRPFCaption_Control1100020Lbl)
                    {
                    }
                    column(ShowCustomer_Number; Number)
                    {
                    }
                    column(MemInt_Direccion; MemInt."Description 1")
                    {
                    }
                    column(MemInt_CP; MemInt."Description 2")
                    {
                    }
                    column(MemIntIRPF_100; MemInt.Importe4)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT MemInt.FIND('-')THEN CurrReport.Break();
                        END
                        ELSE IF MemInt.Next() = 0 THEN CurrReport.Break();
                    end;
                    trigger OnPreDataItem()
                    begin
                        CurrReport.CREATETOTALS(MemInt.Importe1, MemInt.Importe3);
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                MemInt.Reset();
                MemInt.DeleteAll();
            end;
            trigger OnPreDataItem()
            begin
                TxtFilter:=GETFILTERS;
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
    labels
    {
    }
    var PurchInv: Record 123;
    CMINv: Record 125;
    PurchInvHeader: Record 122;
    CMINvHeader: Record 124;
    Vendor: Record 23;
    T: array[2]of Decimal;
    MemInt: Record "MemIntAcumulados Inv" temporary;
    TxtFilter: Text[1024];
    BuffVendor: Record 23 temporary;
    FiltrarConfProv: Boolean;
    BaseCaptionLbl: Label 'Base';
    IRPFCaptionLbl: Label '% IRPF';
    Importe_IRPFCaptionLbl: Label 'Imp. IRPF';
    PROVEEDORCaptionLbl: Label 'Proveedor';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    RESUMEN_IRPFCaptionLbl: Label 'RESUMEN IRPF';
    BaseCaption_Control1100010Lbl: Label 'Base';
    Importe_IRPFCaption_Control1100013Lbl: Label 'Importe IRPF';
    PROVEEDORCaption_Control1100014Lbl: Label 'Proveedor';
    RESUMEN_IRPFCaption_Control1100020Lbl: Label 'RESUMEN IRPF';
    FechaCap: Label 'Fecha Reg.';
    DocExtCap: Label 'Doc. Externo';
}
