tableextension 52031 "FADepreciationBook" extends "FA Depreciation Book"
{
    fields
    {
        modify("FA Posting Group")
        {
        trigger OnBeforeValidate()
        begin
            //<005
            //3609 - ED
            //FAPostingGroup.GET("FA Posting Group");
            FAPostingGroup.Reset();
            FAPostingGroup.SetRange(Code, "FA Posting Group");
            if FAPostingGroup.FindFirst()then //3609 - ED END
 IF(("No. of Depreciation Years" <> 0) AND ("No. of Depreciation Years" <> FAPostingGroup."Default Depreciation Years"))THEN BEGIN
                    IF CONFIRM(LText001, FALSE, "No. of Depreciation Years", FAPostingGroup."Default Depreciation Years")THEN "No. of Depreciation Years":=FAPostingGroup."Default Depreciation Years";
                END
                ELSE IF("No. of Depreciation Years" = 0)THEN "No. of Depreciation Years":=FAPostingGroup."Default Depreciation Years";
        //005>
        end;
        }
        //3358 - MEP - 2022 02 22 START
        modify("Depreciation Starting Date")
        {
        trigger OnBeforeValidate()
        var
            myInt: Integer;
        begin
            "AñoAnterior":=Rec."No. of Depreciation Years";
        end;
        trigger OnAfterValidate()
        var
            FADateCalc2: Codeunit "FA Date Calculation";
        begin
            if rec."Depreciation Ending Date" = 0D then begin
                rec."No. of Depreciation Years":="AñoAnterior";
                rec."Depreciation Ending Date":=FADateCalc2.CalculateDate("Depreciation Starting Date", Round("No. of Depreciation Years" * 360, 1), false);
                rec.Modify();
            end;
        end;
        }
    }
    //Unsupported feature: Code Modification on "CalcDeprPeriod(PROCEDURE 4)".
    //procedure CalcDeprPeriod();
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Depreciation Starting Date" = 0D THEN BEGIN
    #2..4
    END;
    IF ("Depreciation Starting Date" = 0D) OR ("Depreciation Ending Date" = 0D) THEN BEGIN
    //<005
      IF ("Depreciation Starting Date" <> 0D) AND ("No. of Depreciation Years" <> 0) THEN
        VALIDATE("No. of Depreciation Years")
      ELSE BEGIN
    //005>
        "No. of Depreciation Years" := 0;
        "No. of Depreciation Months" := 0;
      END;  //005
    END ELSE BEGIN
      IF "Depreciation Starting Date" > "Depreciation Ending Date" THEN
        ERROR(
          Text002,
          FIELDCAPTION("Depreciation Starting Date"),FIELDCAPTION("Depreciation Ending Date"));
      DeprBook2.GET("Depreciation Book Code");
      IF DeprBook2."Fiscal Year 365 Days" THEN BEGIN
        "No. of Depreciation Months" := 0;
        "No. of Depreciation Years" := 0;
      END;
      IF NOT DeprBook2."Fiscal Year 365 Days" THEN BEGIN
        "No. of Depreciation Months" :=
          DepreciationCalc.DeprDays("Depreciation Starting Date","Depreciation Ending Date",FALSE) / 30;
        "No. of Depreciation Months" := ROUND("No. of Depreciation Months",0.00000001);
        "No. of Depreciation Years" := ROUND("No. of Depreciation Months" / 12,0.00000001);
      END;
      "Straight-Line %" := 0;
      "Fixed Depr. Amount" := 0;
    END;
    */
    //end;
    var FAPostingGroup: Record 5606;
    LText001: Label 'Dou you really want to change depreciation years from %1 to %2?';
    AñoAnterior: decimal;
}
