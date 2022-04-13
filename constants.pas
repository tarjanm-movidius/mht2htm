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
unit Constants;

{$mode objfpc}{$H+}

interface

const
     //program version etc.
     PVer='1.8.1';
     PDat='05.apr.2016.';
     PExtra=' ('+{$I %FPCTARGETOS }+' '+{$i %FPCTARGETCPU%}+')';
     PMyMail='mailto:bajaatan@yahoo.com';
     PMySite='http://pgm.bpalanka.com';
     

     MaxFilenameLength=60; //limit filename length to avoid stupid truncation
                           //NOTE: filename can be few characters longer then this value
     MaxFileExtensionLength=10;

    //some specific strings
    utf8_file_header = #239#187#191;
    unicode_file_header = chr(255)+ chr(254);

     //domains, protocols... need this to determine absolute path
     TopLevelDomainsCounter=324;
     TopLevelDomains:array[1..TopLevelDomainsCounter]of string


     = (
       '.aero', '.asia', '.biz', '.cat', '.com', '.coop', '.info',
       '.int', '.jobs', '.mobi', '.museum', '.name', '.net', '.org',
       '.pro', '.tel', '.travel', '.xxx',
       '.edu', '.gov', '.mil',
       '.arpa',

       '.root', '.cs', '.zr', '.dd', '.su', '.local', '.site',
       '.internal', '.post', '.sx', '.nato',

       '.ac', '.ad', '.ae', '.af', '.ag', '.ai', '.al', '.am', '.an',
       '.ao', '.aq', '.ar', '.as', '.at', '.au', '.aw', '.ax', '.az',
       '.ba', '.bb', '.bd', '.be', '.bf', '.bg', '.bh', '.bi', '.bj',
       '.bm', '.bn', '.bo', '.br', '.bs', '.bt', '.bv', '.bw', '.by',
       '.bz', '.ca', '.cc', '.cd', '.cf', '.cg', '.ch', '.ci', '.ck',
       '.cl', '.cm', '.cn', '.co', '.cr', '.cs', '.cu', '.cv', '.cx',
       '.cy', '.cz', '.dd', '.de', '.dj', '.dk', '.dm', '.do', '.dz',
       '.ec', '.ee', '.eg', '.eh', '.er', '.es', '.et', '.eu', '.fi',
       '.fj', '.fk', '.fm', '.fo', '.fr', '.ga', '.gb', '.gd', '.ge',
       '.gf', '.gg', '.gh', '.gi', '.gl', '.gm', '.gn', '.gp', '.gq',
       '.gr', '.gs', '.gt', '.gu', '.gw', '.gy', '.hk', '.hm', '.hn',
       '.hr', '.ht', '.hu', '.id', '.ie', '.il', '.im', '.in', '.io',
       '.iq', '.ir', '.is', '.it', '.je', '.jm', '.jo', '.jp', '.ke',
       '.kg', '.kh', '.ki', '.km', '.kn', '.kp', '.kr', '.kw', '.ky',
       '.kz', '.la', '.lb', '.lc', '.li', '.lk', '.lr', '.ls', '.lt',
       '.lu', '.lv', '.ly', '.ma', '.mc', '.md', '.me', '.mg', '.mh',
       '.mk', '.ml', '.mm', '.mn', '.mo', '.mp', '.mq', '.mr', '.ms',
       '.mt', '.mu', '.mv', '.mw', '.mx', '.my', '.mz', '.na', '.nc',
       '.ne', '.nf', '.ng', '.ni', '.nl', '.no', '.np', '.nr', '.nu',
       '.nz', '.om', '.pa', '.pe', '.pf', '.pg', '.ph', '.pk', '.pl',
       '.pm', '.pn', '.pr', '.ps', '.pt', '.pw', '.py', '.qa', '.re',
       '.ro', '.rs', '.ru', '.rw', '.sa', '.sb', '.sc', '.sd', '.se',
       '.sg', '.sh', '.si', '.sj', '.sk', '.sl', '.sm', '.sn', '.so',
       '.sr', '.ss', '.st', '.su', '.sv', '.sx', '.sy', '.sz', '.tc',
       '.td', '.tf', '.tg', '.th', '.tj', '.tk', '.tl', '.tm', '.tn',

       '.to', '.tp', '.tr', '.tt', '.tv', '.tw', '.tz', '.ua', '.ug',
       '.uk', '.us', '.uy', '.uz', '.va', '.vc', '.ve', '.vg', '.vi',
       '.vn', '.vu', '.wf', '.ws', '.ye', '.yt', '.yu', '.za', '.zm',
       '.zw',

       '.বাংলা', '.中国', '.中國', '.გე', '.香港', '.भारत', '.భారత్',
       '.ભારત', '.ਭਾਰਤ', '.இந்தியா', '.ভারত', '.қаз', '.мон', '.рф',
       '.срб', '.新加坡', '.சிங்கப்பூர்', '.한국', '.ලංකා', '.இலங்கை',
       '.台湾', '.台灣', '.ไทย', '.укр', '.бг', '.ελ', '.日本', '.日本国',
       '.ລາວ ', 'ليبيا.‎', '测试', '測試', 'испытание', 'परीक्षा',
       'δοκιμή', '테스트', 'テスト', 'பரிட்சை'
       );






     ProtocolsCounter=3;
     Protocols:array[1..ProtocolsCounter]of string
              = ('http://', 'ftp://', 'https://');

     LocalProtocolsCounter=79;
     LocalProtocols:array[1..LocalProtocolsCounter]of string
              = (
     'file://a:', 'file://b:', 'file://c:', 'file://d:', 'file://e:',
     'file://f:', 'file://g:', 'file://h:', 'file://i:', 'file://j:',
     'file://k:', 'file://l:', 'file://m:', 'file://n:', 'file://o:',
     'file://p:', 'file://q:', 'file://r:', 'file://s:', 'file://t:',
     'file://u:', 'file://v:', 'file://w:', 'file://x:', 'file://y:',
     'file://z:',
     'file:///a:', 'file:///b:', 'file:///c:', 'file:///d:', 'file:///e:',
     'file:///f:', 'file:///g:', 'file:///h:', 'file:///i:', 'file:///j:',
     'file:///k:', 'file:///l:', 'file:///m:', 'file:///n:', 'file:///o:',
     'file:///p:', 'file:///q:', 'file:///r:', 'file:///s:', 'file:///t:',
     'file:///u:', 'file:///v:', 'file:///w:', 'file:///x:', 'file:///y:',
     'file:///z:',
     'mhtml:file://a:', 'mhtml:file://b:', 'mhtml:file://c:', 'mhtml:file://d:',
     'mhtml:file://e:', 'mhtml:file://f:', 'mhtml:file://g:', 'mhtml:file://h:',
     'mhtml:file://i:', 'mhtml:file://j:', 'mhtml:file://k:', 'mhtml:file://l:',
     'mhtml:file://m:', 'mhtml:file://n:', 'mhtml:file://o:', 'mhtml:file://p:',
     'mhtml:file://q:', 'mhtml:file://r:', 'mhtml:file://s:', 'mhtml:file://t:',
     'mhtml:file://u:', 'mhtml:file://v:', 'mhtml:file://w:', 'mhtml:file://x:',
     'mhtml:file://y:', 'mhtml:file://z:',
     'file://localhost');
     
     recognizedcount1=65;
     recognized1:array[1..recognizedcount1,1..5]of string    // 'string',
                                                           // '.ext',
                                                           // 'col'={'', '1','2',...}; ''=anywhere
                                                           // 'row'={'', '1', '1-5',...}
                                                           // {'', 'l'=lowercase, string must be lowercase
                                                           //  combination with ﻿ and =EF=BB=BF
                                                           //  will be checked too
                                                           //  in case col is '' or '1'}
                                                           // if col='' or '1' and row='' or '1' or '1-... and lowercase='l'
                                                           // then also check '﻿'+ and '=EF=BB=BF'+

       =(
           ('R0lGOD',                            '.gif', '1', '1',  ''),
            //R0lGODlh
            //R0lGODdh  exception
           ('/9j/4',                             '.jpg', '1', '1',  ''),
           ('iVBORw0K',                          '.png', '1', '1',  ''),
             //possible 'iVBORw0KGgoAAAANSUhEUgAA'

           ('<!doctype html public',             '.htm', '', '',  'l'),
           ('<html>',                            '.htm', '', '1',  'l'),
           ('document.',                         '.js', '1', '1',  'l'),
           ('d.',                                '.js', '1', '1',  'l'),
           ('var ',                              '.js', '1', '1',  'l'),
           ('body',                              '.css', '1', '1',  'l'),
           ('html',                              '.css', '1', '1',  'l'),
           //('*****not good***htm/js***<!-- ',    '.htm'),
           ('<!doctype html',                    '.htm', '', '',  'l'),

           ('function',                          '.js', '1', '1',  'l'),
           ('(function',                         '.js', '1', '1',  'l'),
           ('eval',                              '.js', '1', '1',  'l'),
           ('//-- google analytics',             '.js', '1', '1',  'l'),
           ('<!--',                              '.htm', '1', '1',  'l'), //.js, also can be html
           ('if ',                               '.js', '1', '1',  'l'),
           ('if(',                               '.js', '1', '1',  'l'),
           ('RldT',                              '.swf', '1', '1',  ''), //
           ('Q1dT',                              '.swf', '1', '1',  ''),

           ('/* css document */',                '.css', '1', '1',  'l'),
           ('link',                              '.css', '1', '1',  'l'),
           ('div#',                              '.css', '1', '1',  'l'),
           ('div.',                              '.css', '1', '1',  'l'),
           ('font',                              '.css', '1', '1',  'l'),
           ('@import',                           '.css', '1', '1',  'l'),
           ('@media',                            '.css', '1', '1',  'l'),
           ('input#',                            '.css', '1', '1',  'l'),
           ('window',                            '.css', '1', '1',  'l'), //window.
           ('form',                              '.css', '1', '1',  'l'),

           ('AAABAAEA',                          '.ico', '1', '1',  ''),
           ('AAABAAIA',                          '.ico', '1', '1',  ''),
           ('AAABAAQA',                          '.ico', '1', '1',  ''),


//           ('<HTML',                             '.htm', '1', '1',  'l'),
           ('<html xml',                         '.htm', '1', '',  'l'),
           ('<html',                             '.htm', '1', '',  'l'),   //
           ('TVNDR',                             '.cab', '1', '1',  ''),
           ('SVNjKAFSA',                         '.cab', '1', '1',  ''), //encoded cab?

           ('SUkqA',                             '.tif', '1', '1',  ''),

           ('YOovA',                             '.arj', '1', '1',  ''),
           ('UEsDBBQAA',                         '.zip', '1', '1',  ''),
           ('UmFyIRoHA',                         '.rar', '1', '1',  ''),
           ('H4sI',                              '.tgz', '1', '1',  ''), // also .gz and .tar.tar
           ('QlpoOTFBWSZTW',                     '.bz2', '1', '1',  ''),
           ('oqQUNFKio',                         '.ace', '11', '1',  ''),
           //.tar  -not good
           //QXZpLwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
           //YXZpLwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA


           ('SUQzAwAAAAA',                       '.mp3', '1', '1',  ''),
           ('MCaydY5mzxGm2QCqAGLOb',             '.wma', '1', '1',  ''),
           ('UklGRjL',                           '.wav', '1', '1',  ''),
           ('TVRoZAAAAAYAAQA',                   '.mid', '1', '1',  ''),
           ('UklGR',                             '.avi', '1', '1',  ''),
           ('Qk0',                               '.bmp', '1', '1',  ''),
           ('UklGR',                             '.cdr', '1', '1',  ''),
           ('hash:',                             '.dsc', '1', '1',  'l'),
           ('{\rtf1\',                           '.rtf', '1', '1',  'l'),
           ('UlBLAQAC',                          '.rpk', '1', '1',  ''),
           ('QUMxMDE1AAAAAAAGAdwAAAAXBhwABgAAAABrQwAA','.dwg', '1', '1',  ''),
           ('SVRTRgMAAABgAAAAAQAAAE',            '.chm', '1', '1',  ''),
           ('ITxhcmNoPgpkZWJpYW4tYmluYXJ5ICAgMTAxM','.deb', '1', '1',  ''),
           ('JVBERi0xLj',                        '.pdf', '1', '1',  ''),
           ('7avu2wMAAAAAA',                     '.rpm', '1', '1',  ''),

            //exe , can be .com, possible 'TVr'
           ('TVq',                               '.exe', '1', '1',  ''),
           ('TVp',                               '.exe', '1', '1',  ''),


            //com
            {6V0VAHcVAACXDwAAVQ4AAIQSAAAAAAAAAAAAAAAAAAA
            TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAA
            TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAA
            TVr+AIkAAADNAfoE//9YD4AAAAAQACwPHgAAAAEAAAAAAAAAAAAAAAAAAAAAAA
            6TQoAAAAAAAAAAAAAAAAAOsIAAAAAAAAAACA/Kx1Fgr
            6RAiAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFwAYAJcAlgAA
            vEQDuGsFBQ8AsQTT6IvYjMEDwS1sD3ME99gD2LRKzSHoOgBzBLAB6xeAPiw }

            //msi
            //0M8R4KGxGuEAAAAAAAAAAAAAAAAAAAAAPgADAP7/CQAGAAAAAAAAAAAAAABiAAAA
            
           ('<xml xmlns',                        '.xml', '1', '1',  'l'),
           ('<html>',                            '.htm', '1', '2-3',  'l'),
           ('<!-- RSS',                          '.xml', '1', '1-5',  'l'),
           ('<rss',                              '.xml', '1', '1-5',  'l')


         );
     //2nd priority
     recognizedcount2=19;
     recognized2:array[1..recognizedcount2,1..5]of string

       =(
    //rare

           ('unknown {',                         '.css', '1', '1',  'l'),
           ('function(',                         '.js', '', '1',  'l'),
           ('function (',                        '.js', '', '1',  'l'),

    //less sure, keep at end
           ('a:',                                '.css', '1', '1',  'l'),
           ('a.',                                '.css', '1', '1',  'l'),
           ('.',                                 '.css', '1', '1',  ''),
           ('{',                                 '.css', '1', '1',  ''),
           ('#',                                 '.css', '1', '1',  ''),
           ('@',                                 '.css', '1', '1',  ''),
           ('//',                                '.js', '1', '1',  ''),
           ('/*',                                '.js', '1', '1',  ''), //or .css, but usualy .js

           ('img {',                             '.css', '1', '1',  'l'), //also .js ?
           ('*{',                                '.css', '1', '1',  ''),


           ('h1 {',                            '.css', '1', '1',  'l'),
           ('div {',                           '.css', '1', '1',  'l'),
           ('span {',                          '.css', '1', '1',  'l'),
           ('table {',                         '.css', '1', '1',  'l'),
           ('td {:',                           '.css', '1', '1',  'l'),
           ('<html>',                          '.htm', '', '2-10',  'l')
         );

         contenttypescount1=315;
         contenttypes1:array[1..contenttypescount1,1..2]of string
       =(   //lowercase strings
           ('application/zip',                   '.zip'), //zone alarm's .zm9 is also .zip
           ('application/x-zip-compressed',      '.zip'),
           ('application/x-zip',                 '.zip'), //???
           ('application/x-compress',            '.z'),
           ('application/x-rar-compressed',      '.rar'), //zone alarm's .zma = .rar
           ('image/x-icon',                      '.ico'),
           ('text/html',                         '.htm'),
           ('text/.htm',                         '.htm'),
           ('image/jpeg',                        '.jpg'),
           ('image/jpg',                         '.jpg'),
           ('image/png',                         '.png'),
           ('image/gif',                         '.gif'),
           ('text/css',                          '.css'),
           ('text.css',                          '.css'),
           ('application/x-javascript',          '.js'),
           ('application/javascript',            '.js'),
           ('text/javascript',                   '.js'),
           ('application/x-shockwave-flash',     '.swf'),
           ('image/x-png',                       '.png'),
           ('image/pjpeg',                       '.jpg'),
           ('image/bmp',                         '.bmp'),
           ('image/tiff',                        '.tif'),
           ('application/msword',                '.doc'),
           ('application/pdf',                   '.doc'),
           ('application/vnd.ms-powerpoint',     '.pps'),
           ('application/vnd.ms-excel',          '.xls'), //also can be .dif (template)
           ('application/x-msexcel',             '.xls'),
           ('application/x-gzip',                '.gz'), // also tar.gz ...
           ('application/gzip',                  '.gz'),
           ('application/x-bzip2',               '.bz2'), // also tar.bz2 ...
           ('application/x-gtar',                '.tgz'),
           ('application/ms-tnef',               '.dat'),
           ('application/x-shellscript',         '.sh'),

           ('text/x-pascal',                     '.pas'),  //:-)
           ('application/rtf',                   '.rtf'),
           ('text/richtext',                     '.rtf'),
           ('image/x-xpixmap',                   '.xpm'),
           ('application/x-pkcs7-signature',     '.p7s'),
           ('application/pgp-signature',         '.asc'),
           
           ('text/x-patch',                      '.patch'),
           ('text/x-diff',                       '.patch'),
           ('text/x-c',                          '.c'),

           ('application/rss+xml',               '.xml'),


           ('application/vnd.ms-xpsdocument',    '.xps'),
           ('application/vnd.adobe.xfdf',        '.xfdf'),
           ('application/vnd.adobe.xfd+xml',     '.xfd'),
           ('application/vnd.adobe.xdp+xml',     '.xdp'),
           ('application/x-ms-xbap',             '.xbap'),
           ('application/xaml+xml',              '.xaml'),
           ('video/x-ms-wvx',                    '.wvx'),
           ('interface/x-winamp-skin',           '.wsz'),
           ('text/scriptlet',                    '.wsc'),
           ('application/vnd.ms-wpl',            '.wpl'),
           ('application/x-ms-wmz',              '.wmz'),
           ('video/x-ms-wmx',                    '.wmx'),
           ('application/x-ms-wmd',              '.wmd'),
           ('audio/x-ms-wma',                    '.wma'),
           ('video/x-ms-wm',                     '.wm'),
           ('interface/x-winamp-lang',           '.wlz'),
           ('audio/x-ms-wax',                    '.wax'),
           ('audio/wav',                         '.wav'),
           ('audio/x-wav',                       '.wav'),
           ('interface/x-winamp3-skin',          '.wal'),
           ('application/cdf',                   '.cdf'),
           ('application/fractals',              '.fif'),
           ('application/futuresplash',          '.spl'),
           ('application/hta',                   '.hta'),
           ('application/ibe',                   '.ibe'),
           ('application/mac-binhex40',          '.hqx'),
           ('application/msaccess',              '.accdb'),
           ('application/ms-infopath.xml',       '.infopathxml'),
           ('application/msonenote',             '.one'),
           ('application/ms-vsi',                '.vsi'),
           ('application/opensearchdescription+xml','.osdx'),
           ('application/pkcs10',                '.p10'),
           ('application/pkcs7-mime',            '.p7m'),
           ('application/pkcs7-signature',               '.p7s'),
           ('application/pkix-cert',               '.cer'),
           ('application/pkix-crl',               '.crl'),
           ('application/postscript',               '.ps'),
           ('application/sdp',               '.sdp'),
           ('application/set-payment-initiation',               '.setpay'),
           ('application/set-registration-initiation',               '.setreg'),
           ('application/smil',               '.smil'),
           ('application/streamingmedia',               '.ssm'),
           ('application/vnd.adobe.pdfxml',               '.pdfxml'),
           ('application/vnd.adobe.pdx',               '.pdx'),
           ('application/vnd.adobe.rmf',               '.rmf'),
           ('application/vnd.fdf',               '.fdf'),
           ('application/vnd.google-earth.kml+xml',               '.kml'),
           ('application/vnd.google-earth.kmz',               '.kmz'),
           ('application/vnd.groove-injector',               '.grv'),
           ('application/vnd.groove-space-archive',               '.gsa'),
           ('application/vnd.groove-tool-archive',               '.gta'),
           ('application/vnd.groove-vcard',               '.vcg'),
           ('application/vnd.ms-excel.addin.macroEnabled.12',               '.xlam'),
           ('application/vnd.ms-excel.sheet.binary.macroEnabled.12',               '.xlsb'),
           ('application/vnd.ms-excel.sheet.macroEnabled.12',               '.xlsm'),
           ('application/vnd.ms-excel.template.macroEnabled.12',               '.xltm'),
           ('application/vnd.ms-mediapackage',               '.mpf'),
           ('application/vnd.ms-officetheme',               '.thmx'),
           ('application/vnd.ms-package.relationships+xml',               '.rels'),
           ('application/vnd.ms-pki.certstore',               '.sst'),
           ('application/vnd.ms-pki.pko',               '.pko'),
           ('application/vnd.ms-pki.seccat',               '.cat'),
           ('application/vnd.ms-pki.stl',               '.stl'),
           ('application/vnd.ms-powerpoint.addin.macroEnabled.12',               '.ppam'),
           ('application/vnd.ms-powerpoint.presentation.macroEnabled.12',               '.pptm'),
           ('application/vnd.ms-powerpoint.slide.macroEnabled.12',               '.sldm'),
           ('application/vnd.ms-powerpoint.slideshow.macroEnabled.12',               '.ppsm'),
           ('application/vnd.ms-powerpoint.template.macroEnabled.12',               '.potm'),
           ('application/vnd.ms-publisher',               '.pub'),
           ('application/vnd.ms-visio.viewer',               '.vdx'),
           ('application/vnd.ms-word.document.macroEnabled.12',               '.docm'),
           ('application/vnd.ms-word.template.macroEnabled.12',               '.dotm'),
           ('application/vnd.oasis.opendocument.formula',               '.odf'),
           ('application/vnd.oasis.opendocument.graphics',               '.odg'),
           ('application/vnd.oasis.opendocument.presentation',               '.odp'),
           ('application/vnd.oasis.opendocument.spreadsheet',               '.ods'),
           ('application/vnd.oasis.opendocument.text',               '.odt'),
           ('application/vnd.oasis.opendocument.text-master',               '.odm'),
           ('application/vnd.oasis.opendocument.text-web',               '.oth'),
           ('application/vnd.openofficeorg.extension',               '.oxt'),
           ('application/vnd.openxmlformats-officedocument.presentationml.pr',               '.pptx'),
           ('application/vnd.openxmlformats-officedocument.presentationml.sl',               '.sldx'),
           ('application/vnd.openxmlformats-officedocument.presentationml.te',               '.potx'),
           ('application/vnd.openxmlformats-officedocument.spreadsheetml.she',               '.xlsx'),
           ('application/vnd.openxmlformats-officedocument.spreadsheetml.tem',               '.xltx'),
           ('application/vnd.openxmlformats-officedocument.wordprocessingml.',               '.dotx'),
           ('application/vnd.rn-realaudio-secure',               '.rms'),
           ('application/vnd.rn-realmedia',               '.rm'),
           ('application/vnd.rn-realmedia-secure',               '.rms'),
           ('application/vnd.rn-realmedia-vbr',               '.rmvb'),
           ('application/vnd.rn-realplayer',               '.rnx'),
           ('application/vnd.rn-realsystem-rjt',               '.rjt'),
           ('application/vnd.rn-realsystem-rmj',               '.rmj'),
           ('application/vnd.rn-realsystem-rmx',               '.rmx'),
           ('application/vnd.rn-rn_music_package',               '.rmp'),
           ('application/vnd.rn-rsml',               '.rsml'),
           ('application/vnd.stardivision.calc',               '.sdc'),
           ('application/vnd.stardivision.chart',               '.sds'),
           ('application/vnd.stardivision.draw',               '.sda'),
           ('application/vnd.stardivision.impress',               '.sdd'),
           ('application/vnd.stardivision.impress-packed',               '.sdp'),
           ('application/vnd.stardivision.math',               '.smf'),
           ('application/vnd.stardivision.writer',               '.vor'),
           ('application/vnd.stardivision.writer-global',               '.sgl'),
           ('application/vnd.sun.xml.base',               '.odb'),
           ('application/vnd.sun.xml.calc',               '.sxc'),
           ('application/vnd.sun.xml.draw',               '.sxd'),
           ('application/vnd.sun.xml.impress',               '.sxi'),
           ('application/vnd.sun.xml.math',               '.sxm'),
           ('application/vnd.sun.xml.writer',               '.sxw'),
           ('application/vnd.sun.xml.writer.global',               '.sxg'),
           ('application/vnd.visio',               '.vsd'),
           ('application/x-bittorrent',               '.torrent'),
           ('application/x-bittorrent-app',               '.btapp'),
           ('application/x-bittorrent-appinst',               '.btinstall'),
           ('application/x-bittorrent-key',               '.btkey'),
           ('application/x-bittorrentsearchdescription+xml',               '.btsearch'),
           ('application/x-bittorrent-skin',               '.btskin'),
           ('application/x-bridge-url',               '.adobebridge'),
           ('application/x-cdf',               '.cdf'),
           ('application/x-compressed',               '.tgz'),
           ('application/x-director',               '.dir'),
           ('application/x-internet-signup',               '.ins'),
           ('application/x-iphone',               '.iii'),
           ('application/x-itunes-itls',               '.itls'),
           ('application/x-itunes-itms',               '.itms'),
           ('application/x-itunes-itpc',               '.itpc'),
           ('application/x-java-jnlp-file',               '.jnlp'),
           ('application/x-jtx+xps',               '.jtx'),
           ('application/x-latex',               '.latex'),
           ('application/x-mix-transfer',               '.nix'),
           ('application/x-mpeg',               '.amc'),
           ('application/x-mplayer2',               '.asx'),
           ('application/x-ms-application',               '.application'),
           ('application/x-ms-license',               '.slupkg-ms'),
           ('application/x-mspowerpoint',               '.ppt'),
           ('application/x-mspowerpoint.12',               '.pptx'),
           ('application/x-mspowerpoint.macroEnabled.12',               '.pptm'),
           ('application/x-ms-vsto',               '.vsto'),
           ('application/x-pkcs12',               '.p12'),
           ('application/x-pkcs7-certificates',               '.p7b'),
           ('application/x-pkcs7-certreqresp',               '.p7r'),
           ('application/x-podcast',               '.pcast'),
           ('application/x-psn-dstartup',               '.xpd'),
           ('application/x-psp-dstartup',               '.xpd'),
           ('application/x-quicktimeplayer',               '.qtl'),
           ('application/x-rtsp',               '.rtsp'),
           ('application/x-sdp',               '.sdp'),
           ('application/x-skype',               '.skype'),
           ('application/x-sparc',               '.sparc'),
           ('application/x-starcalc',               '.sdc'),
           ('application/x-starchart',               '.sds'),
           ('application/x-stardraw',               '.sda'),
           ('application/x-starimpress',               '.sdd'),
           ('application/x-starmath',               '.smf'),
           ('application/x-starwriter',               '.sdw'),
           ('application/x-stuffit',               '.sit'),
           ('application/x-tar',               '.tar'),
           ('application/x-troff-man',               '.man'),
           ('application/x-wmplayer',               '.asx'),
           ('application/x-x509-ca-cert',               '.cer'),
           ('audio/3gpp',               '.3gp'),
           ('audio/3gpp2',               '.3g2'),
           ('audio/aac',               '.aac'),
           ('audio/ac3',               '.ac3'),
           ('audio/aiff',               '.aiff'),
           ('audio/AMR',               '.AMR'),
           ('audio/basic',               '.au'),
           ('audio/evrc-qcp',               '.EVRC'),
           ('audio/m4a',               '.m4a'),
           ('audio/mid',               '.mid'),
           ('audio/midi',               '.mid'),
           ('audio/mp3',               '.mp3'),
           ('audio/mp4',               '.mp4'),
           ('audio/mpeg',               '.mp3'),
           ('audio/mpegurl',               '.m3u'),
           ('audio/mpg',               '.mp3'),
           ('audio/qcelp',               '.qcp'),
           ('audio/scpls',               '.pls'),
           ('audio/vnd.dlna.adts',               '.adts'),
           ('audio/vnd.qcelp',               '.qcp'),
           ('audio/vnd.rn-realaudio',               '.ra'),
           ('audio/vnd.rn-realmedia',               '.rm'),
           ('audio/vnd.rn-realpix',               '.rp'),
           ('audio/x.pn-realaudio',               '.ram'),
           ('audio/x-aac',               '.aac'),
           ('audio/x-ac3',               '.ac3'),
           ('audio/x-aiff',               '.aiff'),
           ('audio/x-caf',               '.caf'),
           ('audio/x-gsm',               '.gsm'),
           ('audio/x-m4a',               '.m4a'),
           ('audio/x-m4b',               '.m4b'),
           ('audio/x-m4p',               '.m4p'),
           ('audio/x-mid',               '.mid'),
           ('audio/x-midi',               '.mid'),
           ('audio/x-mp3',               '.mp3'),
           ('audio/x-mpeg',               '.mp3'),
           ('audio/x-mpegurl',               '.m3u'),
           ('audio/x-mpg',               '.mp3'),
           ('audio/x-pn-realaudio',               '.ram'),
           ('audio/x-realaudio',               '.ra'),
           ('audio/x-realaudio-secure',               '.rms'),
           ('audio/x-scpls',               '.pls'),
           ('image/jp2',               '.jp2'),
           ('image/jpeg2000',               '.jp2'),
           ('image/jpeg2000-image',               '.jp2'),
           ('image/pict',               '.pict'),
           ('image/vnd.ms-modi',               '.mdi'),
           ('image/vnd.rn-realpix',               '.rp'),
           ('image/xbm',               '.xbm'),
           ('image/x-jpeg2000-image',               '.jp2'),
           ('image/x-macpaint',               '.pntg'),
           ('image/x-pict',               '.pict'),
           ('image/x-quicktime',               '.qtif'),
           ('image/x-sgi',               '.sgi'),
           ('image/x-targa',               '.targa'),
           ('image/x-tiff',               '.tif'),
           ('image/x-xbitmap',               '.xbm'),
           ('midi/mid',               '.mid'),
           ('model/vnd.dwfx+xps',               '.dwfx'),
           ('model/vnd.easmx+xps',               '.easmx'),
           ('model/vnd.edrwx+xps',               '.edrwx'),
           ('model/vnd.eprtx+xps',               '.eprtx'),
           ('pkcs10',               '.p10'),
           ('pkcs7-mime',               '.p7m'),
           ('pkcs7-signature',               '.p7s'),
           ('pkix-cert',               '.cer'),
           ('pkix-crl',               '.crl'),
           ('text/calendar',               '.ics'),
           ('text/h323',               '.323'),
           ('text/iuls',               '.uls'),
           ('text/vnd.rn-realtext',               '.rt'),
           ('text/vnd-ms.click2record+xml',               '.c2r'),
           ('text/webviewhtml',               '.htt'),
           ('text/x-component',               '.htc'),
           ('text/x-ms-contact',               '.contact'),
           ('text/x-ms-iqy',               '.iqy'),
           ('text/x-ms-odc',               '.odc'),
           ('text/x-ms-rqy',               '.rqy'),
           ('text/x-vcard',               '.vcf'),
           ('video/3gp',               '.3gp'),
           ('video/3gpp',               '.3gp'),
           ('video/3gpp2',               '.3g2'),
           ('video/asx',               '.asx'),
           ('video/avi',               '.avi'),
           ('video/flc',               '.flc'),
           ('video/mp4',               '.mp4'),
           ('video/mpeg',               '.mpg'),
           ('video/mpg',               '.mpg'),
           ('video/msvideo',               '.avi'),
           ('video/quicktime',               '.mov'),
           ('video/sd-video',               '.sdv'),
           ('video/vnd.dlna.mpeg-tts',               '.tts'),
           ('video/vnd.rn-realvideo',               '.rv'),
           ('video/vnd.rn-realvideo-secure',               '.rms'),
           ('video/x-asx',               '.asx'),
           ('video/x-ivf',               '.IVF'),
           ('video/x-m4v',               '.m4v'),
           ('video/x-mpeg',               '.mpg'),
           ('video/x-mpeg2a',               '.mpg'),
           ('video/x-ms-asf',               '.asx'),
           ('video/x-ms-asf-plugin',               '.asx'),
           ('video/x-msvideo',               '.avi'),
           ('video/x-ms-wmv',               '.wmv'),
           ('vnd.ms-pki.certstore',               '.sst'),
           ('vnd.ms-pki.pko',               '.pko'),
           ('vnd.ms-pki.seccat',               '.cat'),
           ('vnd.ms-pki.stl',               '.stl'),
           ('x-pkcs12',               '.p12'),
           ('x-pkcs7-certificates',               '.p7b'),
           ('x-pkcs7-certreqresp',               '.p7r'),
           ('x-x509-ca-cert',               '.cer')




         );
         
         contenttypescount2=7;
         contenttypes2:array[1..contenttypescount2,1..2]of string
       =(   //lowercase strings
           // unsure:
           ('text/plain',                        '.txt'),
           ('plain/text',                        '.txt'),
           ('text',                              '.txt'),

           //('application/octet-stream',          '.???'), //usualy .js
           //('message/delivery-status',           '.???'), //not a file but extra header lines (e.a. in returned mail)
           //('message/rfc822',                    '.???'), //not a file but extra header lines (e.a. in returned mail)
           //('audio/basic',                       '.js'), //I'm confused, .jpg file had this ContentType mark
           //('application/x-msdownload',          '.???'), //.exe usualy

           ('application/x-unknown-content-type-WinRAR','.rar'), //not 100% sure

            //('application/force-download',        '.zip'), //???

           ('text/xml',                          '.xml'),  //can be html
           ('application/xml',                   '.xml'),  //can be html
           ('application/x-multiplan',           '.wma')  //???
         );
         
{
multipart/report
multipart/mixed
unknown/unknown
Message/Delivery-Status
Text/RFC822-headers
}








         
     //unhandled .mht (or .eml) header commands, usualy from e-mails.
     //checked only to find if header is over.
     //not needed any more???
{     OtherHeaderCommandsCounter=322;
     OtherHeaderCommands:array[1..OtherHeaderCommandsCounter]of string
              = (
                  '(authenticated bits=',
                  '(authenticated user',
                  '(version=',
                  '(envelope-from',
                  '(exim',
                  '(for',
                  '((iPlanet Messaging Server)) id',
                  '(jaw authenticated user',
                  '(mdaemon',
                  '(not processed:',
                  '(original mail from',
                  '(peer crosscheck:',
                  '(return-path',
                  '(smtpd',
                  '(squirrelmail authenticated user',
                  'a=',
                  'allow=all',
                  'authentication-results:',
                  'auth-sender:',
                  'b=',
                  'bcc:',
                  'bh=',
                  'bounces-to:',
                  'by ',
                  'c=',
                  'cc:',
                  'cg_sih_inv=',
                  'cg_sih=',
                  'cg_siu_inv=',
                  'cg_siu=',
                  'cg_siw_inv=',
                  'cg_siw=',
                  'comment:',
                  'complaints-to:',
                  'content analysis details:',
                  'content preview:',
                  'content-class:',
                  'content-description:',
                  'content-disposition:',
                  'content-language:',
                  'content-length:',
                  'content-transfer-encoding:',
                  'content-type:',
                  'd=',
                  'date:',
                  'delivered-to:',
                  'delivery-date:',
                  'delsp=',
                  'dkim-signature:',
                  'domainkeys=',
                  'domainkey-signature:',
                  'domainkey-status:',
                  'envelope-from:',
                  'envelope-to:',
                  'errors-to:',
                  'for ',
                  'format="flowed"',
                  'format=flowed',
                  'format=flowed;',
                  'fri,',
                  'from:',
                  'from=',
                  'h=',
                  'hih=',
                  'hiu=',
                  'hiw=',
                  'id ',
                  'in-reply-to:',
                  'injection-info:',
                  'lines:',
                  'list-id:',
                  'list-unsubscribe:',
                  'livewords=',
                  'mailing-list:',
                  'message-id:',
                  'mime-version:',
                  'mon,',
                  'name=',
                  'newsgroups:',
                  'nntp-posting-date:',
                  'nntp-posting-host:',
                  'organization:',
                  'path:',
                  'posting-account=',
                  'posting-host=',
                  'precedence:',
                  'q=',
                  'received:',
                  'received-spf:',
                  'references:',
                  'reply-to:',
                  'reply-type=',
                  'reportspam=',
                  'resent-date:',
                  'resent-from:',
                  'resent-message-id:',
                  'resent-sender:',
                  'return-path:',
                  's=',
                  'sat,',
                  'sender:',
                  'sih=',
                  'siu=',
                  'siw=',
                  'smtp-auth:',
                  'spf=',
                  'status:',
                  'subject:',
                  'sun,',
                  'thread-index:',
                  'thread-topic:',
                  'thu,',
                  'to:',
                  'tue,',
                  'user-agent:',
                  'via smtpd',
                  'wed,',
                  'with esmtp',
                  'with smtp',
                  'x-abuse:',
                  'x-accept-language:',
                  'x-ad:',
                  'x-adf:',
                  'x-amazon-client-host:',
                  'x-amazon-client-sendtime:',
                  'x-amazon-corporate-relay:',
                  'x-amazon-mail-relay-type:',
                  'x-amazon-rte-version:',
                  'x-amazon-track:',
                  'x-an:',
                  'x-anf:',
                  'x-antiabuse:',
                  'x-antivirus:',
                  'x-antivirus-scanner:',
                  'x-antivirus-status:',
                  'x-aol-ip:',
                  'x-ap:',
                  'x-apf:',
                  'x-apparently-to:',
                  'x-ash:',
                  'x-ashf:',
                  'x-asn:',
                  'x-asnf:',
                  'x-auditid:',
                  'x-authenticated-sender:',
                  'x-authentication-warning:',
                  'x-auto:',
                  'x-batch-number:',
                  'x-bg:',
                  'x-bgc:',
                  'x-bgpx:',
                  'x-bgpy:',
                  'x-bgt:',
                  'x-bogosity:',
                  'x-brightmail-tracker:',
                  'x-clientaddr:',
                  'x-cnt:',
                  'x-complaints-to:',
                  'x-egroups-msg-info:',
                  'x-elnk-trace:',
                  'x-escm-mailfrom:',
                  'x-esmtp: 0 0 1',
                  'x-extensions:',
                  'x-fcat:',
                  'x-fcol:',
                  'x-fdis:',
                  'x-fid:',
                  'x-fit:',
                  'x-fver:',
                  'x-gmail-received:',
                  'x-google-adsense-creation-method:',
                  'x-google-adsense-message:',
                  'x-google-sender-auth:',
                  'x-header:',
                  'x-http-useragent:',
                  'x-info:',
                  'x-library:',
                  'x-log-id:',
                  'x-loop:',
                  'x-lyris-type:',
                  'x-mailing-list:',
                  'x-mailscanner:',
                  'x-mailscanner-from:',
                  'x-mailscanner-spamscore:',
                  'x-mb-message-source:',
                  'x-mb-message-type:',
                  'x-mdaemon-deliver-to:',
                  'x-mdav-processed:',
                  'x-message-info:',
                  'x-me-uuid:',
                  'x-mime-autoconverted:',
                  'x-mimeole:',
                  'x-msmail-priority:',
                  'x-nas-bayes:',
                  'x-nas-bwl:',
                  'x-nas-classification:',
                  'x-nas-language:',
                  'x-nas-messageid:',
                  'x-nas-validation:',
                  'x-neobee-spam-score:',
                  'x-newsreader:',
                  'x-nortonav-timeoutprotection:',
                  'x-originalarrivaltime:',
                  'x-original-to:',
                  'x-originating-email:',
                  'x-originating-ip:',
                  'x-originating-site:',
                  'x-pmg-msgid:',
                  'x-pmg-recipient:',
                  'x-pmg-userid:',
                  'x-ppaccount:',
                  'x-ppdownloaddate:',
                  'x-ppdownloadtimestamp:',
                  'x-ppremotemessagenumber:',
                  'x-ppsource-mbox:',
                  'x-ppuidl:',
                  'x-ppvia:',
                  'x-priority:',
                  'x-provags-id:',
                  'x-rfc2646:',
                  'x-return-path:',
                  'x-rocketnr:',
                  'x-rocketrt:',
                  'x-rocket-spam:',
                  'x-rocketsrv:',
                  'x-rockettip:',
                  'x-rocketymumid:',
                  'x-sbb-mailscanner:',
                  'x-sbb-mailscanner-information:',
                  'x-sbb-spam-level:',
                  'x-sbb-spam-score:',
                  'x-sbb-virus-status:',
                  'x-scanned-by:',
                  'x-sender:',
                  'x-senderip:',
                  'x-sensitivity:',
                  'x-sent:',
                  'x-sieve:',
                  'x-smtp-vilter-version:',
                  'x-source:',
                  'x-source-args:',
                  'x-source-dir:',
                  'x-spam:',
                  'x-spam-flag:',
                  'x-spam-processed:',
                  'x-spam-report:',
                  'x-spam-score:',
                  'x-spam-status:',
                  'x-spf-guess:',
                  'x-status:',
                  'x-symantec-timeoutprotection:',
                  'x-type:',
                  'x-trace:',
                  'x-uidl:',
                  'x-unsent:',
                  'x-virus:',
                  'x-virus-scanned:',
                  'x-virus-status:',
                  'x-xam3-api-version:',
                  'x-yahoofilteredbulk:',
                  'x-yahoo-newman-property:',
                  'x-yahoo-post-ip:',
                  'x-yahoo-profile:',
                  'x-ymail-osg:',
                  'x-ypops-folder:',
                  'x-yubc.net-mailscanner:',
                  'x-yubc.net-mailscanner-information:',
                  'xref:',
                  'yahoo',
                  
                  'autolearn',
                  'auto-submitted:',
                  'contact',
                  'content-encoding:',
                  'followup-to:',
                  'original',
                  'report-type',
                  'sbc=',
                  'x-account-key:',
                  'x-campaignid:',
                  'x-egroups-application:',
                  'x-entireweb-tag:',
                  'x-eon-dm:',
                  'x-eon-sig:',
                  'x-greylist:',
                  'x-http-via:',
                  'x-kaspersky:',
                  'x-mailman-version:',
                  'x-mozilla-keys:',
                  'x-nas-autoblock-code:',
                  'x-nas-autoblock-description:',
                  'x-original-bytes:',
                  'x-popbeforesmtpsenders:',
                  'x-server:',
                  'x-spam-checker-version:',
                  'x-spam-level:',
                  'x-yahoo-newman-id:',

                  'received:',
                  'X-Entireweb-Orig:',
                  'X-Envelope-From:',
                  'X-MDRemoteIP:',
                  
                  
                  'x-entireweb-orig:',
                  'x-envelope-from:',
                  'x-keywords:',
                  'x-mdremoteip:',
                  'x-shopcentar-mailscanner:',
                  'x-shopcentar-mailscanner-information:',
                  'x-shopcentar-mailscanner-spamcheck:',

                  '(authid:',
                  'x-avas-spam-score:',
                  'x-avas-spam-symbols:',
                  'x-avas-virus-status:',
                  'x-beenthere:',
                  'x-identified-user:',
                  'x-kav_disinfected:',
                  'x-list-administrivia:',
                  'x-senderid:',
                  'x-spam-checker:',
                  'x-version:',
                  'x-virus-scan:',
                  'x-yubc-mailscanner:',
                  'x-yubc-mailscanner-from:',
                  'X-yubc-mailscanner-information:'
                  
         );    }
         
     deletetagcount=1;
     deletetag:array[1..deletetagcount,1..2]of string

       =(
           ('<base href',           '/>')
         );


     //HTML and CSS strings
     HTMLCSSStringsCounter=14;
     HTMLCSSStrings:array[1..HTMLCSSStringsCounter]of string
       = (
       'style="border: 12px dotted #fff; padding:27px; margin: 5px; background: url(data:image/gif;base64,R0lGODlhKwArAIAAAP7s7P/4+CH5BAAAAAAALAAAAAArACsAAALCDI6pGu0PI2irMhMzPM7aPmkZ8ngXxYkluZobq57g98KjPONoolW9vuPVgEERLUhExWguldPV/C19Bo/RNhQitdmQZPEFh4HiMbZ6zHlvXLS1tf7ZTNyz3Es/pZyzbZ7CZ5ZXFrhReDdIsncYkihkd6VGl1M4NwgXxxb3h5mJKdjmBkkouViaSSWIWJc6dsWU9jXlCFn59mY0KxNb86rTmrXqKToMvKWr+Rvq2oWzzNZMWHvTiWsaiEcLeAj6R5sUWAAAOw==); background-color: #fdacaf;"',
       'style="border: 10px dashed #fff; padding:45px 0px; margin: 5px; background: url(data:image/gif;base64,R0lGODlhHgAeAIAAAJb/n7z/wyH5BAAAAAAALAAAAAAeAB4AAAIyjI+pAe29YnxOWkTB3ebxD4biSJbmiaJemqmZZr5wKZ+1TaVMpff+DwwKh65ey5WLvQoAOw==); BACKGROUND-COLOR: #9fd5ff;"',
       //'style="border: 10px dashed #fff; padding:45px 0px; margin: 5px; background: url(data:image/gif;base64,R0lGODlhHwAXAJEAAIfDh/j7+NTs1K7criH5BAAAAAAALAAAAAAfABcAAAJhTAYSwO3vDBsrVoiZQpmKnAUfmFwkI51Aem4qOoLeO4mkTWtHaObuw8o1DBzUTmixUQw932KJwwkpxYcCuWpahFfS7EVVdVXSU5AnPFu13rLjxz2+5Uh4if1S2PRfJHVZAAA7); BACKGROUND-COLOR: #9fd5ff;"',
       'style="background-color: #fff; color: #f00; font-size: 170%; border: 2px solid #4cae50; padding: 10px 20px; text-align: center; text-shadow: 2px 2px 2px #777; margin-left: 20px;"',
       'style="background-color: #f3e198; margin-top: 5px; border-top: 2px solid #D1C076; padding: 5px;"',
       'style="background-color: #bdf4e8; border-top: 2px solid #9bd2c6; border-bottom: 2px solid #9bd2c6; padding: 5px;"',
       'style="background-color: #bfb9da; margin-top: 5px; border-top: 2px solid #9d97b8; padding: 5px;"',
       'style="background-color: #bfb9da; border-top: 2px solid #9d97b8; padding: 5px;"',
       'style="background-color: #d4ffd3; margin-top: 5px; border-top: 2px solid #b2ddb1; border-bottom: 2px solid #b2ddb1; padding: 5px;"',
       'style="background-color: #fdfbd1; margin-top: 5px; border-top: 2px solid #dbd9af; padding: 5px;"',
       'style="background-color: #fdfbd1; border-top: 2px solid #dbd9af; padding: 5px;"',
       'style="background-color: #fdfce8; border-top: 2px solid #dbd9af; border-bottom: 2px solid #dbd9af; padding: 5px;"',
       'style="background-color: #d0f8fb; margin-top: 5px; border-top: 2px solid #aed6d9; padding: 5px;"',
       'style="background-color: #d0f8fb; border-top: 2px solid #aed6d9; padding: 5px;"',
       'style="background-color: #e3f9fb; border-top: 2px solid #aed6d9; border-bottom: 2px solid #aed6d9; padding: 5px;"'
        );

implementation

end.

