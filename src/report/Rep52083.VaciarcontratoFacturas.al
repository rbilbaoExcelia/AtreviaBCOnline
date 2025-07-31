report 52083 "Vaciar contrato Facturas"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; "Sales Line")
        {
            RequestFilterFields = "document No.", "Line No.";

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                // IF (GetFilter("Document No.") <> '') and (GetFilter("Line No.") <> '') then Error('Filtro de documento y línea necesarios');
                // Message('1 ' + FORMAT(GetFilter("Document No.")));
                // Message('2 ' + FORMAT(GetFilter("Line No.")));
                numLinea:=0;
            end;
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                IF(GetFilter("Document No.") <> '') and ("Document Type" = "Document Type"::Invoice)then begin
                    CLEAR("Job Contract Entry No.");
                    Modify();
                    numLinea+=1;
                // Message('Modificada línea ' + FORMAT(GetFilter("Line No.") + ' de la factura ' + FORMAT(GetFilter("Document No."))));
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(opciones)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message(FORMAT(numLinea) + ' Líneas modificadas.');
    end;
    var numLinea: Integer;
}
