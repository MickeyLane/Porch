unit DevConfig;

interface

uses
  Windows;

function ReadDeviceCfg(lpIpAddr: LPCTSTR): WORD; stdcall;
external 'DevConfig.dll';

function SaveDeviceCfg: WORD; stdcall;
external 'DevConfig.dll';

function GetErrorCode: WORD; stdcall;
external 'DevConfig.dll';

procedure GetErrorMsg(pErrorMsg: LPSTR; wLen: WORD); stdcall;
external 'DevConfig.dll';

function DeviceCfgReady: WORD; stdcall;
external 'DevConfig.dll';

function CanCfgWeb: WORD; stdcall;
external 'DevConfig.dll';

function CanCfgButton: WORD; stdcall;
external 'DevConfig.dll';

function CanCfgMisc: WORD; stdcall;
external 'DevConfig.dll';

function GetEnableWeb: WORD; stdcall;
external 'DevConfig.dll';

function GetRestoreState: WORD; stdcall;
external 'DevConfig.dll';

function GetVersion(pVersion: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetIpAddr(pIpAddr: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetSubMask(pSubMask: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetGateway(pGateway: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetDeviceId(pDeviceId: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetDns(pDns: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetWebServer(pWebServer: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetPassword(pPassword: LPSTR; wLen: WORD): WORD; stdcall;
external 'DevConfig.dll';

function GetButtonCfg(ButtonId: WORD): WORD; stdcall;
external 'DevConfig.dll';

function SetEnableWeb(Enabled: WORD): WORD; stdcall;
external 'DevConfig.dll';

function SetRestoreState(Enabled: WORD): WORD; stdcall;
external 'DevConfig.dll';

function SetIpAddr(pIpAddr:LPCTSTR): WORD; stdcall;
external 'DevConfig.dll';

function SetSubMask(pSubMask: LPCTSTR): WORD; stdcall;
external 'DevConfig.dll';

function SetGateway(pGateway: LPCTSTR): WORD; stdcall;
external 'DevConfig.dll';

function SetDns(pDns: LPCTSTR): WORD; stdcall;
external 'DevConfig.dll';

function SetWebServer(pWebServer: LPCTSTR): WORD; stdcall;
external 'DevConfig.dll';

function SetPassword(pPassword: LPCTSTR): WORD; stdcall;
external 'DevConfig.dll';

function SetButtonCfg(ButtonId, Mode: WORD): WORD; stdcall;
external 'DevConfig.dll';

implementation

end.
