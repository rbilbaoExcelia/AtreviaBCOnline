pageextension 52087 "VendorCard" extends "Vendor Card"
{
    layout
    {
        addafter(Name)
        {
            field("VAT Registration No"; Rec."VAT Registration No.")
            {
                ToolTip = 'VAT Registration No';
                ApplicationArea = All;
                Caption = 'VAT Registration No.';

                trigger OnDrillDown()
                var
                    VATRegistrationLogMgt: Codeunit 249;
                begin
                    VATRegistrationLogMgt.AssistEditVendorVATReg(Rec);
                end;
            }
        }
        moveafter(Name; County)
        moveafter(Name; "Primary Contact No.")
        addafter("Responsibility Center")
        {
            field("Codigo IAE"; Rec."Codigo IAE")
            {
                ToolTip = 'Codigo IAE';
                ApplicationArea = All;
                AssistEdit = false;
                TableRelation = IAE."Codigo IAE";
            }
            field(Sector; Rec."Sector AT")
            {
                ToolTip = 'Sector';
                ApplicationArea = All;
            }
        }
        addafter(Blocked)
        {
            field("Billing Class"; Rec."Billing Class")
            {
                ToolTip = 'Billing Class';
                ApplicationArea = All;
            }
            //3626  -  JX  -  2022 04 20
            field(Homologado; Rec.Homologado)
            {
                ToolTip = 'Homologado';
                ApplicationArea = All;
            }
            field("Fecha Homologacion"; Rec."Fecha Homologacion")
            {
                ToolTip = 'Fecha Homologacion';
                ApplicationArea = All;
            }
        //3626  -  JX  -  2022 04 20 END
        }
        addafter("Last Date Modified")
        {
            field(IBAN; Rec.IBAN)
            {
                ToolTip = 'IBAN';
                ApplicationArea = All;
                Enabled = false;
            }
        }
        moveafter("Balance Due (LCY)"; "IC Partner Code")
        moveafter("Prices Including VAT"; "Prepayment %")
        addafter("Prepayment %")
        {
            field("IRPF Codigo"; Rec."IRPF Codigo")
            {
                ToolTip = 'IRPF Codigo';
                ApplicationArea = All;
            }
            field("IRPF Pctg"; Rec."IRPF Pctg")
            {
                ToolTip = 'IRPF Pctg';
                ApplicationArea = All;
            }
        }
    }
}
