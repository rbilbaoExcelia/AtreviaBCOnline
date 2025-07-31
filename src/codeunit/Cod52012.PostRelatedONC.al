codeunit 52012 "Post Related ONC"
{
    // 010 OS.MIR  20/06/2016  FIN.009   Funcionalidad filiales
    TableNo = "NOT Commercial Operations AT";

    trigger OnRun()
    begin
        ClearAll();
        Rec.TESTFIELD("NCO Code");
        Rec.TESTFIELD(Posted, FALSE);
        ReasonCode.GET(Rec."NCO Code");
        ReasonCode.TESTFIELD(ReasonCode."Not Commercial Operation AT", TRUE);
        IF ReasonCode."Special NCO AT" THEN ReasonCode.TESTFIELD(ReasonCode."Balance NCO AT");
        IF NOT CONFIRM('¿Registrar documento %1 de operación tipo %2?', FALSE, Rec."Document No.", Rec."NCO Code")THEN EXIT;
        Company.GET(COMPANYNAME);
        IF Company.Consolidated THEN IF BU.COUNT <> 1 THEN ERROR('No puede ejecutarse desde la empresa consolidada');
        Rec.TESTFIELD("Source Type");
        Rec.TESTFIELD("Source No.");
        Rec.TESTFIELD("Account No.");
        Rec.TESTFIELD("Balance Account No.");
        Rec.TESTFIELD("Amount (LCY)");
        Rec.TESTFIELD(Description);
        OpType:=Rec;
        PostLine(0, Rec."Account No.", Rec."Amount (LCY)", Rec."NCO Code", Rec."Job No.", Rec."Job Task No.");
        IF Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account" THEN PostLine(0, Rec."Balance Account No.", -Rec."Amount (LCY)", '', '', '')
        ELSE
            PostLine(GenJnlLine."Account Type"::"Bank Account", Rec."Balance Account No.", -Rec."Amount (LCY)", '', '', '');
        OpType.Posted:=TRUE;
        GLRegister.FIND('+');
        OpType."GL Transaction No.":=GLRegister."No.";
        OpType.Modify();
        Rec:=OpType;
        Commit();
        MESSAGE('Se ha registrado correctamente');
    end;
    var OpType: Record "NOT Commercial Operations AT";
    GenJnlLine: Record 81;
    GenJnlPostLine: Codeunit 12;
    GLRegister: Record 45;
    Company: Record "Company Information";
    BU: Record 220;
    ReasonCode: Record 231;
    SOURCECODE: Label 'OPTIPO';
    local procedure PostLine(BalanceType: Integer; GLAccount: Code[20]; Amount: Decimal; vOPType: Code[10]; JobNo: Code[20]; JobTask: Code[20])
    begin
        GenJnlLine.Init();
        GenJnlLine."Account Type":=BalanceType;
        GenJnlLine."Account No.":=GLAccount;
        GenJnlLine."Posting Date":=OpType.Date;
        GenJnlLine."Document No.":=OpType."Document No.";
        GenJnlLine.Description:=OpType.Description;
        GenJnlLine.Correction:=OpType.Correction;
        GenJnlLine.VALIDATE(GenJnlLine.Amount, Amount);
        GenJnlLine."Source Code":=SOURCECODE;
        GenJnlLine."Reason Code":=vOPType;
        GenJnlLine."Shortcut Dimension 1 Code":=OpType."Dim 1";
        GenJnlLine."Shortcut Dimension 2 Code":=OpType."Dim 2";
        IF(vOPType <> '') OR (OpType."Special NCO")THEN BEGIN
            GenJnlLine."Source Type":=OpType."Source Type";
            GenJnlLine."Source No.":=OpType."Source No.";
            GenJnlLine."Reason Code":=OpType."NCO Code";
        END;
        IF(vOPType = '') AND OpType."Special NCO" THEN GenJnlLine."Reason Code":=ReasonCode."Balance NCO AT";
        //<CONS.006
        GenJnlLine."Job No.":=JobNo;
        //GenJnlLine."Job Task No." := JobTask;
        //GenJnlLine."Job Line Type" := GenJnlLine."Job Line Type"::"1";
        //GenJnlLine."Job Total Price (LCY)" := Amount;
        //GenJnlLine."Job Quantity" := 1;
        //CONS.006>
        GenJnlPostLine.RUN(GenJnlLine);
    end;
}
