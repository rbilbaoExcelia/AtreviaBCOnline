xmlport 52008 "MOVS PROYECTOS"
{
    Direction = Import;
    FieldDelimiter = '<"">';
    FieldSeparator = '@#@';
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("MOVS PROYECTOS";
    "MOVS PROYECTOS")
    {
    XmlName = 'Import';

    fieldelement(NoMov;
    "MOVS PROYECTOS"."Entry No.")
    {
    }
    fieldelement(EntryType;
    "MOVS PROYECTOS"."Entry Type")
    {
    }
    fieldelement(NoProyecto;
    "MOVS PROYECTOS"."Job No.")
    {
    }
    fieldelement(FechaRegistro;
    "MOVS PROYECTOS"."Posting Date")
    {
    }
    fieldelement(NoDoc;
    "MOVS PROYECTOS"."Document No.")
    {
    }
    fieldelement(Tipo;
    "MOVS PROYECTOS".Type)
    {
    }
    fieldelement(No;
    "MOVS PROYECTOS"."No.")
    {
    }
    fieldelement(Descripcion;
    "MOVS PROYECTOS".Description)
    {
    }
    fieldelement(Cantidad;
    "MOVS PROYECTOS".TxtQuantity)
    {
    }
    fieldelement(CosteUnitDir;
    "MOVS PROYECTOS".TxtDirectCost)
    {
    }
    fieldelement(CosteUnit;
    "MOVS PROYECTOS".TxtUnitCost)
    {
    }
    fieldelement(TotalCost;
    "MOVS PROYECTOS".TxtTotalCost)
    {
    }
    fieldelement(PrecioVta;
    "MOVS PROYECTOS".TxtUnitPrice)
    {
    }
    fieldelement(TotalPrice;
    "MOVS PROYECTOS".TxtTotalPrice)
    {
    }
    fieldelement(UnidadMedida;
    "MOVS PROYECTOS"."Unit of Measure Code")
    {
    }
    fieldelement(Dim1;
    "MOVS PROYECTOS".Dim1)
    {
    }
    fieldelement(Dim2;
    "MOVS PROYECTOS".Dim2)
    {
    }
    fieldelement(NoDocExt;
    "MOVS PROYECTOS"."External Document No.")
    {
    }
    fieldelement(ImportePendiente;
    "MOVS PROYECTOS".TxtRemAmount)
    {
    }
    fieldelement(Abierto;
    "MOVS PROYECTOS".Open)
    {
    }
    trigger OnBeforeInsertRecord()
    var
        xMovProy: Record 169;
    begin
        dFORMAT("MOVS PROYECTOS".TxtQuantity, "MOVS PROYECTOS".Quantity);
        dFORMAT("MOVS PROYECTOS".TxtDirectCost, "MOVS PROYECTOS"."Direct Unit Cost");
        dFORMAT("MOVS PROYECTOS".TxtRemAmount, "MOVS PROYECTOS"."Remaining Amount");
        dFORMAT("MOVS PROYECTOS".TxtUnitCost, "MOVS PROYECTOS"."Unit Cost");
        dFORMAT("MOVS PROYECTOS".TxtUnitPrice, "MOVS PROYECTOS"."Unit Price");
        dFORMAT("MOVS PROYECTOS".TxtTotalCost, "MOVS PROYECTOS".TotalCost);
        dFORMAT("MOVS PROYECTOS".TxtTotalPrice, "MOVS PROYECTOS".TotalPrice);
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
        MESSAGE('Finalizado');
    end;
    local procedure dFORMAT(OrigenTxt: Text; var DestinoDec: Decimal)
    var
        lTxtImporte: Text;
    begin
        //Pasamos a decimal el importe inicial de texto (TxtImporte)
        //lTxtImporte := DELCHR(OrigenTxt,'=',',');
        //lTxtImporte := CONVERTSTR(lTxtImporte,'.',',');
        //EVALUATE(DestinoDec,lTxtImporte);
        EVALUATE(DestinoDec, OrigenTxt);
    end;
}
