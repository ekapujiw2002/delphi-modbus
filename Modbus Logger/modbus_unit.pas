unit modbus_unit;

interface
uses sysutils;

        function modbus_crc(astr_ascii:string;polynom_val:word):word;
        function modbus_format2rtu(id,func_code:byte;addr_start,num_point,polynom_crc:word):string;
        function modbus_format2ascii(id,func_code:byte;addr_start,num_point:word):string;

implementation

{
function utk crc modbus
input : rtu modbus data
output : crc value word
}
function modbus_crc(astr_ascii:string;polynom_val:word):word;
var
        i:integer;
        id_loop,tmp_data:byte;
        tmp_str:string;
        tmp_word_crc:word;
begin
        tmp_word_crc:=$ffff;
        tmp_str:=astr_ascii;

        for i:=1 to length(tmp_str) do
        begin
                tmp_data:=ord(tmp_str[i]);      //assign data
                tmp_word_crc:=tmp_word_crc xor tmp_data;        //xor awal
                for id_loop:=1 to 8 do                                  //crc bit1-8
                begin
                        if (tmp_word_crc and 1)=1 then
                                tmp_word_crc:=(tmp_word_crc shr 1) xor polynom_val
                        else
                                tmp_word_crc:=tmp_word_crc shr 1;
                end;
        end;
        Result:=tmp_word_crc;
end;

{
function format string modbus
input :
        -slave id       :byte
        -function code  :byte
        -addr start     :word
        -num of point   :word
output:
        -modbus string with crc
}
function modbus_format2rtu(id,func_code:byte;addr_start,num_point,polynom_crc:word):string;
var
        crcx:word;
        tmp_str:string;
begin
        if addr_start>0 then
                addr_start:=addr_start-1
        else
                addr_start:=1;

        tmp_str:=chr(id)+chr(func_code)+ chr(hi(addr_start)) +
                chr(lo(addr_start)) + chr(hi(num_point)) +
                chr(lo(num_point));
        
        crcx:=modbus_crc(tmp_str,polynom_crc);
        Result:=tmp_str+chr(lo(crcx))+chr(hi(crcx));
end;

{
function ubah modbus rtu ke modbus ascii
input :
        -slave id       :byte
        -function code  :byte
        -addr start     :word
        -num of point   :word
output:
        -modbus ascii string with lrc
}
function modbus_format2ascii(id,func_code:byte;addr_start,num_point:word):string;
var
        lrc:byte;
begin
        if addr_start>0 then
                addr_start:=addr_start-1
        else
                addr_start:=1;
        Result:=IntToHex(id,2)+IntToHex(func_code,2)+IntToHex(hi(addr_start),2)+IntToHex(lo(addr_start),2)+
                IntToHex(hi(num_point),2)+IntToHex(lo(num_point),2);
        lrc:=id+func_code+hi(addr_start)+lo(addr_start)+hi(num_point)+lo(num_point);    //htg lrc
        lrc:=1+ (not lrc);
        Result:=':'+Result+inttohex(lrc,2)+#13#10;
end;

end.
