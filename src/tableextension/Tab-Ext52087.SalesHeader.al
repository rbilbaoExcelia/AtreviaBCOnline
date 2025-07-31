tableextension 52087 "SalesHeader" extends "Sales Header"
{
    fields
    {
        field(52000; Hash; Text[172])
        {
            DataClassification = CustomerContent;
            Caption = 'Hash';
            Description = '-003';
        }
        field(52001; "Private Key Version"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Private Key Version';
            Description = '-003';
        }
        field(52002; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Time';
            Description = '-003';
        }
        field(52003; "Creation Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Time';
            Description = '-003';
        }
        field(52005; "Job No."; Code[20])
        {
            CalcFormula = Lookup("Sales Line"."Job No." WHERE("Document Type"=FIELD("Document Type"), "Document No."=FIELD("No."), "Job No."=FILTER(<>'')));
            Caption = 'Job No.';
            FieldClass = FlowField;
        }
        field(52006; "Job Name"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No."=FIELD("Job No.")));
            Caption = 'Job Name';
            FieldClass = FlowField;
        }
        field(52010; "External Job Document No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'External Job Document No.';
            Description = '-027';
        }
    }
    var //Err001: Label 'Accounting Posting Date can not be later than current date.';
 //Err002: Label 'Accounting Posting Date is prior to the margin of days allowed for presentation to AEAT.';
    lNoSeries: Record 308;
    lPostDesc: Text[250];
    Text1100002: Label 'The %1 does not exist. \Identification fields and values:\%1 = %2';
}
