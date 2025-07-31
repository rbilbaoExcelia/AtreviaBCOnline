tableextension 52016 "CostAllocationTarget" extends "Cost Allocation Target"
{
    fields
    {
        modify("Target Cost Center")
        {
        trigger OnBeforeValidate()
        begin
            //FIN012
            if("Target Cost Center" <> '') and ("Target Cost Object" <> '')then;
        //FIN012
        end;
        }
    }
}
