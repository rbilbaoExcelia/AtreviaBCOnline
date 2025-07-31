pageextension 52079 "SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    layout
    {
        // addafter("Archive Quotes and Orders")//incompatibilidad25
        addlast(General)
        {
            field("Print on PDF"; Rec."Print on PDF")
            {
                ToolTip = 'Print on PDF';
                ApplicationArea = All;
            }
            field("Admin email"; Rec."Admin email")
            {
                ToolTip = 'Admin email';
                ApplicationArea = All;
            }
        }
        addafter("Number Series")
        {
            group(Atrevia)
            {
                Caption = 'Atrevia';

                field("Seminar Foot Text"; Rec."Seminar Foot Text")
                {
                    ToolTip = 'Seminar Foot Text';
                    ApplicationArea = All;
                }
                field("Salon Foot Text"; Rec."Salon Foot Text")
                {
                    ToolTip = 'Salon Foot Text';
                    ApplicationArea = All;
                }
            }
        }
    }
}
