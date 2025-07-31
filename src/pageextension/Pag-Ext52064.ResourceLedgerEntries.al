pageextension 52064 "ResourceLedgerEntries" extends "Resource Ledger Entries"
{
    Editable = false;

    layout
    {
        addafter("Job No.")
        {
        /*TODO - "Job Name" not exists
            field("Job Name"; Rec."Job Name") 
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
            } */
        }
    }
}
