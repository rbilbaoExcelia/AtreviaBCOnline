pageextension 52028 "GLAccountList" extends "G/L Account List"
{
    // 001 OS.MIR  07/06/2016  FIN.001 Gastos refacturables en Plan de Cuentas
    // 004 OS.MIR  07/06/2016  FIN.004 Cuentas bloqueadas en Plan de Cuentas
    Editable = false;

    layout
    {
        addafter("Income Stmt. Bal. Acc.")
        {
            field("Expenses Billable"; Rec."Expenses Billable AT")
            {
                ToolTip = 'Expenses Billable';
                ApplicationArea = All;
            }
            field(Blocked; Rec.Blocked)
            {
                ToolTip = 'Blocked';
                ApplicationArea = All;
            }
        }
    }
}
