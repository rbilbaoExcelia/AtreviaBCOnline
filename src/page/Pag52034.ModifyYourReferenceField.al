page 52034 "ModifyYourReferenceField"
{
    Caption = 'Modificar campo Su/ntra referencia';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(localYourRefence; localYourRefence)
                {
                    ToolTip = 'Su/ntra referencia';
                    Caption = 'Su/ntra referencia';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Update)
            {
                ApplicationArea = All;
                Caption = 'Update';
                ToolTip = 'Update';
                PromotedIsBig = true;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    UpdateSalesInvHrd: Codeunit UpdateSalesInvHrd;
                begin
                    UpdateSalesInvHrd.UpdateYourReference(SalesInvNo, localYourRefence);
                    Message('Campo modificado');
                end;
            }
        }
    }
    var localYourRefence: Text[35];
    SalesInvNo: Code[20];
    procedure InitPage(SalesInvHrd: record "Sales Invoice Header")
    begin
        localYourRefence:=SalesInvHrd."Your Reference";
        SalesInvNo:=SalesInvHrd."No.";
    end;
}
