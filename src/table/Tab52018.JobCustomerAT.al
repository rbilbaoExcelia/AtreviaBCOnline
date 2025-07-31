table 52018 "Job Customer AT"
{
    // 025 OS.MIR  29/06/2016  COM.002   Texto descriptivo timming a pedidos de compra (Sincronización SQL)
    // 030 OS.MIR  20/06/2016  PROY.005  Facturación multicliente desde proyecto
    // 999 OS.MIR  29/06/2016  DataPerCompany = No
    // 123
    Caption = 'Jobs Customer';
    DataPerCompany = false;

    fields
    {
        field(1; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(4; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No."=FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Attendant Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Attendant Name';
        }
        field(6; "To Credit"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'To Credit';
        }
        field(7; "Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice No.';
            Editable = false;
            TableRelation = "Sales Invoice Header";
        }
        field(8; "Cr. Memo No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cr. Memo No.';
            Editable = false;
            TableRelation = "Sales Cr.Memo Header";
        }
        field(9; "Job Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Internal,"One Off",Periodical,Salon,Seminar';
            OptionMembers = Internal, "One Off", Periodical, Salon, Seminar;
        }
        field(10; "SQL Synchronized"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Synchronized';

            trigger OnValidate()
            begin
                IF Rec."SQL Synchronized" <> xRec."SQL Synchronized" THEN IF NOT CONFIRM('Confirma que desea modificar la línia')THEN ERROR('');
            end;
        }
        field(11; "Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Discount %';
        }
        field(12; "Net Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Amount';
        }
        field(13; Invoiced; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoiced';
        }
        field(14; Credited; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Credited';
        }
        field(15; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(16; "Payment Synchr."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Synchr.';
        }
        field(17; "Invoice Amt. (DL)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Amt. (DL)';
            Description = '-025';
        }
    }
    keys
    {
        key(Key1; "Job No.", "Customer No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "To Credit")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        Job2: Record Job;
    begin
        //120617
        Job2.GET("Job No.");
        IF(Job2."Job Type AT" = Job2."Job Type AT"::Salon) OR (Job2."Job Type AT" = Job2."Job Type AT"::Seminar)THEN ERROR('No se pueden eliminar clientes de proyectos tipo tertulia');
        IF NOT CONFIRM('Confirma que desea eliminar la línia')THEN ERROR('');
    //120617
    end;
    procedure InvoicePaid(): Boolean var
        CustLedgEntry: Record 21;
        InvoiceNo: Code[20];
    begin
        //InvoiceNo := FindInvoiceNo;
        //IF InvoiceNo = '' THEN
        //  EXIT(FALSE);
        IF(FindInvoiceNo() <> '') OR (FindCrMemoNo <> '')THEN EXIT(TRUE);
        CustLedgEntry.Reset();
        CustLedgEntry.SETCURRENTKEY("Document No.");
        CustLedgEntry.SETRANGE("Document No.", InvoiceNo);
        CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", CustLedgEntry."Document Type"::Bill);
        IF NOT CustLedgEntry.FindSet()then CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", CustLedgEntry."Document Type"::Invoice);
        IF NOT CustLedgEntry.FindSet()then EXIT(FALSE);
        EXIT(NOT CustLedgEntry.Open);
    end;
    ////[Scope('Internal')]
    procedure FindInvoiceNo(): Code[20]var
        JobPlanningLineInvoice: Record 1022;
    begin
        JobPlanningLineInvoice.SETRANGE("Job No.", "Job No.");
        JobPlanningLineInvoice.SETRANGE("Job Task No.", "Job No.");
        JobPlanningLineInvoice.SETRANGE("Job Planning Line No.", "Line No.");
        JobPlanningLineInvoice.SETRANGE(JobPlanningLineInvoice."Document Type", JobPlanningLineInvoice."Document Type"::"Posted Invoice");
        IF JobPlanningLineInvoice.FindFirst()then EXIT(JobPlanningLineInvoice."Document No.")
        ELSE
            EXIT('');
    end;
    procedure FindCrMemoNo(): Code[20]var
        JobPlanningLineInvoice: Record 1022;
    begin
        JobPlanningLineInvoice.SETRANGE("Job No.", "Job No.");
        JobPlanningLineInvoice.SETRANGE("Job Task No.", "Job No.");
        JobPlanningLineInvoice.SETRANGE("Job Planning Line No.", "Line No." + 1);
        JobPlanningLineInvoice.SETRANGE(JobPlanningLineInvoice."Document Type", JobPlanningLineInvoice."Document Type"::"Posted Credit Memo");
        IF JobPlanningLineInvoice.FindFirst()then EXIT(JobPlanningLineInvoice."Document No.")
        ELSE
            EXIT('');
    end;
}
