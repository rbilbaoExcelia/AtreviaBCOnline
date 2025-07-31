pageextension 52083 "ServiceOrder" extends "Service Order"
{
    layout
    {
        moveafter("Contact No."; City)
        moveafter(City; County)
        moveafter("Ship-to Code"; "Ship-to County")
    }
}
