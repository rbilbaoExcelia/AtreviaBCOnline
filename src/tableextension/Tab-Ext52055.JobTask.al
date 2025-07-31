tableextension 52055 "JobTask" extends "Job Task"
{
    fields
    {
        field(52000; "Billable AT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Billable';
            Description = '-026';
        }
        field(52001; "Status AT"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Description = 'MN02';
            InitValue = "Order";
            OptionCaption = 'Planning,Quote,Order,Completed';
            OptionMembers = Planning, Quote, "Order", Completed;
        }
        field(52002; "Task Type AT"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Home,Service,Management,Refurbishable,Internal,End';
            OptionMembers = Incio, Servicio, Gestion, Refacturable, Interno, Fin;
        }
    }
}
