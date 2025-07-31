pageextension 52017 "DimensionValues" extends "Dimension Values"
{
    layout
    {
        addafter(Name)
        {
            field(Alias; Rec.Alias)
            {
                ToolTip = 'Alias';
                ApplicationArea = All;
            }
        }
        addafter("Consolidation Code")
        {
            field("Dim Estructura"; Rec."Dim Estructura")
            {
                ToolTip = 'Dim Estructura';
                ApplicationArea = All;
            }
            field("Split Dimension"; Rec."Split Dimension")
            {
                ToolTip = 'Split Dimension';
                ApplicationArea = All;
            }
            field("Excel Column"; Rec."Excel Column")
            {
                ToolTip = 'Excel Column';
                ApplicationArea = All;
            }
            field("No. of Ranking Entries"; Rec."No. of Ranking Entries")
            {
                ToolTip = 'No. of Ranking Entries';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Borrar Sin Trigger")
            {
                ApplicationArea = All;
                Image = Delete;
                Visible = Bpermiso;

                trigger OnAction()
                var
                    lDimValue: Record "Dimension Value";
                begin
                    CurrPage.SetSelectionFilter(lDimValue);
                    if lDimValue.FindFirst()then if Confirm('Esta seguro que desea borrar el registro?', false)then lDimValue.Delete(false);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        lRecUser: Record User;
    begin
        if lRecUser.Get(UserSecurityId())then if lRecUser."User Name" = 'EXCELIA-X' then Bpermiso:=true;
    end;
    var Bpermiso: Boolean;
//EX-RBF 200524 Fin
}
