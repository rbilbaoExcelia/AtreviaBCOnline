pageextension 52090 "CustomerCard" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Mandatory Purch. Order"; Rec."Mandatory Purch. Order")
            {
                ToolTip = 'Mandatory Purch. Order';
                ApplicationArea = All;
            }
            field(Sector; Rec.Sector)
            {
                ToolTip = 'Sector';
                ApplicationArea = All;
            }
            field(Subsector; Rec.Subsector)
            {
                ToolTip = 'Subsector';
                ApplicationArea = All;
            }
            field("Tipo empresa"; Rec."Tipo empresa")
            {
                ToolTip = 'Tipo empresa';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast("&Customer")
        {
            action("Movs. Prediccion de pago")
            {
                ApplicationArea = All;
                Caption = 'Movs. Predicción de pago';
                Image = CustomerLedger;
                RunObject = Page "Movimientos Prediccion Pago";
                RunPageLink = "Customer No."=FIELD("No.");
                RunPageView = SORTING("Customer No.")ORDER(Descending);
            }
        }
    }
    //EX-RBF 010323 Fin
    var myInt: Integer;
}
