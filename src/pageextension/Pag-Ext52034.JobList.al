pageextension 52034 "JobList" extends "Job List"
{
    // 030 OS.MIR  20/06/2016  PROY.005  Facturación multicliente desde proyecto
    //EX-RBF 220922 Añadidos campos CÓD. CLIENTE FINAL y NOMBRE CLIENTE FINAL
    Editable = false;

    layout
    {
        addafter(Description)
        {
            field("Creation Date"; Rec."Creation Date")
            {
                ToolTip = 'Creation Date';
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Customer No.")
        {
            field("Job Type"; Rec."Job Type AT")
            {
                ToolTip = 'Job Type';
                ApplicationArea = All;
            }
            //3652  -  MRF  -  2022 04 29
            field("Tipo de Origen"; rec."Tipo de Origen AT")
            {
                ToolTip = 'Origin Type';
                ApplicationArea = all;
            }
            field("External Job Document No."; rec."External Job Document No. AT")
            {
                ToolTip = 'External Job Document No.';
                ApplicationArea = all;
            }
            //3652  -  MRF  -  2022 04 29 END
            field("Cod Cliente Final"; rec."Cod Cliente Final")
            {
                ApplicationArea = all;
            } //EX-RBF 220922
            field("Nombre Cliente Final"; rec."Nombre Cliente Final")
            {
                ApplicationArea = all;
            } //EX-RBF 220922
        }
        addafter(Status)
        {
            field("Billable Expenses"; Rec."Billable Expenses AT")
            {
                ToolTip = 'Billable Expenses';
                ApplicationArea = All;
            }
            field("Expenses Surcharge %"; Rec."Expenses Surcharge % AT")
            {
                ToolTip = 'Expenses Surcharge %';
                ApplicationArea = All;
            }
        }
        addafter("% Invoiced")
        {
            field("Old Dimension 1"; Rec."Old Dimension 1 AT")
            {
                ToolTip = 'Old Dimension 1';
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ToolTip = 'Global Dimension 1';
                ApplicationArea = All;
                Visible = true;
            }
            field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
            {
                ToolTip = 'Global Dimension 2';
                ApplicationArea = All;
                Visible = true;
            }
        }
        //3625 - ED
        addlast(Control1)
        {
            field(StatusAT; Rec.Status)
            {
                ApplicationArea = All;
            }
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = All;
            }
            field("Origen AT"; Rec."Origen AT")
            {
                ApplicationArea = All;
            }
            field("Tipo de Origen AT"; Rec."Tipo de Origen AT")
            {
                ApplicationArea = All;
            }
            field("Person Responsible AT"; Rec."Person Responsible")
            {
                ApplicationArea = All;
            }
        }
    }
}
