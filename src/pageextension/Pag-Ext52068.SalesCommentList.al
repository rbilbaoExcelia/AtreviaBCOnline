pageextension 52068 "SalesCommentList" extends "Sales Comment List"
{
    // 008 OS.MIR  14/07/2016  FIN.008   Formato Impreso Factura de Venta
    Editable = false;

    layout
    {
        addafter(Comment)
        {
            field("Print On Invoices"; Rec."Print On Invoices")
            {
                ToolTip = 'Print On Invoices';
                ApplicationArea = All;
            }
        }
    }
}
