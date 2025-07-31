pageextension 52047 "PostedSalesInvoices" extends "Posted Sales Invoices"
{
    // 052 OS.SPG  20/02/2017  PROY.003  Enviar facturas de venta según perfil de envío del proyecto
    Editable = false;

    layout
    {
        addafter("No. Printed")
        {
            field("Document sent"; Rec."Document sent")
            {
                ToolTip = 'Document sent';
                ApplicationArea = All;
            }
            field("Date Doc. sent"; Rec."Date Doc. sent")
            {
                ToolTip = 'Date Doc. sent';
                ApplicationArea = All;
            }
        }
        addafter(Corrective)
        {
            field("Job No."; Rec."Job No.")
            {
                ToolTip = 'Job No.';
                ApplicationArea = All;
            }
            field("Job Name"; Rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ToolTip = 'Your Reference';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SendCustom)
        {
            action(SendCustom2)
            {
                ToolTip = 'Send By Job';
                ApplicationArea = All;
                Caption = 'Send By Job';
                Ellipsis = true;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesInvHeader: Record 112;
                begin
                    //052
                    SalesInvHeader:=Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    IF SalesInvHeader.FIND('-')THEN REPEAT //3660 - ED
 SalesInvHeader.SendRecords2();
                        //3660 - ED END
                        UNTIL SalesInvHeader.Next() = 0;
                //052
                end;
            }
        }
    }
}
