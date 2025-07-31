tableextension 52029 "DocumentSendingProfile" extends "Document Sending Profile"
{
    fields
    {
    }
    // 052 OS.SPG  20/02/2017  PROY.003  Enviar facturas de venta según perfil de envío del proyecto
    procedure GetDefaultForJob(JobNo: Code[20]; var DocumentSendingProfile: Record 60)
    var
        Job: Record Job;
    begin
        //052
        IF Job.GET(JobNo)THEN IF DocumentSendingProfile.GET(Job."Document Sending Profile AT")THEN EXIT;
        GetDefault(DocumentSendingProfile);
    //052
    end;
}
