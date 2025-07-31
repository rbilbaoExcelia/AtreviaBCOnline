pageextension 52044 "PostedSalesCreditMemos" extends "Posted Sales Credit Memos"
{
    // 052 OS.SPG  20/02/2017  PROY.003  Enviar facturas de venta según perfil de envío del proyecto
    Editable = false;

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
                    SalesCrMemoHeader: Record 114;
                begin
                    //052
                    SalesCrMemoHeader:=Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    IF SalesCrMemoHeader.FIND('-')THEN REPEAT SalesCrMemoHeader.SendRecords2;
                        UNTIL SalesCrMemoHeader.Next() = 0;
                //052
                end;
            }
        }
    }
}
