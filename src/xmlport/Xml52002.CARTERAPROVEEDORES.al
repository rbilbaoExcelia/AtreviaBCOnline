xmlport 52002 "CARTERA PROVEEDORES"
{
    Direction = Import;
    FieldSeparator = '@#@';
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("CARTERA PROV.";
    "CARTERA PROV.")
    {
    XmlName = 'Import';

    fieldelement(NoMov;
    "CARTERA PROV.".EntryNo)
    {
    }
    fieldelement(NoProveedor;
    "CARTERA PROV.".VendorNo)
    {
    }
    fieldelement(NoDoc;
    "CARTERA PROV.".DocumentNo)
    {
    }
    fieldelement(NoEfecto;
    "CARTERA PROV.".BillNo)
    {
    }
    fieldelement(FechaRegistro;
    "CARTERA PROV.".PostingDate)
    {
    }
    fieldelement(NoDocExt;
    "CARTERA PROV.".ExtDocNo)
    {
    }
    fieldelement(FechaDoc;
    "CARTERA PROV.".Docdate)
    {
    }
    fieldelement(FechaVencim;
    "CARTERA PROV.".DueDate)
    {
    }
    fieldelement(Descripcion;
    "CARTERA PROV.".Description)
    {
    }
    fieldelement(Importe;
    "CARTERA PROV.".TxtImporte)
    {
    }
    fieldelement(ImportePendiente;
    "CARTERA PROV.".TxtImportePte)
    {
    }
    fieldelement(OldDimension1;
    "CARTERA PROV."."Old Dimension1")
    {
    }
    fieldelement(OldDimension2;
    "CARTERA PROV."."Old Dimension2")
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        /*
                    //Pasamos a decimal el importe inicial de texto (TxtImporte)
                    lTxtImporte := DELCHR("CARTERA PROV.".TxtImporte,'=',',');
                    lTxtImporte := CONVERTSTR(lTxtImporte,'.',',');
                    EVALUATE("CARTERA PROV.".Amount,lTxtImporte);
                    
                    //Pasamos a decimal el importe inicial de texto (TxtImporte)
                    lTxtImportePte := DELCHR("CARTERA PROV.".TxtImportePte,'=',',');
                    lTxtImportePte := CONVERTSTR(lTxtImportePte,'.',',');
                    EVALUATE("CARTERA PROV.".RemAmount,lTxtImportePte);
                    */
        EVALUATE("CARTERA PROV.".Amount, "CARTERA PROV.".TxtImporte);
        EVALUATE("CARTERA PROV.".RemAmount, "CARTERA PROV.".TxtImportePte);
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
