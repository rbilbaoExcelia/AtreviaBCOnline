tableextension 52039 "GLAccountPT" extends "G/L Account"
{
    fields
    {
        field(52000; "Expenses Billable AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Expenses Billable';
            Description = '-001';
        }
        field(52001; "Grouping Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grouping Code';
            Description = '-013';
            TableRelation = "Account Grouping AT";
        }
        field(52002; "Action Account"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Action Account';
            Description = '-055';
        }
        field(52020; "Bloqueados migracion"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52072; "Not Commercial Operations AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Not Commercial Operations';
            Description = '-010';
        }
        field(52073; "NCO Subsidiary Association"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'NCO Subsidiary Association';
            Description = '-010';
            TableRelation = "Reason Code" WHERE("Not Commercial Operation AT"=CONST(true));
        }
        field(52074; "Block Subsidiary Import AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Block Subsidiary Import';
            Description = '-010';
        }
        field(52076; "Complete Description"; Text[90])
        {
            DataClassification = CustomerContent;
            Caption = 'Complete Description';
            Description = '-010';
        }
    }
//Unsupported feature: Code Modification on "OnDelete".
//trigger OnDelete()
//>>>> ORIGINAL CODE:
//begin
/*
    if ("Account Type" = "Account Type"::Heading) then begin
      GLAcc := Rec;
      if GLAcc.Next <> 0 then
        if CopyStr(GLAcc."No.",1,StrLen("No.")) = "No." then
          Error(Text1100000);
    end;

    MoveEntries.MoveGLEntries(Rec);

    GLBudgetEntry.SetCurrentKey("Budget Name","G/L Account No.");
    GLBudgetEntry.SetRange("G/L Account No.","No.");
    GLBudgetEntry.DeleteAll(true);

    CommentLine.SetRange("Table Name",CommentLine."Table Name"::"G/L Account");
    CommentLine.SetRange("No.","No.");
    CommentLine.DeleteAll();

    ExtTextHeader.SetRange("Table Name",ExtTextHeader."Table Name"::"G/L Account");
    ExtTextHeader.SetRange("No.","No.");
    ExtTextHeader.DeleteAll(true);

    AnalysisViewEntry.SetRange("Account No.","No.");
    AnalysisViewEntry.DeleteAll();

    AnalysisViewBudgetEntry.SetRange("G/L Account No.","No.");
    AnalysisViewBudgetEntry.DeleteAll();

    MyAccount.SetRange("Account No.","No.");
    MyAccount.DeleteAll();

    DimMgt.DeleteDefaultDim(DATABASE::"G/L Account","No.");
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    IF ("Account Type" = "Account Type"::Heading) THEN BEGIN
      GLAcc := Rec;
      IF GLAcc.NEXT <> 0 THEN
        IF COPYSTR(GLAcc."No.",1,STRLEN("No.")) = "No." THEN
          ERROR(Text1100000);
    END;
    #7..9
    //<010

    // GLBudgetEntry.SETCURRENTKEY("Budget Name","G/L Account No.");
    // GLBudgetEntry.SETRANGE("G/L Account No.","No.");
    // GLBudgetEntry.DELETEALL(TRUE);
    //
    // CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"G/L Account");
    // CommentLine.SETRANGE("No.","No.");
    // CommentLine.DeleteAll();
    //
    // ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::"G/L Account");
    // ExtTextHeader.SETRANGE("No.","No.");
    // ExtTextHeader.DELETEALL(TRUE);
    //
    // AnalysisViewEntry.SETRANGE("Account No.","No.");
    // AnalysisViewEntry.DeleteAll();
    //
    // AnalysisViewBudgetEntry.SETRANGE("G/L Account No.","No.");
    // AnalysisViewBudgetEntry.DeleteAll();

    Company.FindSet();
    REPEAT
      GLBudgetEntry.CHANGECOMPANY(Company.Name);
      ExtTextHeader.CHANGECOMPANY(Company.Name);
      AnalysisViewEntry.CHANGECOMPANY(Company.Name);
      AnalysisViewBudgetEntry.CHANGECOMPANY(Company.Name);

      GLBudgetEntry.SETCURRENTKEY("Budget Name","G/L Account No.");
      GLBudgetEntry.SETRANGE("G/L Account No.","No.");
      GLBudgetEntry.DELETEALL(TRUE);

      ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::"G/L Account");
      ExtTextHeader.SETRANGE("No.","No.");
      ExtTextHeader.DELETEALL(TRUE);

      AnalysisViewEntry.SETRANGE("Account No.","No.");
      AnalysisViewEntry.DeleteAll();

      AnalysisViewBudgetEntry.SETRANGE("G/L Account No.","No.");
      AnalysisViewBudgetEntry.DeleteAll();
    UNTIL Company.Next() = 0;

    CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"G/L Account");
    CommentLine.SETRANGE("No.","No.");
    CommentLine.DeleteAll();
    //010>

    DimMgt.DeleteDefaultDim(DATABASE::"G/L Account","No.");
    */
//end;
}
