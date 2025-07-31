page 52025 "SAFT - Portugal"
{
    ApplicationArea = All;
    UsageCategory = Administration;

    // 003 OS.MIR  07/06/2016  FIN.003   Fichero SAF-T Portugal
    layout
    {
        area(content)
        {
            field("<StartingDate>"; StartingDate)
            {
                ToolTip = 'Starting Date';
                ApplicationArea = All;
                Caption = 'Starting Date';
            }
            field("<EndingDate>"; LastDate)
            {
                ToolTip = 'Ending Date';
                ApplicationArea = All;
                Caption = 'Ending Date';
            }
        /*field("<FileName>"; FileName)
            {
                ToolTip = '<FileName>';
                ApplicationArea = All;
                Caption = 'File Name';

                trigger OnAssistEdit()
                var
                    FileManagementL: Codeunit "File Management";
                begin
                    //Todo: CreateNewXML WITH FileName and return path
                    //FileName := FileManagementL.SaveFileDialog(TextOL001, '', '.Xml fields (*.xml)|*.xml');
                end;
            }*/
        }
    }
    // actions
    // {
    //     area(processing)
    //     {
    //         action("Exportar fichero SAFT Portugal")
    //         {
    //             Promoted = true;
    //             Caption = 'Exportar fichero SAFT Portugal';
    //             ApplicationArea = All;
    //             ToolTip = 'Exportar fichero SAFT Portugal';
    //             PromotedCategory = Process;
    //             trigger OnAction()
    //             var
    //                 ToFile: Text[1024];
    //                 Text000: Label 'Export to XML File';
    //                 Text001: Label 'XML Files (*.xml)|*.xml|All Files (*.*)|*.*';
    //                 OutFile: codeunit "Temp Blob";
    //                 lIStream: InStream; //EX-SGG 080422                    
    //             //TempOut: OutStream;
    //             begin
    //                 //IF FileName = '' THEN
    //                 //ERROR(Text1110001);
    //                 //TempFileName := FileName + '.tmp';
    //                 IF LastDate < StartingDate THEN
    //                     ERROR(Text13301, StartingDate);
    //                 //OutputFile.TEXTMODE(TRUE);
    //                 //OutputFile.WRITEMODE(TRUE);
    //                 //IF NOT ISSERVICETIER THEN 
    //                 //OutputFile.QUERYREPLACE(TRUE);
    //                 //OutputFile.CREATE(TempFileName);
    //                 OutFile.CreateOutStream(OutputStream);
    //                 //OutputFile.CREATEOUTSTREAM(OutputStream);
    //                 CLEAR(SAFTPT);
    //                 SAFTPT.SetData(LastDate, StartingDate);
    //                 SAFTPT.SETDESTINATION(OutputStream); //EX-SGG 080422 DESCOMENTO. 
    //                 SAFTPT.EXPORT;
    //                 OutFile.CreateInStream(lIStream);
    //                 ToFile := Format(CurrentDateTime, 0, 9) + '_SAFT-PT.xml'; //EX-SGG 080422
    //                 DownloadFromStream(lIStream, 'Seleccione una ubicación', '', '*.xml|*.XML', ToFile); //EX-SGG 080422
    //                 //OutputFile.Close();
    //                 /*
    //                 Evauar fichero y corregir espacios en blanco (TODO)
    //                 IF ISSERVICETIER THEN BEGIN
    //                     ToFile := Text1110005;
    //                     SAFTPT.ModifyNameSpace(TempFileName);
    //                     ReplaceString(TempFileName, ' xmlns=""', '');
    //                     CheckANDModifyFile(TempFileName, FileName);
    //                     IF D(FileName, Text000, '', Text001, ToFile) THEN
    //                         MESSAGE(Text1110000, ToFile)
    //                 END ELSE
    //                     MESSAGE(Text1110000, FileName);
    //                 */
    //                 CurrPage.Close();
    //             end;
    //         }
    //     }
    // }
    // Could not resolve the usercontrol owning 'XslTemplateL@1100225000::ondataavailable@198'
    //trigger ondataavailable()
    //begin
    /*
    */
    //end;
    // Could not resolve the usercontrol owning 'XslTemplateL@1100225000::onreadystatechange@-609'
    //trigger onreadystatechange()
    //begin
    /*
    */
    //end;
    // Could not resolve the usercontrol owning 'XmlOutL@1100225001::ondataavailable@198'
    //trigger ondataavailable()
    //begin
    /*
    */
    //end;
    // Could not resolve the usercontrol owning 'XmlOutL@1100225001::onreadystatechange@-609'
    //trigger onreadystatechange()
    //begin
    /*
    */
    //end;
    // Could not resolve the usercontrol owning 'XmlInL@1100225002::ondataavailable@198'
    //trigger ondataavailable()
    //begin
    /*
    */
    //end;
    // Could not resolve the usercontrol owning 'XmlInL@1100225002::onreadystatechange@-609'
    //trigger onreadystatechange()
    //begin
    /*
    */
    //end;
    var //CommonDialogMgt: Codeunit 412;
 SAFTPT: XMLport "SAF - T PT PT";
    //FileName: Text[1024];
    //TempFileName: Text[1024];
    LastDate: Date;
    StartingDate: Date;
    OutputFile: File;
    OutputStream: OutStream;
    JournalsFlag: Boolean;
    Text1110000: Label 'The file %1 has been exported successfully.';
    Text1110001: Label 'FileName should be specified before exporting the SAF-T file.';
    Text13302: Label 'Last Date should be specified before exporting the SAF-T file.';
    Text1110004: Label 'Path SAF-T PT File';
    Text1110005: Label 'SAF-T.xml';
    Text13300: Label 'Starting Date should be specified before exporting the SAF-T file.';
    Text13301: Label 'Ending Date must not be less than %1.';
    TextOL001: Label 'SAFT File create';
    procedure CheckANDModifyFile(var TempFileName: Text[1024]; var FileName: Text[1024])
    var
        InPutFile: Codeunit "Temp Blob";
        OutPutFile2: Codeunit "Temp Blob";
        TextLine: Text[1024];
    begin
    //OutPutFile2.TEXTMODE(TRUE);
    //OutPutFile2.WRITEMODE(TRUE);
    //OutPutFile2.CREATE(FileName);
    //InPutFile.TEXTMODE(TRUE);
    //InPutFile.OPEN(TempFileName);
    /*
        Verifica y corrige (TODOModifyNameSpace)
        WHILE InPutFile.POS < InPutFile.LEN DO BEGIN
            InPutFile.READ(TextLine);

            IF NOT RemoveBlankTagLine(TextLine) THEN
                OutPutFile2.WRITE(TextLine);
        END;
        InPutFile.Close();
        FILE.ERASE(TempFileName);
        OutPutFile2.Close();
        File.DownloadFromStream()
        */
    end;
    local procedure RemoveBlankTagLine(var TempStr: Text[1024]): Boolean begin
        IF STRPOS(TempStr, '<Journal>') > 0 THEN JournalsFlag:=TRUE;
        IF STRPOS(TempStr, '</Journal>') > 0 THEN JournalsFlag:=FALSE;
        IF(STRPOS(TempStr, '<CustomerID/>') > 0) OR (STRPOS(TempStr, '<SupplierID/>') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<AddressDetail/>') > 0) OR (STRPOS(TempStr, '<AddressDetail />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<Journal/>') > 0) OR (STRPOS(TempStr, '<Journal />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<DeliveryID/>') > 0) OR (STRPOS(TempStr, '<DeliveryID />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<DeliveryDate/>') > 0) OR (STRPOS(TempStr, '<DeliveryDate />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<OrderDate/>') > 0) OR (STRPOS(TempStr, '<OrderDate />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<OriginatingON/>') > 0) OR (STRPOS(TempStr, '<OriginatingON />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<OrderReferences/>') > 0) OR (STRPOS(TempStr, '<OrderReferences />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<Address/>') > 0) OR (STRPOS(TempStr, '<Address />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<Settlement/>') > 0) OR (STRPOS(TempStr, '<Settlement />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<SettlementDiscount/>') > 0) OR (STRPOS(TempStr, '<SettlementDiscount />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<SettlementAmount/>') > 0) OR (STRPOS(TempStr, '<SettlementAmount />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<SettlementDate/>') > 0) OR (STRPOS(TempStr, '<SettlementDate />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<PaymentMechanism/>') > 0) OR (STRPOS(TempStr, '<PaymentMechanism />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<City/>') > 0) OR (STRPOS(TempStr, '<City />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<PostalCode/>') > 0) OR (STRPOS(TempStr, '<PostalCode />') > 0)THEN EXIT(TRUE);
        IF(STRPOS(TempStr, '<Country/>') > 0) OR (STRPOS(TempStr, '<Country />') > 0)THEN EXIT(TRUE);
        //<<INF.P02
        IF(STRPOS(TempStr, '<TaxExemptionReason/>') > 0) OR (STRPOS(TempStr, '<TaxExemptionReason />') > 0)THEN EXIT(TRUE);
        //INF.P02>>
        IF NOT JournalsFlag THEN EXIT(FALSE);
    end;
    //procedure DeleteEmptyXMLNodes(XMLNode: Automation)
    //var
    //    XMLDomNodeList: Automation;
    //    XMLChildNode: Automation;
    //    i: Integer;
    //begin
    //    IF ISCLEAR(XMLNode) THEN EXIT;
    //
    //    IF XMLNode.nodeTypeString = 'element' THEN BEGIN
    //        IF (XMLNode.hasChildNodes = FALSE) THEN BEGIN
    //            IF (XMLNode.xml = '<' + XMLNode.nodeName + '/>') THEN
    //                XMLNode := XMLNode.parentNode.removeChild(XMLNode);
    //        END ELSE BEGIN
    //            XMLDomNodeList := XMLNode.childNodes;
    //            FOR i := 1 TO XMLDomNodeList.length DO BEGIN
    //                XMLChildNode := XMLDomNodeList.nextNode();
    //                DeleteEmptyXMLNodes(XMLChildNode);
    //            END;
    //        END;
    //    END;
    //end;
    local procedure "***PUBLIC***"()
    begin
    end;
    //procedure TransformDocument(var XmlInP: Automation; var XmlOutP: Automation; var XslTemplateP: Automation)
    //var
    //    XslTemplateNodeL: Automation;
    //begin
    //    CREATE(XmlOutP, CreateNewAutomation, TRUE);
    //
    //    XslTemplateNodeL := XslTemplateP.documentElement;
    //    XmlInP.transformNodeToObject(XslTemplateNodeL, XmlOutP);
    //end;
    //procedure CreateXslt_DeleteEmptyNodes(var XslTemplateP: Automation)
    //begin
    //    CREATE(XslTemplateP, CreateNewAutomation, TRUE);
    //
    //    XslTemplateP.loadXML(
    //      '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">' +
    //      '<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>' +
    //
    //      '<xsl:template match="node()|@*">' +
    //      '<xsl:copy>' +
    //      '<xsl:apply-templates select="node()|@*"/>' +
    //      '</xsl:copy>' +
    //      '</xsl:template>' +
    //
    //      '<xsl:template match="*[not(@*) and not(*) and (not(text()) or .=-1)]"/>' +
    //
    //      '</xsl:stylesheet>');
    //end;
    local procedure "***PRIVATE***"()
    begin
    end;
    local procedure CreateNewAutomation(): Boolean begin
        EXIT(FALSE);
    end;
    local procedure CreateOnClientSide(): Boolean begin
        EXIT(TRUE);
    end;
    local procedure ReplaceString(FileName: Text[1024]; sourceTxt: Text[1024]; desTxt: Text[1024])
    //var
    //    f: DotNet File;
    //    str: DotNet String;
    begin
    //str := f.ReadAllText(FileName);
    //str := str.Replace(sourceTxt, desTxt);
    //str := str.Replace('<TaxExemptionCode/>', '');
    //f.WriteAllText(FileName, str.ToString());
    end;
}
