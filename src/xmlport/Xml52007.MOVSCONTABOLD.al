xmlport 52007 "MOVS CONTAB OLD"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '#@#';
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = true;

    schema
    {
    textelement(LinesOrigin)
    {
    tableelement("Gen. Journal Line";
    81)
    {
    AutoSave = true;
    AutoUpdate = true;
    XmlName = 'GenJournalLine';

    fieldelement(JournalTemplate;
    "Gen. Journal Line"."Journal Template Name")
    {
    Width = 250;
    }
    fieldelement(LineNo;
    "Gen. Journal Line"."Line No.")
    {
    Width = 250;
    }
    fieldelement(AccType;
    "Gen. Journal Line"."Account Type")
    {
    Width = 250;
    }
    fieldelement(AccNo;
    "Gen. Journal Line"."Account No.")
    {
    Width = 250;
    }
    fieldelement(PostingDate;
    "Gen. Journal Line"."Posting Date")
    {
    Width = 250;
    }
    fieldelement(DocumentType;
    "Gen. Journal Line"."Document Type")
    {
    Width = 250;
    }
    fieldelement(DocumentNo;
    "Gen. Journal Line"."Document No.")
    {
    Width = 250;
    }
    fieldelement(Descr;
    "Gen. Journal Line".Description)
    {
    Width = 250;
    }
    fieldelement(Amt;
    "Gen. Journal Line".Amount)
    {
    Width = 250;
    }
    fieldelement(Dim1;
    "Gen. Journal Line"."Shortcut Dimension 1 Code")
    {
    Width = 250;
    }
    fieldelement(Dim2;
    "Gen. Journal Line"."Shortcut Dimension 2 Code")
    {
    Width = 250;
    }
    textelement(jobcode)
    {
    XmlName = 'JobNo';
    Width = 250;

    trigger OnAfterAssignVariable()
    begin
        Job."No.":=JobCode;
        IF Job.Insert()then;
        "Gen. Journal Line"."Job No.":=JobCode;
    end;
    }
    fieldelement(Qty;
    "Gen. Journal Line".Quantity)
    {
    Width = 250;
    }
    fieldelement(JournalBatch;
    "Gen. Journal Line"."Journal Batch Name")
    {
    Width = 250;
    }
    fieldelement(DocumentDate;
    "Gen. Journal Line"."Document Date")
    {
    Width = 250;
    }
    fieldelement(TransactionNo;
    "Gen. Journal Line"."Transaction No.")
    {
    Width = 250;
    }
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    var Job: Record Job;
}
