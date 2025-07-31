tableextension 52006 "BusinessUnit" extends "Business Unit"
{
    fields
    {
        field(52000; "Parent Company"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Parent Company';
            Description = '-010';

            trigger OnValidate()
            begin
                IF "Parent Company" THEN BEGIN
                    xBussUnit.SETFILTER(xBussUnit.Code, '<>%1', Code);
                    xBussUnit.SETRANGE(xBussUnit."Parent Company", TRUE);
                    IF NOT xBussUnit.ISEMPTY THEN xBussUnit.MODIFYALL(xBussUnit."Parent Company", FALSE);
                END;
            end;
        }
        field(52001; "First Consolidation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'First Consolidation Date';
            Description = '-010';
        }
        field(52002; "Consolidation Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Consolidation Type';
            Description = '-010';
            OptionCaption = ' ,Global,Proportional,Equivalence Method,Minority';
            OptionMembers = " ", Global, Proportional, "Equivalence Method", Minority;

            trigger OnValidate()
            begin
                IF "Consolidation Type" = "Consolidation Type"::Global THEN "Share %":=100;
            end;
        }
        field(52003; "Share %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Share %';
            Description = '-010';
        }
        field(52004; "Consolidated into Company"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Consolidated into Company';
            Description = '-010';
            TableRelation = "Business Unit";

            trigger OnValidate()
            begin
                Rec.TESTFIELD("Parent Company", FALSE);
            end;
        }
    }
    trigger OnInsert()
    begin
        //<010
        CompanyInformation.Get();
        CompanyInformation.TESTFIELD(Consolidated);
    //010>
    end;
    var CompanyInformation: Record "Company Information";
    //BUAdvanced: Record "Consolidation Companies";
    xBussUnit: Record 220;
}
