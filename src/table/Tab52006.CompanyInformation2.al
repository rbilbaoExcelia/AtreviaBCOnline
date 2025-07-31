table 52006 "Company Information 2"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; Name; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(52005; "Usuario FTP"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(52006; "Contraseña FTP"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(52009; "NIF Declarante"; Code[9])
        {
            DataClassification = CustomerContent;
        }
        field(52010; "Apell. Nombre.- Razón social"; Text[120])
        {
            DataClassification = CustomerContent;
        }
        field(52011; "NIF Representante legal"; Code[9])
        {
            DataClassification = CustomerContent;
        }
        field(52012; Ejercicio; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(52014; "Nº registro envío autorización"; Code[15])
        {
            DataClassification = CustomerContent;
        }
        field(52015; "Obtener docs. desde fecha"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52016; "Obtener docs. hasta fecha"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52017; "Generar fichero desde fecha"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52018; "Generar fichero hasta fecha"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52019; "Enviar documentos desde fecha"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52020; "Enviar documentos hasta fecha"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52021; "Ult. desde fecha Obtención"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52022; "Ult. hasta fecha Obtención"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52023; "Ult. desde fecha generación"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52024; "Ult. hasta fecha generación"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52025; "Ult. desde fecha Envío"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52026; "Ult. hasta fecha Envío"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(52027; "Procesar Facturas venta"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52028; "Procesar Abonos venta"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52029; "Procesar Facturas compra"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52030; "Procesar Abonos compra"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52031; "Procesar Bienes de inversión"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ERROR('Proceso no implementado.');
            end;
        }
        field(52032; "Proceso obtención documentos"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52033; "Proceso generación ficheros"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52034; "Proceso envío a plataforma"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52036; "Procesar Movimientos Contables"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
