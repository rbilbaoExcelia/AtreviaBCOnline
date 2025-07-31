xmlport 52000 "AGRUPACIONES CUENTAS Y PRODUCT"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement(MemIntFra;
    MemIntFra)
    {
    XmlName = 'Import';

    fieldelement(AccNo;
    MemIntFra."Cod 1")
    {
    }
    fieldelement(AccAgrup;
    MemIntFra."Cod 2")
    {
    MinOccurs = Zero;
    }
    trigger OnAfterInsertRecord()
    begin
        /*
                    IF GLAccount.GET(MemIntFra."Cod 1") THEN
                    BEGIN
                      GLAccount."Grouping Code" := MemIntFra."Cod 2";
                      GLAccount.Modify();
                    END;
                    */
        IF Item.GET(MemIntFra."Cod 1")THEN BEGIN
            Item."Grouping Code":=MemIntFra."Cod 2";
            Item.Modify();
        END;
    end;
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
    trigger OnPostXmlPort()
    begin
        MemIntFra.DeleteAll();
    end;
    var GLAccount: Record "G/L Account";
    Item: Record 27;
}
