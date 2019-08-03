unit string_conversion_unit;

interface
uses sysutils;

        function ascii2decimal(adata,delimiter:string):string;
        function ascii2hex_extended(a_str,delimiter:string):string;
        function hex2ascii(a_str_hex,delimiter:string):string;
        function ascii2asciiextended(adata,delimiter:string):string;
        function ascii2hex_simple(astr,separator:string):string;
        function decode_cmd_hex_ascii(acmd:string):string;

implementation

{
fungsi utk decode cmd dlm mode decimal atau hex ke string normal ascii code
}
function decode_cmd_hex_ascii(acmd:string):string;
var
        i,j:integer;
        tmp_cmd_str:string;
begin
        result:='';
        i:=0;
        tmp_cmd_str:=acmd;
        try
        repeat
        
                inc(i);

                if tmp_cmd_str[i]='$' then      //hex mode cmd
                        begin
                                if tmp_cmd_str[i+1]='$' then
                                begin
                                        inc(i);
                                        Result:=Result+tmp_cmd_str[i];
                                end
                                else
                                begin
                                        j:=strtoint(tmp_cmd_str[i]+tmp_cmd_str[i+1]+tmp_cmd_str[i+2]);
                                        Result:=Result+chr(j);
                                        i:=i+2;
                                end;        
                        end
                else if tmp_cmd_str[i]='#' then //dec mode cmd
                        begin
                                if tmp_cmd_str[i+1]='#' then
                                begin
                                        inc(i);
                                        Result:=Result+tmp_cmd_str[i];
                                end
                                else
                                begin
                                        j:=strtoint(tmp_cmd_str[i+1]+tmp_cmd_str[i+2]+tmp_cmd_str[i+3]);
                                        Result:=Result+chr(j);
                                        i:=i+3;
                                end;
                        end
                else
                        Result:=Result+tmp_cmd_str[i]; 

        until i>=length(tmp_cmd_str);
        except
                begin
                Result:='';
                exit;
                end;
        end;
end;

{
ubah ascii ke hexa simple
}
function ascii2hex_simple(astr,separator:string):string;
var
        i:integer;
begin
        Result:='';
        for i:=1 to length(astr) do
                Result:=Result+separator+IntToHex(ord(astr[i]),2);
end;

{
fungsi : ubah ascii ke hex
in : ascii string
out : ascii hex
}
function ascii2hex_extended(a_str,delimiter:string):string;
var
        i,j:integer;
        tmp_str,ctrl_str:string;
const
        ascii_ctrl:array[0..32] of string=('NULL','SOH','STX','ETX','EOT','ENQ','ACK','BELL','BS','HT',
                'LF','VT','FF','CR','SO','SI','DLE','DC1','DC2','DC3','DC4','NAK','SYN','ETB','CAN','EM',
                'SUB','ESC','FS','GS','RS','US','SP');
begin
result:='';
try
        tmp_str:=a_str;
        //for i:=1 to length(tmp_str) do
        i:=0;
        repeat
        begin
                inc(i);
                if tmp_str[i]='<' then
                        begin
                                ctrl_str:='';
                                inc(i);
                                repeat
                                       ctrl_str:=ctrl_str+tmp_str[i];
                                       inc(i);
                                until tmp_str[i]='>';

                                for j:=0 to 32 do
                                        if ctrl_str=ascii_ctrl[j] then
                                                break;

                                result:=Result+'$'+inttohex(j,2)+delimiter;
                        end
                else
                        result:=Result+'$'+inttohex(ord(tmp_str[i]),2)+delimiter;
        end
        until i>=length(tmp_str);
        
except
        on Exception do exit;
end;
end;

{
fungsi : ubah hex ke ascii
in : hex string
out : ascii string
}
function hex2ascii(a_str_hex,delimiter:string):string;
var
        i:integer;
        str_hex_tmp,tmp_str:string;
const
        ascii_ctrl:array[0..32] of string=('NULL','SOH','STX','ETX','EOT','ENQ','ACK','BELL','BS','HT',
                'LF','VT','FF','CR','SO','SI','DLE','DC1','DC2','DC3','DC4','NAK','SYN','ETB','CAN','EM',
                'SUB','ESC','FS','GS','RS','US','SP');
begin
result:='';
str_hex_tmp:='';
try
        tmp_str:=a_str_hex;
        for i:=1 to length(tmp_str) do
        begin
                if tmp_str[i]<>delimiter[1] then
                        str_hex_tmp:=str_hex_tmp+tmp_str[i]
                else
                        begin
                                if StrToInt(str_hex_tmp)<=32 then
                                        result:=Result+'<'+ascii_ctrl[StrToInt(str_hex_tmp)]+'>'
                                else
                                        result:=Result+chr(StrToInt(str_hex_tmp));
                                str_hex_tmp:='';
                        end;
        end;
except
        on Exception do exit;
end;
end;

{
fungsi : ubah ascii normal ke ascii extended
in : ascii string
out : ascii extended string
}
function ascii2asciiextended(adata,delimiter:string):string;
var
        i:integer;
        tmp_str:string;
const
        ascii_ctrl:array[0..32] of string=('NULL','SOH','STX','ETX','EOT','ENQ','ACK','BELL','BS','HT',
                'LF','VT','FF','CR','SO','SI','DLE','DC1','DC2','DC3','DC4','NAK','SYN','ETB','CAN','EM',
                'SUB','ESC','FS','GS','RS','US','SP');
begin
        Result:='';
        tmp_str:=adata;
        try
                i:=0;
                repeat
                        inc(i);
                        if ord(tmp_str[i])<=32 then
                                Result:=Result+'<'+ascii_ctrl[ord(tmp_str[i])]+'>'+delimiter
                        else
                                Result:=Result+tmp_str[i]+delimiter;
                until i>=length(tmp_str);
        except
                on Exception do
                        exit;
        end;
end;

{
fungsi : ubah ascii ke dec
in : ascii string
out : dec string
}
function ascii2decimal(adata,delimiter:string):string;
var
        i:integer;
        tmp_str:string;
begin
        Result:='';
        tmp_str:=adata;
        try
                i:=0;
                repeat
                        inc(i);
                        Result:=Result+inttostr(ord(tmp_str[i]))+delimiter;
                until i>=length(tmp_str);
        except
                on Exception do exit;
        end;
end;

end.
