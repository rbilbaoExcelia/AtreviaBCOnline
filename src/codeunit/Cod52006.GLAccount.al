codeunit 52006 "GLAccount"
{
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterCheckGLAcc', '', true, true)]
    local procedure "G/L Account_OnAfterCheckGLAcc"(var GLAccount: Record "G/L Account")
    begin
        //<010
        IF GLAccount."Not Commercial Operations AT" AND (NOT bIsNotCommertial)THEN ERROR(Text7135700);
        IF(NOT GLAccount."Not Commercial Operations AT") AND bIsNotCommertial THEN ERROR(Text7135700);
    //010>
    end;
    procedure IsNotCommertial(vIsNotCommertial: Boolean)
    begin
        //<010
        bIsNotCommertial:=vIsNotCommertial;
    //010>
    end;
    var bIsNotCommertial: Boolean;
    Text7135700: Label 'This account can only be used on related transactions.';
}
