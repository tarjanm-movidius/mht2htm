{    This file is part of mht2htm converter.

     Copyright (C) 2004,2007,2011 Goran Atanasijevic
     All Rights Reserved.

    mht2htm is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    mht2htm is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Goran Atanasijevic
    <bajaatan@yahoo.com>
}

unit main;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF MSWINDOWS}
    //Windows, ShellAPI,
  {$ENDIF}
  {$IFDEF UNIX}
    Unix,
  {$ENDIF}
  Classes, SysUtils, LResources, Forms, Controls, Dialogs, Grids,
  StdCtrls, ComCtrls, ExtCtrls, Menus , LCLIntf, Process,
  mechanism, languages, Constants, fileutil, Clipbrd, lazfileutils, lazutf8;


     
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button15: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CloseHistory1: TMenuItem;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    OpenDialog1: TOpenDialog;
    OpenHTMdir1: TMenuItem;
    OpenHTMfile1: TMenuItem;
    OpenIE1: TMenuItem;
    OpenMHTfile1: TMenuItem;
    OpenNetscape1: TMenuItem;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    SelectDirectoryDialog2: TSelectDirectoryDialog;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure Open_Document(file_name: string);
    procedure Open_WebPage(URL: string);
    procedure Open_Directory(directory_name: string);
    procedure Button15Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button8Mouse(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button9Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure set_language(i:integer);
    procedure Button1Click(Sender: TObject);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button5Click(Sender: TObject);
    procedure Button5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button7Click(Sender: TObject);
    procedure Button7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure AddFilesFromList(file_list:TStrings);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image2MouseUp(Sender: TOBject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label12Click(Sender: TObject);
    procedure Label16MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label19MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label22MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label7Click(Sender: TObject);
    procedure Label7MouseUp(Sender: TOBject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label9Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure OpenHTMdir1Click(Sender: TObject);
    procedure OpenHTMfile1Click(Sender: TObject);
    procedure OpenMHTfile1Click(Sender: TObject);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StringGrid2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

  stop,pause:boolean;
  StartTime,NowTime,MidTime:TDateTime;
  SizeAll,SizeRem:QWord;
  CDir:string;
  tm,dm:boolean;
  Browser, Params: string;



implementation

procedure TForm1.set_language(i:integer);
var j:integer;
begin
   j:=language_nr; //old language_nr
   language_nr:=i;

   if StringGrid1.Visible then Label1.Caption:=language_strings[i,1]
   else Label1.Caption:=language_strings[i,2];

    StringGrid1.Cells[0,0]:=language_strings[i,3];
    StringGrid1.Cells[1,0]:=language_strings[i,4];
    StringGrid1.Cells[2,0]:=language_strings[i,5];
    StringGrid2.Cells[0,0]:=language_strings[i,6];
    StringGrid2.Cells[1,0]:=language_strings[i,7];

    Label2.Caption:='0 '+language_strings[i,8]+' 0 '+language_strings[i,9];
    Label3.Caption:='0 '+language_strings[i,8]+' 0 '+language_strings[i,10];
    GroupBox1.Caption:=language_strings[i,11];
    Label13.Caption:='00:00:00 '+language_strings[i,12]+#13+language_strings[i,14]+' '+language_strings[i,13];
    GroupBox2.Caption:=language_strings[i,15];
  case TrackBar1.Position of
     0:Label15.Caption:=language_strings[i,16];
     1:Label15.Caption:=language_strings[i,17];
     2:Label15.Caption:=language_strings[i,18];
     3:Label15.Caption:=language_strings[i,19];
     4:Label15.Caption:=language_strings[i,20];
  end;
  case TrackBar2.Position of
     1:Label18.Caption:=language_strings[i,149];
     2:Label18.Caption:=language_strings[i,150];
     3:Label18.Caption:=language_strings[i,151];
  end;
    CheckBox2.Caption:=language_strings[i,24];
    Button1.Caption:=language_strings[i,25];
    Button2.Caption:=language_strings[i,26];
    if Button3.Caption=language_strings[j,30] then Button3.Caption:=language_strings[i,30]
    else Button3.Caption:=language_strings[i,27];
    if Button7.Caption=language_strings[j,29] then Button7.Caption:=language_strings[i,29]
    else Button7.Caption:=language_strings[i,28];
    if Button4.Caption=language_strings[j,32] then Button4.Caption:=language_strings[i,32]
    else Button4.Caption:=language_strings[i,31];
    Button5.Caption:=language_strings[i,33];
    Label4.Caption:=language_strings[i,36];
    CheckBox1.Caption:=language_strings[i,37];
    Label16.Caption:=language_strings[i,38];
        Image3.Hint:=language_strings[i,38];
    Label17.Caption:=language_strings[i,39];
    Label20.Caption:=language_strings[i,40];
    Label22.Caption:=language_strings[i,41];
    Label5.Hint:=language_strings[i,42];
    Shape1.Hint:=language_strings[i,42];
    Shape2.Hint:=language_strings[i,42];
    Label6.Hint:=language_strings[i,43];
    Shape3.Hint:=language_strings[i,43];
    Shape4.Hint:=language_strings[i,43];

    OpenMHTfile1.Caption:=language_strings[i,76];
    OpenHTMfile1.Caption:=language_strings[i,77];
    OpenHTMdir1.Caption:=language_strings[i,78];
    CloseHistory1.Caption:=language_strings[i,79];
    //MenuItem12.Caption:=language_strings[i,80];
    Button8.Caption:=language_strings[i,154];
    Button9.Caption:=language_strings[i,156];
    Button15.Caption:=language_strings[i,157];
    GroupBox3.Caption:=language_strings[i,158];

    CheckBox3.Caption:=language_strings[i,161];

  ImageList1.GetBitmap(i,Image2.Picture.Bitmap);
  FormResize(Form1);
end;

procedure TForm1.Open_WebPage(URL: string);
begin
   OpenURL(URL);
end;

procedure TForm1.Open_Document(file_name: string);
begin
{$IFDEF MSWINDOWS}
  ExecuteFile1(file_name,'','');
{$ELSE}
  OpenDocument(file_name);
{$ENDIF}
end;

procedure TForm1.FormDropFiles(Sender: TObject; const FileNames: array of String
  );
var i: integer;
    file_list:TStringList;
begin
  if Button1.Enabled then
  begin
    if MessageDlg(language_strings[language_nr,162], language_strings[language_nr,163]+inttostr(High(FileNames)-Low(FileNames)+1)+language_strings[language_nr,164], mtConfirmation,
     [mbYes, mbNo],0) = mrYes then
    begin
     file_list:=TStringList.Create;
     for i:=Low(FileNames) to High(FileNames) do
       file_list.Add(FileNames[i]);
     AddFilesFromList(file_list);
     file_list.Free;
    end;
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Clipboard.AsText:=StringGrid2.Cells[1,StringGrid2.Row]+'_0_start_me.htm';
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Clipboard.AsText:=StringGrid2.Cells[0,StringGrid2.Row];
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Clipboard.AsText:=StringGrid2.Cells[1,StringGrid2.Row];
end;

procedure TForm1.Open_Directory(directory_name: string);
var
  AProcess: TProcess;
begin
{$IFDEF MSWINDOWS}
  //ExecuteFile( Browser,'/e,'+directory_name,'');
  AProcess := TProcess.Create(nil);
  AProcess.Executable:=Browser;
  AProcess.Parameters.add('/e,');
  AProcess.Parameters.add(directory_name);
  AProcess.Execute;
  AProcess.Free;
{$ELSE}
  OpenDocument(directory_name);
{$ENDIF}
end;

procedure TForm1.Button8Mouse(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     StatusBar1.SimpleText:=language_strings[language_nr,155];
end;

procedure TForm1.Button9Click(Sender: TObject);
var   file_list:TStringList;
begin
  //GroupBox3.Visible:=false;
  Panel10.Visible:=false;
  Panel1.Enabled:=True;
  Panel2.Enabled:=True;
  file_list:=FindAllFiles(SelectDirectoryDialog2.FileName,ComboBox1.Text,CheckBox3.Checked);
  AddFilesFromList(file_list);
  file_list.Free;
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: char);
begin
  if ord(key)=13 then Button9Click(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  megaNFOlist.Free;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if SelectDirectoryDialog2.Execute then
  begin
    //GroupBox3.Visible:=true;
    Panel10.Visible:=true;
    Panel1.Enabled:=false;
    Panel2.Enabled:=false;
    StatusBar1.SimpleText:=language_strings[language_nr,159];
  end;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  //GroupBox3.Visible:=false;
  Panel10.Visible:=false;
  Panel1.Enabled:=True;
  Panel2.Enabled:=True;
end;

procedure TForm1.FormResize(Sender: TObject);
var h,w:integer;
begin
   w:=Button1.Width+Button2.Width+Button4.Width+Button5.Width;
   if Button7.Visible then w:=w+Button7.Width;
   if Button3.Visible then w:=w+Button3.Width;
   w:=w+Panel1.Width;
   h:=GroupBox2.Top+GroupBox2.Height+StatusBar1.Height;
   if Form1.ClientWidth<w then Form1.ClientWidth:=w;
   if Form1.ClientHeight<h then Form1.ClientHeight:=h;
   
   if StringGrid2.Width>StringGrid1.Width then w:=StringGrid2.Width
   else w:=StringGrid1.Width;
   StringGrid2.ColWidths[0]:=(w-20) div 2;
   StringGrid2.ColWidths[1]:=StringGrid2.ColWidths[0];
   StringGrid1.ColWidths[0]:=w-100;
   StringGrid1.ColWidths[2]:=w-100;
   //GroupBox3.Left:=(Form1.ClientWidth-GroupBox3.Width) div 2;
   //GroupBox3.Top:=(Form1.ClientHeight-GroupBox3.Height) div 2;
   Panel10.Left:=(Form1.ClientWidth-Panel10.Width) div 2;
   Panel10.Top:=(Form1.ClientHeight-Panel10.Height) div 2;
end;

procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
StatusBar1.SimpleText:=language_strings[language_nr,74];
end;


procedure TForm1.Image2MouseUp(Sender: TOBject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {$IFDEF Gtk2}
     PopupMenu2.PopUp(X+Form1.Left, Y+Form1.Top);
  {$ELSE}
     PopupMenu2.PopUp(X+Form1.Left+Panel1.Left+6, Y+Form1.Top+Panel8.Top+GroupBox2.Top+20);
  {$ENDIF}
end;



procedure TForm1.Label12Click(Sender: TObject);
begin
    Open_WebPage('http://www.lazarus.freepascal.org');
end;

procedure TForm1.Label16MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,67];
end;

procedure TForm1.Label19MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,68];
end;

procedure TForm1.Label22MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,69];
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
     Open_WebPage(PMySite);
end;

procedure TForm1.Label7MouseUp(Sender: TOBject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {$IFDEF Gtk2}
     PopupMenu2.PopUp(X+Form1.Left, Y+Form1.Top);
  {$ELSE}
     PopupMenu2.PopUp(X+Form1.Left+Panel1.Left+Label7.Left+6, Y+Form1.Top+Panel8.Top+GroupBox2.Top+20);
  {$ENDIF}
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
     Open_WebPage(PMyMail)
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  MenuItem2.Checked:=false;
  MenuItem1.Checked:=true;
  Label7.Caption:=MenuItem1.Caption;
  set_language(0);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  MenuItem1.Checked:=false;
  MenuItem2.Checked:=true;
  Label7.Caption:=MenuItem2.Caption;
  set_language(1);
end;

procedure TForm1.OpenHTMdir1Click(Sender: TObject);
begin
   if NeedRTLAnsi then
   begin
     if DirectoryExists(StringGrid2.Cells[1,StringGrid2.Row]) then
       Open_Directory(StringGrid2.Cells[1,StringGrid2.Row])
     else if DirectoryExistsUTF8(StringGrid2.Cells[1,StringGrid2.Row]) then
       Open_Directory(ExtractShortPathNameUTF8(StringGrid2.Cells[1,StringGrid2.Row]));
   end
   else if DirectoryExistsUTF8(StringGrid2.Cells[1,StringGrid2.Row]) then
     Open_Directory(StringGrid2.Cells[1,StringGrid2.Row]);
end;

procedure TForm1.OpenHTMfile1Click(Sender: TObject);
begin
  if NeedRTLAnsi then
  begin
    if FileExists(StringGrid2.Cells[0,StringGrid2.Row]) then
      Open_Document(StringGrid2.Cells[0,StringGrid2.Row])
    else if FileExistsUTF8(StringGrid2.Cells[0,StringGrid2.Row]) then
      Open_Document(ExtractShortPathNameUTF8(StringGrid2.Cells[0,StringGrid2.Row]));
  end
  else if FileExistsUTF8(StringGrid2.Cells[0,StringGrid2.Row]) then
    Open_Document(StringGrid2.Cells[0,StringGrid2.Row]);
end;

procedure TForm1.OpenMHTfile1Click(Sender: TObject);
begin
  if NeedRTLAnsi then
  begin
    if FileExists(StringGrid2.Cells[1,StringGrid2.Row]+'_0_start_me.htm') then
      Open_Document(StringGrid2.Cells[1,StringGrid2.Row]+'_0_start_me.htm')
    else if FileExistsUTF8(StringGrid2.Cells[1,StringGrid2.Row]+'_0_start_me.htm') then
      Open_Document(ExtractShortPathNameUTF8(StringGrid2.Cells[1,StringGrid2.Row]+'_0_start_me.htm'));
  end
  else if FileExistsUTF8(StringGrid2.Cells[1,StringGrid2.Row]+'_0_start_me.htm') then
    Open_Document(StringGrid2.Cells[1,StringGrid2.Row]+'_0_start_me.htm');
end;

procedure TForm1.StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,71];
end;


procedure TForm1.StringGrid2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,70];
end;



procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  case TrackBar1.Position of
     0:Label15.Caption:=language_strings[language_nr,16];
     1:Label15.Caption:=language_strings[language_nr,17];
     2:Label15.Caption:=language_strings[language_nr,18];
     3:Label15.Caption:=language_strings[language_nr,19];
     4:Label15.Caption:=language_strings[language_nr,20];
  end;
  AddressCorrecting:=TrackBar1.Position;
end;

procedure TForm1.TrackBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
StatusBar1.SimpleText:=language_strings[language_nr,72];
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  case TrackBar2.Position of
     1:Label18.Caption:=language_strings[language_nr,149];
     2:Label18.Caption:=language_strings[language_nr,150];
     3:Label18.Caption:=language_strings[language_nr,151];
  end;
  DetailsLevel:=TrackBar2.Position;
end;

procedure TForm1.TrackBar2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,146];
end;

procedure TForm1.FormCreate(Sender: TObject);
var table_tmp:string;
    i:byte;
begin
    Form1.Caption:='mht2htm v'+PVer+' '+PDat+' '+PExtra;
    Application.Title:='mht2htm';
    Label16.Hint:=PMySite;
    tm:=false;
    dm:=false;
    table_tmp:='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    for i:=0 to 63 do
        table[i]:=table_tmp[i+1];
    stop:=false;
    pause:=false;
    GetDir(0,CDIR);
    SizeAll:=0;

    megaNFOlist := TStringList.Create;

  {$IFDEF MSWINDOWS}
    Browser:='explorer.exe';
    Params:='';
  {$ELSE}
    FindDefaultBrowser(Browser, Params);
  {$ENDIF}



    language_nr:=0;
    set_language(0);
    AddressCorrecting:=4;
    DetailsLevel:=2;
    debugmode:=false;
    SelectDirectoryDialog1.FileName:=ExtractFilePath(Application.ExeName);
    SelectDirectoryDialog2.FileName:=SelectDirectoryDialog1.FileName;
end;

procedure TForm1.AddFilesFromList(file_list:TStrings);
var i,k:integer;
    j:longword;
    s,sdir,sfile:string;
    bo:boolean;
begin
    for k:=0 to file_list.Count-1 do
     begin
      i:=0;
      s:=file_list.Strings[k];
      //ToDo: check if this can be done using FPC functions for path and file extraction
      while Pos(DirectorySeparator,copy(s,i+1,length(s)-i))>0 do
        i:=i+Pos(DirectorySeparator,copy(s,i+1,length(s)-i));
      sdir:=Copy(s,1,i);
      sfile:=copy(s,i+1,length(s)-i);
      j:=0;
      bo:=true;
      for i:=1 to StringGrid1.RowCount-1 do
       if (StringGrid1.Cells[2,i]+StringGrid1.Cells[0,i]=file_list.Strings[k]) then
            bo:=false;
       if bo then
       begin
         if not(DirectoryExists(file_list.Strings[k])) then
         begin
           if FileExists(file_list.Strings[k]) then
           begin
              if (StringGrid1.Cells[0,StringGrid1.RowCount-1]+StringGrid1.Cells[1,StringGrid1.RowCount-1]+StringGrid1.Cells[2,StringGrid1.RowCount-1]<>'') then
                 StringGrid1.RowCount:=StringGrid1.RowCount+1;
              StringGrid1.Cells[0,StringGrid1.RowCount-1]:=sfile;
              StringGrid1.Cells[2,StringGrid1.RowCount-1]:=sdir;
              j:=FileSize(file_list.Strings[k]);
              SizeAll:=SizeAll+j;
              StringGrid1.Cells[1,StringGrid1.RowCount-1]:=IntToStr(j);
           end
           //FileExistsUTF8
           else if FileExistsUTF8(file_list.Strings[k]) then
           begin
              if (StringGrid1.Cells[0,StringGrid1.RowCount-1]+StringGrid1.Cells[1,StringGrid1.RowCount-1]+StringGrid1.Cells[2,StringGrid1.RowCount-1]<>'') then
                 StringGrid1.RowCount:=StringGrid1.RowCount+1;
              StringGrid1.Cells[0,StringGrid1.RowCount-1]:=sfile;
              StringGrid1.Cells[2,StringGrid1.RowCount-1]:=sdir;
              j:=FileSize(file_list.Strings[k]);
              SizeAll:=SizeAll+j;
              StringGrid1.Cells[1,StringGrid1.RowCount-1]:=IntToStr(j);
           end
           else
           begin
             ShowMessage(language_strings[language_nr,153]+chr(13)+file_list.Strings[k]);
             Beep;
           end;
         end;
       end;
     end;
      SizeRem:=SizeAll;
      Label2.Caption:='0 '+language_strings[language_nr,8]+' '+IntToStr(StringGrid1.RowCount-1)+' '+language_strings[language_nr,9];
      Label3.Caption:='0 '+language_strings[language_nr,8]+' 0 '+language_strings[language_nr,10];
      ProgressBar1.Position:=0;
      ProgressBar2.Position:=0;
      StatusBar1.SimpleText:=IntToStr(StringGrid1.RowCount-1)+' '+language_strings[language_nr,9]+' ('+IntToStr(SizeAll)+' '+language_strings[language_nr,75]+')';

end;



procedure TForm1.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
  AddFilesFromList(OpenDialog1.Files);
end;

procedure TForm1.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,55];
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  if StringGrid1.Cells[1,StringGrid1.Row]<>'' then
  begin
      SizeAll:=SizeAll-StrToInt(StringGrid1.Cells[1,StringGrid1.Row]);
      SizeRem:=SizeAll;
      StatusBar1.SimpleText:=IntToStr(StringGrid1.RowCount-1)+' '+language_strings[language_nr,9]+' ('+IntToStr(SizeAll)+' '+language_strings[language_nr,75]+')';
  end;

if StringGrid1.RowCount>2 then
 begin
  StringGrid1.DeleteColRow(false,StringGrid1.Row);
 end
 else
 begin
   StringGrid1.Cells[0,StringGrid1.RowCount-1]:='';
   StringGrid1.Cells[1,StringGrid1.RowCount-1]:='';
   StringGrid1.Cells[2,StringGrid1.RowCount-1]:='';
   StatusBar1.SimpleText:='0 '+language_strings[language_nr,9]+' (0 '+language_strings[language_nr,75]+')';
 end;

end;

procedure TForm1.Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,56];
end;

procedure TForm1.Button3Click(Sender: TObject);
var BF,i,j,t1,t2,t3:integer;

    dpom:double;
    s1,s2,s3:string;
    SourDir,OutpDir,MHTFile:string;
    SourDirCorrected,OutpDirCorrected,MHTFileCorrected:string;
    MKDirError,UnsupportedError:boolean;
    ErrorCounter:integer;
begin
if (StringGrid1.RowCount>2) or (StringGrid1.Cells[0,1]<>'') then
begin
 if CheckBox2.Checked then Button7.Caption:=language_strings[language_nr,29]
 else Button7.Caption:=language_strings[language_nr,28];
 Button7.Visible:=true;
 Button3.Visible:=false;
 Button1.Enabled:=false;
 Button2.Enabled:=false;
 Button6.Enabled:=false;
 Button8.Enabled:=false;
 CheckBox1.Enabled:=false;
 CheckBox2.Enabled:=false;
 Edit1.Enabled:=false;
 TrackBar1.Enabled:=false;
 TrackBar2.Enabled:=false;
 if Button3.Caption=language_strings[language_nr,27] then megaNFOlist.Clear; //Clear if Button3=Start
 pause:=false;
 Application.Title:='mht2htm [0% '+language_strings[language_nr,34]+']';
 Form1.Caption:='mht2htm [0% '+language_strings[language_nr,34]+']';
 StartTime:=Now;
 Label13.Caption:='00:00:00 '+language_strings[language_nr,12]+#13+language_strings[language_nr,14]+' '+language_strings[language_nr,13];
 BF:=StringGrid1.RowCount-1;
 ProgressBar2.Visible:=true;
 Form1.FormResize(Form1);
 ErrorCounter:=0;
 for i:=1 to BF do
 begin
   MKDirError:=false;
   UnsupportedError:=false;
   SourDir:=StringGrid1.Cells[2,1];
   if SourDir[length(SourDir)]=DirectorySeparator then SourDir:=copy(SourDir,1,length(SourDir)-1);
   MHTFile:=StringGrid1.Cells[0,1];
   if CheckBox1.Checked or (Edit1.Text='') then OutpDir:=SourDir
   else OutpDir:=Edit1.Text;
   if OutpDir[length(OutpDir)]=DirectorySeparator then OutpDir:=copy(OutpDir,1,length(OutpDir)-1);

   SourDir:=StringGrid1.Cells[2,1];
   if SourDir[length(SourDir)]=DirectorySeparator then SourDir:=copy(SourDir,1,length(SourDir)-1);
   MHTFile:=StringGrid1.Cells[0,1];
   if CheckBox1.Checked or (Edit1.Text='') then OutpDir:=SourDir
   else OutpDir:=Edit1.Text;
   if OutpDir[length(OutpDir)]=DirectorySeparator then OutpDir:=copy(OutpDir,1,length(OutpDir)-1);

   OutpDir:=OutpDir+DirectorySeparator+MHTFile+'_Files';
   OutpDir:=IllegalChar(OutpDir);

   if DirectoryExistsUTF8(OutpDir) then
   begin
     j:=1;
     while DirectoryExistsUTF8(OutpDir+' ('+inttostr(j)+')') do
       j:=j+1;
     OutpDir:=OutpDir+' ('+inttostr(j)+')';
   end;

   //Fow non-UTF8 code pages use 8.3 names for MH2HT
   SourDirCorrected:=SourDir;
   OutpDirCorrected:=OutpDir;
   MHTFileCorrected:=MHTFile;
   if NeedRTLAnsi then
   begin
     if not(CreateDirUTF8(OutpDirCorrected)) then
     begin
       Beep;
       ErrorCounter:=ErrorCounter+1;
       MKDirError:=true;
     end
     else
     begin
       OutpDirCorrected:=ExtractShortPathNameUTF8(OutpDirCorrected);
       MHTFileCorrected:=ExtractFileName(ExtractShortPathNameUTF8(SourDir+DirectorySeparator+MHTFile));
       SourDirCorrected:=ExtractShortPathNameUTF8(SourDirCorrected);
     end;
   end

{$I-}
   else
   begin
     MKDir(OutpDir);
     if IOResult <> 0 then
     begin
       Beep;
       ErrorCounter:=ErrorCounter+1;
       MKDirError:=true;
     end
   end;
{$I+}
   if not(MKDirError) then
   begin
     UnsupportedError:=not(MH2HT(SourDirCorrected,MHTFileCorrected,OutpDirCorrected));
     if UnsupportedError then ErrorCounter:=ErrorCounter+1;
   end;
   SizeRem:=SizeRem-StrToInt(StringGrid1.Cells[1,1]);
   NowTime:=Now;
   dpom:=NowTime-StartTime;
   t1:=Trunc(dpom*24);
   str(t1:2,s1);
   if s1[1]=' ' then s1[1]:='0';
   t2:=Trunc(dpom*24*60)-t1*60;
   str(t2:2,s2);
   if s2[1]=' ' then s2[1]:='0';
   t3:=Round(dpom*24*3600)-t1*3600-t2*60;
   str(t3:2,s3);
   if s3[1]=' ' then s3[1]:='0';
   Label13.Caption:=s1+':'+s2+':'+s3+' '+language_strings[language_nr,12];
   if SizeRem<>0 then dpom:=SizeAll*dpom/(SizeAll-SizeRem)-dpom
   else dpom:=0;
   t1:=Trunc(dpom*24);
   str(t1:2,s1);
   if s1[1]=' ' then s1[1]:='0';
   t2:=Trunc(dpom*24*60)-t1*60;
   str(t2:2,s2);
   if s2[1]=' ' then s2[1]:='0';
   t3:=Round(dpom*24*3600)-t1*3600-t2*60;
   str(t3:2,s3);
   if s3[1]=' ' then s3[1]:='0';
   Label13.Caption:=Label13.Caption+#13+s1+':'+s2+':'+s3+' '+language_strings[language_nr,13];
   StringGrid1.Row:=1;
   StringGrid2.Cells[0,StringGrid2.RowCount-1]:=StringGrid1.Cells[2,1]+StringGrid1.Cells[0,1];
   if MKDirError then
     StringGrid2.Cells[1,StringGrid2.RowCount-1]:=language_strings[language_nr,168]
   else if UnsupportedError then
     StringGrid2.Cells[1,StringGrid2.RowCount-1]:=language_strings[language_nr,152]
   else
     StringGrid2.Cells[1,StringGrid2.RowCount-1]:=OutpDir+DirectorySeparator;
   StringGrid2.RowCount:=StringGrid2.RowCount+1;
   if StringGrid1.RowCount>2 then
   begin
    StringGrid1.DeleteColRow(false,StringGrid1.Row);
   end
   else
   begin
    StringGrid1.Cells[0,StringGrid1.RowCount-1]:='';
    StringGrid1.Cells[1,StringGrid1.RowCount-1]:='';
    StringGrid1.Cells[2,StringGrid1.RowCount-1]:='';
   end;
   ProgressBar1.Position:=Round(i*100/BF);
   Label2.Caption:=IntToStr(i)+' '+language_strings[language_nr,8]+' '+IntToStr(BF)+' '+language_strings[language_nr,9];
   Application.Title:='mht2htm ['+IntToStr(Round(i*100/BF))+'% '+language_strings[language_nr,34]+']';
   Form1.Caption:='mht2htm ['+IntToStr(Round(i*100/BF))+'% '+language_strings[language_nr,34]+']';
   if stop then
   begin
     Label2.Caption:='0 '+language_strings[language_nr,8]+' '+IntToStr(StringGrid1.RowCount-1)+' '+language_strings[language_nr,9];
     Label3.Caption:='0 '+language_strings[language_nr,8]+' 0 '+language_strings[language_nr,10];
     Form1.Caption:='mht2htm v'+PVer+' '+PDat+' '+PExtra;
     Application.Title:='mht2htm';
     ProgressBar1.Position:=0;
     ProgressBar2.Position:=0;
     stop:=false;
     pause:=false;
     SizeAll:=SizeRem;
     if CheckBox2.Checked then
     begin
         megaNFOlist.SaveToFile(CDIR+'\mega.NFO');
         megaNFOlist.Clear;
     end;
     Beep;
     Button3.Caption:=language_strings[language_nr,27];
     Button7.Visible:=false;
     Button3.Visible:=true;
     Button1.Enabled:=true;
     Button2.Enabled:=true;
     Button6.Enabled:=true;
     Button8.Enabled:=true;
     CheckBox1.Enabled:=true;
     CheckBox2.Enabled:=true;
     if not(CheckBox1.Checked) then Edit1.Enabled:=true;
 TrackBar1.Enabled:=true;
 TrackBar2.Enabled:=true;
     Form1.FormResize(Form1);
     exit;
   end;
   if pause then
   begin
     stop:=false;
     pause:=false;
     SizeAll:=SizeRem;
     megaNFOlist.SaveToFile(CDIR+'\mega.NFO');
     Application.Title:='mht2htm ['+language_strings[language_nr,35]+']';
     Form1.Caption:='mht2htm ['+language_strings[language_nr,35]+']';
     Button3.Caption:=language_strings[language_nr,30];
     Button7.Visible:=false;
     Button3.Visible:=true;
     Button1.Enabled:=true;
     Button2.Enabled:=true;
     Button6.Enabled:=true;
     Button8.Enabled:=true;
     CheckBox1.Enabled:=true;
     CheckBox2.Enabled:=true;
     if not(CheckBox1.Checked) then Edit1.Enabled:=true;
 TrackBar1.Enabled:=true;
 TrackBar2.Enabled:=true;
     Form1.FormResize(Form1);
     exit;
   end;

 end;
 if CheckBox2.Checked then
 begin
   megaNFOlist.SaveToFile(CDIR+'\mega.NFO');
   megaNFOlist.Clear;
 end;
 Form1.Caption:='mht2htm v'+PVer+' '+PDat+' '+PExtra;
 Application.Title:='mht2htm';
 SizeAll:=0;
 stop:=false;
 pause:=false;
 Beep;
 if ErrorCounter>0 then
   ShowMessage(inttostr(ErrorCounter)+language_strings[language_nr,169]);
 Button3.Caption:=language_strings[language_nr,27];
 Button7.Visible:=false;
 Button3.Visible:=true;
 Button1.Enabled:=true;
 Button2.Enabled:=true;
 Button6.Enabled:=true;
 Button8.Enabled:=true;
 CheckBox1.Enabled:=true;
 CheckBox2.Enabled:=true;
 if not(CheckBox1.Checked) then Edit1.Enabled:=true;
 TrackBar1.Enabled:=true;
 TrackBar2.Enabled:=true;
 Form1.FormResize(Form1);
end;
end;

procedure TForm1.Button3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button3.Caption=language_strings[language_nr,27] then
     StatusBar1.SimpleText:=language_strings[language_nr,57]
  else if Button3.Caption=language_strings[language_nr,30] then
     StatusBar1.SimpleText:=language_strings[language_nr,58];
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 if StringGrid2.Visible then
begin
 Label1.Caption:=language_strings[language_nr,1];  //Files to convert:
 Button4.Caption:=language_strings[language_nr,31];
 StringGrid2.Visible:=false;
 StringGrid1.Visible:=true;
 Button1.Enabled:=true;
 Button2.Enabled:=true;
 Button3.Enabled:=true;
end
else
begin
 Label1.Caption:=language_strings[language_nr,2]; //Converted files:
 Button4.Caption:=language_strings[language_nr,32];
 StringGrid1.Visible:=false;
 StringGrid2.Visible:=true;
end;
 Form1.FormResize(Form1);
end;

procedure TForm1.Button4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button4.Caption=language_strings[language_nr,31] then
     StatusBar1.SimpleText:=language_strings[language_nr,61]
  else if Button4.Caption=language_strings[language_nr,32] then
     StatusBar1.SimpleText:=language_strings[language_nr,62];
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName)+'help'+DirectorySeparator+language_strings[language_nr,160]+DirectorySeparator+'index.htm') then
       Open_Document(ExtractFilePath(Application.ExeName)+'help'+DirectorySeparator+language_strings[language_nr,160]+DirectorySeparator+'index.htm')
  else Open_WebPage(PMySite+'/mht2htm/help.html');
  beep;
end;

procedure TForm1.Button5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,63];
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute then
  begin
     Edit1.Text:=SelectDirectoryDialog1.FileName;
     Edit1.Enabled:=true;
     CheckBox1.Checked:=false;
  end;
end;

procedure TForm1.Button6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    StatusBar1.SimpleText:=language_strings[language_nr,65];
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  if Button7.Caption=language_strings[language_nr,28] then stop:=true
  else pause:=true;
end;

procedure TForm1.Button7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button7.Caption=language_strings[language_nr,28] then
     StatusBar1.SimpleText:=language_strings[language_nr,59]
  else if Button7.Caption=language_strings[language_nr,29] then
     StatusBar1.SimpleText:=language_strings[language_nr,60];

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then Edit1.Enabled:=false
  else Edit1.Enabled:=true;
end;

procedure TForm1.CheckBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    StatusBar1.SimpleText:=language_strings[language_nr,66];
end;

procedure TForm1.CheckBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
StatusBar1.SimpleText:=language_strings[language_nr,73];
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Edit1.text='debug mode' then
  begin
    Label23.visible:=not(Label23.visible);
    debugmode:=Label23.visible;
    Edit1.text:='';
    Beep;
  end;
end;

procedure TForm1.Edit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.SimpleText:=language_strings[language_nr,64];
end;


initialization
  {$I main.lrs}

end.

