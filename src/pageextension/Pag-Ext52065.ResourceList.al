pageextension 52065 "ResourceList" extends "Resource List"
{
    Editable = false;

    layout
    {
        addafter(Type)
        {
            field("Incorporation Date"; Rec."Incorporation Date AT")
            {
                ToolTip = 'Incorporation Date';
                ApplicationArea = All;
            }
            field("Leaving Date"; Rec."Leaving Date AT")
            {
                ToolTip = 'Leaving Date';
                ApplicationArea = All;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field(Holidays; Rec."Holidays AT")
            {
                ToolTip = 'Holidays';
                ApplicationArea = All;
                Visible = false;
            }
            field("Remaining Days"; Rec."Remaining Days AT")
            {
                ToolTip = 'Remaining Days';
                ApplicationArea = All;
            }
            field("<Remaining Days>"; Rec."Extra Days AT")
            {
                ToolTip = 'Remaining Days (Extra Days)';
                ApplicationArea = All;
            }
            field("Accumulated Days"; Rec."Accumulated Days AT")
            {
                ToolTip = 'Accumulated Days';
                ApplicationArea = All;
                Visible = false;
            }
            field("Other Days"; Rec."Other Days AT")
            {
                ToolTip = 'Other Days';
                ApplicationArea = All;
            }
        }
        addafter("Search Name")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ToolTip = 'Global Dimension 1 Code';
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ToolTip = 'Global Dimension 2 Code';
                ApplicationArea = All;
            }
            field("Old Dimension 1 Code"; Rec."Old Dimension 1 Code AT")
            {
                ToolTip = 'Old Dimension 1 Code';
                ApplicationArea = All;
                Visible = false;
            }
            field("Old Dimension 2 Code"; Rec."Old Dimension 2 Code AT")
            {
                ToolTip = 'Old Dimension 2 Code';
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Default Deferral Template Code")
        {
            field("E-Mail"; Rec."E-Mail AT")
            {
                ToolTip = 'E-Mail';
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //INF
        //SETFILTER( "Date Filter", '%1..%2', DMY2DATE(1, 1, DATE2DMY(TODAY, 3) -1), DMY2DATE(31, 12, DATE2DMY(TODAY, 3) -1));
        //SETFILTER( "Date Filter", '%1..%2', DMY2DATE(1, 1, DATE2DMY(TODAY, 3)), DMY2DATE(31, 12, DATE2DMY(TODAY, 3)));
        Rec.CALCFIELDS("Extra Days AT", "Accumulated Days AT");
        Rec."Extra Days AT":=Rec."Extra Days AT" / 8;
        Rec."Accumulated Days AT":=Rec."Accumulated Days AT" / 8;
        Rec."Other Days AT":=Rec."Holidays AT" + Rec."Remaining Days AT" + Rec."Extra Days AT" - Rec."Accumulated Days AT";
    //INF
    end;
    procedure DiasPendientes()DiasAcum: Decimal var
        res: Record 156;
    begin
    /*
        //<INF.001
        IF res.GET("No.") THEN BEGIN
          res.SETFILTER( "Date Filter", '%1..%2', DMY2DATE(1, 1, DATE2DMY(TODAY, 3) -1), DMY2DATE(31, 12, DATE2DMY(TODAY, 3) -1));
          res.CALCFIELDS();
          EXIT("Dias Vacaciones" - (res."Dias Acumulados")/8)
        
        END
        */
    //INF.001>
    end;
}
