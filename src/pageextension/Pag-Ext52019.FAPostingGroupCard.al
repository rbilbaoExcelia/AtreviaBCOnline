pageextension 52019 "FAPostingGroupCard" extends "FA Posting Group Card"
{
    layout
    {
        addafter("Losses Acc. on Disposal")
        {
            field("Default Depreciation Years"; Rec."Default Depreciation Years")
            {
                ToolTip = 'Default Depreciation Years';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(Allocations)
        {
            action(Acquisition)
            {
                ToolTip = 'Acquisition';
                ApplicationArea = All;
                Caption = 'Acquisition';
                Image = Allocate;
                RunObject = Page 5623;
                RunPageLink = Code=FIELD(Code), "Allocation Type"=CONST(Acquisition);
            }
        }
        addafter(Custom2)
        {
            action("Disp&osal")
            {
                ToolTip = 'Disposal';
                ApplicationArea = All;
                Caption = 'Disposal';
                Image = Allocate;
                RunObject = Page 5623;
                RunPageLink = Code=FIELD(Code), "Allocation Type"=CONST(Disposal);
            }
        }
        addafter(Loss)
        {
            action("Book Value (Gain)")
            {
                ToolTip = 'Book Value (Gain)';
                ApplicationArea = All;
                Caption = 'Book Value (Gain)';
                Image = Allocate;
                RunObject = Page 5623;
                RunPageLink = Code=FIELD(Code), "Allocation Type"=CONST("Book Value (Gain)");
            }
            action("Book &Value (Loss)")
            {
                ToolTip = 'Book &Value (Loss)';
                ApplicationArea = All;
                Caption = 'Book &Value (Loss)';
                Image = Allocate;
                RunObject = Page 5623;
                RunPageLink = Code=FIELD(Code), "Allocation Type"=CONST("Book Value (Loss)");
            }
        }
    }
}
