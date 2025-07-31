pageextension 52026 "GeneralLedgerSetup" extends "General Ledger Setup"
{
    layout
    {
        addafter("Discount Calculation")
        {
            field("Unit-Amount Rounding Precision"; Rec."Unit-Amount Rounding Precision")
            {
                ToolTip = 'Unit-Amount Rounding Precision';
                ApplicationArea = All;
            }
            field("Amount Rounding Precision"; Rec."Amount Rounding Precision")
            {
                ToolTip = 'Amount Rounding Precision';
                ApplicationArea = All;
            }
            field(OmmitAllCompanies; Rec.OmmitAllCompanies)
            {
                ToolTip = 'Omite todas compañias';
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
            }
        }
        addafter("Shortcut Dimension 8 Code")
        {
            field("Dimension Proyecto"; Rec."Dimension Proyecto")
            {
                ToolTip = 'Dimension Proyecto';
                ApplicationArea = All;
            }
        }
        addafter("Payroll Transaction Import") //"Importación de transacción de nómina")
        {
            group("Generacion lineas diario")
            {
                Caption = 'Generacion lineas diario';

                field("Libro generacion diario"; Rec."Libro generacion diario")
                {
                    ToolTip = 'Libro generacion diario';
                    ApplicationArea = All;
                    DrillDownPageID = "General Journal Templates";
                    LookupPageID = "General Journal Templates";
                }
                field("Seccion generacion diario"; Rec."Seccion generacion diario")
                {
                    ToolTip = 'Seccion generacion diario';
                    ApplicationArea = All;
                    DrillDownPageID = "General Journal Batches";
                    LookupPageID = "General Journal Batches";
                }
            }
        }
    }
}
