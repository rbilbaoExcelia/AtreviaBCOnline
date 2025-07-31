page 52017 "Listado bancos MIGR.NOV"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = 270;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Name';
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Search Name';
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Name 2';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Address';
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Address 2';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'City';
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Contact';
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Phone No.';
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Bank Account No.';
                    ApplicationArea = All;
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ToolTip = 'Territory Code';
                    ApplicationArea = All;
                }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
                {
                    ToolTip = 'Bank Acc. Posting Group';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Currency Code';
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Language Code';
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Country/Region Code';
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Post Code';
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ToolTip = 'County';
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'E-Mail';
                    ApplicationArea = All;
                }
                field(IBAN; Rec.IBAN)
                {
                    ToolTip = 'IBAN';
                    ApplicationArea = All;
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ToolTip = 'SWIFT Code';
                    ApplicationArea = All;
                }
                field("CCC Bank No."; Rec."CCC Bank No.")
                {
                    ToolTip = 'CCC Bank No.';
                    ApplicationArea = All;
                }
                field("CCC Bank Branch No."; Rec."CCC Bank Branch No.")
                {
                    ToolTip = 'CCC Bank Branch No.';
                    ApplicationArea = All;
                }
                field("CCC Control Digits"; Rec."CCC Control Digits")
                {
                    ToolTip = 'CCC Control Digits';
                    ApplicationArea = All;
                }
                field("CCC Bank Account No."; Rec."CCC Bank Account No.")
                {
                    ToolTip = 'CCC Bank Account No.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
