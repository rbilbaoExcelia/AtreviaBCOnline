pageextension 52031 "JobCard" extends "Job Card"
{
    layout
    {
        moveafter("Bill-to Country/Region Code"; "Bill-to County")
        addafter("Person Responsible")
        {
            field("External Job Document No."; Rec."External Job Document No. AT")
            {
                ToolTip = 'External Job Document No.';
                ApplicationArea = All;
            }
            field("Mandatory Purch. Order"; Rec."Mandatory Purch. Order AT")
            {
                ToolTip = 'Mandatory Purch. Order';
                ApplicationArea = All;
                Editable = false;
            }
            field("Business Office Code"; Rec."Business Office Code AT")
            {
                ToolTip = 'Business Office Code';
                ApplicationArea = All;
            }
            field("Expenses Surcharge %"; Rec."Expenses Surcharge % AT")
            {
                ToolTip = 'Expenses Surcharge %';
                ApplicationArea = All;
            }
            field("Billable Expenses"; Rec."Billable Expenses AT")
            {
                ToolTip = 'Billable Expenses';
                ApplicationArea = All;
            }
            field("Expenses on same Invoice"; Rec."Expenses on same Invoice AT")
            {
                ToolTip = 'Expenses on same Invoice';
                ApplicationArea = All;
            }
            field("Expenses Text"; Rec."Expenses Text AT")
            {
                ToolTip = 'Expenses Text';
                ApplicationArea = All;
            }
            field("Job Type"; Rec."Job Type AT")
            {
                ToolTip = 'Job Type';
                ApplicationArea = All;
                Importance = Promoted;
                ShowMandatory = true;
            }
            field("Billing Concept"; Rec."Billing Concept AT")
            {
                ToolTip = 'Billing Concept';
                ApplicationArea = All;
                Caption = 'Concepto facturación';
            }
            field("Billing Company"; Rec."Billing Company AT")
            {
                ToolTip = 'Billing Company';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Last Date Modified")
        {
            field("Invoice Text 1"; Rec."Invoice Text 1 AT")
            {
                ToolTip = 'Invoice Text 1';
                ApplicationArea = All;
                Importance = Additional;
            }
            field("Invoice Text 2"; Rec."Invoice Text 2 AT")
            {
                ToolTip = 'Invoice Text 2';
                ApplicationArea = All;
                Importance = Additional;
            }
            field("Invoice Text 3"; Rec."Invoice Text 3 AT")
            {
                ToolTip = 'Invoice Text 3';
                ApplicationArea = All;
                Importance = Additional;
            }
            field(Template; Rec."Template AT")
            {
                ToolTip = 'Template';
                ApplicationArea = All;
            }
            field("Blocked Template"; Rec."Blocked Template AT")
            {
                ToolTip = 'Blocked Template';
                ApplicationArea = All;
            }
            field(Origen; Rec."Origen AT")
            {
                ToolTip = 'Origen';
                ApplicationArea = All;
            }
            field("Tipo de Origen"; Rec."Tipo de Origen AT")
            {
                ToolTip = 'Tipo de Origen';
                ApplicationArea = All;
            }
            field("No. Recurso"; Rec."No. Recurso AT")
            {
                ToolTip = 'No. Recurso';
                ApplicationArea = All;
            }
            field("Cod Cliente Final"; rec."Cod Cliente Final")
            {
                ApplicationArea = all;
            } //EX-RBF 220922
            field("Nombre Cliente Final"; rec."Nombre Cliente Final")
            {
                ApplicationArea = all;
            } //EX-RBF 220922
        }
        addbefore(Posting)
        {
            group(Email)
            {
                Caption = 'Email';

                field("Document Sending Profile"; Rec."Document Sending Profile AT")
                {
                    ToolTip = 'Document Sending Profile';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                    //052
                    end;
                }
                field("Contact Mail 1"; Rec."Contact Mail 1 AT")
                {
                    ToolTip = 'Contact Mail 1';
                    ApplicationArea = All;
                }
                field("Contact Mail 2"; Rec."Contact Mail 2 AT")
                {
                    ToolTip = 'Contact Mail 2';
                    ApplicationArea = All;
                }
                field("Contact Mail 3"; Rec."Contact Mail 3 AT")
                {
                    ToolTip = 'Contact Mail 3';
                    ApplicationArea = All;
                }
                field("Contact Mail 4"; Rec."Contact Mail 4 AT")
                {
                    ToolTip = 'Contact Mail 4';
                    ApplicationArea = All;
                }
                field("Contact Mail 5"; Rec."Contact Mail 5 AT")
                {
                    ToolTip = 'Contact Mail 5';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        addafter("&Statistics")
        {
            action("Cambiar datos de facturacion")
            {
                ApplicationArea = All;
                Caption = 'Cambiar datos de facturación';

                trigger OnAction()
                var
                    RepCambiarDatosFacturacion: Report CambiarDatosFacturacion;
                begin
                    RepCambiarDatosFacturacion.SetJobNo(Rec."No.");
                    RepCambiarDatosFacturacion.Run();
                end;
            }
        }
    }
//EX-RBF 310123 Fin
}
