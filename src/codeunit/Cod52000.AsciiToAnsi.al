codeunit 52000 "AsciiToAnsi"
{
    // 999 OS.MIR 29/06/2016 AsciiToAnsii Codeunit
    trigger OnRun()
    begin
    end;
    var AsciiStr: Text[250];
    AnsiStr: Text[250];
    CharVar: array[32]of Char;
    r: Report "Make 349 Declaration";
    local procedure Ansi2Ascii(_Text: Text[1024]): Text[1024]begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AnsiStr, AsciiStr));
    end;
    local procedure Ascii2Ansi(_Text: Text[1024]): Text[1024]begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AsciiStr, AnsiStr));
    end;
    local procedure MakeVars()
    begin
        AsciiStr:='ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥ƒáíóúñÑªº¿¬½¼¡«»¦¦¦¦¦…†‡ˆ¦¦++Ž++--+-+–—++--¦-+';
        AsciiStr:=AsciiStr + 'Ÿ¨©­®¯i´¸¹++¦_¦ÃØÊßËÌÍÎµÏÐÒÓÔÕ×ØÙÚ±=ÝÞã÷ð°õ·øý²¦ ';
        CharVar[1]:=196;
        CharVar[2]:=19;
        CharVar[3]:=201;
        CharVar[4]:=242;
        CharVar[5]:=220;
        CharVar[6]:=186;
        CharVar[7]:=191;
        CharVar[8]:=188;
        CharVar[9]:=187;
        CharVar[10]:=193;
        CharVar[11]:=194;
        CharVar[12]:=192;
        CharVar[13]:=195;
        CharVar[14]:=202;
        CharVar[15]:=203;
        CharVar[16]:=200;
        CharVar[17]:=205;
        CharVar[18]:=206;
        CharVar[19]:=204;
        CharVar[20]:=175;
        CharVar[21]:=223;
        CharVar[22]:=213;
        CharVar[23]:=254;
        CharVar[24]:=218;
        CharVar[25]:=219;
        CharVar[26]:=217;
        CharVar[27]:=180;
        CharVar[28]:=177;
        CharVar[29]:=176;
        CharVar[30]:=185;
        CharVar[31]:=179;
        CharVar[32]:=178;
        AnsiStr:='—ýÒËÍÊÎÏÓÔÐÙØÕ' + FORMAT(CharVar[1]) + FORMAT(CharVar[2]) + FORMAT(CharVar[3]) + 'µ–Þ÷' + FORMAT(CharVar[4]);
        AnsiStr:=AnsiStr + 'øõ ´' + FORMAT(CharVar[5]) + '°ú¹¸âß×Ý·±©¬' + FORMAT(CharVar[6]) + FORMAT(CharVar[7]);
        AnsiStr:=AnsiStr + '«¼' + FORMAT(CharVar[8]) + 'í½' + FORMAT(CharVar[9]) + '___ªª' + FORMAT(CharVar[10]) + FORMAT(CharVar[11]);
        AnsiStr:=AnsiStr + FORMAT(CharVar[12]) + 'ªª++óÑ++--+-+Ì' + FORMAT(CharVar[13]) + '++--ª-+ñÚ¨';
        AnsiStr:=AnsiStr + FORMAT(CharVar[14]) + FORMAT(CharVar[15]) + FORMAT(CharVar[16]) + 'i' + FORMAT(CharVar[17]) + FORMAT(CharVar[18]);
        AnsiStr:=AnsiStr + 'Ÿ++__ª' + FORMAT(CharVar[19]) + FORMAT(CharVar[20]) + '®' + FORMAT(CharVar[21]) + '¯­ã';
        AnsiStr:=AnsiStr + FORMAT(CharVar[22]) + '…' + FORMAT(CharVar[23]) + 'Ã' + FORMAT(CharVar[24]) + FORMAT(CharVar[25]);
        AnsiStr:=AnsiStr + FORMAT(CharVar[26]) + '²¦»' + FORMAT(CharVar[27]) + '¡' + FORMAT(CharVar[28]) + '=Ž†ºðˆ' + FORMAT(CharVar[29]);
        AnsiStr:=AnsiStr + '¿‡' + FORMAT(CharVar[30]) + FORMAT(CharVar[31]) + FORMAT(CharVar[32]) + '_ ';
    end;
}
