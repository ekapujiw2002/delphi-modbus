unit frmMainModbusTester;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, TFlatComboBoxUnit, TFlatGroupBoxUnit, TFlatEditUnit,
  TFlatSpinEditUnit, TFlatButtonUnit, TFlatMemoUnit, CPort, ExtCtrls,inifiles,math;

type
  TForm1 = class(TForm)
    pgConfig: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    cbCOMPortSetting: TFlatComboBox;
    cbCOMBaudrateSetting: TFlatComboBox;
    Label6: TLabel;
    Label7: TLabel;
    cbCOMDatabitSetting: TFlatComboBox;
    Label8: TLabel;
    cbCOMStopBitsetting: TFlatComboBox;
    cbCOMParitySetting: TFlatComboBox;
    Label9: TLabel;
    Label10: TLabel;
    cbCOMFlowCtrlSetting: TFlatComboBox;
    Label1: TLabel;
    cbModbusType: TFlatComboBox;
    Label2: TLabel;
    Label3: TLabel;
    cbModbusFunctionCode: TFlatComboBox;
    Label4: TLabel;
    Label11: TLabel;
    spModbusStartAddress: TFlatSpinEditInteger;
    spModbusNumberPoint: TFlatSpinEditInteger;
    Label12: TLabel;
    spModbusCRCKey: TFlatSpinEditInteger;
    spModbusSlaveID: TFlatSpinEditInteger;
    btnModbusAddFunctionCode: TFlatButton;
    FlatButton1: TFlatButton;
    Label13: TLabel;
    spModbusScanRate: TFlatSpinEditInteger;
    Label14: TLabel;
    spModbusTimeout: TFlatSpinEditInteger;
    btnStartStopPoll: TFlatButton;
    pgDataView: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    lvDataView: TListView;
    memoLogModbus: TFlatMemo;
    comSerial1: TComPort;
    tmrModbusScanRate: TTimer;
    tmrModbusTimeout: TTimer;
    tmrWaktu: TTimer;
    TabSheet6: TTabSheet;
    Label15: TLabel;
    edModbusDataViewLogFile: TFlatEdit;
    edModbusStreamViewLogFile: TFlatEdit;
    Label16: TLabel;
    btnSaveLogOption: TFlatButton;
    SaveDialog1: TSaveDialog;
    Label17: TLabel;
    cbModbusLogViewMode: TFlatComboBox;
    procedure FormCreate(Sender: TObject);
    procedure comSerial1AfterClose(Sender: TObject);
    procedure comSerial1AfterOpen(Sender: TObject);
    procedure btnStartStopPollClick(Sender: TObject);
    procedure spModbusScanRateChange(Sender: TObject);
    procedure spModbusTimeoutChange(Sender: TObject);
    procedure tmrModbusScanRateTimer(Sender: TObject);
    procedure tmrModbusTimeoutTimer(Sender: TObject);
    procedure memoLogModbusChange(Sender: TObject);
    procedure comSerial1RxChar(Sender: TObject; Count: Integer);
    procedure cbCOMPortSettingChange(Sender: TObject);
    procedure cbCOMBaudrateSettingChange(Sender: TObject);
    procedure cbCOMDatabitSettingChange(Sender: TObject);
    procedure cbCOMStopBitsettingChange(Sender: TObject);
    procedure cbCOMParitySettingChange(Sender: TObject);
    procedure cbCOMFlowCtrlSettingChange(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure cbModbusFunctionCodeChange(Sender: TObject);
    procedure edModbusDataViewLogFileDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure reload_config;
    procedure fill_port_cb;
    function path:string;
  end;

var
  Form1: TForm1;
  dt_modbus_rx,dt_all_rx:string;
  i,j,k:integer;
  cfg_file:TIniFile;
  modbus_is_start_data,modbus_is_id,modbus_is_len,modbus_is_data,modbus_is_crc:boolean;
  modbus_cnt_dt,modbus_state_id:integer;
  modbus_slave_id,modbus_slave_code,modbus_slave_data_len,modbus_slave_data,modbus_slave_crc,code_str:string;
  li:tlistitem;

const
        arr_baudrate:array[0..13] of tbaudrate=(brCustom,br110,br300,br600,br1200,br2400,br4800,br9600,br14400,br19200,br38400,br56000,br57600,br115200);
        arr_databit:array[0..3] of TDataBits= (dbFive, dbSix, dbSeven, dbEight);
        arr_stopbit:array[0..2] of TStopBits = (sbOneStopBit, sbOne5StopBits, sbTwoStopBits);
        arr_parity:array[0..4] of TParityBits = (prNone, prOdd, prEven, prMark, prSpace);
        arr_flowctrl:array[0..3] of TFlowControl = (fcHardware, fcSoftware, fcNone, fcCustom);

implementation

{$R *.DFM}

{
procedure isi port combobox
}
procedure tform1.fill_port_cb;
var
        i:integer;
begin
        for i:=1 to 255 do
                cbCOMPortSetting.Items.Add('COM'+inttostr(i));
end;

{
fungsi path
out : application path
}
function tform1.path:string;
begin
        result:=ExtractFilePath(paramstr(0));
end;

{
procedure reload config
}
procedure tform1.reload_config;
var
        i:integer;
begin
        cfg_file:=TIniFile.Create(path+'cfg.ini');

        edModbusDataViewLogFile.Text:=cfg_file.ReadString('log','data','');
        edModbusStreamViewLogFile.Text:=cfg_file.ReadString('log','stream','');

        cbCOMPortSetting.ItemIndex:=cbCOMPortSetting.Items.IndexOf(comSerial1.Port);

        for i:=low(arr_baudrate) to high(arr_baudrate) do
                begin
                        if arr_baudrate[i]=comSerial1.BaudRate then
                                break;
                end;
        cbCOMBaudrateSetting.ItemIndex:=i;

        for i:=low(arr_databit) to high(arr_databit) do
                begin
                        if arr_databit[i]=comSerial1.DataBits then
                                break;
                end;
        cbCOMDatabitSetting.ItemIndex:=i;

        for i:=low(arr_stopbit) to high(arr_stopbit) do
                begin
                        if arr_stopbit[i]=comSerial1.StopBits then
                                break;
                end;
        cbCOMStopBitsetting.ItemIndex:=i;

        for i:=low(arr_parity) to high(arr_parity) do
                begin
                        if arr_parity[i]=comSerial1.Parity.Bits then
                                break;
                end;
        cbCOMParitySetting.ItemIndex:=i;

        for i:=low(arr_flowctrl) to high(arr_flowctrl) do
                begin
                        if arr_flowctrl[i]=comSerial1.FlowControl.FlowControl then
                                break;
                end;
        cbCOMFlowCtrlSetting.ItemIndex:=i;

end;

{
fungsi : ubah ascii ke hex
in : ascii string
out : ascii hex
}
function ascii2hex(a_str,delimiter:string):string;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
try
        modbus_is_start_data:=false;
        modbus_is_id:=false;
        modbus_is_len:=false;
        modbus_is_data:=false;
        modbus_is_crc:=false;
        modbus_cnt_dt:=0;
        modbus_state_id:=0;
        
        pgConfig.ActivePageIndex:=0;
        pgDataView.ActivePageIndex:=0;
        cbModbusType.ItemIndex:=0;
        cbModbusFunctionCode.ItemIndex:=0;
        cbModbusLogViewMode.ItemIndex:=0;

        fill_port_cb;
        comSerial1.LoadSettings(stIniFile,path+'cfg.ini');      //reload seting serial
        reload_config;  //reload seting dr ini

        cbModbusFunctionCodeChange(self);

        //comSerial1.Open;
except
        on e:Exception do
        begin
                if MessageDlg('You got error at '#13+e.Message+#13'Continue?',mtWarning,[mbyes,mbno],MB_ICONWARNING)<>mryes then
                        Application.Terminate;
        end;
end;
end;

procedure TForm1.comSerial1AfterClose(Sender: TObject);
begin
        tmrModbusScanRate.Enabled:=false;
        btnStartStopPoll.Caption:='Start &Poll';
end;

procedure TForm1.comSerial1AfterOpen(Sender: TObject);
begin
        tmrModbusScanRate.Enabled:=true;
        btnStartStopPoll.Caption:='Stop &Poll';
end;

procedure TForm1.btnStartStopPollClick(Sender: TObject);
begin
        comSerial1.Connected:=not comSerial1.Connected;
end;

procedure TForm1.spModbusScanRateChange(Sender: TObject);
begin
        tmrModbusScanRate.Interval:=spModbusScanRate.Value;
end;

procedure TForm1.spModbusTimeoutChange(Sender: TObject);
begin
        tmrModbusTimeout.Interval:=spModbusTimeout.Value*1000;
end;

procedure TForm1.tmrModbusScanRateTimer(Sender: TObject);
var
        str_modbus:string;
begin
try
        if not comSerial1.Connected then
                exit;

        if not tmrModbusTimeout.Enabled then
                begin
                        if cbModbusType.ItemIndex=0 then        //rtu modbus type
                                begin
                                str_modbus:=modbus_format2rtu(spModbusSlaveID.Value,strtoint(trim(copy(cbModbusFunctionCode.Text,1,pos(':',cbModbusFunctionCode.Text)-1))),spModbusStartAddress.Value,spModbusNumberPoint.Value,spModbusCRCKey.Value);
                                memoLogModbus.Lines.Add(formatdatetime('dd/mm/yyyy hh:nn:ss:zzz',now)+' : [TX] '+ascii2hex(str_modbus,' '));
                                end
                        else    //ascii modbus
                                begin
                                str_modbus:=modbus_format2ascii(spModbusSlaveID.Value,strtoint(trim(copy(cbModbusFunctionCode.Text,1,pos(':',cbModbusFunctionCode.Text)-1))),spModbusStartAddress.Value,spModbusNumberPoint.Value);
                                memoLogModbus.Lines.Add(formatdatetime('dd/mm/yyyy hh:nn:ss:zzz',now)+' : [TX] '+copy(str_modbus,1,length(str_modbus)-2)+'[CR][LF]');
                                end;
                        comSerial1.WriteStr(str_modbus);

                        tmrModbusTimeout.Enabled:=true;
                end;
        
except
        on Exception do exit;
end;
end;

procedure TForm1.tmrModbusTimeoutTimer(Sender: TObject);
begin
try
        memoLogModbus.Lines.Add(formatdatetime('dd/mm/yyyy hh:nn:ss:zzz',now)+' : Communication timeout');
        modbus_state_id:=0;
        tmrModbusTimeout.Enabled:=false;
except
        on Exception do
                tmrModbusTimeout.Enabled:=false;
end;
end;

procedure TForm1.memoLogModbusChange(Sender: TObject);
begin
        if memoLogModbus.Lines.Count>100 then
                memoLogModbus.Clear;
end;

procedure TForm1.comSerial1RxChar(Sender: TObject; Count: Integer);                
begin
try
        comSerial1.ReadStr(dt_modbus_rx,1);

        case modbus_state_id of
        0:      //start id
                begin
                        if cbModbusType.ItemIndex=0 then        //rtu modbus
                        begin
                        if Ord(dt_modbus_rx[1])=spModbusSlaveID.Value then
                                begin
                                        modbus_slave_id:=dt_modbus_rx;
                                        modbus_cnt_dt:=0;
                                        modbus_state_id:=1;
                                        tmrModbusTimeout.Enabled:=false;
                                end;
                        end;
                end;
        1:      //code
                begin
                        code_str:=copy(cbModbusFunctionCode.Text,1,pos(' :',cbModbusFunctionCode.Text)-1);
                        if cbModbusType.ItemIndex=0 then        //rtu modbus
                        begin
                        if (Ord(dt_modbus_rx[1])=strtoint(code_str))or(Ord(dt_modbus_rx[1])=($80+strtoint(code_str))) then
                                begin
                                        modbus_slave_code:=dt_modbus_rx;
                                        modbus_state_id:=2;
                                        tmrModbusTimeout.Enabled:=false;
                                end;
                        end;
                end;
        2:      //data length
                begin
                        if cbModbusType.ItemIndex=0 then        //rtu modbus
                        begin
                        modbus_slave_data_len:=dt_modbus_rx;
                        modbus_state_id:=3;
                        tmrModbusTimeout.Enabled:=false;
                        end;
                end;
        3:      //data slave
                begin
                        if cbModbusType.ItemIndex=0 then        //rtu modbus
                        begin
                        inc(modbus_cnt_dt);
                        if modbus_cnt_dt<=ord(modbus_slave_data_len[1]) then
                                modbus_slave_data:=modbus_slave_data+dt_modbus_rx
                        else
                                begin
                                        modbus_slave_crc:=' '+dt_modbus_rx;
                                        modbus_state_id:=4;
                                        modbus_cnt_dt:=0;
                                end;
                        tmrModbusTimeout.Enabled:=false;
                        end;
                end;
        4:      //data crc
                begin
                        if cbModbusType.ItemIndex=0 then        //rtu modbus
                        begin
                        inc(modbus_cnt_dt);
                        if modbus_cnt_dt<=1 then
                                modbus_slave_crc[1]:=dt_modbus_rx[1]
                        else
                                begin

                                        {
                                        Memo1.Clear;
                                        Memo1.Lines.Add('id='+ascii2hex(modbus_slave_id,''));
                                        Memo1.Lines.Add('code='+ascii2hex(modbus_slave_code,''));
                                        Memo1.Lines.Add('length='+ascii2hex(modbus_slave_data_len,''));
                                        Memo1.Lines.Add('data='+ascii2hex(modbus_slave_data,' '));
                                        Memo1.Lines.Add('crc='+ascii2hex(modbus_slave_crc,''));
                                        }
                                        memoLogModbus.Lines.Add(formatdatetime('dd/mm/yyyy hh:nn:ss:zzz',now)+' : [RX] '+
                                                ascii2hex(modbus_slave_id,' ')+
                                                ascii2hex(modbus_slave_code,' ')+
                                                ascii2hex(modbus_slave_data_len,' ')+
                                                ascii2hex(modbus_slave_data,' ')+
                                                ascii2hex(modbus_slave_crc,' '));
                                        

                                        case ord(modbus_slave_code[1]) of
                                        1,2:    //read bit respon data
                                                begin
                                                lvDataView.Items.BeginUpdate;
                                                lvDataView.Items.Clear;
                                                modbus_cnt_dt:=spModbusStartAddress.Value;
                                                //for i:=1 to length(modbus_slave_data) do
                                                        for j:=1 to spModbusNumberPoint.Value do
                                                        begin
                                                                k:=1 shl (j-1);
                                                                
                                                                li:=lvDataView.Items.Add;
                                                                with li do
                                                                begin
                                                                        Caption:=inttostr(modbus_cnt_dt+j-1);
                                                                        SubItems.Add(inttostr( ord(modbus_slave_data[(j div 9)+1]) and k) );
                                                                        SubItems.Add('$'+inttohex( ord(modbus_slave_data[(j div 9)+1]) and k ,2));
                                                                end;
                                                        end;

                                                lvDataView.Items.EndUpdate;
                                                end;

                                        3,4:    //read 16bit respon data
                                                begin
                                                lvDataView.Items.BeginUpdate;
                                                lvDataView.Items.Clear;
                                                modbus_cnt_dt:=spModbusStartAddress.Value;

                                                i:=1;
                                                repeat
                                                        li:=lvDataView.Items.Add;
                                                        with li do
                                                        begin
                                                                Caption:=inttostr(modbus_cnt_dt+(i div 2));
                                                                SubItems.Add(inttostr( (ord(modbus_slave_data[i])*256) + ord(modbus_slave_data[i+1]) ));
                                                                SubItems.Add('$'+inttohex( (ord(modbus_slave_data[i])*256)+ord(modbus_slave_data[i+1]),4 ));
                                                        end;
                                                        i:=i+2;
                                                until (i>=length(modbus_slave_data)) or (i>=ord(modbus_slave_data_len[1]));

                                                lvDataView.Items.EndUpdate;
                                                end;
                                        end;

                                        modbus_slave_id:='';
                                        modbus_slave_code:='';
                                        modbus_slave_data_len:='';
                                        modbus_slave_data:='';
                                        modbus_slave_crc:='';
                                        modbus_state_id:=0;
                                end;
                        tmrModbusTimeout.Enabled:=false;
                        end;
                end;
        end;  
Except
        on Exception do exit;
end;
end;

procedure TForm1.cbCOMPortSettingChange(Sender: TObject);
begin
comSerial1.Port:=cbCOMPortSetting.Text;
end;

procedure TForm1.cbCOMBaudrateSettingChange(Sender: TObject);
begin
comSerial1.BaudRate:=arr_baudrate[cbcombaudratesetting.itemindex];
end;

procedure TForm1.cbCOMDatabitSettingChange(Sender: TObject);
begin
comSerial1.DataBits:=arr_databit[cbCOMDatabitSetting.itemindex];
end;

procedure TForm1.cbCOMStopBitsettingChange(Sender: TObject);
begin
comSerial1.StopBits:=arr_stopbit[cbCOMStopBitsetting.itemindex];
end;

procedure TForm1.cbCOMParitySettingChange(Sender: TObject);
begin
comSerial1.Parity.Bits:=arr_parity[cbCOMParitySetting.itemindex];
end;

procedure TForm1.cbCOMFlowCtrlSettingChange(Sender: TObject);
begin
comSerial1.FlowControl.FlowControl:=arr_flowctrl[cbCOMFlowCtrlSetting.itemindex];
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
comSerial1.StoreSettings(stIniFile,path+'cfg.ini');
cfg_file:=TIniFile.Create(path+'cfg.ini');
with cfg_file do
begin
        WriteString('log','data',edModbusDataViewLogFile.Text);
        WriteString('log','stream',edModbusStreamViewLogFile.Text);
end;
MessageDlg(#13'Setting saved.',mtInformation,[mbok],MB_ICONINFORMATION);
end;

procedure TForm1.cbModbusFunctionCodeChange(Sender: TObject);
begin
        cbModbusFunctionCode.Hint:=cbModbusFunctionCode.Text;
end;

procedure TForm1.edModbusDataViewLogFileDblClick(Sender: TObject);
begin
        with SaveDialog1 do
        begin
                FileName:='';
                Filter:='Log File(*.log)|*.log';
                DefaultExt:='.log';
                Title:='Save Log File';
                if Execute then
                begin
                        (Sender as TFlatEdit).Text:=FileName;
                end;
        end;
end;

end.
