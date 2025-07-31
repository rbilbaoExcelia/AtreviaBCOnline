report 52007 "ACT VTOSMOVPROV"
{
    ProcessingOnly = true;
    Caption = 'ACT VTOSMOVPROV';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1100225000; VTO_SPROV)
        {
            DataItemTableView = SORTING(VENDOR, DOCNO, IMPTEPDTE);

            trigger OnAfterGetRecord()
            begin
            /*
                MovProv.SETRANGE(MovProv."Vendor No.",VTO_SPROV.VENDOR);
                //MovProv.SETRANGE(MovProv."Posting Date",VTO_SPROV.POSTINGDATE);
                MovProv.SETRANGE(MovProv."Posting Date",20170430D);
                //MovProv.SETRANGE(MovProv."Document Type",VTO_SPROV.DOCTYPE);
                MovProv.SETRANGE(MovProv."Document No.",VTO_SPROV.DOCNO);
                MovProv.SETRANGE(MovProv."Remaining Amount",VTO_SPROV.IMPTEPDTE);
                IF MovProv.FIND('-') THEN BEGIN
                  MovProv.VALIDATE(MovProv."Due Date",VTO_SPROV.DUEDATE);
                  MovProv.Modify();
                END;
                */
            end;
        }
        dataitem(VTOS_CLIENTE; VTOS_CLIENTE)
        {
            DataItemTableView = SORTING(CUSTOMER, DOCNO, IMPTEPDTE);

            trigger OnAfterGetRecord()
            begin
                MovCli.SETRANGE(MovCli."Customer No.", VTOS_CLIENTE.CUSTOMER);
                MovCli.SETRANGE(MovCli."Posting Date", 20170430D);
                MovCli.SETRANGE(MovCli."Document No.", VTOS_CLIENTE.DOCNO);
                MovCli.SETRANGE(MovCli."Remaining Amount", VTOS_CLIENTE.IMPTEPDTE);
                IF MovCli.FIND('-')THEN BEGIN
                    MovCli.VALIDATE(MovCli."Due Date", VTOS_CLIENTE.DUEDATE);
                    MovCli.Modify();
                END;
            end;
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
    trigger OnPostReport()
    begin
        MESSAGE('Fin');
    end;
    var MovProv: Record 25;
    MovCli: Record 21;
}
