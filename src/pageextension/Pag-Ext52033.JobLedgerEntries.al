pageextension 52033 "JobLedgerEntries" extends "Job Ledger Entries"
{
    Editable = false;

    layout
    {
        moveafter("Job Posting Group"; "Global Dimension 1 Code")
        moveafter("Global Dimension 1 Code"; "Global Dimension 2 Code")
        addafter("Total Cost (LCY)")
        {
            field("Job Assistant"; Rec."Job Assistant")
            {
                ToolTip = 'Job Assistant';
                ApplicationArea = All;
            }
        }
        addafter(Adjusted)
        {
            field("Company source"; Rec."Company source")
            {
                ToolTip = 'Company source';
                ApplicationArea = All;
                Caption = 'Company source';
            }
        }
    }
    var ActiveField: Option " ", Cost, CostLCY, PriceLCY, Price;
    trigger OnOpenPage()
    begin
        IF ActiveField = 1 THEN;
        IF ActiveField = 2 THEN;
        IF ActiveField = 3 THEN;
        IF ActiveField = 4 THEN;
    end;
    procedure SetActiveField(ActiveField2: Integer)
    begin
        ActiveField:=ActiveField2;
    end;
}
