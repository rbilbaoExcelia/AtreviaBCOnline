xmlport 52003 "IMPORT Horas Consultor"
{
    Direction = Import;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
    textelement(root)
    {
    tableelement("Hours consulting AT";
    "Hours consulting AT")
    {
    XmlName = 'source';

    fieldelement(Noconsultor;
    "Hours consulting AT"."No. consultor")
    {
    }
    fieldelement(Noproyecto;
    "Hours consulting AT"."No. proyecto")
    {
    }
    fieldelement(Fecha;
    "Hours consulting AT".Fecha)
    {
    }
    fieldelement(Horas;
    "Hours consulting AT".Horas)
    {
    }
    fieldelement(Sincronizado;
    "Hours consulting AT".Sincronizado)
    {
    }
    fieldelement(Registrado;
    "Hours consulting AT".Registrado)
    {
    }
    fieldelement(Horasregistradas;
    "Hours consulting AT"."Horas registradas")
    {
    }
    fieldelement(Nomovimiento;
    "Hours consulting AT"."No. movimiento")
    {
    }
    fieldelement(Tipoerror;
    "Hours consulting AT"."Tipo error")
    {
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
    trigger OnPostXmlPort()
    begin
        MESSAGE('FIN');
    end;
}
