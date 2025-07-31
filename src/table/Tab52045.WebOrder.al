table 52045 "Web Order"
{
    // 025 OS.MIR  29/06/2016  COM.002   Texto descriptivo timming a pedidos de compra (Sincronización SQL)
    // 999 OS.MIR  29/06/2016  DataPerCompany = No
    Caption = 'Web Order';
    DataPerCompany = false;

    fields
    {
        field(1; NumPedido; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; NoProveedor; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Email; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(4; Nombre; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(5; Direccion; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; Poblacion; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(7; Telefono; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(8; Fax; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(9; Contacto; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(10; NIF; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; FechaCreacion; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; FechaPrevista; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; CodDepartamento; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; CodProyecto; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; Estado; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(16; UsuarioCreacion; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(17; UsuarioModificacion; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; NumFactura; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; Oficina; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(20; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(21; Importe; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; TipoGastos; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(23; ImporteAccion; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; Autorizador; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(25; Sector; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(26; Empresa; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(27; Sincronizado; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52001; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
            //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(52002; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
            //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
    }
    keys
    {
        key(Key1; NumPedido, Empresa)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
