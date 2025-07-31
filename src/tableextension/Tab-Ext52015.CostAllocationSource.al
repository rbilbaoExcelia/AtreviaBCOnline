tableextension 52015 "CostAllocationSource" extends "Cost Allocation Source"
{
    fields
    {
        modify("Cost Center Code")
        {
        trigger OnBeforeValidate()
        begin
            //FIN012
            if("Cost Center Code" <> '') and ("Cost Object Code" <> '')then;
        //FIN012
        end;
        }
        modify("Cost Object Code")
        {
        trigger OnBeforeValidate()
        begin
            //FIN012
            if("Cost Center Code" <> '') and ("Cost Object Code" <> '')then;
        //FIN012
        end;
        }
    }
}
