pageextension 52001 "AccScheduleOverview" extends "Acc. Schedule Overview"
{
    actions
    {
        //3629 - ED
        //EX-AMT 22122022 INICIO
        modify("Create New Document")
        {
            Visible = false;
        }
        modify("Update Existing Document")
        {
            Visible = false;
        }
        modify("Export to Excel")
        {
            Visible = false;
        }
        modify("Excel")
        {
            Visible = false;
        }
        // addafter("Create New Document")
        // {
        addafter("F&unctions")
        {
            group("Exportar Excel")
            {
                action("Create New Document AT")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create New Document';
                    Image = ExportToExcel;
                    ToolTip = 'Open the account schedule overview in a new Excel workbook. This creates an Excel workbook on your device.';

                    trigger OnAction()
                    var
                        ExportAccSchedToExcel: Report "Export Acc. Sched. to Excel AT";
                    begin
                        ExportAccSchedToExcel.SetOptions(Rec, FinancialReport."Financial Report Column Group", UseAmtsInAddCurr); //EX-AMT 22122022
                        ExportAccSchedToExcel.Run();
                    end;
                }
                //     action("Update Existing Document AT")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Update Copy Of Existing Document';
                //         Image = ExportToExcel;
                //         ToolTip = 'Refresh the data in the copy of the existing Excel workbook, and download it to your device. You must specify the workbook that you want to update.';
                //         trigger OnAction()
                //         var
                //             ExportAccSchedToExcel: Report "Export Acc. Sched. to Excel AT";
                //         begin
                //             ExportAccSchedToExcel.SetOptions(Rec, CurrentColumnName, UseAmtsInAddCurr);
                //             ExportAccSchedToExcel.SetUpdateExistingWorksheet(true);
                //             ExportAccSchedToExcel.Run();
                //         end;
                //     }
                // }
                // addafter("Update Existing Document AT")
                // {
                //3629 - ED END
                action("Create Excel with all DIM")
                {
                    ToolTip = 'Create Excel with all DIM';
                    ApplicationArea = All;
                    Caption = 'Create Excel with all DIM';
                    Image = ExportToExcel;

                    trigger OnAction()
                    var
                        ExportAccSchedToExcel: Report "Export Acc. Sched. to Excel 3";
                    begin
                        //<040
                        //TODO - CurrentColumnName and UseAmtsInAddCurr does not exist
                        //ExportAccSchedToExcel.SetOptions(Rec, CurrentColumnName, UseAmtsInAddCurr);
                        ExportAccSchedToExcel.SetOptions(Rec, CurrentColumnName, UseAmtsInAddCurr); //3350 - MEP - 2022 02 22
                        ExportAccSchedToExcel.Run();
                    //040>
                    end;
                }
            }
        //EX-AMT 22122022 FIN
        }
    }
    var UseAmtsInAddCurr: Boolean; //3350 - MEP - 2022 02 22 
    FinancialReport: Record "Financial Report"; //EX-AMT 22122022
    /* trigger OnOpenPage()
    begin
        //#...
        //123
        UseAmtsInAddCurr := FALSE;
        //123
    end; */
    //EX-AMT 22122022 INICIO
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        FinancialReport.SetRange(Name, Rec."Schedule Name");
        if FinancialReport.FindFirst()then;
    end;
//EX-AMT 22122022 FIN
}
