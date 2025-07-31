pageextension 52074 "SalesInvoiceList" extends "Sales Invoice List"
{
    // 056
    Editable = false;

    layout
    {
        moveafter("Posting Date"; Amount)
        //moveafter(Amount; "Amount Including VAT")
        addafter("Shipment Date")
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
        }
    }
    var //"-----": 
 JobNo: Code[20];
//Unsupported feature: Code Insertion on "OnAfterGetRecord".
//trigger OnAfterGetRecord()
//var
//JobLibr: Codeunit "Job Library";
//RecRef: RecordRef;
//begin
/*
    //056
    {
    CLEAR(JobNo);
    RecRef.GETTABLE(Rec);
    "Job No." := JobLibr.GetJobNo(RecRef);
    }
    //056
    */
//end;
}
