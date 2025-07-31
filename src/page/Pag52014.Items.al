page 52014 "Items"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = Item;

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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Search Description';
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Description 2';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Base Unit of Measure';
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Inventory Posting Group';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Unit Price';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Blocked';
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Last Date Modified';
                    ApplicationArea = All;
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    ToolTip = 'Price Includes VAT';
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    ToolTip = 'VAT Bus. Posting Gr. (Price)';
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Gen. Prod. Posting Group';
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'VAT Prod. Posting Group';
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ToolTip = 'Sales Unit of Measure';
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ToolTip = 'Purch. Unit of Measure';
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Item Category Code';
                    ApplicationArea = All;
                }
                field("SQL Synchronized"; Rec."SQL Synchronized")
                {
                    ToolTip = 'SQL Synchronized';
                    ApplicationArea = All;
                }
                field(ForSale; Rec.ForSale)
                {
                    ToolTip = 'ForSale';
                    ApplicationArea = All;
                }
                field(ForPurchase; Rec.ForPurchase)
                {
                    ToolTip = 'ForPurchase';
                    ApplicationArea = All;
                }
                field("Grouping Code"; Rec."Grouping Code")
                {
                    ToolTip = 'Grouping Code';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
