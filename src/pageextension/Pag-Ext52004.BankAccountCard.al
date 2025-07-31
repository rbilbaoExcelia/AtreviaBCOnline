pageextension 52004 "BankAccountCard" extends "Bank Account Card"
{
    layout
    {
        modify("SWIFT Code")
        {
            trigger OnLookup(var Text: Text): Boolean var
                fBICCodesL: Page "BIC Codes";
                tBicCodeL: Record "BIC Code";
            begin
                //<SEPA.001
                CLEAR(fBICCodesL);
                CLEAR(tBicCodeL);
                fBICCodesL.EDITABLE(FALSE);
                fBICCodesL.LOOKUPMODE(TRUE);
                fBICCodesL.SETTABLEVIEW(tBicCodeL);
                IF fBICCodesL.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    fBICCodesL.GETRECORD(tBicCodeL);
                    Rec."SWIFT Code":=tBicCodeL."BIC 11";
                END;
            //SEPA.001>
            end;
        }
        addafter("Positive Pay Export Code")
        {
            field("Contrato Confirming"; Rec."Contrato Confirming")
            {
                ToolTip = 'Contrato Confirming';
                ApplicationArea = All;
            }
        }
    }
}
