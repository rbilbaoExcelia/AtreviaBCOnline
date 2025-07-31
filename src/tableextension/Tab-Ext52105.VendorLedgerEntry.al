tableextension 52105 "VendorLedgerEntry" extends "Vendor Ledger Entry"
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
        field(52010; "Company source"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company source';
            TableRelation = Company.Name;
        }
    }
    //Unsupported feature: Code Insertion on "OnInsert".
    //trigger OnInsert()
    //var
    //GenJnlPostPreview: Codeunit 19;
    //begin
    /*
    GenJnlPostPreview.SaveVendLedgEntry(Rec);
    */
    //end;
    procedure CalcJobNo(): Code[20]var
        InvLine: Record 123;
        CrMemoLine: Record 125;
    begin
        InvLine.SETRANGE("Document No.");
        InvLine.SETFILTER("Job No.", '<>''');
        IF InvLine.FIND('-')THEN EXIT(InvLine."Job No.");
        CrMemoLine.SETRANGE("Document No.");
        CrMemoLine.SETFILTER("Job No.", '<>''');
        IF CrMemoLine.FIND('-')THEN EXIT(CrMemoLine."Job No.");
        EXIT('');
    end;
//Unsupported feature: Property Modification (Subtype) on ""Payment Method Code"(Field 172).OnValidate.CarteraDoc(Variable 1100000)".
//var
//>>>> ORIGINAL VALUE:
//"Payment Method Code" : "Cartera Doc.";
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//"Payment Method Code" : 7000002;
//Variable type has not been exported.
//Unsupported feature: Property Modification (Subtype) on "DocMisc(Variable 1100000)".
//var
//>>>> ORIGINAL VALUE:
//DocMisc : "Document-Misc";
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//DocMisc : 7000007;
//Variable type has not been exported.
}
