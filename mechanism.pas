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
unit mechanism;

{$mode objfpc}{$H+}
//{$DEFINE CL}  //comment this if not command line program

interface
uses
  {$IFDEF MSWINDOWS}
    Windows
  {$ENDIF}
  {$IFDEF UNIX}
    Unix
  {$ENDIF}
  ,base64
  {$IFNDEF CL}

  , Forms,  Graphics{, dos}
  {$ENDIF}
  , languages, Constants, Classes , SysUtils, Process {, MarkedText};
  {$IFNDEF CL}
   procedure ExecuteFile(const FileName:string; Params:TStrings; DefaultDir: string);
   procedure ExecuteFile1(const FileName, Params, DefaultDir: string);
  {$ENDIF}
   function IllegalChar(s:string):string;
   procedure Chk(var s:string);
   function Str2Byte(s:string):byte;
   function ExtractMultiline(s:string):string;
   function MH2HT(SourDir,MHTFile,OutpDir:string):boolean;

var
   table:array[0..63]of string[1];
   language_nr:integer;
   startme:textfile;
   megaNFOlist:TStringList;
   AddressCorrecting:integer; //Address Correction level. Contain value from slider
   DetailsLevel:integer;      //Detail output level. Contain value from slider
   debugmode:boolean;
   silentmode:boolean;

    
implementation
{$IFNDEF CL}
    uses main;
{$ENDIF}


{$IFNDEF CL}
procedure ExecuteFile(const FileName:string; Params:TStrings; DefaultDir: string);
var
  AProcess: TProcess;
begin
      AProcess := TProcess.Create(nil);
      AProcess.Executable:=FileName;
      AProcess.Parameters:=Params;
      AProcess.CurrentDirectory:= DefaultDir;
      AProcess.Execute;
      AProcess.Free;
end;
{$ENDIF}

{$IFNDEF CL}
procedure ExecuteFile1(const FileName, Params, DefaultDir: string);
begin
   if FileExists(FileName) then
   begin
      {$IFDEF MSWINDOWS}
         ShellExecute(Application.MainForm.Handle, nil, PChar(FileName),
         PChar(Params), PChar(DefaultDir), SW_SHOW);
      {$ENDIF}
      {$IFDEF UNIX}
     // Shell(format('kghostview %s',[FileName]));
      {$ENDIF}
   end;
end;
{$ENDIF}

function IllegalChar(s:string):string; //remove bad path/filename chars and chars I don't like
begin

   while pos('%20',s)<>0 do s:=copy(s,1,pos('%20',s)-1)+'_'+copy(s,pos('%20',s)+3,length(s)-pos('%',s)-2);
   while pos('%',s)<>0 do s:=copy(s,1,pos('%',s)-1)+'_'+copy(s,pos('%',s)+1,length(s)-pos('%',s));
   while pos('?',s)<>0 do s:=copy(s,1,pos('?',s)-1)+'_'+copy(s,pos('?',s)+1,length(s)-pos('?',s));
   while pos('=',s)<>0 do s:=copy(s,1,pos('=',s)-1)+'_'+copy(s,pos('=',s)+1,length(s)-pos('=',s));
   while pos('&',s)<>0 do s:=copy(s,1,pos('&',s)-1)+'_'+copy(s,pos('&',s)+1,length(s)-pos('&',s));
   while pos('|',s)<>0 do s:=copy(s,1,pos('|',s)-1)+'_'+copy(s,pos('|',s)+1,length(s)-pos('|',s));
   while pos(';',s)<>0 do s:=copy(s,1,pos(';',s)-1)+'_'+copy(s,pos(';',s)+1,length(s)-pos(';',s));
   while pos(',',s)<>0 do s:=copy(s,1,pos(',',s)-1)+'_'+copy(s,pos(',',s)+1,length(s)-pos(',',s));
   while pos('[',s)<>0 do s:=copy(s,1,pos('[',s)-1)+'_'+copy(s,pos('[',s)+1,length(s)-pos('[',s));
   while pos(']',s)<>0 do s:=copy(s,1,pos(']',s)-1)+'_'+copy(s,pos(']',s)+1,length(s)-pos(']',s));
   while pos('<',s)<>0 do s:=copy(s,1,pos('<',s)-1)+'_'+copy(s,pos('<',s)+1,length(s)-pos('<',s));
   while pos('>',s)<>0 do s:=copy(s,1,pos('>',s)-1)+'_'+copy(s,pos('>',s)+1,length(s)-pos('>',s));
   while pos('{',s)<>0 do s:=copy(s,1,pos('{',s)-1)+'_'+copy(s,pos('{',s)+1,length(s)-pos('{',s));
   while pos('}',s)<>0 do s:=copy(s,1,pos('}',s)-1)+'_'+copy(s,pos('}',s)+1,length(s)-pos('}',s));
   while pos('''',s)<>0 do s:=copy(s,1,pos('''',s)-1)+'_'+copy(s,pos('''',s)+1,length(s)-pos('''',s));
   while pos('"',s)<>0 do s:=copy(s,1,pos('"',s)-1)+'_'+copy(s,pos('"',s)+1,length(s)-pos('"',s));
   while pos('@',s)<>0 do s:=copy(s,1,pos('@',s)-1)+'_'+copy(s,pos('@',s)+1,length(s)-pos('@',s));
   while pos('#',s)<>0 do s:=copy(s,1,pos('#',s)-1)+'_'+copy(s,pos('#',s)+1,length(s)-pos('#',s));
   //s[pos('%',s)]:='_';
   //while pos('?',s)<>0 do s[pos('%',s)]:='_';
   //while pos('&',s)<>0 do s[pos('%',s)]:='_';
   IllegalChar:=s;
end;


function IllegalChar2(s:string):string; {remove bad path/filename chars and chars I dont like}
begin
   while pos(':',s)<>0 do s:=copy(s,1,pos(':',s)-1)+'_'+copy(s,pos(':',s)+1,length(s)-pos(':',s));
   while pos('/',s)<>0 do s:=copy(s,1,pos('/',s)-1)+'_'+copy(s,pos('/',s)+1,length(s)-pos('/',s));
   while pos('\',s)<>0 do s:=copy(s,1,pos('\',s)-1)+'_'+copy(s,pos('\',s)+1,length(s)-pos('\',s));
   IllegalChar2:=s;
end;

function DeEnEsc(s:string):string; {replace ESC sequences with equivalent}
begin
   StringReplace(s,'&amp;','&', [rfReplaceAll]);
   while pos('&amp;',s)<>0 do s:=copy(s,1,pos('&amp;',s)-1)+'&'+copy(s,pos('&amp;',s)+3,length(s)-pos('&amp;',s)-2);
   //add all sequences: %code, =code, &code, &name
   DeEnEsc:=s;
end;

function EnEsc(s:string):string; {replace some characters with ESC sequences}
var i:integer;
    s1:string;
begin
   s1:='';
   i:=pos('&',s);
   while (i>0) do
   begin
     if (lowercase(copy(s,i,4))='&amp;') then
     begin
       s1:=s1+copy(s,1,i+4);
       s:=copy(s,i+5,length(s)-i-4);
     end
     else
     begin
       s1:=s1+copy(s,1,i)+'amp;';
       s:=copy(s,i+1,length(s)-i);
     end;
     i:=pos('&',s);
   end;
   EnEsc:=s1+s;
end;

procedure Chk(var s:string); {remove non table chars}
var i,i1:integer;
    b:boolean;
begin
   i1:=1;
   while i1<=length(s) do
   begin
      b:=true;
      for i:=0 to 63 do
         if table[i]=s[i1] then b:=false;
      if s[i1]='=' then b:=false;
      if b then Delete(s,i1,1);
   end;
end;

function Str2Byte(s:string):byte; //returns 0 to 63 or 127 for error (non table char)
var i:integer;
    b:boolean;
begin
   b:=true;
   for i:=0 to 63 do
   begin
      if table[i]=s then
      begin
         Str2Byte:=i;
         b:=false;
      end;
   end;
   if b then Str2Byte:=127;
end;


function ExtractMultiline(s:string):string;
var st,en:integer;
    s1:string;
begin

   if ((pos('=?',s)<>0) and (pos('?=',s)<>0)) and (pos('?q?',lowercase(s))<>0) then
   begin
      s1:='';
      while ((pos('=?',s)<>0) and (pos('?=',s)<>0)) and (pos('?q?',lowercase(s))<>0) do
      begin
         st:=pos('?q?',lowercase(s))+3;
         en:=pos('?=',copy(s,st,length(s)-st+1));
         s1:=s1+copy(s,st,en-1);
         s:=copy(s,st+en+1,length(s)-st-en);
//         Delete(s,1,en+1);
      end;
   end
   else s1:=s;
   ExtractMultiline:=s1;

end;

function MH2HT(SourDir,MHTFile,OutpDir:string):boolean;
var s,s1:string;

    info,debugfile:textfile;
    firsthtmfound:boolean;  //is first html found?
    firstpart:integer; //position inside mht of first html
    i,j,i1,i2:integer;
    recog:string;
    temptime:TDateTime;
    line_counter,lines:integer;
    header,part_header:boolean;
    tempboolean:boolean;
    GoodMHT:boolean;

    //next variables for header data from mht file
    mht_from,mht_subject,mht_date,mht_importance,mht_priority,
    mht_content_type,mht_mime_version,mht_type,mht_start_file:string;
    mht_content_transfer_encoding,mht_charset,mht_content_location,
    mht_product,mht_x_maf,mht_x_mime,mht_thread_index,
    mht_content_class,{mht_first_boundry,mht_last_boundry,}
    mht_start_line,mht_other_mht_creator:string;
    parts,alternatives:integer;

    nizOrig,nizNew,nizNewName,nizType,nizCode:TStringList; //arrays of Original names, new (local) location+filename, only name, filetype and b64/qp

    //next variables for header data for each file from mht file
    part_content_type,part_charset,part_content_transfer_encoding,
    part_content_location,part_content_id,part_content_disposition,
    part_filename,part_name,
    part_start_line,part_end_line,alternative,

    part_orig_path_full,part_orig_path_relative,part_unchanged_file_name,part_local_name,
    part_encoding,part_type,   //simplefied values
                               //part_type usualy same as recognized

    repso,repsn,delo,     //replace what, replace with, strings to delete
    repso1,repsn1,delo1,  //replace what, replace with, strings to delete
                          //addition for each QB file, except main html

    part_recognized:TStringList;



    source:textfile;
    f:file of byte;
    mht_file_size:integer;
    mht_file_creator:string;



    boundary:TStringList;
    boundarycount:integer;
    BaseURL:string;
    firsthtm:string;

    //**********inner procedure***********************
    procedure ClearPartHeader;
    begin
       part_content_type[Parts]:='';
       part_charset[Parts]:='';
       part_content_transfer_encoding[Parts]:='';
       part_content_location[Parts]:='';
       part_content_id[Parts]:='';
       part_content_disposition[Parts]:='';
       part_filename[Parts]:='';
       part_name[Parts]:='';
       part_start_line[Parts]:='';
       part_end_line[Parts]:='';
       alternative[Parts]:='';
       
       part_orig_path_full[Parts]:='';
       part_orig_path_relative[Parts]:='';
       part_local_name[Parts]:='';
       part_unchanged_file_name[Parts]:='';
       part_encoding[Parts]:='';
       part_type[Parts]:='';
       part_recognized[Parts]:='';
    end;
    
    //**********inner procedure***********************
    procedure AddPartHeader;
    begin
       part_content_type.Add('');
       part_charset.Add('');
       part_content_transfer_encoding.Add('');
       part_content_location.Add('');
       part_content_id.Add('');
       part_content_disposition.Add('');
       part_filename.Add('');
       part_name.Add('');
       part_start_line.Add('');
       part_end_line.Add('');
       alternative.Add('');
       
       part_orig_path_full.Add('');
       part_orig_path_relative.Add('');
       part_local_name.Add('');
       part_unchanged_file_name.Add('');
       part_encoding.Add('');
       part_recognized.Add('');
       part_type.Add('');
    end;

   //**********inner procedure***********************
   function ExtendToFullPath(URL:string):string;  //transform relative url to absolute
   var //common_parts_no:integer;
       slash,backslash:integer;
       i,j,dot1,dot2,dot3:integer;
       {BaseURL_copy,}URL_copy:string;  //copies of input strings
       s:string;
   begin
     //BaseURL_copy:=BaseURL;
     URL_copy:=url;
     if URL='' then
     begin
       ExtendToFullPath:=URL;  //address is empty
       exit;
     end;
     //find URL protocol if any. If there is then not
     for i:=1 to ProtocolsCounter do
        if lowercase(copy(URL_copy,1,length(Protocols[i])))=Protocols[i] then
        begin
          ExtendToFullPath:=URL;  //address is absolute
          exit;
        end;
     for i:=1 to LocalProtocolsCounter do
        if lowercase(copy(URL_copy,1,length(LocalProtocols[i])))=LocalProtocols[i] then
        begin
          ExtendToFullPath:=URL;  //address is absolute (local)
          exit;
        end;


     //disasemble URL, extract 1st part
     slash:=pos('/',URL_copy);
     backslash:=pos('\',URL_copy);
     if slash+backslash>0 then
     begin
       if ((slash<backslash) and (slash>0)) or (backslash=0) then
          s:=copy(URL_copy,1,slash-1)
       else
          s:=copy(URL_copy,1,backslash-1);
     end;
     //check if 1st part is domain
     if lowercase(copy(s,1,4))='www.' then
     begin
       ExtendToFullPath:=URL;  //address is absolute
       exit;
     end;
     for i:=1 to TopLevelDomainsCounter do
       if pos(TopLevelDomains[i],lowercase(s))>0 then
       begin
         ExtendToFullPath:=URL;  //address is absolute
         exit;
       end;
     //check if 1st part is IP start
     dot1:=pos('.',s);
     if dot1=0 then
     begin
         ExtendToFullPath:=URL;  //address is absolute
         exit;
     end;
     dot2:=pos('.',copy(s,dot1+1,length(s)-dot1));
     if (dot2=0) or (dot2-dot1=1) then
     begin
         ExtendToFullPath:=URL;  //address is absolute
         exit;
     end;
     dot3:=pos('.',copy(s,dot1+dot2+1,length(s)-dot1-dot2));
     if (dot3=0) or (dot3-dot2-dot1=1) then
     begin
         ExtendToFullPath:=URL;  //address is absolute
         exit;
     end;
     Val(copy(s,dot1+1,dot2-1),i,j);
     if (j<>0) or ((i>255) or (i<0)) then
     begin
         ExtendToFullPath:=URL;  //address is absolute
         exit;
     end;
     Val(copy(s,dot1+dot2+1,dot3-1),i,j);
     if (j<>0) or ((i>255) or (i<0)) then
     begin
         ExtendToFullPath:=URL;  //address is absolute
         exit;
     end;
     Val(copy(s,dot1+dot2+dot3+1,length(s)-dot1-dot2-dot3),i,j);
     if (j<>0) or ((i>255) or (i<0)) then
     begin
         ExtendToFullPath:=URL;  //address is absolute
         exit;
     end;
     //check if 1st part is IP end
     
     //now we know that address is local
     if (copy(URL,1,1)='/') or (copy(URL,1,1)='\') then
         s:=BaseURL+copy(URL,2,length(URL)-1)
     else
         s:=BaseURL+URL;
// DEBUG MODE START
     if debugmode then
     begin
       Writeln(debugfile,'oooooooooooooooooooooooooooooooooo');
       Writeln(debugfile,'Extended local URL: '+URL);
       Writeln(debugfile,'to full URL: '+s);
       Writeln(debugfile,'oooooooooooooooooooooooooooooooooo');
     end;
// DEBUG MODE END
     ExtendToFullPath:=s;
   end;
    
    //**********inner procedure***********************
    function ExtractHeader(var s:string):boolean;   //returns true if line is header
    var found:boolean;
        s1:string;
        //i:integer;
    begin
       found:=false;
       repeat
          s:=trim(s);
          if Copy(s,length(s),1)=';' then s:=Copy(s,1,length(s)-1);
          s:=trim(s);
          s1:='';
          if pos(';',s)<>0 then
          begin
             s1:=copy(s,pos(';',s)+1,length(s)-length(s1)-1);
             s:=copy(s,1,pos(';',s)-1);
          end;
          if header then  //mht file header only (not parts headers)
          begin
             //From: <  > extract start
             if pos('from:',lowercase(s))=1 then
             begin
                Delete(s,1,5);
                s:=Trim(s);
                if pos('<',s)<>0 then
                begin
                   Delete(s,1,pos('<',s));
                   if pos('>',s)<>0 then
                      s:= copy(s,1,pos('>',s)-1)
                end;
                mht_from:=s;
                found:=true;
             end
             else if pos('boundary',lowercase(s))=1 then
             begin
                Delete(s,1,8);
                s:=Trim(s);
                if copy(s,1,1)='=' then Delete(s,1,1);
                s:=Trim(s);
{                if copy(s,1,1)='"' then
                begin
                   Delete(s,1,1);
                   if pos('"',s)<>0 then
                      s:= copy(s,1,pos('"',s)-1)
                end;   }
                if pos('"',s)<>0 then
                begin
                   Delete(s,1,pos('"',s));
                   if pos('"',s)<>0 then
                      s:= copy(s,1,pos('"',s)-1)
                end;
                if boundary.IndexOf(s)=-1 then
                begin
                   boundary.Add(s);
                   boundarycount:=boundarycount+1;
                end;
                found:=true;
             end
             //boundary extract end
             //Start=<  > extract start  (Opera only, points to CID of first html file)
             else if pos('start=',lowercase(s))=1 then
             begin
                Delete(s,1,6);
                s:=Trim(s);
                if pos('<',s)<>0 then
                begin
                   Delete(s,1,pos('<',s));
                   if pos('>',s)<>0 then
                      s:= copy(s,1,pos('>',s)-1)
                end;
{                if s[1]='<' then
                begin
                   Delete(s,1,1);
                   if pos('>',s)<>0 then
                      s:= copy(s,1,pos('>',s)-1)
                end;   }
                mht_start_file:=s;
                found:=true;
             end
             //Start=<  > extract start
             //Subject: extract start
             else if pos('subject:',lowercase(s))=1 then
             begin
                Delete(s,1,8);
                s:=Trim(s);
                s:=ExtractMultiline(s);
                mht_subject:=s;
                found:=true;
             end
             //Subject: extract start
             //Content-Location: extract start
             else if pos('content-location:',lowercase(s))=1 then
             begin
                Delete(s,1,17);
                s:=Trim(s);
                s:=ExtractMultiline(s);
                mht_content_location:=s;
                found:=true;
             end
             //Content-Location: extract start
             //Content-Transfer-Encoding: extract start
             else if pos('content-transfer-encoding:',lowercase(s))=1 then
             begin
                Delete(s,1,26);
                s:=Trim(s);
                mht_content_transfer_encoding:=s;
                found:=true;
             end
             //Content-Transfer-Encoding: extract start
             //Date: extract start
             else if pos('date:',lowercase(s))=1 then
             begin
                Delete(s,1,5);
                s:=Trim(s);
                mht_date:=s;
                found:=true;
             end
             //Date: extract start
             //Importance: extract start
             else if pos('importance:',lowercase(s))=1 then
             begin
                Delete(s,1,11);
                s:=Trim(s);
                mht_importance:=s;
                found:=true;
             end
             //Importance: extract end
             //thread-index: extract start (Save Page, b64 array)
             else if pos('thread-index:',lowercase(s))=1 then
             begin
                Delete(s,1,13);
                s:=Trim(s);
                mht_thread_index:=s;
                found:=true;
             end
             //Importance: extract end
             //Priority: extract start
             else if pos('priority:',lowercase(s))=1 then
             begin
                Delete(s,1,9);
                s:=Trim(s);
                mht_priority:=s;
                found:=true;
             end
             //Priority: extract end
             //Product: extract start (EZ Save MHT, link to homepage)
             else if pos('product:',lowercase(s))=1 then
             begin
                Delete(s,1,8);
                s:=Trim(s);
                mht_product:=s;
                found:=true;
             end
             //Product: extract end
             //X-MAF: extract start
             else if pos('x-maf:',lowercase(s))=1 then
             begin
                Delete(s,1,6);
                s:=Trim(s);
                mht_x_maf:=s;
                found:=true;
             end
             //X-MAF: extract end
             //X-MimeOLE: extract start
             else if pos('x-mimeole:',lowercase(s))=1 then
             begin
                Delete(s,1,10);
                s:=Trim(s);
                mht_x_mime:=s;
                found:=true;
             end
             //X-MimeOLE: extract end
             //MIME-Version: extract start
             else if pos('mime-version:',lowercase(s))=1 then
             begin
                Delete(s,1,13);
                s:=Trim(s);
                mht_mime_version:=s;
                found:=true;
             end
             //MIME-Version: extract end
             //Content-Type: extract start
             else if pos('content-type:',lowercase(s))=1 then
             begin
                Delete(s,1,13);
                s:=Trim(s);
                mht_content_type:=s;
                found:=true;
             end
             //Content-Type: extract end
             //charset= extract start
             else if pos('charset',lowercase(s))=1 then
             begin
                Delete(s,1,7);
                s:=Trim(s);
                if s[1]='=' then Delete(s,1,1);
                s:=Trim(s);
                if s[1]='"' then
                begin
                   Delete(s,1,1);
                   if pos('"',s)<>0 then
                      s:= copy(s,1,pos('"',s)-1)
                end;
                mht_charset:=s;
                found:=true;
             end
             //charset= extract start
             //type=" " extract start
             else if pos('type',lowercase(s))=1 then
             begin
                Delete(s,1,4);
                s:=Trim(s);
                if s[1]='=' then Delete(s,1,1);
                s:=Trim(s);
                if s[1]='"' then
                begin
                   Delete(s,1,1);
                   if pos('"',s)<>0 then
                      s:= copy(s,1,pos('"',s)-1)
                end;
                mht_type:=s;
                found:=true;
             end
             //type: extract end
             
             //Content-Class: extract start (SavePage only)
             else if pos('content-class:',lowercase(s))=1 then
             begin
                Delete(s,1,14);
                s:=Trim(s);
                mht_content_class:=s;
                found:=true;
             end
             //Content-Class: extract end
             //This is a multi-part message in MIME format. - extract nothing but ount as header
             else if pos('this is a multi-part message in mime format.',lowercase(s))=1 then
             begin
                found:=true;
             end
             else if pos('this document is a web archive file.',lowercase(s))=1 then
             begin
                found:=true;
                mht_other_mht_creator:='MS Word'
             end
             //x-mailer:
             else if pos('x-mailer:',lowercase(s))=1 then
             begin
                Delete(s,1,9);
                s:=Trim(s);
                found:=true;
                if pos('aol webmail',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('atmail',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('mail',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('earthlink',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('iplanet',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('messenger',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('listmerge',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('microsoft',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('outlook',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('mime',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('mozilla',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('php',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('qmail',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('eudora',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('servage',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('bat!',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                else if pos('yahoo',lowercase(s))<>0 then
                  mht_other_mht_creator:='(email) '+s
                //else found:=false; //only during test
             end
             //x-mailer: end

             //other mailing servers:
             else if (pos('(iplanet messaging server',lowercase(s))=1)
                  or (pos('sun java system messaging server',lowercase(s))<>0) then
             begin
               if (pos('(',s)=1) and (pos(')',s)=length(s)) then
                 s:=copy(s,2,length(s)-2);
               mht_other_mht_creator:='(email) '+s;
               found:=true;
             end
             else if (pos('((iplanet messaging server))',lowercase(s))=1) then
             begin
               mht_other_mht_creator:='(email) iPlanet Messaging Server';
               found:=true;
             end
             else if (pos('x-enigmail-version:',lowercase(s))=1) then
             begin
               mht_other_mht_creator:='(email) '+s;
               found:=true;
             end;
             //other mailing servers end
             //other unhandled commands
            { else
             begin
                found:=false;
                for i:=1 to OtherHeaderCommandsCounter do
                  if pos(OtherHeaderCommands[i],lowercase(s))=1 then
                  begin
                    found:=true;
                    break;
                  end;
             end; }

             // FOR TESTING ONLY
             // ADD Memo1 to Form1
             {if not found then
             begin
                 tempboolean:=true;
                 for i:=0 to Form1.Memo1.Lines.Count-1 do
                    if Form1.Memo1.Lines.Strings[i]=s then tempboolean:=false;
                 if tempboolean then
                    Form1.Memo1.Lines.Add(s);
             end; }
             // FOR TESTING ONLY
             {if s<>'' then found:=true;}

             //mht_other_mht_creator
             //This is a multi-part message in MIME format. end
             //rest strings that can be found in mht files (usualy .eml mail files) start
             {else if pos('this is a multi-part message in mime format.',lowercase(s))=1 then
             begin
                found:=true;
             end }
             //rest strings that can be found in mht files (usualy .eml mail files) start
             
          end
          //parts headers only (not mht file header)
          //boundary extract start
          else if pos('boundary',lowercase(s))=1 then
          begin
             Delete(s,1,8);
             s:=Trim(s);
             if copy(s,1,1)='=' then Delete(s,1,1);
             s:=Trim(s);
             if copy(s,1,1)='"' then
             begin
                Delete(s,1,1);
                if pos('"',s)<>0 then
                   s:= copy(s,1,pos('"',s)-1)
             end;
             if boundary.IndexOf(s)=-1 then
             begin
                boundary.Add(s);
                boundarycount:=boundarycount+1;
             end;
             found:=true;
          end
          //boundary extract end
          //Content-Type: extract start
          else if pos('content-type:',lowercase(s))=1 then
          begin
             Delete(s,1,13);
             s:=Trim(s);
             part_content_type[Parts]:=s;
             found:=true;
          end
          //Content-Type: extract end
          //Content-Location: extract start
          else if pos('content-location:',lowercase(s))=1 then
          begin
             Delete(s,1,17);
             s:=Trim(s);
             s:=ExtractMultiline(s);
             part_content_location[Parts]:=s;
             found:=true;
          end
          //Content-Location: extract start
          //Content-Description:: extract start //??? newly found, not extracted yet
          else if pos('content-description:',lowercase(s))=1 then
          begin
             {Delete(s,1,20);
             s:=Trim(s);
             s:=ExtractMultiline(s);
             part_content_location[Parts]:=s;   }
             found:=true;
          end
          //Content-Description:Content-Location: extract start
          //Content-Transfer-Encoding: extract start
          else if pos('content-transfer-encoding:',lowercase(s))=1 then
          begin
             Delete(s,1,26);
             s:=Trim(s);
             part_content_transfer_encoding[Parts]:=s;
             found:=true;
          end
          //Content-Transfer-Encoding: extract start
          //Content-Type: extract end
          //charset= extract start
          else if (part_header or found) and (pos('charset',lowercase(s))=1) then  //header can't start with this
          begin
             Delete(s,1,7);
             s:=Trim(s);
             if s[1]='=' then Delete(s,1,1);
             s:=Trim(s);
             if s[1]='"' then
             begin
                Delete(s,1,1);
                if pos('"',s)<>0 then
                   s:= copy(s,1,pos('"',s)-1)
          end;
          part_charset[Parts]:=s;
          found:=true;
          end
          //charset= extract start
          //Content-ID: <  > extract start
          else if pos('content-id:',lowercase(s))=1 then
          begin
             Delete(s,1,11);
             s:=Trim(s);
             if pos('<',s)<>0 then
             begin
                Delete(s,1,pos('<',s));
                if pos('>',s)<>0 then
                   s:= copy(s,1,pos('>',s)-1)
             end;
{             if s[1]='<' then
             begin
                Delete(s,1,1);
                if pos('>',s)<>0 then
                   s:= copy(s,1,pos('>',s)-1)
             end;  }
             part_content_id[Parts]:=s;
             found:=true;
          end
          //Content-ID: <  > extract start
          //Content-Disposition: extract start
          else if pos('content-disposition:',lowercase(s))=1 then
          begin
             Delete(s,1,20);
             s:=Trim(s);
             part_content_disposition[Parts]:=s;
             found:=true;
          end
          //Content-Disposition: extract start
          //filename= extract start (Firefox, Opera)
          else if (part_header or found) and (pos('filename',lowercase(s))=1) then //header can't start with this
          begin
             Delete(s,1,8);
             s:=Trim(s);
             if s[1]='=' then Delete(s,1,1)
             else if (s[1]='*') and (pos('=',s)<>0) then Delete(s,1,pos('=',s));
             s:=Trim(s);
             if (s[1]='"') and (s[length(s)]='"') then s:=copy(s,2,length(s)-2);
             part_filename[Parts]:=s;
             found:=true;
          end
          //filename= extract end
          //name= extract start (Firefox, Opera)
          else if (part_header or found) and (pos('name',lowercase(s))=1) then  //header can't start with this
          begin
             Delete(s,1,4);
             s:=Trim(s);
             if s[1]='=' then Delete(s,1,1)
             else if (s[1]='*') and (pos('=',s)<>0) then Delete(s,1,pos('=',s));
             s:=Trim(s);
             if (s[1]='"') and (s[length(s)]='"') then s:=copy(s,2,length(s)-2);
             part_name[Parts]:=s;
             found:=true;
          end;
          //name= extract start
//       end;
          s:=s1;
       until s1='';
       ExtractHeader:=found;

    end;
    
   //**********inner procedure***********************
   function isboundary(s:string):integer;  //is line boundary?
   var i:integer;
       found:integer;
   begin
      s:=trim(s);
      found:=0;
      for i:=1 to boundarycount do
        if pos('--'+boundary[i],s)=1 then found:=i;
      isboundary:=found;
   end;

  //**********inner procedure***********************
   Procedure PrepRep(source,target,targetfilename:string;mainfile:boolean); //simular as PrepareReplace, but all files is compared with one, source file
   var source_parts,target_parts:TStrings;  //parts of URL separated with / or \
       source_parts_no,target_parts_no:integer; //number of parts (directories)
       common_parts_no:integer;
       slash,backslash:integer;
       i,j:integer;
       source_copy,target_copy:string;  //copies of input strings
       s:string;
      //*inner inner procedure*
      procedure RepsoAdd(s,s1:string;mainfile:boolean); //check if already in list and add new if not
      begin
         //avoid dead loops and strings already in lists
         if s='' then exit
         else if s=s1 then exit
         else if repso.IndexOf(s)<>-1 then exit;

         if mainfile then
         begin
             repso.Add(s);
             repsn.Add(s1);
         end
         else
           if repso1.IndexOf(s)=-1 then
           begin
             repso1.Add(s);
             repsn1.Add(s1);
           end
      end;
      //*inner inner procedure*
      procedure DeloAdd(s:string;mainfile:boolean);  //check if already in list and add as new if not
      begin
         //avoid strings already in lists
         if s='' then exit
         else if delo.IndexOf(s)<>-1 then exit;
         
         if mainfile then
             delo.Add(s)
         else
           if (s<>'') and (delo1.IndexOf(s)=-1) then
             delo1.Add(s);
      end;
       
   begin
     source_parts := TStringList.Create;
     source_parts.Clear; source_parts.Add('');
     target_parts := TStringList.Create;
     target_parts.Clear; target_parts.Add('');
     source_copy:=source;
     target_copy:=target;
     //find source protocol if any
     if lowercase(copy(source_copy,1,7))='http://' then
     begin
       source_copy:=copy(source_copy,8,length(source_copy)-7);
       source_parts[0]:='http://';
     end
     else if lowercase(copy(source_copy,1,6))='ftp://' then
     begin
       source_copy:=copy(source_copy,7,length(source_copy)-6);
       source_parts[0]:='ftp://'
     end
     else
     begin
       for i:=1 to 26 do
       if lowercase(copy(source_copy,1,9))='file://'+chr(96+i)+':' then
       begin
         source_copy:=copy(source_copy,11,length(source_copy)-10);
         source_parts[0]:='file://'+chr(96+i)+':';
         break;
       end;
       for i:=1 to 26 do
       if lowercase(copy(source_copy,1,10))='file:///'+chr(96+i)+':' then
       begin
         source_copy:=copy(source_copy,12,length(source_copy)-11);
         source_parts[0]:='file:///'+chr(96+i)+':';
         break;
       end;
       for i:=1 to 26 do
       if lowercase(copy(source_copy,1,15))='mhtml:file://'+chr(96+i)+':' then
       begin
         source_copy:=copy(source_copy,17,length(source_copy)-16);
         source_parts[0]:='mhtml:file://'+chr(96+i)+':';
         break;
       end;
       for i:=1 to 26 do
       if lowercase(copy(source_copy,1,19))='file://localhost/'+chr(96+i)+':' then
       begin
         source_copy:=copy(source_copy,21,length(source_copy)-20);
         source_parts[0]:='file://localhost/'+chr(96+i)+':';
         break;
       end;
     end;

     //find target protocol if any
     if lowercase(copy(target_copy,1,7))='http://' then
     begin
       target_copy:=copy(target_copy,8,length(target_copy)-7);
       source_parts[0]:='http://';
     end
     else if lowercase(copy(target_copy,1,6))='ftp://' then
     begin
       target_copy:=copy(target_copy,7,length(target_copy)-6);
       source_parts[0]:='ftp://'
     end
     else
     begin
       for i:=1 to 26 do
       if lowercase(copy(target_copy,1,9))='file://'+chr(96+i)+':' then
       begin
         target_copy:=copy(target_copy,11,length(target_copy)-10);
         source_parts[0]:='file://'+chr(96+i)+':';
         break;
       end;
       for i:=1 to 26 do
       if lowercase(copy(target_copy,1,10))='file:///'+chr(96+i)+':' then
       begin
         target_copy:=copy(target_copy,12,length(target_copy)-11);
         source_parts[0]:='file:///'+chr(96+i)+':';
         break;
       end;
       for i:=1 to 26 do
       if lowercase(copy(target_copy,1,15))='mhtml:file://'+chr(96+i)+':' then
       begin
         target_copy:=copy(target_copy,17,length(target_copy)-16);
         source_parts[0]:='mhtml:file://'+chr(96+i)+':';
         break;
       end;
       for i:=1 to 26 do
       if lowercase(copy(target_copy,1,17))='file://localhost/' then
       begin
         target_copy:=copy(target_copy,19,length(target_copy)-18);
         target_parts[0]:='file://localhost';
         break;
       end;
     end;
     //disasemble source URL
     source_parts_no:=0;
     slash:=pos('/',source_copy);
     backslash:=pos('\',source_copy);
     while slash+backslash>0 do
     begin
       if ((slash<backslash) and (slash>0)) or (backslash=0) then
       begin
          source_parts.Add(copy(source_copy,1,slash-1));
          source_copy:=copy(source_copy,slash+1,length(source_copy)-slash);
          source_parts_no:=source_parts_no+1;
       end
       else
       begin
          source_parts.Add(copy(source_copy,1,backslash-1));
          source_copy:=copy(source_copy,backslash+1,length(source_copy)-backslash);
          source_parts_no:=source_parts_no+1;
       end;
       slash:=pos('/',source_copy);
       backslash:=pos('\',source_copy);
     end;
     source_parts.Add(source_copy);
     source_parts_no:=source_parts_no+1;
     //disasemble target URL
     target_parts_no:=0;
     slash:=pos('/',target_copy);
     backslash:=pos('\',target_copy);
     while slash+backslash>0 do
     begin
       if ((slash<backslash) and (slash>0)) or (backslash=0) then
       begin
          target_parts.Add(copy(target_copy,1,slash-1));
          target_copy:=copy(target_copy,slash+1,length(target_copy)-slash);
          target_parts_no:=target_parts_no+1;
       end
       else
       begin
          target_parts.Add(copy(target_copy,1,backslash-1));
          target_copy:=copy(target_copy,backslash+1,length(target_copy)-backslash);
          target_parts_no:=target_parts_no+1;
       end;
       slash:=pos('/',target_copy);
       backslash:=pos('\',target_copy);
     end;
     target_parts.Add(target_copy);
     target_parts_no:=target_parts_no+1;


     if source_parts_no<target_parts_no then j:=source_parts_no
     else j:=target_parts_no;
     //find common parts (directories) in two URLs
     common_parts_no:=j;
     for i:=1 to j do
       if lowercase(source_parts[i])<>lowercase(target_parts[i]) then
       begin
         common_parts_no:=i-1;
         break;
       end;
     //make relative addresses for target URL
     //looked from source URL
     s:='';
     for i:=1 to source_parts_no-1-common_parts_no do
       s:=s+'../';
     for i:=common_parts_no+1 to target_parts_no do
     begin
       s:=s+target_parts[i];
       if i<target_parts_no then s:=s+'/';
     end;
     RepsoAdd(s,targetfilename,mainfile);
     if AddressCorrecting>=2 then
     begin
       s:='/'+s;
       RepsoAdd(s,targetfilename,mainfile);
     end;
     if AddressCorrecting>=4 then
       RepsoAdd('.'+s,targetfilename,mainfile);
       
     //delete all unneeded parts of addrsses (dir1/dir2/../dir3 -> dir1/dir3)
     if AddressCorrecting>=3 then
       for i:=2 to target_parts_no-1 do
         DeloAdd(target_parts[i]+'/../',mainfile);
       
     //make all other possible relative addresses
     if mainfile and (AddressCorrecting>=4) then
     begin
       s:='';
       for i:=target_parts_no downto 2 do
       begin
         s:=target_parts[i]+s;
         RepsoAdd(s,targetfilename,mainfile);
         s:='/'+s;
         RepsoAdd(s,targetfilename,mainfile);
       end;
     end;
// DEBUG MODE START
     if debugmode and not(mainfile) then
     begin
       Writeln(debugfile,'------------------------------------------------------------------------');
       Writeln(debugfile,'REPLACE for FILE: '+source);
       Writeln(debugfile,'------------------------------------------------------------------------');
       for i:=1 to repso1.Count-1 do
       begin
         Writeln(debugfile,'ORIG: '+repso1[i]);
         Writeln(debugfile,'NEW : '+repsn1[i]);
         Writeln(debugfile,'---------');
       end;
       for i:=1 to delo1.Count-1 do
       begin
         Writeln(debugfile,'DEL : '+delo1[i]);
       end;
     end;
// DEBUG MODE END
     source_parts.Free;
     target_parts.Free;
   end;

  //**********inner procedure***********************
   Procedure PrepRep2(part:integer;mainfile:boolean);
   var i:integer;
   begin
     repso1.Clear; repso1.Add('');
     repsn1.Clear; repsn1.Add('');
     delo1.Clear;  delo1.Add('');

     for i:=1 to parts do
       if (i<>part) and ((part_orig_path_full[part]<>'') and (part_orig_path_full[i]<>'')) then
         PrepRep(part_orig_path_full[part],part_orig_path_full[i],part_local_name[i],mainfile);
   end;
  
  //**********inner procedure***********************
   Procedure PrepareReplace;
   var bri:longint;

      //*inner inner procedure*
      procedure Prov1;         //check if already in list and add new if not
      begin
         if repso[repso.Count-1]<>'' then
            if repso.IndexOf(repso[repso.Count-1])<repso.Count-1 then
            begin
               repso[repso.Count-1]:='';
               repsn[repso.Count-1]:='';
            end
            else
            begin
               repso.Add('');
               repsn.Add('');
            end;
      end;
      //*inner inner procedure*
      procedure Prov2;           //check if already in list and add as new if not
      begin
         if delo[delo.Count-1]<>'' then
            if delo.IndexOf(delo[delo.Count-1])<delo.Count-1 then
               delo[delo.Count-1]:=''
            else
               delo.Add('');
      end;

   begin
      {repso.Clear;
      repsn.Clear;
      delo.Clear;}
      

     for bri:=1 to parts do
       if part_local_name[bri]<>'' then
       begin
         //adding absolute addresses
         if (part_orig_path_full[bri]<>'') then
         begin
           part_orig_path_full[bri]:=trim(part_orig_path_full[bri]);
           repso.add(part_orig_path_full[bri]);
           repsn.add(part_local_name[bri]);

           //adding absolute addresses without http:// and ftp://      ...//file://???
           if copy(part_orig_path_full[bri],1,7)='http://' then
           begin
             repso.add(copy(part_orig_path_full[bri],8,length(part_orig_path_full[bri])-7));
             repsn.add(part_local_name[bri]);
           end
           else if copy(part_orig_path_full[bri],1,6)='ftp://' then
           begin
             repso.add(copy(part_orig_path_full[bri],7,length(part_orig_path_full[bri])-6));
             repsn.add(part_local_name[bri]);
           end;
         end;
         //adding Content-ID (or CID)
         if part_content_id[bri]<>'' then
         begin
           repso.add('cid:'+part_content_id[bri]);
           repsn.add(part_local_name[bri]);
           repso.add('CID:'+part_content_id[bri]);
           repsn.add(part_local_name[bri]);
         end;
       end;
     if firstpart>0 then PrepRep2(firstpart,true); //will add all relative addresses
                                                   //looking from main html file
                                                   //and parial addresses for all files

// DEBUG MODE START
     if debugmode then
     begin
       Writeln(debugfile,'------------------------------------------------------------------------');
       Writeln(debugfile,'REPLACE MAIN FILE');
       Writeln(debugfile,'------------------------------------------------------------------------');
       for bri:=1 to repso.Count-1 do
       begin
         Writeln(debugfile,'ORIG: '+repso[bri]);
         Writeln(debugfile,'NEW : '+repsn[bri]);
         Writeln(debugfile,'---------');
       end;
       for bri:=1 to delo.Count-1 do
       begin
         Writeln(debugfile,'DEL : '+repso[bri]);
       end;
     end;
// DEBUG MODE END

      //FOR TESTING ONLY Make Memo1 and Memo2 in Form1
      //Form1.Memo1.lines.AddStrings(repso);
      //Form1.Memo2.lines.AddStrings(repsn);
      //FOR TESTING ONLY }
   end;

Function ReplaceURL(s:string):string;   //Replace original addresses with local ones
var i:integer;
    deenesc_s,enesc_s:string;
   function Replace(s,s1,s2,starting,ending:string):string;
   //s1=repso,s2=repsn
   var i1,startlength{,endlength}:integer;
   begin
     if ((s1<>s2) and (pos(s1,s2)=0)) and (s1<>'') then
     begin
       startlength:=length(starting);
       //endlength:=length(ending);
       i1:=Pos(starting+LowerCase(s1)+ending,LowerCase(s));
       while i1<>0 do
       begin
//         s:=copy(s,1,i1+startlength)+s2+copy(s,i1+startlength+length(s1)+endlength+1,length(s)-startlength-length(s1)-endlength);
         Delete(s,i1+startlength,length(s1));
         Insert(s2,s,i1+startlength);
         i1:=Pos(starting+LowerCase(s1)+ending,LowerCase(s));
// DEBUG MODE START
     if debugmode then
     begin
       Writeln(debugfile,'<<<<<<<<<<<<<<<<<<<<');
       Writeln(debugfile,'Replaced string: ['+starting+']'+LowerCase(s1)+'['+ending+']');
       Writeln(debugfile,'With string: ['+starting+']'+LowerCase(s2)+'['+ending+']');
       Writeln(debugfile,'<<<<<<<<<<<<<<<<<<<<');
     end;
// DEBUG MODE END
       end;
     end;
     Replace:=s;
   end;
   function Dellete(s,s1:string):string;
   //s1=delo
   var i1{,startlength}:integer;
   begin
     i1:=Pos(LowerCase(s1),LowerCase(s));
     while i1<>0 do
     begin
       Delete(s,i1,length(s1));
       i1:=Pos(LowerCase(s1),LowerCase(s));
// DEBUG MODE START
     if debugmode then
     begin
       Writeln(debugfile,'^^^^^^^^^^^^^^^^^^^^');
       Writeln(debugfile,'Deleted string: '+LowerCase(s1));
       Writeln(debugfile,'^^^^^^^^^^^^^^^^^^^^');
     end;
// DEBUG MODE END
     end;
     Dellete:=s;
   end;
   function DeleteBaseURL(s:string):string;   //remove "<base href=" ..."/>"
   var st,en:integer;
   begin
     st:=pos('<base href',lowercase(s));
     if st>0 then
     begin
       en:=pos('/>',lowercase(copy(s,st+10,length(s)-st-9)));
       if en>0 then
         Delete(s,st,en+11);
     end;
     DeleteBaseURL:=s;
   end;
   
begin
  if AddressCorrecting>=4 then
  begin
    DeleteBaseURL(s);
    for i:=1 to delo.Count-1 do
      if delo[i]<>'' then
        s:=Dellete(s,delo[i]);
    for i:=1 to delo1.Count-1 do
      if delo1[i]<>'' then
        s:=Dellete(s,delo1[i]);
  end;
 if AddressCorrecting>=1 then
 begin
   for i:=1 to repso.Count-1 do
     if ((repso[i]<>repsn[i]) and (repso[i]<>'')) and (pos(repso[i],repsn[i])=0) then //avoid dead loop
     begin
       s:=Replace(s,repso[i],repsn[i],'"','"');
       s:=Replace(s,repso[i],repsn[i],'''','''');
       s:=Replace(s,repso[i],repsn[i],'"','#');
       s:=Replace(s,repso[i],repsn[i],'(',')');
    //
       deenesc_s:=DeEnEsc(repso[i]);
       enesc_s:=EnEsc(repso[i]);
       if AddressCorrecting>=2 then
       begin
         s:=Replace(s,repso[i],repsn[i],'''','#');
         if ((deenesc_s<>repso[i]) and (deenesc_s<>'')) and (pos(deenesc_s,repsn[i])=0) then
         begin
           s:=Replace(s,deenesc_s,repsn[i],'"','"');
           s:=Replace(s,deenesc_s,repsn[i],'"','#');
         end;
         if ((enesc_s<>repso[i]) and (enesc_s<>'')) and (pos(enesc_s,repsn[i])=0) then
         begin
           s:=Replace(s,enesc_s,repsn[i],'"','"');
           s:=Replace(s,enesc_s,repsn[i],'"','#');
         end;
    //
         if AddressCorrecting>=3 then
         begin
           s:=Replace(s,repso[i],repsn[i],'=','');
           s:=Replace(s,repso[i],repsn[i],'= ','');
           if ((deenesc_s<>repso[i]) and (deenesc_s<>'')) and (pos(deenesc_s,repsn[i])=0) then
           begin
             s:=Replace(s,deenesc_s,repsn[i],'''','''');
             s:=Replace(s,deenesc_s,repsn[i],'(',')');
             s:=Replace(s,deenesc_s,repsn[i],'''','#');
           end;
           if ((enesc_s<>repso[i]) and (enesc_s<>'')) and (pos(enesc_s,repsn[i])=0) then
           begin
             s:=Replace(s,enesc_s,repsn[i],'''','''');
             s:=Replace(s,enesc_s,repsn[i],'(',')');
             s:=Replace(s,enesc_s,repsn[i],'''','#');
           end;
    //
           if AddressCorrecting>=4 then
           begin
             s:=Replace(s,repso[i],repsn[i],'=  ','');
             s:=Replace(s,repso[i],repsn[i],'( ',' )');
             if ((deenesc_s<>repso[i]) and (deenesc_s<>'')) and (pos(deenesc_s,repsn[i])=0) then
             begin
               s:=Replace(s,deenesc_s,repsn[i],'=','');
               s:=Replace(s,deenesc_s,repsn[i],'= ','');
               s:=Replace(s,deenesc_s,repsn[i],'=  ','');
               s:=Replace(s,deenesc_s,repsn[i],'( ',' )');
             end;
             if ((enesc_s<>repso[i]) and (enesc_s<>'')) and (pos(enesc_s,repsn[i])=0) then
             begin
               s:=Replace(s,enesc_s,repsn[i],'=','');
               s:=Replace(s,enesc_s,repsn[i],'= ','');
               s:=Replace(s,enesc_s,repsn[i],'=  ','');
               s:=Replace(s,enesc_s,repsn[i],'( ',' )');
             end;
           end;
         end;
       end;
     end;
   for i:=1 to repso1.Count-1 do
     if ((repso1[i]<>repsn1[i]) and (repso1[i]<>'')) and (pos(repso1[i],repsn1[i])=0) then //avoid dead loop
     begin
       s:=Replace(s,repso1[i],repsn1[i],'"','"');
       s:=Replace(s,repso1[i],repsn1[i],'''','''');
       s:=Replace(s,repso1[i],repsn1[i],'"','#');
       s:=Replace(s,repso1[i],repsn1[i],'(',')');
  //
       deenesc_s:=DeEnEsc(repso1[i]);
       enesc_s:=EnEsc(repso1[i]);
       if AddressCorrecting>=2 then
       begin
         s:=Replace(s,repso1[i],repsn1[i],'''','#');
         if ((deenesc_s<>repso1[i]) and (deenesc_s<>'')) and (pos(deenesc_s,repsn1[i])=0) then
         begin
           s:=Replace(s,deenesc_s,repsn1[i],'"','"');
           s:=Replace(s,deenesc_s,repsn1[i],'"','#');
         end;
         if ((enesc_s<>repso1[i]) and (enesc_s<>'')) and (pos(enesc_s,repsn1[i])=0) then
         begin
           s:=Replace(s,enesc_s,repsn1[i],'"','"');
           s:=Replace(s,enesc_s,repsn1[i],'"','#');
         end;
  //
         if AddressCorrecting>=3 then
         begin
           s:=Replace(s,repso1[i],repsn1[i],'=','');
           s:=Replace(s,repso1[i],repsn1[i],'= ','');
           if ((deenesc_s<>repso[i]) and (deenesc_s<>'')) and (pos(deenesc_s,repsn[i])=0) then
           begin
             s:=Replace(s,deenesc_s,repsn1[i],'''','''');
             s:=Replace(s,deenesc_s,repsn1[i],'(',')');
             s:=Replace(s,deenesc_s,repsn1[i],'''','#');
           end;
           if ((enesc_s<>repso1[i]) and (enesc_s<>'')) and (pos(enesc_s,repsn1[i])=0) then
           begin
             s:=Replace(s,enesc_s,repsn1[i],'''','''');
             s:=Replace(s,enesc_s,repsn1[i],'(',')');
             s:=Replace(s,enesc_s,repsn1[i],'''','#');
           end;
  //
           if AddressCorrecting>=4 then
           begin
             s:=Replace(s,repso1[i],repsn1[i],'=  ','');
             s:=Replace(s,repso1[i],repsn1[i],'( ',' )');
             if ((deenesc_s<>repso[i]) and (deenesc_s<>'')) and (pos(deenesc_s,repsn[i])=0) then
             begin
               s:=Replace(s,deenesc_s,repsn1[i],'=','');
               s:=Replace(s,deenesc_s,repsn1[i],'= ','');
               s:=Replace(s,deenesc_s,repsn1[i],'=  ','');
               s:=Replace(s,deenesc_s,repsn1[i],'( ',' )');
             end;
             if ((enesc_s<>repso1[i]) and (enesc_s<>'')) and (pos(enesc_s,repsn1[i])=0) then
             begin
               s:=Replace(s,enesc_s,repsn1[i],'=','');
               s:=Replace(s,enesc_s,repsn1[i],'= ','');
               s:=Replace(s,enesc_s,repsn1[i],'=  ','');
               s:=Replace(s,enesc_s,repsn1[i],'( ',' )');
             end;
           end;
           
//           s:=Replace(s,repso1[i],repsn1[i],'"','&'); //unsure
         end;
       end;
     end;
  end;
  ReplaceURL:=s;
end;


   //**********inner procedure***********************
   procedure B64ToStandard(part_no:integer); //handle base64 files
   var f:file of byte;
      tempf1,tempf2:textfile;
      s,s1,s2,tempname:string;
      i,zerocounter,fsize:integer;
      b:byte;
      b64decoder:TBase64DecodingStream;
      ss:TStringStream;
      ms:TMemoryStream;
   begin

     while line_counter<StrtoInt(part_start_line[part_no]) do
     begin
       readln(source,s2);
       line_counter:=line_counter+1;
     end;

     s1:='';
     while line_counter<=StrtoInt(part_end_line[part_no]) do
     begin
       s1:=s1+s2;
       readln(source,s2);
       line_counter:=line_counter+1;
       if (s2='') and not(eof(source)) then
       begin
         readln(source,s2);
         line_counter:=line_counter+1;
       end;

     end;
     {$IFNDEF CL}
      Form1.Shape3.Brush.Color:=clLime;
      Application.ProcessMessages;
     {$ENDIF}

      zerocounter:=0; //counts 00 bytes if lot of them then in text file then unicode

      ss := TStringStream.Create(s1);
      ms:=TMemoryStream.Create;
      b64decoder := TBase64DecodingStream.Create(ss);
      try
        ms.CopyFrom(b64decoder,b64decoder.Size);
        ms.SaveToFile(OutpDir+DirectorySeparator+part_local_name[part_no]);
        fsize:=ms.size;
        ms.Position:=0;
        for i:=1 to fsize do
            if ms.ReadByte=0 then zerocounter:=zerocounter+1;
      except
        AssignFile(f,OutpDir+DirectorySeparator+part_local_name[part_no]);
        Rewrite(f);
        while length(s1)>3 do
        begin
           s:=copy(s1,1,4);
           Delete(s1,1,4);
           if s[3]+s[4]='==' then
           begin
              i:=Str2Byte(s[1])*64+Str2Byte(s[2]);
              b:=i div 16;
              write(f,b);
              if b=0 then zerocounter:=zerocounter+1;
           end
           else
           if s[4]='=' then
           begin
              i:=(Str2Byte(s[1])*64+Str2Byte(s[2]))*64+Str2Byte(s[3]);
              b:=i div 1024;
              write(f,b);
              if b=0 then zerocounter:=zerocounter+1;
              b:=(i mod 1024) div 4;
              write(f,b);
              if b=0 then zerocounter:=zerocounter+1;
           end
           else
           begin
              i:=((Str2Byte(s[1])*64+Str2Byte(s[2]))*64+Str2Byte(s[3]))*64+Str2Byte(s[4]);
              b:=i div 65536;
              write(f,b);
              if b=0 then zerocounter:=zerocounter+1;
              i:=i mod 65536;
             b:=i div 256;
             write(f,b);
             if b=0 then zerocounter:=zerocounter+1;
             b:=i mod 256;
             write(f,b);
             if b=0 then zerocounter:=zerocounter+1;
           end
        end;
        fsize:=FileSize(f);
        closeFile(f);
      end;
      ms.Free;
      ss.Free;
      b64decoder.Free;

     {$IFNDEF CL}
      Form1.Shape3.Brush.Color:=clRed;
      Application.ProcessMessages;
     {$ENDIF}
      //next part is for correcting addresses in B64 encoded "text" files
      if (((part_content_type[part_no]='text/html') or (part_content_type[part_no]='text/.htm'))
        or ((part_content_type[part_no]='text/css') or (part_content_type[part_no]='text.css')))
        or (((part_content_type[part_no]='application/x-javascript') or (part_content_type[part_no]='text/javascript'))
        or (((pos('htm', part_type[part_no])>0) or (part_type[part_no]='.css')) or (part_type[part_no]='.js'))) then
      begin
        if zerocounter>0 then
          if (fsize*100) div zerocounter >10 then exit; //unicode. don't touch this files!
        {$IFNDEF CL}
        Form1.Shape1.Brush.Color:=clLime;
        Application.ProcessMessages;
        {$ENDIF}
        randomize;
        tempname:='temp'+IntToStr(Round(random(999)))+'.tmp';
        AssignFile(tempf1,OutpDir+DirectorySeparator+part_local_name[part_no]);
        Reset(tempf1);
        AssignFile(tempf2,OutpDir+DirectorySeparator+tempname);
        Rewrite(tempf2);
        if part_no<>firstpart then PrepRep2(part_no,false);
        while not(eof(tempf1)) do
        begin
          readln(tempf1,s);
          writeln(tempf2,ReplaceURL(s));
        end;
        closeFile(tempf1);
        closeFile(tempf2);
        DeleteFile(OutpDir+DirectorySeparator+part_local_name[part_no]);
        RenameFile(OutpDir+DirectorySeparator+tempname, OutpDir+DirectorySeparator+part_local_name[part_no]);
        {$IFNDEF CL}
        Form1.Shape1.Brush.Color:=clRed;
        Application.ProcessMessages;
        {$ENDIF}
      end;

   end;

procedure HTML(part_no:integer);  //handle all quoted-printable files (8bit,7bit)
var f:textfile;
    s,s1:string;
    i,i1,i2,j:integer;
    b:boolean;
begin
 {$IFNDEF CL}
   Form1.Shape1.Brush.Color:=clLime;
   Application.ProcessMessages;
 {$ENDIF}
   AssignFile(f,OutpDir+DirectorySeparator+part_local_name[part_no]);
   Rewrite(f);
   if part_no<>firstpart then PrepRep2(part_no,false);
   while line_counter<StrtoInt(part_start_line[part_no]) do
   begin
     readln(source,s1);
     line_counter:=line_counter+1;
   end;

   if copy(s1,1,2)=unicode_file_header then Delete(s1,1,2)  //remove start fo uicode file Windows is adding ÿþ
   else if copy(s1,1,3)=utf8_file_header then Delete(s1,1,3)  //remove mess Windows is making with Unicode files ï»¿
   else if copy(s1,1,9)='=EF=BB=BF' then Delete(s1,1,9);     //delete ﻿ from start of windows utf-8 text file

   while line_counter<=StrtoInt(part_end_line[part_no]) do
   begin
     s:=s1;
     while copy(s,length(s),1)='=' do
     begin
        readln(source,s1);
        line_counter:=line_counter+1;
        if copy(s1,1,2)=unicode_file_header then Delete(s1,1,2)
        else if copy(s1,1,3)=utf8_file_header then Delete(s1,1,3)
        else if copy(s1,1,9)='=EF=BB=BF' then Delete(s1,1,9);
{        if Pos(boundary,s1)<>0 then s1:='';}
        s:=copy(s,1,length(s)-1)+s1;
     end;
     i:=pos('=',s);
     while (i<length(s)-1) and (pos('=',s)<>0) do
     begin
        b:=true;
        i1:=126;
        while (i1<256) and b do
        begin
           if (copy(s,i,3)='='+inttohex(i1,2)) and b then
           begin
               Delete(s,i,3);
               Insert(Chr(i1),s,i);
               b:=false;
           end;
           i1:=i1+1;
        end;
        i1:=11;
        while (i1<32) and b do
        begin
           if (copy(s,i,3)='='+inttohex(i1,2)) and b then
           begin
               Delete(s,i,3);
               Insert(Chr(i1),s,i);
               b:=false;
           end;
           i1:=i1+1;
        end;
        i1:=0;
        while (i1<10) and b do
        begin
           if (copy(s,i,3)='='+inttohex(i1,2)) and b then
           begin
               Delete(s,i,3);
               Insert(Chr(i1),s,i);
               b:=false;
           end;
           i1:=i1+1;
        end;
        if (copy(s,i,3)='=24') and b then
        begin
            Delete(s,i,3);
            Insert(Chr(36),s,i);
            b:=false;
        end;
        if (copy(s,i,3)='=5C') and b then
        begin
            Delete(s,i,3);
            Insert(Chr(92),s,i);
            b:=false;
        end;
        if (copy(s,i,3)='=20') and b then
        begin
            Delete(s,i,3);
            Insert(' ',s,i);
            b:=false;
        end;
        if (copy(s,i,3)='=5E') and b then
        begin
            Delete(s,i,3);
            Insert(Chr(94),s,i);
            b:=false;
        end;
        if (copy(s,i,3)='=60') and b then
        begin
            Delete(s,i,3);
            Insert(Chr(96),s,i);
            b:=false;
        end;
        if (copy(s,i,3)='=3D') and b then
        begin
            Delete(s,i,3);
            Insert('=',s,i);
            b:=false;
        end;
        if (copy(s,i,3)='=0A') and b then
        begin
          writeln(f,ReplaceURL(copy(s,1,i-1){repso,repsn,delo}));
          Delete(s,1,i+2);
          {if s='=0A' then s:='';}
          {s:=Copy(s,i+4,length(s)-i-3);}
          i:=0;
          b:=false;
        end;

        i:=i+1;
     end;
     // delete tags
     for j:=1 to deletetagcount do
     begin
       i1:=pos(deletetag[j,1],lowercase(s));
       if i1>0 then
       begin
         i2:=pos(deletetag[j,2],lowercase(copy(s,i1+1,length(s)-i1)));
         if i2>0 then Delete(s,i1,i2+length(deletetag[j,2]));
       end;
     end;
     // delete tags end
     
     if s<>'=0A' then
       writeln(f,ReplaceURL(s));
     readln(source,s1);
     line_counter:=line_counter+1;
     if copy(s1,1,2)=unicode_file_header then Delete(s1,1,2)
     else if copy(s1,1,3)=utf8_file_header then Delete(s1,1,3)
     else if copy(s1,1,9)='=EF=BB=BF' then Delete(s1,1,9);
   end;
   closeFile(f);
   {$IFNDEF CL}
   Form1.Shape1.Brush.Color:=clRed;
   Application.ProcessMessages;
   {$ENDIF}
end;

//***********
begin
    mht_from:='';
    mht_subject:='';
    mht_date:='';
    mht_importance:='';
    mht_priority:='';
    mht_content_type:='';
    mht_mime_version:='';
    mht_type:='';
    mht_start_file:='';
    mht_content_location:='';
    mht_content_transfer_encoding:='';
    mht_charset:='';
    mht_product:='';
    mht_x_maf:='';
    mht_x_mime:='';
    mht_thread_index:='';
    mht_content_class:='';
    //mht_first_boundry:='';
    //mht_last_boundry:='';
    mht_other_mht_creator:='';
    parts:=0;
    alternatives:=0;
    
    //next variables for header data for each file from mht file
    part_content_type := TStringList.Create;
    part_charset := TStringList.Create;
    part_content_transfer_encoding := TStringList.Create;
    part_content_location := TStringList.Create;
    part_content_id := TStringList.Create;
    part_content_disposition := TStringList.Create;
    part_filename := TStringList.Create;
    part_name := TStringList.Create;
    part_start_line := TStringList.Create;
    part_end_line := TStringList.Create;
    alternative:= TStringList.Create;
    
    part_orig_path_full:= TStringList.Create;
    part_orig_path_relative:= TStringList.Create;
    part_local_name:= TStringList.Create;
    part_unchanged_file_name:= TStringList.Create;
    part_encoding:= TStringList.Create;
    part_recognized:= TStringList.Create;
    part_type:= TStringList.Create;

    AddPartHeader; //add part[0], 0 will not be used

    boundary := TStringList.Create;
    boundary.Clear; boundary.Add('');
    boundarycount:=0;

    repso := TStringList.Create;
    repso.CaseSensitive:=false;
    repsn := TStringList.Create;
    delo := TStringList.Create;
    repso1 := TStringList.Create;
    repso1.CaseSensitive:=false;
    repsn1 := TStringList.Create;
    delo1 := TStringList.Create;
    nizOrig := TStringList.Create;
    nizNew := TStringList.Create;
    nizNewName := TStringList.Create;
    nizType := TStringList.Create;
    nizCode := TStringList.Create;
    
    
    repso.Clear; repso.Add('');
    repsn.Clear; repsn.Add('');
    delo.Clear;  delo.Add('');
    repso1.Clear; repso1.Add('');
    repsn1.Clear; repsn1.Add('');
    delo1.Clear;  delo1.Add('');
    nizOrig.Clear; nizOrig.Add('');
    nizNew.Clear;  nizNew.Add('');
    nizNewName.Clear; nizNewName.Add('');
    nizType.Clear; nizType.Add('');
    nizCode.Clear; nizCode.Add('');

    GoodMHT:=true;
    temptime:=Now;

   AssignFile(f,SourDir+DirectorySeparator+MhtFile);
   //ToDo: remove reset and close ? or use fileutils
    reset(f);
    mht_file_size:=FileSize(f);
    CloseFile(f);

   AssignFile(info,OutpDir+DirectorySeparator+'_1_info.nfo');
   Rewrite(info);
   Writeln(info,language_strings[language_nr,46]+' mht2htm - '+language_strings[language_nr,50]);
   Writeln(info,'---------------------------------------------');
   Writeln(info,language_strings[language_nr,51]+' [-] '+language_strings[language_nr,52]+' [-] '+language_strings[language_nr,53]+' [-] '+language_strings[language_nr,54]);
   Writeln(info,'');
// DEBUG MODE START
   if debugmode then
   begin
     AssignFile(debugfile,OutpDir+DirectorySeparator+'_2_debug.nfo');
     Rewrite(debugfile);
   end;
// DEBUG MODEEND
    AssignFile(source,SourDir+DirectorySeparator+MhtFile);
   Reset(source);
   header:=true;
   part_header:=false;
   line_counter:=0;
   //1st pass: multiline joining; parts's header start-end line; parts's start-end
   //          also Extract header values

   while not(eof(source)) do
   begin
      Readln(source,s);
      line_counter:=line_counter+1;
      if header and (trim(s)='') then
      begin
        header:=false;
        parts:=1;
        AddPartHeader;
        mht_start_line:=IntToStr(line_counter);
      end
      else if pos('this is a multi-part message in mime format.',lowercase(s))=1 then
      begin
        Readln(source,s);
        line_counter:=line_counter+1;
      end
      else if pos('this document is a web archive file.',lowercase(s))=1 then
      begin
        Readln(source,s);
        line_counter:=line_counter+1;
        mht_other_mht_creator:='MS Word'
      end;

      //multiline joining
      if ((pos('=?',s)<>0) and (pos('?=',s)<>0)) and (pos('?q?',lowercase(s))<>0) then //ima i ono drugo umesto ?Q?
      begin
         if not(eof(source)) then
         begin
            Readln(source,s1);
            line_counter:=line_counter+1;
         end
         else s1:='';
         while ((pos('=?',s1)<>0) and (pos('?=',s1)<>0)) and (pos('?q?',lowercase(s1))<>0) do
         begin
            s:=s+s1;
            if not(eof(source)) then
            begin
               Readln(source,s1);
               line_counter:=line_counter+1;
            end
            else s1:='';
         end;
            if header then
            begin
               {header:=}ExtractHeader(s);
               if not(header) then
               begin
                  parts:=1;
                  AddPartHeader;
                  mht_start_line:=IntToStr(line_counter); //needed for one part mht files
               end;
            end
            else if ExtractHeader(s) and not(part_header) then  //new part header found
            begin
               part_header:=true;
               ExtractHeader(s);
            end
            else if not(ExtractHeader(s)) and part_header then //part header ends
            begin
               part_header:=false;
//               //check if not header for nested files, if yes delete
//               if part_content_type[Parts]='multipart/alternative' then ClearPartHeader
//               else
//               begin
                  parts:=parts+1;
                  AddPartHeader;
                  part_start_line[Parts-1] := IntToStr(line_counter); ////
//               end
            end
            else if ExtractHeader(s) then ; //in case if condition is parialy checked (optimization)
         s:=s1;
      end;
      //multiline joining end
      if header then
      begin
         {header:=}ExtractHeader(s);
         if not(header) then
         begin
            parts:=1;
            AddPartHeader;
            mht_start_line:=IntToStr(line_counter); //needed for one part mht files
         end;
      end
      else if part_header then
      begin
         if not(ExtractHeader(s)) then  //part header ends
         begin
            part_header:=false;
//            //check if not header for nested files, if yes delete
//            if pos('multipart/alternative',lowercase(part_content_type[Parts-1]))=1 then ClearPartHeader
//            else
//            begin
               parts:=parts+1;
               AddPartHeader;
               part_start_line[Parts-1] := IntToStr(line_counter);
//            end
         end
      end
      else if not(part_header) then
      begin
         if ExtractHeader(s) then  //new part header found
         begin
            part_header:=true;
            if part_end_line[Parts-1]='' then part_end_line[Parts-1] := IntToStr(line_counter-1);
            //ExtractHeader(s);
         end
      end;
      if Parts>0 then
      begin
         if (part_end_line[Parts-1]='') and (isboundary(s)>0) then part_end_line[Parts-1] := IntToStr(line_counter-1)
         else if (part_end_line[Parts-1]='') and eof(source) then part_end_line[Parts-1] := IntToStr(line_counter-1);
      end;
   end;
   parts:=parts-1;
   lines:=line_counter;
   if parts<0 then
   begin
     GoodMHT:=false;
     {$IFNDEF CL}
     //application.MessageBox(PChar(language_strings[language_nr,152]+chr(13)+'Sorry.Maybe in next version.'), 'Error', 0);
     {$ELSE}
     //writeln(language_strings[language_nr,152]+chr(13)+'Sorry.Maybe in next version.');
     {$ENDIF}
     exit;
   end;
   //1st pass end

   //between pass 1 and 2 start
   //if parts=0 assume that mht is one part mht
   //asign data from mht header as part[1] header
   if parts=0 then
   begin
     parts:=1;
     part_content_type[1]:=mht_content_type;
     part_content_location[1]:=mht_content_location;
     part_content_transfer_encoding[1]:=mht_content_transfer_encoding;
     part_charset[1]:=mht_charset;
     part_start_line[1]:=mht_start_line;
     part_end_line[1]:=IntToStr(lines);
   end;
   //between pass 1 and 2 end

   //2nd pass start: try to recognize parts type by content, alternative, encoding,
   //                try to recognize parts type by transfer-type
   for i:=1 to parts do
   begin
      //
      //read file header and try to find real file type
      recog:='';
      line_counter:=0;
      reset(source);//reset(f);
      if part_start_line[i]<>'' then
        while line_counter<StrtoInt(part_start_line[i]) do
        begin
          readln(source,s);
          line_counter:=line_counter+1;
        end;
      if pos('multipart/alternative',lowercase(part_content_type[i]))=0 then
        while (((trim(s)='') or (trim(s)='=0A='))
           or (copy(trim(lowercase(s)),1,10)='x-mimeole:')) and not(Eof(source)) do
        begin
          readln(source,s);
          line_counter:=line_counter+1;
          part_start_line[i]:=IntToStr(StrToInt(part_start_line[i])+1); //find first non empty line
        end;

      for j:=1 to recognizedcount1 do
        if ((recog='') and ((recognized1[j,4]='') or ((recognized1[j,4]='1') or (pos('1-',recognized1[j,4])=1)))) then
        begin
           {application.MessageBox(PChar('i:='+inttostr(i)+chr(13)+'j:='+inttostr(j)+chr(13)+s+chr(13)
             +'part_content_location='+part_content_location[i]+chr(13)
             +'part_name='+part_name[i]+chr(13)+'part_filename='+part_filename[i]+chr(13))
             , 'Look', 1);}
           if (recognized1[j,5]='l') then
           begin
             if recognized1[j,3]='1' then
             begin
               if (pos(recognized1[j,1],lowercase(trim(s)))=1)
               or ((pos(utf8_file_header+recognized1[j,1],lowercase(trim(s)))=1)
               or  (pos('=ef=bb=bf'+recognized1[j,1],lowercase(trim(s)))=1)) then
               begin
                 recog:=recognized1[j,2];
                 break;
               end
             end
             else if recognized1[j,3]='' then
             begin
              if (pos(recognized1[j,1],lowercase(trim(s)))>0) then
               begin
                 recog:=recognized1[j,2];
                 break;
               end
             
             end
             else
             begin
               if pos(recognized1[j,1], lowercase(trim(s)))=strtoint(recognized1[j,3]) then
               begin
                 recog:=recognized1[j,2];
                 break;
               end
             end;
           end
           else
           begin
             if recognized1[j,3]='1' then
             begin
               if pos(recognized1[j,1],trim(s))=1 then
               begin
                 recog:=recognized1[j,2];
                 break;
               end
             end
             else if recognized1[j,3]='' then
             begin
               if pos(recognized1[j,1],trim(s))>0 then
               begin
                 recog:=recognized1[j,2];
                 break;
               end
             end
             else
             begin
               if pos(recognized1[j,1], trim(s))=strtoint(recognized1[j,3]) then
               begin
                 recog:=recognized1[j,2];
                 break;
               end
             end;
           end
        end;
      //
      if part_end_line[i]<>'' then
        while (line_counter<StrtoInt(part_end_line[i])) and (recog='') do
        begin
          readln(source,s);
          line_counter:=line_counter+1;
          for j:=1 to recognizedcount1 do
            if recognized1[j,4]='' then
            begin
              if (recognized1[j,5]='l') then
              begin
                if recognized1[j,3]='1' then
                begin
                  if (pos(recognized1[j,1],lowercase(trim(s)))=1)
                  or ((pos(utf8_file_header+recognized1[j,1],lowercase(trim(s)))=1)
                  or  (pos('=ef=bb=bf'+recognized1[j,1],lowercase(trim(s)))=1)) then
                  begin
                    recog:=recognized1[j,2];
                    break;
                  end
                end
                else if recognized1[j,3]='' then
                begin
                 if (pos(recognized1[j,1],lowercase(trim(s)))>0) then
                  begin
                    recog:=recognized1[j,2];
                    break;
                  end
                 end
                else
                begin
                  if pos(recognized1[j,strtoint(recognized1[j,3])], lowercase(trim(s)))=1 then
                  begin
                    recog:=recognized1[j,2];
                    break;
                  end
                end;
              end
              else
              begin
                if recognized1[j,3]='1' then
                begin
                  if pos(recognized1[j,1],trim(s))=1 then
                  begin
                    recog:=recognized1[j,2];
                    break;
                  end
                end
                else if recognized1[j,3]='' then
                begin
                  if pos(recognized1[j,1],trim(s))>0 then
                  begin
                    recog:=recognized1[j,2];
                    break;
                  end
                end
                else
                begin
                  if pos(recognized1[j,strtoint(recognized1[j,3])], trim(s))=1 then
                  begin
                    recog:=recognized1[j,2];
                    break;
                  end
                end;
              end
            end
            else if (pos('-',recognized1[j,4])>0) then
            begin
              i1:=strtoint(copy(recognized1[j,4],1,pos('-',recognized1[j,4])-1));
              i2:=strtoint(copy(recognized1[j,4],pos('-',recognized1[j,4])+1,length(recognized1[j,4])-pos('-',recognized1[j,4])));
              if part_start_line[i]<>'' then
                if (StrtoInt(part_start_line[i])+i1-1<=line_counter)
                  and (StrtoInt(part_end_line[i])+i2-1>=line_counter) then
                  begin
                    if (recognized1[j,5]='l') then
                    begin
                      if recognized1[j,3]='1' then
                      begin
                        if (pos(recognized1[j,1],lowercase(trim(s)))=1)
                        or ((pos(utf8_file_header+recognized1[j,1],lowercase(trim(s)))=1)
                        or  (pos('=ef=bb=bf'+recognized1[j,1],lowercase(trim(s)))=1)) then
                        begin
                          recog:=recognized1[j,2];
                          break;
                        end
                      end
                      else if recognized1[j,3]='' then
                      begin
                       if (pos(recognized1[j,1],lowercase(trim(s)))>0) then
                        begin
                          recog:=recognized1[j,2];
                          break;
                        end
                      end
                      else
                      begin
                        if pos(recognized1[j,strtoint(recognized1[j,3])], lowercase(trim(s)))=1 then
                        begin
                          recog:=recognized1[j,2];
                          break;
                        end
                      end;
                    end
                    else
                    begin
                      if recognized1[j,3]='1' then
                      begin
                        if pos(recognized1[j,1],trim(s))=1 then
                        begin
                          recog:=recognized1[j,2];
                          break;
                        end
                      end
                      else if recognized1[j,3]='' then
                      begin
                        if pos(recognized1[j,1],trim(s))>0 then
                        begin
                          recog:=recognized1[j,2];
                          break;
                        end
                      end
                      else
                      begin
                        if pos(recognized1[j,strtoint(recognized1[j,3])], trim(s))=1 then
                        begin
                          recog:=recognized1[j,2];
                          break;
                        end
                      end;
                    end
                  end;
            end
        end;
        //try to recognize by content-type, only for some types
         if recog='' then
         begin
           s1:=trim(lowercase(part_content_type[i]));
           for j:=1 to contenttypescount1 do
             if contenttypes1[j,1]=s1 then
             begin
               recog:=contenttypes1[j,2];
               break;
             end;
        end;
      
      //
      if recog='' then
      begin
        line_counter:=0;
        reset(source);//reset(f);
        if part_start_line[i]<>'' then
          while line_counter<StrtoInt(part_start_line[i]) do
          begin
            readln(source,s);
            line_counter:=line_counter+1;
          end;
        if pos('multipart/alternative',lowercase(part_content_type[i]))=0 then
          while (((trim(s)='') or (trim(s)='=0A='))
             or (copy(trim(lowercase(s)),1,10)='x-mimeole:')) and not(Eof(source)) do
          begin
            readln(source,s);
            line_counter:=line_counter+1;
            part_start_line[i]:=IntToStr(StrToInt(part_start_line[i])+1); //find first non empty line
          end;
        end;

      for j:=1 to recognizedcount2 do
        if ((recog='') and ((recognized2[j,4]='') or ((recognized2[j,4]='1') or (pos('1-',recognized2[j,4])=1)))) then
        begin
           {application.MessageBox(PChar('i:='+inttostr(i)+' '+'j:='+inttostr(j)+' '+s+chr(13)
             +'part_content_location='+part_content_location[i]+chr(13)
             +'part_name='+part_name[i]+chr(13)+'part_filename='+part_filename[i]+chr(13))
             , 'Look', 1); }
           if (recognized2[j,5]='l') then
           begin
             if recognized2[j,3]='1' then
             begin
               if (pos(recognized2[j,1],lowercase(trim(s)))=1)
               or ((pos(utf8_file_header+recognized2[j,1],lowercase(trim(s)))=1)
               or  (pos('=ef=bb=bf'+recognized2[j,1],lowercase(trim(s)))=1)) then
               begin
                 recog:=recognized2[j,2];
                 break;
               end
             end
             else if recognized2[j,3]='' then
             begin
              if (pos(recognized2[j,1],lowercase(trim(s)))>0) then
               begin
                 recog:=recognized2[j,2];
                 break;
               end

             end
             else
             begin
               if pos(recognized2[j,1], lowercase(trim(s)))=strtoint(recognized2[j,3]) then
               begin
                 recog:=recognized2[j,2];
                 break;
               end
             end;
           end
           else
           begin
             if recognized2[j,3]='1' then
             begin
               if pos(recognized2[j,1],trim(s))=1 then
               begin
                 recog:=recognized2[j,2];
                 break;
               end
             end
             else if recognized2[j,3]='' then
             begin
               if pos(recognized2[j,1],trim(s))>0 then
               begin
                 recog:=recognized2[j,2];
                 break;
               end
             end
             else
             begin
               if pos(recognized2[j,1], trim(s))=strtoint(recognized2[j,3]) then
               begin
                 recog:=recognized2[j,2];
                 break;
               end
             end;
           end
        end;
      //
      if part_end_line[i]<>'' then
        while (line_counter<StrtoInt(part_end_line[i])) and (recog='') do
        begin
          readln(source,s);
          line_counter:=line_counter+1;
          for j:=1 to recognizedcount2 do
            if recognized2[j,4]='' then
            begin
              if (recognized2[j,5]='l') then
              begin
                if recognized2[j,3]='1' then
                begin
                  if (pos(recognized2[j,1],lowercase(trim(s)))=1)
                  or ((pos(utf8_file_header+recognized2[j,1],lowercase(trim(s)))=1)
                  or  (pos('=ef=bb=bf'+recognized2[j,1],lowercase(trim(s)))=1)) then
                  begin
                    recog:=recognized2[j,2];
                    break;
                  end
                end
                else if recognized2[j,3]='' then
                begin
                 if (pos(recognized2[j,1],lowercase(trim(s)))>0) then
                  begin
                    recog:=recognized2[j,2];
                    break;
                  end
                 end
                else
                begin
                  if pos(recognized2[j,1], lowercase(trim(s)))=strtoint(recognized2[j,3]) then
                  begin
                    recog:=recognized2[j,2];
                    break;
                  end
                end;
              end
              else
              begin
                if recognized2[j,3]='1' then
                begin
                  if pos(recognized2[j,1],trim(s))=1 then
                  begin
                    recog:=recognized2[j,2];
                    break;
                  end
                end
                else if recognized2[j,3]='' then
                begin
                  if pos(recognized2[j,1],trim(s))>0 then
                  begin
                    recog:=recognized2[j,2];
                    break;
                  end
                end
                else
                begin
                  if pos(recognized2[j,1], trim(s))=strtoint(recognized2[j,3]) then
                  begin
                    recog:=recognized2[j,2];
                    break;
                  end
                end;
              end
            end
            else if (pos('-',recognized2[j,4])>0) then
            begin
              i1:=strtoint(copy(recognized2[j,4],1,pos('-',recognized2[j,4])-1));
              i2:=strtoint(copy(recognized2[j,4],pos('-',recognized2[j,4])+1,length(recognized2[j,4])-pos('-',recognized2[j,4])));
              if part_start_line[i]<>'' then
                if (StrtoInt(part_start_line[i])+i1-1<=line_counter)
                  and (StrtoInt(part_end_line[i])+i2-1>=line_counter) then
                  begin


                    if (recognized2[j,5]='l') then
                    begin
                      if recognized2[j,3]='1' then
                      begin
                        if (pos(recognized2[j,1],lowercase(trim(s)))=1)
                        or ((pos(utf8_file_header+recognized2[j,1],lowercase(trim(s)))=1)
                        or  (pos('=ef=bb=bf'+recognized2[j,1],lowercase(trim(s)))=1)) then
                        begin
                          recog:=recognized2[j,2];
                          break;
                        end
                      end
                      else if recognized2[j,3]='' then
                      begin
                       if (pos(recognized2[j,1],lowercase(trim(s)))>0) then
                        begin
                          recog:=recognized2[j,2];
                          break;
                        end
                      end
                      else
                      begin
                        if pos(recognized2[j,1], lowercase(trim(s)))=strtoint(recognized2[j,3]) then
                        begin
                          recog:=recognized2[j,2];
                          break;
                        end
                      end;
                    end
                    else
                    begin
                      if recognized2[j,3]='1' then
                      begin
                        if pos(recognized2[j,1],trim(s))=1 then
                        begin
                          recog:=recognized2[j,2];
                          break;
                        end
                      end
                      else if recognized2[j,3]='' then
                      begin
                        if pos(recognized2[j,1],trim(s))>0 then
                        begin
                          recog:=recognized2[j,2];
                          break;
                        end
                      end
                      else
                      begin
                        if pos(recognized2[j,1], trim(s))=strtoint(recognized2[j,3]) then
                        begin
                          recog:=recognized2[j,2];
                          break;
                        end
                      end;
                    end
                  end;
            end
        end;
        //try to recognize by content-type, only for some types
         if recog='' then
         begin
           s1:=trim(lowercase(part_content_type[i]));
           for j:=1 to contenttypescount2 do
             if contenttypes2[j,1]=s1 then
             begin
               recog:=contenttypes2[j,2];
               break;
             end;
        end;

      //
      part_recognized[i]:=recog;

      if pos('multipart/alternative',lowercase(part_content_type[i]))<>0 then
      begin
         alternative[i]:=language_strings[language_nr,81];
         alternatives:=alternatives+1;
      end
      else //not multipart/alternative
      begin
         alternative[i]:='';
      
         if part_content_location[i]<>'' then
         begin
            part_orig_path_full[i]:=part_content_location[i]; // check later if 'file:///...' or relative address
         end
         else part_orig_path_full[i]:='';

         if part_filename[i]<>'' then              //file name (local and unchanged, original, from server)
         begin
            part_local_name[i]:=IllegalChar2(part_filename[i]);
            part_unchanged_file_name[i]:=part_filename[i];
         end
         else if part_name[i]<>'' then
         begin
            part_local_name[i]:=IllegalChar2(part_name[i]);
            part_unchanged_file_name[i]:=part_name[i];
         end
         else if part_content_location[i]<>'' then
         begin
            part_unchanged_file_name[i]:=part_content_location[i];
            j:=0;                                         //extract file name
            while Pos('/',Copy(part_unchanged_file_name[i],j+1,length(part_unchanged_file_name[i])-j))<>0 do
               j:=j+Pos('/',Copy(part_unchanged_file_name[i],j+1,length(part_unchanged_file_name[i])-j));
            part_unchanged_file_name[i]:=Copy(part_unchanged_file_name[i],j+1,length(part_unchanged_file_name[i])-j+1);
            j:=0;
            while Pos('\',Copy(part_unchanged_file_name[i],j+1,length(part_unchanged_file_name[i])-j))<>0 do
               j:=j+Pos('\',Copy(part_unchanged_file_name[i],j+1,length(part_unchanged_file_name[i])-j));
            part_unchanged_file_name[i]:=Copy(part_unchanged_file_name[i],j+1,length(part_unchanged_file_name[i])-j+1);
            part_local_name[i]:=IllegalChar2(part_unchanged_file_name[i]);
         end
         else                                              //if no name give an generic
         begin
            part_unchanged_file_name[i]:='';

            //part_content_transfer_encoding[i]  part_content_type[i]
            s:=trim(lowercase(part_content_transfer_encoding[i]));
            if (s='quoted-printable') or ((s='7bit') or (s='8bit')) then
            begin
               part_local_name[i]:='txt_'+IntToStr(i);
               if recog<>'' then part_local_name[i]:=part_local_name[i]+recog
               else part_local_name[i]:=part_local_name[i]+'.$$$';
            end
            else
            begin
               part_local_name[i]:='B64_'+IntToStr(i);
               if recog<>'' then part_local_name[i]:=part_local_name[i]+recog
               else part_local_name[i]:=part_local_name[i]+'.$$$';
            end
         end;
         //filename and full address are truncated at '#' (before it)
         if pos('#',part_local_name[i])>0 then part_local_name[i]:=copy(part_local_name[i],1,pos('#',part_local_name[i])-1);
         if pos('#',part_orig_path_full[i])>0 then part_orig_path_full[i]:=copy(part_orig_path_full[i],1,pos('#',part_orig_path_full[i])-1);
         //if filename is empty rename it to index (www.domain/directory/ -> www.domain/directory/index , .htm will be added later)
         if trim(part_local_name[i])='' then part_local_name[i]:='index';
         // local file name, replace illegal chars
         part_local_name[i]:=IllegalChar(part_local_name[i]);
         //truncate filename if longer then MaxFileExtensionLength
         if length(ExtractFileExt(part_local_name[i]))>MaxFileExtensionLength then
           part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-length(ExtractFileExt(part_local_name[i]))+MaxFileExtensionLength);
         
         //truncate filename if longer then MaxFilenameLength
         if length(part_local_name[i])>MaxFilenameLength then
           part_local_name[i]:=copy(part_local_name[i],1,MaxFilenameLength-length(ExtractFileExt(part_local_name[i])))+ExtractFileExt(part_local_name[i]);
            
         {moved down
          for j:=1 to i-1 do
           if part_local_name[i]=part_local_name[j] then // files with same filename will be numbered name_1.ext, name_2.ext...
           begin
              part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-length(ExtractFileExt(part_local_name[i])))+'_'+IntToStr(i)+ExtractFileExt(part_local_name[i]);
              part_local_name[j]:=copy(part_local_name[j],1,length(part_local_name[j])-length(ExtractFileExt(part_local_name[j])))+'_'+IntToStr(j)+ExtractFileExt(part_local_name[j]);
              break;
           end
           else if copy(part_local_name[i],1,length(part_local_name[i])-length(ExtractFileExt(part_local_name[i])))+'_'+IntToStr(j)+ExtractFileExt(part_local_name[i])=part_local_name[j] then // files with same filename will be numbered name_1.ext, name_2.ext...
           begin
              part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-length(ExtractFileExt(part_local_name[i])))+'_'+IntToStr(i)+ExtractFileExt(part_local_name[i]);
              break;
           end;
              // are () characters allowed in flenames on all systems???  }
         //.php->.php.$$$, .jsp->.jsp.$$$, .cgi, .asp
         if ((lowercase(ExtractFileExt(part_local_name[i]))='.php') or (lowercase(ExtractFileExt(part_local_name[i]))='.jsp'))
           or ((lowercase(ExtractFileExt(part_local_name[i]))='.cgi') or (lowercase(ExtractFileExt(part_local_name[i]))='.asp')) then
         begin
             if recog<>'' then part_local_name[i]:=part_local_name[i]+recog
             else part_local_name[i]:=part_local_name[i]+'.$$$';
         end;
         //if there is no ext or there is "wrong" ext add real one. Good for Linux
         //remove leading and trailing '_' OE is adding to attachments
         if (copy(part_local_name[i],1,1)='_') and (copy(part_local_name[i],length(part_local_name[i]),1)='_') then
           part_local_name[i]:=copy(part_local_name[i],2,length(part_local_name[i])-2);
         //remove leading and trailing '_' end
         //reduce repetitive calling of function. (optimize next part)
         if ExtractFileExt(part_local_name[i])='' then part_local_name[i]:=part_local_name[i]+recog
         else if ExtractFileExt(part_local_name[i])='.' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-1)+recog
         else if lowercase(ExtractFileExt(part_local_name[i]))<>recog then
           begin
             if (recog='.htm')      //do not add in those cases
             and (((lowercase(ExtractFileExt(part_local_name[i]))<>'.html') and (lowercase(ExtractFileExt(part_local_name[i]))<>'.htm'))
             and ((lowercase(ExtractFileExt(part_local_name[i]))<>'.dhtml') and (lowercase(ExtractFileExt(part_local_name[i]))<>'.shtml')))
               then part_local_name[i]:=part_local_name[i]+recog;
             if (recog='.jpg') and (lowercase(ExtractFileExt(part_local_name[i]))<>'.jpeg')
               then part_local_name[i]:=part_local_name[i]+recog;
             if (recog<>'.htm') and (recog<>'.jpg') then part_local_name[i]:=part_local_name[i]+recog;
           end;
         //if extension is still .$$$ then try to recognize by content-type, only for some types
         // this is moved up, delete next part latter
         if ExtractFileExt(part_local_name[i])='.$$$' then
         begin
            s:=trim(lowercase(part_content_type[i]));
            if s='image/x-icon' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.ico'
            else if s='text/html' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.htm'
            else if s='text/.htm' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.htm'
            else if s='image/jpeg' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.jpg'
            else if s='image/png' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.png'
            else if s='image/gif' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.gif'
            else if s='text/css' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.css'
            else if s='text.css' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.css'
            else if s='application/x-javascript' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.js'
            else if s='text/javascript' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.js'
            else if s='application/x-shockwave-flash' then part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-4)+'.swf'
            // unsure: 'text/plain ?txt','application/octet-stream'
         end;
         for j:=1 to i-1 do
           if part_local_name[i]=part_local_name[j] then // files with same filename will be numbered name_1.ext, name_2.ext...
           begin
              part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-length(ExtractFileExt(part_local_name[i])))+'_'+IntToStr(i)+ExtractFileExt(part_local_name[i]);
              part_local_name[j]:=copy(part_local_name[j],1,length(part_local_name[j])-length(ExtractFileExt(part_local_name[j])))+'_'+IntToStr(j)+ExtractFileExt(part_local_name[j]);
              break;
           end
           else if copy(part_local_name[i],1,length(part_local_name[i])-length(ExtractFileExt(part_local_name[i])))+'_'+IntToStr(j)+ExtractFileExt(part_local_name[i])=part_local_name[j] then // files with same filename will be numbered name_1.ext, name_2.ext...
           begin
              part_local_name[i]:=copy(part_local_name[i],1,length(part_local_name[i])-length(ExtractFileExt(part_local_name[i])))+'_'+IntToStr(i)+ExtractFileExt(part_local_name[i]);
              break;
           end;
              // are () characters allowed in flenames on all systems???

      end;
      s:=trim(lowercase(part_content_transfer_encoding[i]));

      if ((s='quoted-printable') or (s='text/plain')) or ((s='7bit') or (s='8bit')) then
         part_encoding[i]:='quoted-printable'
      else if alternative[i]<>'' then
         part_encoding[i]:=''
      else if (s='') then
         part_encoding[i]:='quoted-printable'
      else
         part_encoding[i]:='base64';

      part_type[i]:=ExtractFileExt(part_local_name[i])

   end;
   //2nd pass end

   //correct wrong start-end line numbers, very rare
   for i:=1 to parts do
   begin
     if (part_start_line[i]='') and  (part_end_line[i]<>'') then part_start_line[i]:=part_end_line[i]
     else if (part_start_line[i]<>'') and  (part_end_line[i]='') then part_end_line[i]:=part_start_line[i]
     else if (part_start_line[i]='') and  (part_end_line[i]='') then
     begin
       part_end_line[i]:='0';
       part_start_line[i]:='0';
     end
     else if StrToInt(part_end_line[i])<StrToInt(part_start_line[i]) then part_end_line[i]:=part_start_line[i];
   end;

   //between pass 2 and 3 (multiple passes) start
   //move part_end_line up if part_end_line is empty
   tempboolean:=true;
   while tempboolean do
   begin
     tempboolean:=false;
     reset(source);

     for i:=1 to StrToInt(part_end_line[parts]) do
     begin
       readln(source,s);
       for j:= 1 to parts do
         if StrToInt(part_end_line[j])=i then
         begin
           if ((trim(s)='') or (isboundary(s)>0)) and (part_content_type[j]<>'multipart/alternative') then
           begin
             part_end_line[j]:=IntToStr(StrToInt(part_end_line[j])-1);
             tempboolean:=true;
           end
           else if (isboundary(s)>0) and (part_content_type[j]='multipart/alternative') then
           begin
             part_end_line[j]:=IntToStr(StrToInt(part_end_line[j])-1);
             tempboolean:=true;
           end;
         end;
      end;
   end;
   //move part_end_line up if part_end_line is empty
   //between pass 2 and 3 (multiple passes) end

   //3rd pass start
   //                   find first HTML (main file),
   //                   find BaseURL
   firstpart:=0;
   firsthtmfound:=false;
   if mht_start_file<>'' then
   begin
     for i:=1 to parts do
       if mht_start_file=part_content_id[i] then
       begin
         firsthtmfound:=true;
         firstpart:=i;
         firsthtm:=part_local_name[i];
         BaseURL:=part_orig_path_full[i];
       end;
   end;

   if not(firsthtmfound) then
     for i:=1 to parts do                           //cover .htm, .html, .dhtml, .shtml
      if (part_encoding[i]='quoted-printable') and (pos('htm',part_type[i])<>0) then
      begin
         firsthtmfound:=true;
         firstpart:=i;
         firsthtm:=part_local_name[i];
         BaseURL:=part_orig_path_full[i];
         break;
      end;
      
   if not(firsthtmfound) then                       //very rare html is base64 encoded
     for i:=1 to parts do                           //becouse of unusual code-page
      if pos('htm',part_type[i])<>0 then            //cover .htm, .html, .dhtml, .shtml
      begin
         firsthtmfound:=true;
         firstpart:=i;
         firsthtm:=part_local_name[i];
         BaseURL:=part_orig_path_full[i];
         break;
      end;
      
   if not(firsthtmfound) then           //if no html file found find 1st txt file
     for i:=1 to parts do
      if trim(lowercase(part_content_type[i]))='text/plain' then
      begin
         firsthtmfound:=true;
         firstpart:=i;
         firsthtm:=part_local_name[i];
         BaseURL:=part_orig_path_full[i];
         break;
      end;
      
   if not(firsthtmfound) then            //if not found just select 1st file as start file
      begin
         firsthtmfound:=true;
         firstpart:=1;
         firsthtm:=part_local_name[1];
         BaseURL:=part_orig_path_full[1];
      end;

   i1:=0;
   while Pos('/',Copy(BaseURL,i1+1,length(BaseURL)-i1))<>0 do
     i1:=i1+Pos('/',Copy(BaseURL,i1+1,length(BaseURL)-i1));
     i2:=0;
   while Pos('\',Copy(BaseURL,i2+1,length(BaseURL)-i2))<>0 do
     i2:=i2+Pos('\',Copy(BaseURL,i2+1,length(BaseURL)-i2));
   if i1>i2 then BaseURL:=Copy(BaseURL,1,i1)
   else BaseURL:=Copy(BaseURL,1,i2);
// DEBUG MODE START
   if debugmode then
   begin
     Writeln(debugfile,'---------------------------------------------');
     Writeln(debugfile,'Base URL: '+BaseURL);
     Writeln(debugfile,'---------------------------------------------');
   end;
// DEBUG MODE END
   //3rd pass end

   //4th pass start: extract

   line_counter:=0;
   reset(source);
   for i:=1 to parts do      //replace relative (if any) paths with absolute
      part_orig_path_full[i]:=ExtendToFullPath(part_orig_path_full[i]);
   if (AddressCorrecting>0) then //prepare strings for replacing
      PrepareReplace;
   for i:=1 to parts do
   begin

     if part_encoding[i]='base64' then B64ToStandard(i)
     else if part_local_name[i]<>'' then HTML(i);
{     if (AddressCorrecting>3) then //assign original TimeDate to file
     begin
       j:=FileAge(SourDir+DirSep+MhtFile);
       FileSetDate(OutpDir+DirSep+part_local_name[i],j);
     end;}

     {$IFNDEF CL}
     //megaNFOlist begin
     if Form1.CheckBox2.Checked and (part_content_type[i]<>'multipart/alternative') then
     begin
        s:=part_orig_path_full[i]+'[:-:]'+part_content_type[i]+'[:-:]'+OutpDir+DirectorySeparator+part_local_name[i]+'[:-:]'+part_encoding[i];
        if megaNFOlist.IndexOf(s)=-1 then megaNFOlist.Add(s);
     end;
     //megaNFOlist end;
 
     Form1.ProgressBar2.Position:=Round(i*100/Parts);
     Form1.Label3.Caption:=IntToStr(i)+' '+language_strings[language_nr,8]+' '+IntToStr(Parts)+' '+language_strings[language_nr,10];
     Application.ProcessMessages;
     {$ENDIF}

   end;

   CloseFile(source);

         // try to determine mht file creator program - begin of
         mht_file_creator:=language_strings[language_nr,88];
         if (pos('ez save mht',lowercase(mht_from))<>0) or (pos('goupsoft',lowercase(mht_product))<>0) then mht_file_creator:=language_strings[language_nr,82]
         else if (pos('saved by mozilla',lowercase(mht_from))<>0) or (pos('maf',lowercase(mht_x_maf))<>0) then mht_file_creator:=language_strings[language_nr,83]
         else if (pos('microsoft internet explorer',lowercase(mht_from))<>0) and (pos('microsoft mimeole',lowercase(mht_x_mime))<>0) then mht_file_creator:=language_strings[language_nr,84]
         else if mht_other_mht_creator<>'' then mht_file_creator:=mht_other_mht_creator
         else if mht_thread_index<>'' then mht_file_creator:=language_strings[language_nr,85]
         else if (mht_from='') and (pos('microsoft mimeole',lowercase(mht_x_mime))<>0) then mht_file_creator:=language_strings[language_nr,87]
         else if mht_from+mht_x_maf+mht_x_mime='' then mht_file_creator:=language_strings[language_nr,86];
         // try to determine mht file creator program - end of

         AssignFile(startme,OutpDir+DirectorySeparator+'_0_start_me.htm');
         Rewrite(startme);
         Writeln(startme,'<html><head>');
         Writeln(startme,'<body><div align=center '+HTMLCSSStrings[1]+'>');
         Writeln(startme,language_strings[language_nr,46]+' <b>mht2htm</b><br><a href="'+PMyMail+'">'+language_strings[language_nr,47]+' Goran Atanasijevic</a><br><a href="'+PMySite+'">'+language_strings[language_nr,48]+'</a></div><div align=center '+HTMLCSSStrings[2]+'>');
         //if firsthtmfound then
         Writeln(startme,'<a href="'+firsthtm+'" '+HTMLCSSStrings[3]+'>'+language_strings[language_nr,49]+'</a>');
         Writeln(startme,'</div>');
         if DetailsLevel>1 then
         begin
           Writeln(startme,'<code> '+language_strings[language_nr,89]+' <b>'+PVer+' '+PDat+' '+PExtra+'</b><br>');
           Writeln(startme,language_strings[language_nr,90]+' <b>'+DateTimeToStr(Now)+'</b><br>');
           try
             Writeln(startme,language_strings[language_nr,91]+' <b>'+DateTimeToStr(FileDateToDateTime(FileAge(SourDir+DirectorySeparator+MhtFile)))+'</b><br>'); //error on wrong datetime
           except
             Writeln(startme,language_strings[language_nr,91]+' <b>'+language_strings[language_nr,167]+'</b><br>');
           end;
           Writeln(startme,language_strings[language_nr,92]+' <b>'+mht_file_creator+'</b><br>');
           Writeln(startme,language_strings[language_nr,93]+' <b>'+IntToStr(mht_file_size)+'</b> '+language_strings[language_nr,94]+'<br>');
           Writeln(startme,language_strings[language_nr,95]+' <b>'+IntToStr(Parts)+'</b> '+language_strings[language_nr,96]+'. <b>'+IntToStr(Parts-alternatives)+'</b> '+language_strings[language_nr,97]+'.<br>');
         end;
         Writeln(startme,'<div '+HTMLCSSStrings[4]+'>');
         for i:=1 to Parts do
           if part_local_name[i]<>'' then
             writeln(startme,IntToStr(i)+': <a href="'+part_local_name[i]+'">'+part_local_name[i]+'</a><br>')
           else
             writeln(startme,IntToStr(i)+language_strings[language_nr,98]+'<br>');
         Writeln(startme,'</div><div '+HTMLCSSStrings[5]+'>');
         Writeln(startme,language_strings[language_nr,99]+' <b>'+FloatToStrF((Now-temptime)*24*60*60,ffGeneral,5,5)+'</b> '+language_strings[language_nr,100]+'</div>');
         //detailed start
         if DetailsLevel>1 then
         begin
           Writeln(startme,'<div '+HTMLCSSStrings[6]+'><b>'+language_strings[language_nr,101]+'</b></div>');
           Writeln(startme,'<div '+HTMLCSSStrings[7]+'><b>'+language_strings[language_nr,102]+'</b><br>');
           Writeln(startme,language_strings[language_nr,103]+' <b>'+mht_from+'</b><br>');
           Writeln(startme,language_strings[language_nr,104]+' <b>'+mht_subject+'</b><br>');
           Writeln(startme,language_strings[language_nr,105]+' <b>'+mht_date+'</b><br>');
           Writeln(startme,language_strings[language_nr,106]+' <b>'+mht_importance+'</b><br>');
           Writeln(startme,language_strings[language_nr,107]+' <b>'+mht_priority+'</b><br>');
           Writeln(startme,language_strings[language_nr,108]+' <b>'+mht_content_type+'</b><br>');
           Writeln(startme,language_strings[language_nr,109]+' <b>'+mht_type+'</b><br>');
           Writeln(startme,language_strings[language_nr,110]+' <b>'+mht_mime_version+'</b><br>');
           Writeln(startme,language_strings[language_nr,111]+' <b>'+mht_start_file+'</b><br>');
           Writeln(startme,language_strings[language_nr,112]+' <b>'+mht_content_location+'</b><br>');
           Writeln(startme,language_strings[language_nr,113]+' <b>'+mht_content_transfer_encoding+'</b><br>');
           Writeln(startme,language_strings[language_nr,114]+' <b>'+mht_charset+'</b><br>');
           Writeln(startme,language_strings[language_nr,115]+' <b>'+mht_product+'</b><br>');
           Writeln(startme,language_strings[language_nr,116]+' <b>'+mht_x_maf+'</b><br>');
           Writeln(startme,language_strings[language_nr,117]+' <b>'+mht_x_mime+'</b><br>');
           Writeln(startme,language_strings[language_nr,118]+' <b>'+mht_thread_index+'</b><br>');
           Writeln(startme,language_strings[language_nr,119]+' <b>'+mht_content_class+'</b><br>');
           Writeln(startme,language_strings[language_nr,120]+': <b>'+IntToStr(Parts)+'</b><br></div>');

           Writeln(startme,'<div '+HTMLCSSStrings[8]+'>');
           for i:=1 to boundarycount do
             Writeln(startme,language_strings[language_nr,121]+IntToStr(i)+': <b>'+boundary[i]+'</b><br>');
           Writeln(startme,'</div>');
         
           for i:=1 to parts do
           begin
              if i mod 2 =0 then  Writeln(startme,'<div '+HTMLCSSStrings[9]+'>')
              else Writeln(startme,'<div '+HTMLCSSStrings[12]+'>');
              Writeln(startme,'<b>'+language_strings[language_nr,122]+IntToStr(i)+'</b></div>');
              if i mod 2 =0 then  Writeln(startme,'<div '+HTMLCSSStrings[10]+'>')
              else Writeln(startme,'<div '+HTMLCSSStrings[13]+'>');
              Writeln(startme,language_strings[language_nr,123]+' <b>'+part_content_type[i]+'</b><br>');
              // FOR TESTING ONLY find unhandled ContentTypes
              // ADD Memo1 to Form1
              {   tempboolean:=true;
                 s:=part_content_type[i];
                 for j:=0 to Form1.Memo1.Lines.Count-1 do
                    if Form1.Memo1.Lines.Strings[j]=s then tempboolean:=false;
                 for j:=1 to contenttypescount1 do
                    if contenttypes1[j,1]=s then tempboolean:=false;
                 for j:=1 to contenttypescount2 do
                    if contenttypes2[j,1]=s then tempboolean:=false;
                // if Form1.Memo1.Lines.IndexOf(s)<>-1 then
                 if tempboolean then
                    Form1.Memo1.Lines.Add(s); }
              // FOR TESTING ONLY
              Writeln(startme,language_strings[language_nr,124]+' <b>'+part_charset[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,125]+' <b>'+part_content_transfer_encoding[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,126]+' <b>'+part_content_location[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,127]+' <b>'+part_content_id[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,128]+' <b>'+part_content_disposition[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,129]+' <b>'+part_filename[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,130]+' <b>'+part_name[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,131]+' <b>'+part_start_line[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,132]+' <b>'+part_end_line[i]+'</b><br>');
              Writeln(startme,language_strings[language_nr,133]+' <b>'+alternative[i]+'</b><br>');
              Writeln(startme,'</div>');
              
              if DetailsLevel>2 then
              begin
                if i mod 2 =0 then  Writeln(startme,'<div '+HTMLCSSStrings[10]+'>')
                else Writeln(startme,'<div '+HTMLCSSStrings[13]+'>');
                Writeln(startme,'<b>'+language_strings[language_nr,134]+'</b><br>');
                Writeln(startme,language_strings[language_nr,135]+' <b>'+part_orig_path_full[i]+'</b><br>');
                Writeln(startme,language_strings[language_nr,136]+' <b>'+part_unchanged_file_name[i]+'</b><br>');
                Writeln(startme,language_strings[language_nr,137]+' <b>'+part_local_name[i]+'</b><br>');
                Writeln(startme,language_strings[language_nr,138]+' <b>'+part_encoding[i]+'</b><br>');
                Writeln(startme,language_strings[language_nr,139]+' <b>'+part_recognized[i]+'</b><br>');
                Writeln(startme,language_strings[language_nr,140]+' <b>'+part_type[i]+'</b><br>');
                if FileExists(OutpDir+DirectorySeparator+part_local_name[i]) then
                begin
                  AssignFile(f,OutpDir+DirectorySeparator+part_local_name[i]);
                  // ToDo: remove reset and close ?
                  reset(f);
                  Writeln(startme,language_strings[language_nr,141]+' <b>'+IntToStr(FileSize(f))+'</b><br>');
                  CloseFile(f);
                end;
                Writeln(startme,'</div>');
              end;
              //if part_local_name[i]<>'' then
                if i mod 2 =0 then  Writeln(startme,'<div '+HTMLCSSStrings[11]+'>')
                else Writeln(startme,'<div '+HTMLCSSStrings[14]+'>');
                Writeln(startme,language_strings[language_nr,142]+' <b><a href="'+part_local_name[i]+'">'+language_strings[language_nr,143]+'</a> '+language_strings[language_nr,144]+' <a href="'+part_local_name[i]+'" target="_blank">'+language_strings[language_nr,145]+'</a></b><br></div>');

              Writeln(info, part_orig_path_full[i]+' [-] '+part_content_type[i]+' [-] '+part_local_name[i]+' [-] '+part_encoding[i]);
           end;
         end;
         //detailed end
         Writeln(startme,'</code>');
         Writeln(startme,'</body></html>');
         Writeln(info,'');
         Writeln(info,'---------------------------------------------');
         Writeln(info,language_strings[language_nr,44]+' '+IntToStr(Parts)+' '+language_strings[language_nr,45]);

         
         CloseFile(startme);
         CloseFile(info);
// DEBUG MODE START
         if debugmode then CloseFile(debugfile);
// DEBUG MODE END

   repso.Free;
   repsn.Free;
   delo.Free;
   repso1.Free;
   repsn1.Free;
   delo1.Free;
   nizOrig.Free;
   nizNew.Free;
   nizNewName.Free;
   nizType.Free;
   nizCode.Free;
   
   part_content_type.Free;
   part_charset.Free;
   part_content_transfer_encoding.Free;
   part_content_location.Free;
   part_content_id.Free;
   part_content_disposition.Free;
   part_filename.Free;
   part_name.Free;
   part_start_line.Free;
   part_end_line.Free;
   
   part_orig_path_full.Free;
   part_orig_path_relative.Free;
   part_local_name.Free;
   part_unchanged_file_name.Free;
   part_encoding.Free;
   part_recognized.Free;
   part_type.Free;
   
   alternative.Free;
   boundary.Free;
   MH2HT:=GoodMHT;
   
end;

end.

