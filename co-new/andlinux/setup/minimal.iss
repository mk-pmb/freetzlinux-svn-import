; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;    andLinux                                                                 *
;    Copyright (C) 2008 by David Solomon and Joachim Gehweiler                *
;                                                                             *
;    This program is free software: you can redistribute it and/or modify     *
;    it under the terms of the GNU General Public License as published by     *
;    the Free Software Foundation, either version 3 of the License, or        *
;    (at your option) any later version.                                      *
;                                                                             *
;    This program is distributed in the hope that it will be useful,          *
;    but WITHOUT ANY WARRANTY; without even the implied warranty of           *
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
;    GNU General Public License for more details.                             *
;                                                                             *
;    You should have received a copy of the GNU General Public License        *
;    along with this program.  If not, see <http://www.gnu.org/licenses/>.    *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

[Setup]
AppName=andLinux
AppVerName=andLinux Beta 2
AppPublisher=David Solomon and Joachim Gehweiler
DefaultDirName={pf}\andLinux
DefaultGroupName=andLinux
AllowNoIcons=yes
LicenseFile=license.txt
; disable Windows 9x, require at least Windows 2000 (NT 5.0)
MinVersion=0,5.0
; only 32-bit supported
ArchitecturesAllowed=x86
; need to be admin to install andLinux
PrivilegesRequired=admin
; restart required for TAP driver and NT service
AlwaysRestart=yes
UninstallRestartComputer=yes
; compress all files in one stream
Compression=lzma/ultra64
SolidCompression=no

[Files]
Source: "..\minimal\base.vdi"; DestDir: "{app}\Drives"; Flags: confirmoverwrite uninsneveruninstall
Source: "..\minimal\swap.vdi"; DestDir: "{app}\Drives"
Source: "..\common\*"; DestDir: "{app}"; Excludes: ".*sync,stable,testing"; Flags: recursesubdirs
Source: "..\common\stable\*"; DestDir: "{app}"; Excludes: ".*sync"; Flags: recursesubdirs; Check: StableKernelCheck(True)
Source: "..\common\testing\*"; DestDir: "{app}"; Excludes: ".*sync"; Flags: recursesubdirs; Check: StableKernelCheck(False)
Source: "..\common\Xming\*"; DestDir: "{app}\Xming"; Excludes: ".*sync"; Flags: recursesubdirs; Check: XmingCheck()
Source: "..\common\pulseaudio\*"; DestDir: "{app}\pulseaudio"; Excludes: ".*sync"; Flags: recursesubdirs; Check: SoundCheck()
Source: "..\launcher\xfce\*"; DestDir: "{app}\Launcher"; Excludes: ".*sync,menu.txt"; Check: LauncherCheck()
Source: "..\launcher\xfce\menu.txt"; DestDir: "{app}\Launcher"; Flags: uninsneveruninstall; Check: LauncherCheck()

[Tasks]
; desktop icons
Name: "di_startup"; Description: "andLinux start script"; GroupDescription: "Create a Desktop Icon for:"; Flags: checkedonce; Check: NTServiceCheck(False)
Name: "di_fltk"; Description: "CoLinux Console (FLTK)"; GroupDescription: "Create a Desktop Icon for:"; Flags: checkedonce
Name: "di_nt"; Description: "CoLinux Console (NT)"; GroupDescription: "Create a Desktop Icon for:"; Flags: checkedonce
; quick launch icons
Name: "ql_startup"; Description: "andLinux start script"; GroupDescription: "Create Quick Launch Icon for:"; Flags: unchecked; Check: NTServiceCheck(False)
Name: "ql_fltk"; Description: "CoLinux Console (FLTK)"; GroupDescription: "Create Quick Launch Icon for:"; Flags: unchecked
Name: "ql_nt"; Description: "CoLinux Console (NT)"; GroupDescription: "Create Quick Launch Icon for:"; Flags: unchecked
Name: "ql_terminal"; Description: "XFCE Terminal"; GroupDescription: "Create Quick Launch Icon for:"; Flags: checkedonce; Check: LauncherCheck()
Name: "ql_thunar"; Description: "XFCE File Manager"; GroupDescription: "Create Quick Launch Icon for:"; Flags: checkedonce; Check: LauncherCheck()
; Windows Explorer shell extensions
Name: "se_terminal"; Description: "Open in XFCE Terminal (folders menu)"; GroupDescription: "Add to Windows Explorer Context Menu:"; Flags: checkedonce; Check: LauncherCheck()
Name: "se_thunar"; Description: "Open in XFCE File Manager (folders menu)"; GroupDescription: "Add to Windows Explorer Context Menu:"; Flags: checkedonce; Check: LauncherCheck()
Name: "se_mousepad"; Description: "Open with XFCE Text Editor (files menu)"; GroupDescription: "Add to Windows Explorer Context Menu:"; Flags: checkedonce; Check: LauncherCheck()

[Icons]
; batch file case
Name: "{group}\Start andLinux"; Filename: "{app}\startup.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Check: NTServiceCheck(False)
Name: "{userdesktop}\Start andLinux"; Filename: "{app}\startup.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Tasks: di_startup; Check: NTServiceCheck(False)
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Start andLinux"; Filename: "{app}\startup.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Tasks: ql_startup; Check: NTServiceCheck(False)
; NT service case
Name: "{group}\Start andLinux"; Filename: "{app}\srvstart.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Check: NTServiceCheck(True)
Name: "{group}\Stop andLinux"; Filename: "{app}\srvstop.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Check: NTServiceCheck(True)
; NT service (manually) case
Name: "{userdesktop}\Start andLinux"; Filename: "{app}\srvstart.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Tasks: di_startup; Check: NTServiceNoAutoCheck()
Name: "{userdesktop}\Stop andLinux"; Filename: "{app}\srvstop.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Tasks: di_startup; Check: NTServiceNoAutoCheck()
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Start andLinux"; Filename: "{app}\srvstart.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Tasks: ql_startup; Check: NTServiceNoAutoCheck()
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Stop andLinux"; Filename: "{app}\srvstop.bat"; WorkingDir: "{app}"; IconFilename: "{app}\colinux-daemon.exe"; Tasks: ql_startup; Check: NTServiceNoAutoCheck()
; Xming
Name: "{group}\Autostart\Xming"; Filename: "{app}\Xming\Xming.exe"; Parameters: ":0{code:XmingScreenParam} -dpi 85 -clipboard -notrayicon -c -multiwindow -reset -terminate -unixkill -logfile Xming.log"; WorkingDir: "{app}\Xming"; Check: XmingCheck()
; PulseAudio
Name: "{group}\Autostart\PulseAudio"; Filename: "{app}\pulseaudio\pulseaudio.exe"; Parameters: "-D"; WorkingDir: "{app}\pulseaudio"; Check: SoundCheck()
; FLTK + NT console
Name: "{group}\andLinux Console (FLTK)"; Filename: "{app}\colinux-console-fltk.exe"; WorkingDir: "{app}"
Name: "{userdesktop}\andLinux Console (FLTK)"; Filename: "{app}\colinux-console-fltk.exe"; WorkingDir: "{app}"; Tasks: di_fltk
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\andLinux Console (FLTK)"; Filename: "{app}\colinux-console-fltk.exe"; WorkingDir: "{app}"; Tasks: ql_fltk
Name: "{group}\andLinux Console (NT)"; Filename: "{app}\colinux-console-nt.exe"; WorkingDir: "{app}"
Name: "{userdesktop}\andLinux Console (NT)"; Filename: "{app}\colinux-console-nt.exe"; WorkingDir: "{app}"; Tasks: di_nt
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\andLinux Console (NT)"; Filename: "{app}\colinux-console-nt.exe"; WorkingDir: "{app}"; Tasks: ql_nt
; launcher
Name: "{group}\Autostart\XFCE Menu"; Filename: "{app}\Launcher\menu.exe"; WorkingDir: "{app}\Launcher"; Check: LauncherCheck()
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Terminal"; Filename: "{app}\Launcher\andTerminal.exe"; WorkingDir: "{app}\Launcher"; Tasks: ql_terminal; Check: LauncherCheck()
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Thunar"; Filename: "{app}\Launcher\andThunar.exe"; WorkingDir: "{app}\Launcher"; Tasks: ql_thunar; Check: LauncherCheck()

[Registry]
; enable WinXP SP2 compatibility + admin mode in Windows Vista
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\colinux-daemon.exe"; ValueData: "WINXPSP2"; Flags: uninsdeletevalue; MinVersion: 0,6.0
; not necessarily required for these apps
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\colinux-net-daemon.exe"; ValueData: "WINXPSP2"; Flags: uninsdeletevalue; MinVersion: 0,6.0
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\colinux-slirp-net-daemon.exe"; ValueData: "WINXPSP2"; Flags: uninsdeletevalue; MinVersion: 0,6.0
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\pulseaudio\pulseaudio.exe"; ValueData: "WINXPSP2"; Flags: uninsdeletevalue; MinVersion: 0,6.0
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\Xming\Xming.exe"; ValueData: "WINXPSP2"; Flags: uninsdeletevalue; MinVersion: 0,6.0
; Xming
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "Xming (andLinux)"; ValueData: """{app}\Xming\Xming.exe"" :0{code:XmingScreenParam} -dpi 85 -clipboard -notrayicon -c -multiwindow -reset -terminate -unixkill -logfile ""{app}\Xming\Xming.log"""; Flags: uninsdeletevalue; Check: XmingCheck()
; PulseAudio
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "PulseAudio (andLinux)"; ValueData: """{app}\pulseaudio\pulseaudio.exe"" -D"; Flags: uninsdeletevalue; Check: SoundCheck()
; launcher
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "XFCE Menu (andLinux)"; ValueData: """{app}\Launcher\menu.exe"""; Flags: uninsdeletevalue; Check: LauncherCheck()
; Terminal context menu
Root: HKCR; Subkey: "Folder\shell\andTerminal"; ValueType: string; ValueName: ""; ValueData: "Terminal (andLinux)"; Tasks: se_terminal; Flags: uninsdeletekey; Check: LauncherCheck()
Root: HKCR; Subkey: "Folder\shell\andTerminal\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Launcher\andTerminal.exe"" --working-directory ""%1"""; Tasks: se_terminal; Check: LauncherCheck()
; Thunar context menu
Root: HKCR; Subkey: "Folder\shell\andThunar"; ValueType: string; ValueName: ""; ValueData: "Thunar (andLinux)"; Tasks: se_thunar; Flags: uninsdeletekey; Check: LauncherCheck()
Root: HKCR; Subkey: "Folder\shell\andThunar\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Launcher\andThunar.exe"" ""%1"""; Tasks: se_thunar; Check: LauncherCheck()
; Mousepad context menu
Root: HKCR; Subkey: "*\shell\andMousepad"; ValueType: string; ValueName: ""; ValueData: "Mousepad (andLinux)"; Tasks: se_mousepad; Flags: uninsdeletekey; Check: LauncherCheck()
Root: HKCR; Subkey: "*\shell\andMousepad\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Launcher\andMousepad.exe"" ""%1"""; Tasks: se_mousepad; Check: LauncherCheck()
; Turn System-Restore off for andLinux drives
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\BackupRestore\FilesNotToBackup"; ValueType: multisz; ValueName: "andLinux"; ValueData: "{app}\Drives\* /s"; Flags: uninsdeletevalue

[Run]
; install andLinux driver
Filename: "{app}\colinux-daemon.exe"; Parameters: "--install-driver"; WorkingDir: "{app}"; BeforeInstall: CreateConfigs()
; install TAP network device (before installing service!)
Filename: "{app}\netdriver\tapcontrol.exe"; Parameters: "install OemWin2k.inf tap0801co"; WorkingDir: "{app}\netdriver"; AfterInstall: ConfigureWinTap()
; install NT service (if applicable)
Filename: "{app}\colinux-daemon.exe"; Parameters: "--install-service andLinux @{code:GetShortName|{app}}\settings.txt"; WorkingDir: "{app}"; Check: NTServiceCheck(True)
Filename: "{sys}\sc.exe"; Parameters: "config andLinux start= auto"; WorkingDir: "{app}"; Check: NTServiceAutoCheck()
Filename: "{sys}\sc.exe"; Parameters: "config andLinux depend= ""CoLinuxDriver/lanmanserver"""; WorkingDir: "{app}"; Check: NTServiceSambaCheck()

[UninstallRun]
; first remove NT service (if applicable)
Filename: "{sys}\net.exe"; Parameters: "stop andLinux"; WorkingDir: "{app}"; Check: NTServiceCheck(True)
Filename: "{app}\colinux-daemon.exe"; Parameters: "--remove-service andLinux"; WorkingDir: "{app}"; Check: NTServiceCheck(True)
; remove TAP network device
Filename: "{app}\netdriver\tapcontrol.exe"; Parameters: "remove tap0801co"; WorkingDir: "{app}\netdriver"
; remove andLinux driver
Filename: "{app}\colinux-daemon.exe"; Parameters: "--remove-driver"; WorkingDir: "{app}"

[Code]
var
  MemoryPage, SoundPage, MountPage, ServicePage, KernelPage: TInputOptionWizardPage;
  COFSPage: TInputDirWizardPage;
  LoginPage: TInputQueryWizardPage;
  SambaPage, XmingPage: TWizardPage;
  SambaShareLabel, SambaPathLabel, SambaUserLabel, SambaPasswordLabel, SambaRepeatLabel, XmingInstallLabel, XmingResLabel, XmingResXLabel, XmingResYLabel: TNewStaticText;
  SambaComboBox: TNewComboBox;
  SambaRefreshButton: TNewButton;
  SambaUserEdit, XmingResXEdit, XmingResYEdit: TNewEdit;
  SambaPasswordEdit, SambaRepeatEdit: TPasswordEdit;
  XmingInstallYRadio, XmingInstallNRadio, XmingResYRadio, XmingResNRadio: TNewRadioButton;
  SambaShareName, SambaSharePath: String;

function GrepArgFromCmdLine(arg, fallback: String): String;
var
  cmd: String;
  p1, p2, p3: Integer;
begin
  cmd := GetCmdTail();
  p1 := Pos('/'+arg+'=', cmd);
  if (p1 = 0) then
    Result := fallback
  else begin
    p2 := p1 + Length(arg) + 2;
    for p3 := p2+1 to Length(cmd) do
      if (cmd[p3] = '/') then
        break;
    p3 := p3 - 1;
    while (cmd[p3] = ' ') do
      p3 := p3 - 1;
    Result := Copy(cmd, p2, p3-p2+1);
  end
end;

function GrepArgFromCmdLineAsInt(arg: String; fallback: Integer): Integer;
begin
  Result := StrToIntDef(GrepArgFromCmdLine(arg, IntToStr(fallback)), fallback);
end;

function GrepPathFromRegMultiString(RegValue: String): String;
var
  s: String;
  i: Integer;
begin
  Result := ''; // ensure result is empty if not found
  s := '';
  for i := 1 to Length(RegValue) do begin
    if RegValue[i] = #0 then begin
      if Length(s) > 5 then
        if (s[1] = 'P') and (s[2] = 'a') and (s[3] = 't') and (s[4] = 'h') and (s[5] = '=') then begin
          Delete(s, 1, 5);
          Result := s;
        end
      s := '';
    end else
      s := s + RegValue[i];
  end
  if Length(s) > 5 then
    if (s[1] = 'P') and (s[2] = 'a') and (s[3] = 't') and (s[4] = 'h') and (s[5] = '=') then begin
      Delete(s, 1, 5);
      Result := s;
    end
end;

function CheckShareType(RegValue: String): Boolean;
var
  s: String;
  i: Integer;
begin
  s := '';
  for i := 1 to Length(RegValue) do begin
    if RegValue[i] = #0 then begin
      if Length(s) > 5 then
        if (s[1] = 'T') and (s[2] = 'y') and (s[3] = 'p') and (s[4] = 'e') and (s[5] = '=') then
          Result := (s[6] = '0');
      s := '';
    end else
      s := s + RegValue[i];
  end
  if Length(s) > 5 then
    if (s[1] = 'T') and (s[2] = 'y') and (s[3] = 'p') and (s[4] = 'e') and (s[5] = '=') then
      Result := (s[6] = '0');
end;

procedure SambaComboBoxChange();
var
  s: String;
begin
  if SambaComboBox.ItemIndex < 0 then
    SambaPathLabel.Caption := 'Associated path: n/a'
  else begin
    SambaShareName := SambaComboBox.Items[SambaComboBox.ItemIndex];
    if RegQueryMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\lanmanserver\Shares\', SambaShareName, s) then
      SambaPathLabel.Caption := 'Associated path: ' + GrepPathFromRegMultiString(s)
    else
      SambaPathLabel.Caption := 'Associated path: [error]';
  end
end;

procedure SambaComboBoxChangeWrapper(Sender: TObject);
begin
  SambaComboBoxChange();
end;

procedure SambaComboBoxRefresh();
var
  i: Integer;
  s: String;
  values: TArrayOfString;
begin
  SambaComboBox.Items.Clear();
  if RegGetValueNames(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\lanmanserver\Shares\', values) then begin
    for i := 0 to GetArrayLength(values)-1 do
      if RegQueryMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\lanmanserver\Shares\', values[i], s) and CheckShareType(s) then
        SambaComboBox.Items.Add(values[i]);
  end else
    MsgBox('Could not query shared folder / drive names!', mbCriticalError, MB_OK);
  i := SambaComboBox.Items.IndexOf(SambaShareName);
  if i < 0 then
    SambaComboBox.ItemIndex := 0
  else
    SambaComboBox.ItemIndex := i;
  SambaComboBoxChange();
end;

procedure SambaComboBoxRefreshWrapper(Sender: TObject);
begin
  SambaComboBoxRefresh();
end;

procedure XmingInstallYCheck(Sender: TObject);
begin
  XmingResLabel.Enabled := True;
  XmingResYRadio.Enabled := True;
  XmingResNRadio.Enabled := True;
  XmingResXLabel.Enabled := XmingResYRadio.Checked;
  XmingResXEdit.Enabled := XmingResYRadio.Checked;
  XmingResYLabel.Enabled := XmingResYRadio.Checked;
  XmingResYEdit.Enabled := XmingResYRadio.Checked;
end;

procedure XmingInstallNCheck(Sender: TObject);
begin
  XmingResLabel.Enabled := False;
  XmingResYRadio.Enabled := False;
  XmingResNRadio.Enabled := False;
  XmingResXLabel.Enabled := False;
  XmingResXEdit.Enabled := False;
  XmingResYLabel.Enabled := False;
  XmingResYEdit.Enabled := False;
end;

procedure XmingResYCheck(Sender: TObject);
begin
  XmingResXLabel.Enabled := True;
  XmingResXEdit.Enabled := True;
  XmingResYLabel.Enabled := True;
  XmingResYEdit.Enabled := True;
end;

procedure XmingResNCheck(Sender: TObject);
begin
  XmingResXLabel.Enabled := False;
  XmingResXEdit.Enabled := False;
  XmingResYLabel.Enabled := False;
  XmingResYEdit.Enabled := False;
end;

procedure InitializeWizard();
var
  Panel: TPanel;
begin
  KernelPage := CreateInputOptionPage(wpSelectDir, 'andLinux Configuration',
    'Kernal', 'Which coLinux kernel do you want to use?', True, False);
  KernelPage.Add('0.7.4 (stable, recommended)');
  KernelPage.Add('0.8.0 (development snapshot)');
  KernelPage.SelectedValueIndex := GrepArgFromCmdLineAsInt('stable', 0); // preselect 'stable'

  MemoryPage := CreateInputOptionPage(KernelPage.ID, 'andLinux Configuration',
    'Memory Size', 'Please select how much system memory you want to use for andLinux. Pay attention to have enough memory left over for Windows.', True, False);
  MemoryPage.Add('128 MB (not recommended)');
  MemoryPage.Add('192 MB');
  MemoryPage.Add('256 MB');
  MemoryPage.Add('384 MB');
  MemoryPage.Add('512 MB');
  MemoryPage.Add('768 MB');
  MemoryPage.Add('1 GB');
  MemoryPage.SelectedValueIndex := GrepArgFromCmdLineAsInt('mem', 1); // preselect '192 MB'

  XmingPage := CreateCustomPage(MemoryPage.ID, 'andLinux Configuration', 'X Server');
  
  XmingInstallLabel := TNewStaticText.Create(XmingPage);
  XmingInstallLabel.Width := XmingPage.SurfaceWidth;
  XmingInstallLabel.Parent := XmingPage.Surface;
  XmingInstallLabel.Caption := 'Do you want to install Xming?';
  
  XmingInstallYRadio := TNewRadioButton.Create(XmingPage);
  XmingInstallYRadio.Top := XmingInstallLabel.Top + XmingInstallLabel.Height + ScaleY(4);
  XmingInstallYRadio.Width := XmingPage.SurfaceWidth;
  XmingInstallYRadio.Parent := XmingPage.Surface;
  XmingInstallYRadio.Caption := 'yes (recommended)';
  XmingInstallYRadio.Checked := (GrepArgFromCmdLineAsInt('xming', 0) = 0); // preselect 'yes'
  XmingInstallYRadio.OnClick := @XmingInstallYCheck;

  XmingInstallNRadio := TNewRadioButton.Create(XmingPage);
  XmingInstallNRadio.Top := XmingInstallYRadio.Top + XmingInstallYRadio.Height + ScaleY(4);
  XmingInstallNRadio.Width := XmingPage.SurfaceWidth;
  XmingInstallNRadio.Parent := XmingPage.Surface;
  XmingInstallNRadio.Caption := 'no (requires manual installation of another X Server)';
  XmingInstallNRadio.Checked := not XmingInstallYRadio.Checked;
  XmingInstallNRadio.OnClick := @XmingInstallNCheck;

  XmingResLabel := TNewStaticText.Create(XmingPage);
  XmingResLabel.Top := XmingInstallNRadio.Top + XmingInstallNRadio.Height + ScaleY(12);
  XmingResLabel.Width := XmingPage.SurfaceWidth;
  XmingResLabel.Parent := XmingPage.Surface;
  XmingResLabel.Caption := 'Do you wish to specify a different resolution than your primary screen?';

  Panel := TPanel.Create(XmingPage);
  Panel.Top := XmingResLabel.Top + XmingResLabel.Height + ScaleY(4);
  Panel.Width := XmingPage.SurfaceWidth;
  Panel.Parent := XmingPage.Surface;
  Panel.BevelInner := bvNone;
  Panel.BevelOuter := bvNone;
  Panel.BorderStyle := bsNone;

  XmingResNRadio := TNewRadioButton.Create(XmingPage);
  XmingResNRadio.Width := Panel.Width;
  XmingResNRadio.Parent := Panel;
  XmingResNRadio.Caption := 'no, I just use my primary screen';
  XmingResNRadio.Checked := (GrepArgFromCmdLineAsInt('xming_res', 0) = 0); // preselect 'no'
  XmingResNRadio.OnClick := @XmingResNCheck;

  XmingResYRadio := TNewRadioButton.Create(XmingPage);
  XmingResYRadio.Top := XmingResNRadio.Top + XmingResNRadio.Height + ScaleY(4);
  XmingResYRadio.Width := Panel.Width;
  XmingResYRadio.Parent := Panel;
  XmingResYRadio.Caption := 'yes (e.g. if external monitor has a bigger resolution than the laptop display)';
  XmingResYRadio.Checked := not XmingResNRadio.Checked;
  XmingResYRadio.OnClick := @XmingResYCheck;
  
  Panel.Height := XmingResNRadio.Height + ScaleY(4) + XmingResYRadio.Height;

  XmingResXLabel := TNewStaticText.Create(XmingPage);
  XmingResXLabel.Top := Panel.Top + Panel.Height + ScaleY(8);
  XmingResXLabel.Left := ScaleX(16);
  XmingResXLabel.AutoSize := True;
  XmingResXLabel.Parent := XmingPage.Surface;
  XmingResXLabel.Caption := 'Width:';
  XmingResXLabel.Enabled := False;

  XmingResXEdit := TNewEdit.Create(XmingPage);
  XmingResXEdit.Top := XmingResXLabel.Top - ScaleY(3);
  XmingResXEdit.Left := XmingResXLabel.Left + XmingResXLabel.Width + ScaleX(4);
  XmingResXEdit.Width := ScaleX(80);
  XmingResXEdit.Parent := XmingPage.Surface;
  XmingResXEdit.Text := GrepArgFromCmdLine('xming_resx', '');
  XmingResXEdit.Enabled := False;

  XmingResYLabel := TNewStaticText.Create(XmingPage);
  XmingResYLabel.Top := XmingResXLabel.Top;
  XmingResYLabel.Left := XmingResXEdit.Left + XmingResXEdit.Width + ScaleX(20);
  XmingResXLabel.AutoSize := True;
  XmingResYLabel.Parent := XmingPage.Surface;
  XmingResYLabel.Caption := 'Height:';
  XmingResYLabel.Enabled := False;

  XmingResYEdit := TNewEdit.Create(XmingPage);
  XmingResYEdit.Top := XmingResXLabel.Top - ScaleY(3);
  XmingResYEdit.Left := XmingResYLabel.Left + XmingResYLabel.Width + ScaleX(4);
  XmingResYEdit.Width := ScaleX(80);
  XmingResYEdit.Parent := XmingPage.Surface;
  XmingResYEdit.Text := GrepArgFromCmdLine('xming_resy', '');
  XmingResYEdit.Enabled := False;

  SoundPage := CreateInputOptionPage(XmingPage.ID, 'andLinux Configuration',
    'Sound', 'Do you want to enable sound for andLinux?', True, False);
  SoundPage.Add('yes');
  SoundPage.Add('no');
  SoundPage.SelectedValueIndex := GrepArgFromCmdLineAsInt('sound', 0); // preselect 'yes'

  ServicePage := CreateInputOptionPage(SoundPage.ID, 'andLinux Configuration',
    'Startup Type + Panel', 'How do you want to start andLinux and launch applications?', True, False);
  ServicePage.Add('start andLinux manually in a command prompt + use XFCE Panel');
  ServicePage.Add('start andLinux manually in a command prompt + use Windows shortcuts');
  ServicePage.Add('run andLinux manually as a NT service + use XFCE Panel');
  ServicePage.Add('run andLinux manually as a NT service + use Windows shortcuts');
  ServicePage.Add('run andLinux automatically as a NT service + use Windows shortcuts');
  ServicePage.SelectedValueIndex := GrepArgFromCmdLineAsInt('startup', 4); // preselect NT service auto startup

  LoginPage := CreateInputQueryPage(ServicePage.ID, 'andLinux Configuration',
    'andLinux Login', 'Please choose a username and password for andLinux.');
  LoginPage.Add('Username:', False);
  LoginPage.Add('Password:', True);
  LoginPage.Add('Repeat password:', True);
  LoginPage.Values[0] := GrepArgFromCmdLine('user', '');
  LoginPage.Values[1] := GrepArgFromCmdLine('passwd', '');
  LoginPage.Values[2] := LoginPage.Values[1];

  MountPage := CreateInputOptionPage(LoginPage.ID, 'andLinux Configuration',
    'Windows File Access', 'How do you want to access your Windows file system from andLinux?', True, False);
  MountPage.Add('I don''t want to access any files on my Windows partition.');
  MountPage.Add('using CoFS');
  MountPage.Add('using Samba (recommended, works with special characters in file names)');
  MountPage.SelectedValueIndex := GrepArgFromCmdLineAsInt('mount', 2); // preselect Samba

  CoFSPage := CreateInputDirPage(MountPage.ID, 'andLinux Configuration',
    'File Access Using CoFS', 'Please select the folder to mount via CoFS.', False, '');
  CoFSPage.Add('All files below this folder can be accessed from andLinux:');
  CoFSPage.Values[0] := GrepArgFromCmdLine('cofs', 'C:\');

  SambaPage := CreateCustomPage(MountPage.ID, 'andLinux Configuration', 'File Access Using Samba');
  
  SambaShareLabel := TNewStaticText.Create(SambaPage);
  SambaShareLabel.AutoSize := True;
  SambaShareLabel.Parent := SambaPage.Surface;
  SambaShareLabel.Caption := 'Shared folders / drives:';

  SambaComboBox := TNewComboBox.Create(SambaPage);
  SambaComboBox.Top := SambaShareLabel.Top + SambaShareLabel.Height + ScaleY(4);
  SambaComboBox.Width := SambaPage.SurfaceWidth - ScaleX(83);
  SambaComboBox.Parent := SambaPage.Surface;
  SambaComboBox.Style := csDropDownList;
  SambaComboBox.OnChange := @SambaComboBoxChangeWrapper;

  SambaRefreshButton := TNewButton.Create(SambaPage);
  SambaRefreshButton.Top := SambaComboBox.Top - ScaleY(2);
  SambaRefreshButton.Left := SambaPage.SurfaceWidth - ScaleX(75);
  SambaRefreshButton.Width := ScaleX(75);
  SambaRefreshButton.Parent := SambaPage.Surface;
  SambaRefreshButton.Caption := 'Refresh';
  SambaRefreshButton.OnClick := @SambaComboBoxRefreshWrapper;

  SambaPathLabel := TNewStaticText.Create(SambaPage);
  SambaPathLabel.Top := SambaComboBox.Top + SambaComboBox.Height + ScaleY(4);
  SambaPathLabel.Width := SambaPage.SurfaceWidth;
  SambaPathLabel.Parent := SambaPage.Surface;

  SambaShareName := GrepArgFromCmdLine('smb_share', '');
  SambaComboBoxRefresh();

  SambaUserLabel := TNewStaticText.Create(SambaPage);
  SambaUserLabel.Top := SambaPathLabel.Top + SambaPathLabel.Height + ScaleY(20);
  SambaUserLabel.AutoSize := True;
  SambaUserLabel.Parent := SambaPage.Surface;
  SambaUserLabel.Caption := 'User name to access this share:';

  SambaUserEdit := TNewEdit.Create(SambaPage);
  SambaUserEdit.Top := SambaUserLabel.Top + SambaUserLabel.Height + ScaleY(4);
  SambaUserEdit.Width := SambaPage.SurfaceWidth;
  SambaUserEdit.Parent := SambaPage.Surface;
  SambaUserEdit.Text := GrepArgFromCmdLine('smb_user', GetUserNameString());

  SambaPasswordLabel := TNewStaticText.Create(SambaPage);
  SambaPasswordLabel.Top := SambaUserEdit.Top + SambaUserEdit.Height + ScaleY(12);
  SambaPasswordLabel.AutoSize := True;
  SambaPasswordLabel.Parent := SambaPage.Surface;
  SambaPasswordLabel.Caption := 'Password of that user:';

  SambaPasswordEdit := TPasswordEdit.Create(SambaPage);
  SambaPasswordEdit.Top := SambaPasswordLabel.Top + SambaPasswordLabel.Height + ScaleY(4);
  SambaPasswordEdit.Width := SambaPage.SurfaceWidth;
  SambaPasswordEdit.Parent := SambaPage.Surface;
  SambaPasswordEdit.Text := GrepArgFromCmdLine('smb_passwd', '');

  SambaRepeatLabel := TNewStaticText.Create(SambaPage);
  SambaRepeatLabel.Top := SambaPasswordEdit.Top + SambaPasswordEdit.Height + ScaleY(12);
  SambaRepeatLabel.AutoSize := True;
  SambaRepeatLabel.Parent := SambaPage.Surface;
  SambaRepeatLabel.Caption := 'Repeat the password:';

  SambaRepeatEdit := TPasswordEdit.Create(SambaPage);
  SambaRepeatEdit.Top := SambaRepeatLabel.Top + SambaRepeatLabel.Height + ScaleY(4);
  SambaRepeatEdit.Width := SambaPage.SurfaceWidth;
  SambaRepeatEdit.Parent := SambaPage.Surface;
  SambaRepeatEdit.Text := SambaPasswordEdit.Text;
end;

function NTServiceCheck(enabled: Boolean): Boolean;
begin
  if (ServicePage.SelectedValueIndex = 0) or (ServicePage.SelectedValueIndex = 1) then
    Result := not enabled
  else
    Result := enabled;
end;

function NTServiceAutoCheck(): Boolean;
begin
  if ServicePage.SelectedValueIndex = 4 then
    Result := True
  else
    Result := False;
end;

function NTServiceNoAutoCheck(): Boolean;
begin
  if (ServicePage.SelectedValueIndex = 2) or (ServicePage.SelectedValueIndex = 3) then
    Result := True
  else
    Result := False;
end;

function NTServiceSambaCheck(): Boolean;
begin
  if (ServicePage.SelectedValueIndex = 0) or (ServicePage.SelectedValueIndex = 1) or (MountPage.SelectedValueIndex <> 2) then
    Result := False
  else
    Result := True;
end;

function LauncherCheck(): Boolean;
begin
  if (ServicePage.SelectedValueIndex = 0) or (ServicePage.SelectedValueIndex = 2) then
    Result := False
  else
    Result := True;
end;

function StableKernelCheck(stable: Boolean): Boolean;
begin
  if KernelPage.SelectedValueIndex = 0 then
    Result := stable
  else
    Result := not stable;
end;

function SoundCheck(): Boolean;
begin
  if SoundPage.SelectedValueIndex = 0 then
    Result := True
  else
    Result := False;
end;

function XmingCheck(): Boolean;
begin
  Result := XmingInstallYRadio.Checked;
end;

function XmingScreenParam(Param: String): String;
begin
  if XmingInstallYRadio.Checked and XmingResYRadio.Checked then
    Result := ' -screen 0 ' + IntToStr(StrToIntDef(XmingResXEdit.Text, 800)) + ' ' + IntToStr(StrToIntDef(XmingResYEdit.Text, 600))
  else
    Result := '';
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  if (PageID = CoFSPage.ID) and (MountPage.SelectedValueIndex <> 1) then
    Result := True
  else if (PageID = SambaPage.ID) and (MountPage.SelectedValueIndex <> 2) then
    Result := True
  else
    Result := False;
end;

function NextButtonClick(CurPage: Integer): Boolean;
var
  s: String;
  i: Integer;
  c: Byte;
  subkeys: TArrayOfString;
begin
  Result := True;
  if CurPage = wpWelcome then begin
    if RegGetSubkeyNames(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}', subkeys) then begin
      for i := 0 to GetArrayLength(subkeys)-1 do begin
        if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\' + subkeys[i], 'ComponentId', s) then begin
          if CompareText(s, 'tap0801co') = 0 then begin
            Result := (MsgBox('Warning: There is already a TAP-Win32 V8 network adapter installed on your system - or has not been cleanly uninstalled.' + #10 +
                              '(In case you have just uninstalled andLinux: did you do the required Windows restart?)' + #10 +
                              'If you continue with this setup, andLinux may not work or may destroy your existing TAP-Win32 V8 network adapter. If you' + #10 +
                              'are sure that this only is a remainder of an unclean uninstallation, you may try to continue; however, a successful installation' + #10 +
                              'of andLinux cannot be guaranteed. Do yo wish to continue now?', mbError, MB_YESNO) = IDYES);
            break;
          end
        end
      end
    end
    if Result and RegKeyExists(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\CoLinuxDriver') then
      Result := (MsgBox('Warning: There is already a coLinux driver installed on your system - or has not been cleanly uninstalled.' + #10 +
                        '(In case you have just uninstalled andLinux: did you do the required Windows restart?)' + #10 +
                        'If you continue with this setup, andLinux may not work or may destroy your existing coLinux driver. If you' + #10 +
                        'are sure that this only is a remainder of an unclean uninstallation, you may try to continue; however, a' + #10 +
                        'successful installation of andLinux cannot be guaranteed. Do yo wish to continue now?', mbError, MB_YESNO) = IDYES);
    if Result and RegKeyExists(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\andLinux') then
      Result := (MsgBox('Warning: There is already an andLinux NT service installed on your system - or has not been cleanly uninstalled.' + #10 +
                        '(In case you have just uninstalled andLinux: did you do the required Windows restart?)' + #10 +
                        'If you continue with this setup, andLinux may not work. If you are sure that this only is a remainder of an unclean' + #10 +
                        'uninstallation, you may try to continue; however, a successful installation of andLinux cannot be guaranteed.' + #10 +
                        'Do yo wish to continue now?', mbError, MB_YESNO) = IDYES);
  end else if CurPage = XmingPage.ID then begin
    Result := True
    if XmingInstallYRadio.Checked then begin
      if XmingResYRadio.Checked then begin
        if StrToIntDef(XmingResXEdit.Text, 0) < 800 then begin
          MsgBox('The Xming screen width is no valid number (minimum value: 800)!', mbError, MB_OK);
          Result := False;
        end else if StrToIntDef(XmingResYEdit.Text, 0) < 600 then begin
          MsgBox('The Xming screen height is no valid number (minimum value: 600)!', mbError, MB_OK);
          Result := False;
        end
      end
    end else
      MsgBox('Note that andLinux will not work until you install and configure your own X Server!', mbInformation, MB_OK);
  end else if CurPage = LoginPage.ID then begin
    if LoginPage.Values[1] <> LoginPage.Values[2] then begin
      MsgBox('The two passwords entered don''t match.', mbError, MB_OK);
      Result := False;
    end else if Length(LoginPage.Values[0]) = 0 then begin
      MsgBox('The username must not be empty.', mbError, MB_OK);
      Result := False;
    end else if LoginPage.Values[0] = 'root' then begin
      MsgBox('The username must not be ''root''.', mbError, MB_OK);
      Result := False;
    end else if Length(LoginPage.Values[1]) = 0 then begin
      MsgBox('The password must not be empty.', mbError, MB_OK);
      Result := False;
    end else begin
      for i := 1 to Length(LoginPage.Values[0]) do begin
        c := Ord(LoginPage.Values[0][i]);
        if ((c < Ord('A')) or (c > Ord('Z'))) and ((c < Ord('a')) or (c > Ord('z'))) then
          Result := False;
      end
      if Result = False then begin
        MsgBox('Please choose another username that does not contain other characters than: a...z, A...Z', mbError, MB_OK)
        Result := False;
      end
    end
  end else if CurPage = CoFSPage.ID then begin
    if not DirExists(CoFSPage.Values[0]) then begin
      MsgBox('You must enter a valid drive or directory name.', mbError, MB_OK);
      Result := False;
    end
  end else if CurPage = SambaPage.ID then begin
    if SambaPasswordEdit.Text <> SambaRepeatEdit.Text then begin
      MsgBox('The two passwords entered don''t match.', mbError, MB_OK);
      Result := False;
    end else if Length(SambaUserEdit.Text) = 0 then begin
      MsgBox('The Samba username must not be empty.', mbError, MB_OK);
      Result := False;
    end else if Length(SambaPasswordEdit.Text) = 0 then begin
      MsgBox('The Samba password must not be empty. In case this Windows user doesn''t have a password,' + #10 +
             'please either set a password or create another user with a password.', mbError, MB_OK);
      Result := False;
    end else begin
      for i := 1 to Length(SambaShareName) do begin
        c := Ord(SambaShareName[i]);
        if ((c < Ord('A')) or (c > Ord('Z'))) and ((c < Ord('a')) or (c > Ord('z'))) and ((c < Ord('0')) or (c > Ord('9'))) and (c <> Ord('-')) and (c <> Ord('_')) then
          Result := False;
      end
      if Result = False then
        MsgBox('Please choose another share name because andLinux cannot access a share if its name contains spaces or other characters than: a...z, A...Z, 0...9, -, _', mbError, MB_OK)
      else begin
        if RegQueryMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\lanmanserver\Shares\', SambaShareName, s) then begin
          SambaSharePath := GrepPathFromRegMultiString(s);
          if Length(SambaSharePath) = 0 then begin
            MsgBox('There is no path associated with this shared folder / drive!', mbError, MB_OK);
            Result := False;
          end
        end else begin
          MsgBox('Invalid shared folder / drive selected!', mbError, MB_OK);
          Result := False;
        end
      end
    end
  end
end;

procedure CreateConfigs();
var
  settings: TStringList;
begin
  // settings.txt must exist bevor [Run] section is processed and can't be created until the app dir exists
  settings := TStringList.Create;
  case MemoryPage.SelectedValueIndex of
    0: settings.Append('mem=128');
    1: settings.Append('mem=192');
    2: settings.Append('mem=256');
    3: settings.Append('mem=384');
    4: settings.Append('mem=512');
    5: settings.Append('mem=768');
    6: settings.Append('mem=1024');
  end
  settings.Append('root=/dev/cobd0');
  settings.Append('kernel=vmlinux');
  settings.Append('cobd0=Drives\base.vdi');
  settings.Append('cobd1=Drives\swap.vdi');
  settings.Append('cofs31=.');
  settings.Append('eth0=slirp');
  settings.Append('eth1=tuntap,"TAP-Colinux",00:11:22:33:44:55');
  if MountPage.SelectedValueIndex = 1 then
    settings.Append('cofs0=' + GetShortName(CoFSPage.Values[0]));
  if FileExists(AddBackslash(WizardDirValue()) + 'settings.txt') then
    RenameFile(AddBackslash(WizardDirValue()) + 'settings.txt', AddBackslash(WizardDirValue()) + 'settings.old');
  settings.SaveToFile(AddBackslash(WizardDirValue()) + 'settings.txt');

  settings.Clear;
  if MountPage.SelectedValueIndex = 1 then begin
    settings.Append('mounttype=cofs');
    settings.Append('mountpath=' + AddBackslash(CoFSPage.Values[0]));
  end else if MountPage.SelectedValueIndex = 2 then begin
    settings.Append('mounttype=samba');
    settings.Append('mountpath=' + SambaSharePath);
    settings.Append('mountshare=' + SambaShareName);
    settings.Append('mountuser=' + SambaUserEdit.Text);
    settings.Append('mountpassword=' + SambaPasswordEdit.Text);
  end
  if (ServicePage.SelectedValueIndex = 0) or (ServicePage.SelectedValueIndex = 2) then
    settings.Append('launcher=no')
  else
    settings.Append('launcher=yes');
  settings.Append('login=' + LoginPage.Values[0]);
  settings.Append('passwd=' + LoginPage.Values[1]);
  settings.SaveToFile(AddBackslash(WizardDirValue()) + 'firstboot.txt');

  settings.Free;
  
  if not SaveStringToFile(AddBackslash(WizardDirValue()) + 'pulseaudio\daemon.conf', 'dl-search-path=' + AddBackslash(WizardDirValue()) + 'pulseaudio\', True) then
    MsgBox('Warning: PulseAudio could not be properly configured!', mbError, MB_OK);
end;

procedure ConfigureWinTap();
var
  i, r: Integer;
  s: String;
  subkeys: TArrayOfString;
begin
  r := -1; // not found
  if RegGetSubkeyNames(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}', subkeys) then begin
    for i := 0 to GetArrayLength(subkeys)-1 do begin
      if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\' + subkeys[i], 'ComponentId', s) then begin
        if CompareText(s, 'tap0801co') = 0 then begin
          if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\' + subkeys[i], 'NetCfgInstanceId', s) then begin
            if RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}\' + s + '\Connection', 'Name', 'TAP-Colinux') then begin
              if RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\' + s + '\Parameters\Tcpip', 'EnableDHCP', 0)
              and RegWriteMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\' + s + '\Parameters\Tcpip', 'IPAddress', '192.168.11.1')
              and RegWriteMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\' + s + '\Parameters\Tcpip', 'SubnetMask', '255.255.255.0') then begin
                if RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + s, 'AddressType', 1)
                and RegWriteDWordValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + s, 'EnableDHCP', 0)
                and RegWriteMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + s, 'IPAddress', '192.168.11.1')
                and RegWriteMultiStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + s, 'SubnetMask', '255.255.255.0') then
                  r := 0 // found + configured
                else r := 5;
              end else r := 4;
            end else r := 3;
          end else r := 2;
        end
      end
    end
  end else r := 1;
  if r <> 0 then
    MsgBox('Warning: the Tap-Colinux network adapter could not be properly configured (error code: ' + IntToStr(r) + ')', mbError, MB_OK);
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfo, MemoDirInfo, MemoTypeInfo,
  MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  s: String;
begin
  s := MemoDirInfo + NewLine + NewLine;

  if KernelPage.SelectedValueIndex = 0 then
    s := s + 'Kernel: 0.7.4 (stable)' + NewLine + NewLine
  else
    s := s + 'Kernel: 0.8.0 (development snapshot)' + NewLine + NewLine;

  s := s + 'Memory Size: ';
  case MemoryPage.SelectedValueIndex of
    0: s := s + '128 MB (not recommended)';
    1: s := s + '192 MB';
    2: s := s + '256 MB';
    3: s := s + '384 MB';
    4: s := s + '512 MB';
    5: s := s + '768 MB';
    6: s := s + '1 GB';
  end
  s := s + NewLine + NewLine;

  if XmingInstallYRadio.Checked then
    s := s + 'Xming will be installed' + NewLine + NewLine
  else
    s := s + 'Manual installation + configuration of your own X Server' + NewLine + NewLine;

  if SoundPage.SelectedValueIndex = 0 then
    s := s + 'Sound enabled' + NewLine + NewLine
  else
    s := s + 'Sound disabled' + NewLine + NewLine;

  s := s + 'Startup Type: ';
  case ServicePage.SelectedValueIndex of
    0: s := s + 'via command prompt (manually)';
    1: s := s + 'via command prompt (manually)';
    2: s := s + 'as a NT service (manually)';
    3: s := s + 'as a NT service (manually)';
    4: s := s + 'as a NT service (automatically)';
  end
  s := s + NewLine + NewLine;

  s := s + 'Access to files on Windows partition:' + Newline + Space;
  case MountPage.SelectedValueIndex of
    0: s := s + 'disabled';
    1: s := s + 'using CoFS, root folder: ' + CoFSPage.Values[0];
    2: s := s + 'using Samba (name of share: ' + SambaShareName + ', username: ' + SambaUserEdit.Text + ')';
  end
  s := s + NewLine + NewLine;

  s := s + MemoGroupInfo + NewLine + NewLine + MemoTasksInfo;

  Result := s;
end;

