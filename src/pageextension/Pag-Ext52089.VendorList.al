pageextension 52089 "VendorList" extends "Vendor List"
{
    // 025 OS.MIR  29/06/2016  COM.002   Texto descriptivo timming a pedidos de compra (Sincronización SQL)
    Editable = false;

    layout
    {
        addafter(Name)
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ToolTip = 'VAT Registration No.';
                ApplicationArea = All;
            }
        }
        addafter("Country/Region Code")
        {
            field("Purchases (LCY)"; Rec."Purchases (LCY)")
            {
                ToolTip = 'Purchases (LCY)';
                ApplicationArea = All;
            }
            field(Balance; Rec.Balance)
            {
                ToolTip = 'Balance';
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ToolTip = 'Net Change';
                ApplicationArea = All;
            }
            //3651  -  MRF  -  2022 04 29
            field(Homologado; rec.Homologado)
            {
                ToolTip = 'Homologado';
                ApplicationArea = all;
            }
            field("Fecha Homologacion"; rec."Fecha Homologacion")
            {
                ToolTip = 'Fecha Homologacion';
                ApplicationArea = all;
            }
        //3651  -  MRF  -  2022 04 29 END
        }
        addafter("Fax No.")
        {
            field("Codigo IAE"; Rec."Codigo IAE")
            {
                ToolTip = 'Codigo IAE';
                ApplicationArea = All;
            }
            field(Sector; Rec."Sector AT")
            {
                ToolTip = 'Sector';
                ApplicationArea = All;
            }
        }
        addafter("Language Code")
        {
            field(IBAN; Rec.IBAN)
            {
                ToolTip = 'IBAN';
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
            field("E-Mail"; Rec."E-Mail")
            {
                ToolTip = 'E-Mail';
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
}
