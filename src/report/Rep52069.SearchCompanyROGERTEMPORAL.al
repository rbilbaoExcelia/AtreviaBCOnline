report 52069 "Search Company (ROGER TEMPORAL"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layouts/SearchCompanyROGERTEMPORAL.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DimVal1;349)
        {
            DataItemTableView = SORTING("Dimension Code", Code)ORDER(Ascending)WHERE("Global Dimension No."=CONST(1), "Dimension Value Type"=CONST(Standard), Blocked=CONST(false), Alias=FILTER(<>''));
            RequestFilterFields = "Code";

            dataitem(DimVal2;349)
            {
                DataItemTableView = SORTING("Dimension Code", Code)ORDER(Ascending)WHERE("Global Dimension No."=CONST(2), "Dimension Value Type"=CONST(Standard), Blocked=CONST(false), Alias=FILTER(<>''));
                RequestFilterFields = "Code";

                dataitem(Company; Company)
                {
                    DataItemTableView = SORTING(Name)ORDER(Ascending);

                    dataitem("G/L Entry";17)
                    {
                        DataItemTableView = SORTING("G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date")ORDER(Ascending)WHERE("Job No."=FILTER(<>''));
                        RequestFilterFields = "Job No.";

                        trigger OnAfterGetRecord()
                        begin
                            MESSAGE('Encontrado en Company: %1; \Proyecto: %2 - %3; \Valor: %4', Company.Name, "G/L Entry"."Job No.", "G/L Entry"."Job Name", -"G/L Entry".Amount);
                        end;
                        trigger OnPreDataItem()
                        begin
                            CHANGECOMPANY(Company.Name);
                            //SETFILTER("G/L Account No.",JobSetup."Filtro cuentas informe");
                            SETFILTER("G/L Account No.", JobSetup."G/L Accounts Rep. Filter AT");
                            SETRANGE("Posting Date", 20170101D, 20171231D);
                            //Filtro zona
                            SETRANGE("Global Dimension 1 Code", DimVal1.Code);
                            IF DimVal1."Split Dimension" THEN SETRANGE("Global Dimension 2 Code", DimVal2.Code);
                        end;
                    }
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
    labels
    {
    }
    trigger OnInitReport()
    begin
        JobSetup.Get();
    end;
    var JobSetup: Record 315;
}
