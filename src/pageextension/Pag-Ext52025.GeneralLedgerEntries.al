pageextension 52025 "GeneralLedgerEntries" extends "General Ledger Entries"
{
    // INFO - LOG DE CAMBIOS
    // INFO.001 OS.XM 20170424
    //          No mostrar los revertidos. //CANCELADO //WHERE(Reversed=CONST(false))
    Editable = false;

    layout
    {
        /* addafter("G/L Account No.")
        {
            field("Old G/L Account No."; Rec."Old G/L Account No.")
            {
                ToolTip = 'Old G/L Account No.';
                ApplicationArea = All;
                Visible = false;
            }
        } */
        addafter("Job No.")
        {
            field("Job Name"; Rec."Job Name")
            {
                ToolTip = 'Job Name';
                ApplicationArea = All;
            }
            //3653  -  MRF  -  2022 05 02
            field("Transaction No."; rec."Transaction No.")
            {
                ToolTip = 'Transactoin No.';
                ApplicationArea = all;
            }
        //3653  -  MRF  -  2022 05 02 END
        }
        addafter("Global Dimension 2 Code")
        {
            field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
            {
                ToolTip = 'Global Dimension 3 Code';
                ApplicationArea = All;
            }
            field("Global Dimension3 Name"; "Global Dimension3 Name")
            {
                ToolTip = 'Global Dimension3 Name';
                ApplicationArea = All;
                Caption = 'Global Dimension 3 Name ';
            }
        }
        moveafter("Gen. Prod. Posting Group"; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        addafter("Reason Code")
        {
            field("Source No. Atr"; Rec."Source No.")
            {
                ToolTip = 'Source No.';
                ApplicationArea = All;
            }
        }
        addafter("Entry No.")
        {
        /*
            field("Business Unit Code"; Rec."Business Unit Code")
            {
                ToolTip = 'Business Unit Code';
                ApplicationArea = All;
            }
            */
        }
    }
    var "Global Dimension3 Name": Text[50];
    DimensionSetEntry: Record 480;
    trigger OnAfterGetRecord()
    begin
        //123
        CLEAR("Global Dimension3 Name");
        DimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
        DimensionSetEntry.SETRANGE("Dimension Code", 'PROYECTO');
        IF DimensionSetEntry.FIND('-')THEN BEGIN
            DimensionSetEntry.CALCFIELDS("Dimension Value Name");
            "Global Dimension3 Name":=DimensionSetEntry."Dimension Value Name";
        END;
    //123
    end;
}
