xmlport 52006 "Mov. Conta"
{
    Direction = Import;
    FieldSeparator = '@#@';
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("MOV.CONTAB";
    "MOV.CONTAB")
    {
    XmlName = 'Import';

    fieldelement(Cuenta;
    "MOV.CONTAB"."G/L Account No.")
    {
    }
    fieldelement(Fecha;
    "MOV.CONTAB"."Posting Date")
    {
    }
    fieldelement(TipoDocumento;
    "MOV.CONTAB"."Document Type")
    {
    }
    fieldelement(NoDocumento;
    "MOV.CONTAB"."Document No.")
    {
    }
    fieldelement(Descripcion;
    "MOV.CONTAB".Description)
    {
    }
    fieldelement(Importe;
    "MOV.CONTAB".TxtImporte)
    {
    }
    fieldelement(Dim1;
    "MOV.CONTAB"."Global Dimension 1 Code")
    {
    }
    fieldelement(Dim2;
    "MOV.CONTAB"."Global Dimension 2 Code")
    {
    }
    fieldelement(Proyecto;
    "MOV.CONTAB"."Job No.")
    {
    }
    fieldelement(Cantidad;
    "MOV.CONTAB".Quantity)
    {
    }
    fieldelement(NoMovimiento;
    "MOV.CONTAB"."Entry No.")
    {
    }
    fieldelement(NoAsiento;
    "MOV.CONTAB"."Transaction No.")
    {
    }
    trigger OnAfterInsertRecord()
    begin
    //EVALUATE("MOV.CONTAB".Amount, "MOV.CONTAB".TxtImporte);
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
}
