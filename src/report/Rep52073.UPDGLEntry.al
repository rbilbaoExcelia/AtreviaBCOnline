report 52073 "UPD GLEntry"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/UPDGLEntry.rdlc';
    Permissions = TableData 17=rm;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Entry";17)
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date")WHERE("G/L Account No."=FILTER(''));

            trigger OnAfterGetRecord()
            begin
                GLEntry:="G/L Entry";
                IF GLEntry."G/L Account No." = '' THEN BEGIN
                    GLEntry."G/L Account No.":='4720000306';
                    GLEntry.Modify();
                    i:=i + 1;
                    MESSAGE(FORMAT(i));
                END;
            end;
            trigger OnPreDataItem()
            begin
                i:=0;
            end;
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
    labels
    {
    }
    var GLEntry: Record 17;
    i: Integer;
}
