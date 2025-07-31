pageextension 52013 "CompanyInformationPT" extends "Company Information"
{
    layout
    {
        addafter("CNAE Description")
        {
            field("Consolidated Company"; Rec.Consolidated)
            {
                ToolTip = 'Consolidated Company';
                ApplicationArea = All;
            }
            field("Omite Comparticion Datos"; "Omite Comparticion Datos")
            {
                ApplicationArea = All;
            }
        }
        addafter(Picture)
        {
            field("Invoice Down Picture"; Rec."Invoice Down Picture")
            {
                ToolTip = 'Invoice Down Picture';
                ApplicationArea = All;
            }
            field("Invoice Right Picture"; Rec."Invoice Right Picture")
            {
                ToolTip = 'Invoice Right Picture';
                ApplicationArea = All;
            }
        }
        // SAR  -  2024 19 01  -  Correcion de campo
        addlast(Communication)
        // SAR  -  2024 19 01  -  Correcion de campo END
        {
            field("Invoice Text 1"; Rec."Invoice Text 1")
            {
                ToolTip = 'Invoice Text 1';
                ApplicationArea = All;
            }
            field("Invoice Text 2"; Rec."Invoice Text 2")
            {
                ToolTip = 'Invoice Text 2';
                ApplicationArea = All;
            }
            field("Invoice Text 3"; Rec."Invoice Text 3")
            {
                ToolTip = 'Invoice Text 3';
                ApplicationArea = All;
            }
            field("Invoice Text 4"; Rec."Invoice Text 4")
            {
                ToolTip = 'Invoice Text 4';
                ApplicationArea = All;
            }
            field("Invoice Text 5"; Rec."Invoice Text 5")
            {
                ToolTip = 'Invoice Text 5';
                ApplicationArea = All;
            }
            field("Commercial Register Text"; Rec."Commercial Register Text")
            {
                ToolTip = 'Commercial Register Text';
                ApplicationArea = All;
            }
        }
        addafter("System Indicator")
        {
            group("SAF-T Portugal")
            {
                Caption = 'SAF-T Portugal';

                field("Use SAF-T"; Rec."Use SAF-T")
                {
                    ToolTip = 'Use SAF-T';
                    ApplicationArea = All;
                }
                field("Registration Authority PT"; Rec."Registration Authority PT")
                {
                    ToolTip = 'Registration Authority';
                    ApplicationArea = All;
                }
                field("Business Name PT"; Rec."Business Name PT")
                {
                    ToolTip = 'Business Name';
                    ApplicationArea = All;
                }
                field("Software Vendor VAT PT"; Rec."Software Vendor VAT PT")
                {
                    ToolTip = 'Software Vendor VAT';
                    ApplicationArea = All;
                }
                field("Soft. Certificate Number PT"; Rec."Soft. Certificate Number PT")
                {
                    ToolTip = 'Soft. Certificate Number';
                    ApplicationArea = All;
                }
                field("Soft. Certificate Number 2"; Rec."Soft. Certificate Number 2")
                {
                    ToolTip = 'Soft. Certificate Number 2';
                    ApplicationArea = All;
                }
            }
        }
        moveafter("Country/Region Code"; County)
        moveafter("Ship-to Contact"; "Ship-to County")
        moveafter("Address 2"; "Post Code")
        moveafter("Ship-to Address 2"; "Ship-to Post Code")
    }
    actions
    {
        //previusly in "Responsability Center"
        addfirst("System Settings")
        {
            separator(Separator)
            {
            }
            action("Online Map")
            {
                ToolTip = 'Online Map';
                ApplicationArea = All;
                Caption = 'Online Map';
                Image = Map;

                trigger OnAction()
                begin
                    Rec.DisplayMap();
                end;
            }
        }
    }
}
