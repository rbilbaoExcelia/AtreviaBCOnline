xmlport 52001 "CARTERA CLIENTES"
{
    Direction = Import;
    FieldSeparator = '@#@';
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("CARTERA CLIENTS";
    "CARTERA CLIENTS")
    {
    XmlName = 'Import';

    fieldelement(NoMov;
    "CARTERA CLIENTS".EntryNo)
    {
    }
    fieldelement(NoCliente;
    "CARTERA CLIENTS".CustomerNo)
    {
    }
    fieldelement(NoDoc;
    "CARTERA CLIENTS".DocumentNo)
    {
    }
    fieldelement(NoEfecto;
    "CARTERA CLIENTS".BillNo)
    {
    }
    fieldelement(FechaRegistro;
    "CARTERA CLIENTS".PostingDate)
    {
    }
    fieldelement(NoDocExt;
    "CARTERA CLIENTS".ExtDocNo)
    {
    }
    fieldelement(FechaDoc;
    "CARTERA CLIENTS".DocDate)
    {
    }
    fieldelement(FechaVencim;
    "CARTERA CLIENTS".DueDate)
    {
    }
    fieldelement(Descripcion;
    "CARTERA CLIENTS".Description)
    {
    }
    fieldelement(Importe;
    "CARTERA CLIENTS".TxtImporte)
    {
    }
    fieldelement(ImportePendiente;
    "CARTERA CLIENTS".TxtImportePte)
    {
    }
    fieldelement(Vendendor;
    "CARTERA CLIENTS".SalespersonCode)
    {
    }
    fieldelement(OldDimension1;
    "CARTERA CLIENTS"."Old Dimension1")
    {
    }
    fieldelement(OldDimension2;
    "CARTERA CLIENTS"."Old Dimension2")
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        //Pasamos a decimal el importe inicial de texto (TxtImporte)
        /*
                    lTxtImporte := DELCHR("CARTERA CLIENTS".TxtImporte,'=',',');
                    lTxtImporte := CONVERTSTR(lTxtImporte,'.',',');
                    EVALUATE("CARTERA CLIENTS".Amount,lTxtImporte);
                    
                    //Pasamos a decimal el importe inicial de texto (TxtImporte)
                    lTxtImportePte := DELCHR("CARTERA CLIENTS".TxtImportePte,'=',',');
                    lTxtImportePte := CONVERTSTR(lTxtImportePte,'.',',');
                    EVALUATE("CARTERA CLIENTS".RemAmount,lTxtImportePte);
                    */
        EVALUATE("CARTERA CLIENTS".Amount, "CARTERA CLIENTS".TxtImporte);
        EVALUATE("CARTERA CLIENTS".RemAmount, "CARTERA CLIENTS".TxtImportePte);
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
        MESSAGE('Fin');
    end;
    var lTxtImporte: Text[30];
    lTxtImportePte: Text[30];
}
