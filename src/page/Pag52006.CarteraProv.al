page 52006 "Cartera Prov."
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "CARTERA CLIENTS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ToolTip = 'EntryNo';
                    ApplicationArea = All;
                }
                field(CustomerNo; Rec.CustomerNo)
                {
                    ToolTip = 'CustomerNo';
                    ApplicationArea = All;
                }
                field(DocumentNo; Rec.DocumentNo)
                {
                    ToolTip = 'DocumentNo';
                    ApplicationArea = All;
                }
                field(BillNo; Rec.BillNo)
                {
                    ToolTip = 'BillNo';
                    ApplicationArea = All;
                }
                field(PostingDate; Rec.PostingDate)
                {
                    ToolTip = 'PostingDate';
                    ApplicationArea = All;
                }
                field(ExtDocNo; Rec.ExtDocNo)
                {
                    ToolTip = 'ExtDocNo';
                    ApplicationArea = All;
                }
                field(DocDate; Rec.DocDate)
                {
                    ToolTip = 'DocDate';
                    ApplicationArea = All;
                }
                field(DueDate; Rec.DueDate)
                {
                    ToolTip = 'DueDate';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Amount';
                    ApplicationArea = All;
                }
                field(RemAmount; Rec.RemAmount)
                {
                    ToolTip = 'RemAmount';
                    ApplicationArea = All;
                }
                field(SalespersonCode; Rec.SalespersonCode)
                {
                    ToolTip = 'SalespersonCode';
                    ApplicationArea = All;
                }
                field(TxtImporte; Rec.TxtImporte)
                {
                    ToolTip = 'TxtImporte';
                    ApplicationArea = All;
                }
                field(TxtImportePte; Rec.TxtImportePte)
                {
                    ToolTip = 'Importe';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
