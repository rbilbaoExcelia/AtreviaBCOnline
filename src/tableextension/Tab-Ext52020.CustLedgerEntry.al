tableextension 52020 "CustLedgerEntry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(52000; "Job No."; Code[20])
        {
            CalcFormula = Lookup("G/L Entry"."Job No." WHERE("Posting Date"=FIELD("Posting Date"), "Document No."=FIELD("Document No."), "Transaction No."=FIELD("Transaction No.")));
            Caption = 'Job No.';
            Description = '-123';
            FieldClass = FlowField;
        }
        field(52001; Source; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Company source';
        }
        field(52010; "Company source"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company source';
            TableRelation = Company.Name;
        }
        //EX-RBF 010323 Inicio
        field(52011; "Fecha Estimada Cobro"; date)
        {
            DataClassification = CustomerContent;
            Editable = true;
        }
    }
    //Unsupported feature: Code Insertion on "OnInsert".
    //trigger OnInsert()
    //var
    //GenJnlPostPreview: Codeunit 19;
    //begin
    /*
    GenJnlPostPreview.SaveCustLedgEntry(Rec);
    */
    //end;
    procedure CalcJobNo(): Code[20]var
        InvLine: Record 113;
        CrMemoLine: Record 115;
    begin
        InvLine.SETRANGE("Document No.");
        InvLine.SETFILTER("Job No.", '<>''');
        IF InvLine.FIND('-')THEN EXIT(InvLine."Job No.");
        CrMemoLine.SETRANGE("Document No.");
        CrMemoLine.SETFILTER("Job No.", '<>''');
        IF CrMemoLine.FIND('-')THEN EXIT(CrMemoLine."Job No.");
        EXIT('');
    end;
}
