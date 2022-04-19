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
unit languages;

{$mode objfpc}{$H+}

interface



const
  language_count=1;
    //language 0=Englishi i:=0;
  language_encoding:array[0..language_count]of integer=
  (
  0,  //ANSI_CHARSET
  238 //EASTEUROPE_CHARSET
  );
  language_strings:array[0..language_count,1..169]of string=
  ((  //[0,xx]
  'Files to convert:', //[i,1]Files to convert:
  'Converted files:',  //[i,2]Converted files:
  'File',              //[i,3]File
  'Size',              //[i,4]Size
  'Directory',         //[i,5]Dir
  'MHT file',          //[i,6]MHT file
  'HTM file',          //[i,7]HTM file
  'of',                //[i,8]of (in 0 of 0 .mht file(s))
  '.mht files',        //[i,9].mht files
  'files',             //[i,10]files
  'Estimated time',    //[i,11]Estimated time
  'passed',            //[i,12]passed
  'remaining',         //[i,13]remaining
  '...wait...',        //[i,14]...wait...
  'Options',           //[i,15]Options
  'Level 0 of address correcting (none)',    //[i,16]Level 0 of address correcting (none)
  'Level 1 of address correcting (fast)',    //[i,17]Level 1 of address correcting (fast)
  'Level 2 of address correcting (balanced)',//[i,18]Level 2 of address correcting (balanced)
  'Level 3 of address correcting (good)',    //[i,19]Level 3 of address correcting (good)
  'Level 4 of address correcting (best)',    //[i,20]Level 4 of address correcting (best)
  '***reserved***',    //[i,21]
  '***reserved***',    //[i,22]
  '***reserved***',    //[i,23]
  'Create mega.nfo',                   //[i,24]Create mega.nfo
  '&Add files',                   //[i,25]Add .mht files
  '&Remove from list',                    //[i,26]Remove from list
  '&Start',                   //[i,27]Start
  '&Stop',                    //[i,28]Stop
  '&Pause',                   //[i,29]Pause
  '&Continue',                    //[i,30]Continue
  '&History',                   //[i,31]History
  '&Back',                   //[i,32]Back
  '&Help',                   //[i,33]Help
  'done',                   //[i,34]done
  'paused',                   //[i,35]paused
  '&Output dir',                    //[i,36]Output dir
  'use same directory as .mht file',                   //[i,37]use same directory as .mht file
  'Site ',                    //[i,38]Site+space
  'Coder:',                   //[i,39]Coder
  'Planer: v',                    //[i,40]Planer v
  'Coded with Lazarus',                   //[i,41]Coded with Lazarus
  'quoted-printable = text file',                   //[i,42]quoted-printable = text bile
  'base64 = binary file',                   //[i,43]base64 = binary file

  'Total',                   //[i,44]Total
  'files',                   //[i,45]files
  'Generated with',                    //[i,46]Generated with
  'Author',                   //[i,47]Author
  'Check for new version',                    //[i,48]Check for new version
  'Click here to open page',                   //[i,49]Click here to open page
  'Files original locations',                    //[i,50]Files original locations
  'Original location\name',                   //[i,51]Original location\name
  'File type',                   //[i,52]File type
  'New location\name',                   //[i,53]New location\name
  'Encoding',                   //[i,54]Encoding

  'Click here to add mht files to list.',                   //[i,55]Click here to add mht files to list.
  'Click here to remove selected mht file from list.',                   //[i,56]Click here to remove selected mht file from list.
  'Convert all files from list.',                   //[i,57]Convert all files from list.
  'Convert rest of files from list.',                   //[i,58]Convert rest of files from list.
  'Stop conversion (current file will be finished).',                   //[i,59]Stop conversion (current file will be finished).
  'Pause conversion (current file will be finished, do not affect mega.nfo).',                   //[i,60]Pause conversion (current file will be finished, do not affect mega.nfo).
  'Show list of converted files.',                   //[i,61]Show list of converted files.
  'Show list of files not yet converted.',                   //[i,62]Show list of files not yet converted.
  'Open help page.',                   //[i,63]Open help page.
  'Enter oputput dir (for all files). Or select one using button to the right.',                   //[i,64]Enter oputput dir (for all files). Or select one using button to the right.
  'Select oputput dir (for all files).',                   //[i,65]Select oputput dir (for all files).
  'Check if you want to store in same dir(s) where mht files are.',                    //[i,66]Check if you want to store in same dir(s) where mht files are.
  'Visit mht2htm homepage.',                   //[i,67]Visit mht2htm homepage.
  'Send me mail.',                   //[i,68]Send me mail.
  'Visit Lazarus homepage.',                   //[i,69]Visit Lazarus homepage.
  'List of converted files. Right mouse button for pop-up menu.',                   //[i,70]List of converted files. Right mouse button for pop-up menu.
  'List of files to convert.',                   //[i,71]List of files to convert.
  'Select how hard will mht2htm try to replace addresses with local ones. 0=do not try. 4=very hard.',                   //[i,72]How hard will mht2htm try to replace addresses with local ones. 0=do not try. 4=very hard.
  'Create mega.nfo file with all addresses from all files (for use in other programs, usualy with address correcting set to 0).',                   //[i,73]Create mega.nfo file with all addresses from all files (for use in other programs, usualy with address correcting set to 0).
  'Language/Jezik/...',                   //[i,74]Language/Jezik/... **should contain in all languages
  'bytes',                   //[i,75]bytes
  'Open HTM file',                   //[i,76]Open HTM file
  'Open MHT file',                   //[i,77]Open MHT file
  'Open HTM dir',                    //[i,78]Open HTM dir
  'Close History',                    //[i,79]Close History
  'Select browser',                   //[i,80]Select browser

  'Not a real file but header for two or more alternative content formats',                   //[i,81]Not a real file but header for two or more alternative content formats
  'EZ Save MHT (an IE add-on)',                   //[i,82]EZ Save MHT (an IE add-on)
  'MAF MHT Archive Handler (an Mozilla add-on)',                   //[i,83]MAF MHT Archive Handler (an Mozilla add-on)
  'Microsoft Internet Explorer',                   //[i,84]Microsoft Internet Explorer
  'SavePage (command line MHT creator)',                   //[i,85]SavePage (command line MHT creator)
  'Opera (maybe)',                   //[i,86]Opera (maybe)
  'html2mhtml (open source MHT creator)',                   //[i,87]html2mhtml (open source MHT creator)
  '(not sure)',                   //[i,88](not sure)
  'mht2htm program version is',                   //[i,89]mht2htm program version is
  'Converted on',                   //[i,90]Converted on
  'MHT file saved on',                   //[i,91]MHT file saved on
  'MHT file created with',                   //[i,92]MHT file created with
  'MHT file size is',                   //[i,93]MHT file size is
  'bytes',                   //[i,94]bytes
  'MHT file contains',                   //[i,95]MHT file contains
  'parts',                   //[i,96]parts
  'of that are files',                   //[i,97]of that are files
  ': not a file',                   //[i,98]: not a file
  'converted for',                   //[i,99]converted for
  'seconds',                   //[i,100]seconds


  'Detailed:',                   //[i,101]Detailed:
  'MHT file:',                   //[i,102]MHT file:
  'From:',                   //[i,103]From:
  'Subject:',                   //[i,104]Subject:
  'Date:',                   //[i,105]Date:
  'Importance:',                   //[i,106]Importance:
  'Priority:',                   //[i,107]Priority:
  'Content-Type:',                   //[i,108]Content-Type:
  'Type:',                   //[i,109]Type:
  'MIME-Version:',                   //[i,110]MIME-Version:
  'start (file):',                   //[i,111]start (file):
  'Content-Location:',                   //[i,112]Content-Location:
  'Content-Transfer-Encoding:',                   //[i,113]Content-Transfer-Encoding:
  'Charset:',                   //[i,114]Charset:
  'Product:',                   //[i,115]Product:
  'X-MAF:',                   //[i,116]X-MAF:
  'X-MIME:',                   //[i,117]X-MIME:
  'thread_index:',                   //[i,118]thread_index:
  'Content-Class:',                   //[i,119]Content-Class:
  'Parts',                   //[i,120]Parts
  'Boundary ',                   //[i,121]Boundary


  'Part ',                   //[i,122] Part_
  'Content-Type:',                   //[i,123] Content-Type:

  'Charset:',                   //[i,124] Charset:
  'Content-Transfer-Encoding:',                   //[i,125] Content-Transfer-Encoding:
  'Content-Location:',                   //[i,126] Content-Location:
  'Content-ID:',                   //[i,127] Content-ID:
  'Content-Disposition:',                   //[i,128] Content-Disposition:
  'Filename:',                   //[i,129] Filename:
  'Name:',                   //[i,130] Name:
  'Start line:',                   //[i,131] Start line:
  'End line:',                   //[i,132] End line:
  'Alternative:',                   //[i,133] Alternative:

  'Internal data:',                   //[i,134] Internal data:
  'Absolute (full) path:',                   //[i,135] Absolute (full) path:
  'Unchanged filename:',                   //[i,136] Unchanged filename:
  'Saved as (local filename):',                   //[i,137] Saved as (local filename):
  'Encoding:',                   //[i,138] Encoding:
  'Recognized as:',                   //[i,139] Recognized as:
  'File final extension:',                   //[i,140] File final extension:
  'File size:',                   //[i,141] File size:
  'Open this file for preview:',                   //[i,142] Open this file for preview:
  'here',                   //[i,143] here
  'or',                   //[i,144] or
  'in new tab/window',                   //[i,145] in new tab/window

  'Select how much details about mht file will mht2htm write. 1=few, 3=lot.',                   //[i,146]Select how much details about mht file will mht2htm write. 1=few, 3=lot.

  'Directory exists!',                   //[i,147]Directory exists!
  'Target directory already exists and will not be overwriten.'+chr(13)+'To continue remove target dir or mht file from list and press Start again',                   //[i,148]Target directory already exists and will not be overwriten.'+chr(13)+'To continue remove target dir or mht file from list and press Start again

  'Detail level 1 (low)',                   //[i,149]Detail level 1 (low)
  'Detail level 2 (medium)',                   //[i,150]Detail level 2 (medium)
  'Detail level 3 (high)',                   //[i,151]Detail level 3 (high)
  'ERROR - Structure of this mht file is not good.', //[i,152]Structure of this mht file is not good.
  'File not found. If you know that file exists try to rename it. ', //[i,153]File not found. If you know that file exists try to rename it.
  'Add folder', //[i,154]
  'Find all mht files in selected folder and all subfolders and add them to list', //[i,155]
  '&OK', //[i,156]
  '&Cancel', //[i,157]
  'Filter', //[i,158]
  'Select all files from folder (including all subfolders) matching filter. Use single filter at time.', //[i,158]
  'en',  //[i,160]en country code, used for help
  'recursively search sub directories', // [i,161] recursively search sub directories
  'Add files', // [i,162] Add files
  'Do you wish to add ', // [i,163] Do you wish to add
  ' files to the list?', // [i,164] files to the list?
  'File/Directory creation error', // [i,165] File/Directory creation error
  'mht2htm didn''t succeed to create target file or directory. Please check if you have sufficient permissions over target directory.', // [i,166] mht2htm didn''t succeed to create target file or directory. Please check if you have sufficient permissions over target directory.
  'Invalid date format', // [i,167] Invalid date format
  'ERROR - can''t create ouptut directory!', // [i,168] ERROR - can''t create ouptut directory!
  ' files couldn''t be processed. Errors can be found in History list.' // [i,169] files couldn''t be processed. Errors can be found in History list.
  ),
  ( //[1,xx]

    //language 1=Srpski    i:=1;

  'Fajlovi da se konvertuju:',                   //[i,1]Files to convert:
  'Konvertovani fajlovi:',                    //[i,2]Converted files:
  'Fajl',                   //[i,3]File
  'Velicina',                    //[i,4]Size
  'Direktorijum',                   //[i,5]Dir
  'MHT fajl',                    //[i,6]MHT file
  'HTM fajl',                   //[i,7]HTM file
  'od',                   //[i,8]of (in 0 of 0 .mht file(s))
  '.mht fajlova',                    //[i,9].mht files
  'fajlova',                   //[i,10]files
  'Procenjeno vreme',                   //[i,11]Estimated time
  'proteklo',                    //[i,12]passed
  'preostalo',                   //[i,13]remaining
  '...cekaj...',                   //[i,14]...wait...
  'Podesavanja',                   //[i,15]Options
  'Nivo 0 korekcije adresa (nikakva)',                    //[i,16]Level 0 of address correcting (none)
  'Nivo 1 korekcije adresa (brza)',                   //[i,17]Level 1 of address correcting (fast)
  'Nivo 2 korekcije adresa (umerena)',                   //[i,18]Level 2 of address correcting (balanced)
  'Nivo 3 korekcije adresa (dobra)',                    //[i,19]Level 3 of address correcting (good)
  'Nivo 4 korekcije adresa (najbolja)',                   //[i,20]Level 4 of address correcting (best)
  '***reserved***',                   //[i,21]
  '***reserved***',                   //[i,22]
  '***reserved***',                   //[i,23]
  'Napravi mega.nfo',                   //[i,24]Create mega.nfo
  '&Dodaj fajlove',                   //[i,25]Add .mht files
  '&Ukloni iz liste',                    //[i,26]Remove from list
  '&Start',                   //[i,27]Start
  '&Stop',                    //[i,28]Stop
  '&Pauza',                   //[i,29]Pause
  '&Nastavi',                    //[i,30]Continue
  '&Konvertovano',                   //[i,31]History
  'Na&zad',                   //[i,32]Back
  'P&omoc',                   //[i,33]Help
  'gotovo',                   //[i,34]done
  'pauza',                   //[i,35]paused
  '&Ciljni dir',                    //[i,36]Output dir
  'snimi u direktorijum gde je .mht fajl',                   //[i,37]use same directory as .mht file
  'Sajt ',                    //[i,38]Site+space
  'Koder:',                   //[i,39]Coder
  'Planer: v',                    //[i,40]Planer v
  'Kodirano Lazarusom',                   //[i,41]Coded with Lazarus
  'quoted-printable = tekst fajl',                   //[i,42]quoted-printable = text file
  'base64 = binarni fajl',                   //[i,43]base64 = binary file

  'Ukupno',                   //[i,44]Total
  'fajlova',                   //[i,45]files
  'Generisano pomocu',                    //[i,46]Generated with
  'Autor',                   //[i,47]Author
  'Potrazi novu verziju',                    //[i,48]Check for new version
  'Pritisni ovde da otvoris stranu',                   //[i,49]Click here to open page
  'Originalna lokacija fajlova',                    //[i,50]Files original locations
  'Originalna lokacija\ime',                   //[i,51]Original location\name
  'Tip fajla',                   //[i,52]File type
  'Nova lokacija\ime',                   //[i,53]New location\name
  'Vrsta kodiranja',                   //[i,54]Encoding

  'Pritisni ovde da dodas mht fajlove u listu.',                   //[i,55]Click here to add mht files to list.
  'Pritisni ovde da uklonis oznaceni mht fajl iz liste.',                   //[i,56]Click here to remove selected mht file from list.
  'Konvertuj sve fajlove iz liste.',                   //[i,57]Convert all files from list.
  'Konvertuj preostale fajlove iz liste.',                   //[i,58]Convert rest of files from list.
  'Prekini konverziju (zapoceti fajl ce da bude dovrsen).',                   //[i,59]Stop conversion (current file will be finished).
  'Pauziraj konverziju (zapoceti fajl ce da bude dovrsen, ne utice na mega.nfo).',                   //[i,60]Pause conversion (current file will be finished, do not affect mega.nfo).
  'Prikazi listu konvertovanih fajlova.',                   //[i,61]Show list of converted files.
  'Prikazi listu fajlova koji jos nisu konvertovani.',                   //[i,62]Show list of files not yet converted.
  'Otvori pomoc.',                   //[i,63]Open help page.
  'Unesi ciljni direktorijum (za sve fajlove). Ili odaveri jedan preko dugmeta sa desne strane.',                   //[i,64]Enter oputput dir (for all files). Or select one using button to the right.
  'Odaberi ciljni direktorijum (za sve fajlove).',                   //[i,65]Select oputput dir (for all files).
  'Oznaci ovo ako zelis da se svi fajlovi smestaju u isti direktorijum gde su i mht fajlovi.',                    //[i,66]Check if you want to store in same dir(s) where mht files are.
  'Poseti mht2htm stranu na Internetu.',                   //[i,67]Visit mht2htm homepage.
  'Posalji mi mail.',                   //[i,68]Send me mail.
  'Poseti Lazarus stranu na Internetu.',                   //[i,69]Visit Lazarus homepage.
  'Lista konvertovanih fajlova. Desno dugme misa za pop-up meni.',                   //[i,70]List of converted files. Right mouse button for pop-up menu.
  'Lista fajlova koji treba da se konvertuju.',                   //[i,71]List of files to convert.
  'Odaberi koliko ce mht2htm da se trudi da zameni adrese relativnim adresama. 0=ne zamenjuje ih. 4=trudi se iz sve snage.',                   //[i,72]How hard will mht2htm try to replace addresses with local ones. 0=do not try. 4=very hard.
  'Kreira mega.nfo fajl sa svim adresama iz svih fajlova (za upotrebu sa drugim programima, obicno uz korekciju adresa na nuli).',                   //[i,73]Create mega.nfo file with all addresses from all files (for use in other programs, usualy with address correcting set to 0).
  'Language/Jezik/...',                   //[i,74]Language/Jezik/... **should contain in all languages
  'bajtova',                   //[i,75]bytes

  'Otvori HTM fajl',                   //[i,76]Open HTM file
  'Otvori MHT fajl',                   //[i,77]Open MHT file
  'Otvori HTM dir',                    //[i,78]Open HTM dir
  'Nazad',                    //[i,79]Close History
  'Pregledac',                   //[i,80]Select browser

  'Nije pravi fajl nego zaglavlje dve ili vise alternativnih formata sadrzaja',                   //[i,81]Not a real file but header for two or more alternative content formats
  'EZ Save MHT (IE dodatak)',                   //[i,82]EZ Save MHT (an IE add-on)
  'MAF MHT Archive Handler (Mozilla dodatak)',                   //[i,83]MAF MHT Archive Handler (an Mozilla add-on)
  'Microsoft Internet Explorer',                   //[i,84]Microsoft Internet Explorer
  'SavePage (program za snimanje MHT fajlova iz komandne linije)',                   //[i,85]SavePage (command line MHT creator)
  'Opera (mozda)',                   //[i,86]Opera (maybe)
  'html2mhtml (open source program za snimanje MHT fajlova)',                   //[i,87]html2mhtml (open source MHT creator)
  '(nije sigurno)',                   //[i,88](not sure)
  'verzija mht2htm programa je',                   //[i,89]mht2htm program version is
  'Konvertovano',                   //[i,90]Converted on
  'MHT fajl snimljen',                   //[i,91]MHT file saved on
  'MHT fajl snimljen programom',                   //[i,92]MHT file created with
  'Velicina MHT fajla je',                   //[i,93]MHT file size is
  'bajtova',                   //[i,94]bytes
  'MHT fajl sadrzi',                   //[i,95]MHT file contains
  'delova',                   //[i,96]parts
  'od toga su fajlovi',                   //[i,97]of that are files
  ': nije fajl',                   //[i,98]: not a file
  'konvertovano za',                   //[i,99]converted for
  'sekundi',                   //[i,100]seconds


  'Detaljnije:',                   //[i,101]Detailed:
  'MHT file:',                   //[i,102]MHT file:
  'From:',                   //[i,103]From:
  'Subject:',                   //[i,104]Subject:
  'Date:',                   //[i,105]Date:
  'Importance:',                   //[i,106]Importance:
  'Priority:',                   //[i,107]Priority:
  'Content-Type:',                   //[i,108]Content-Type:
  'Type:',                   //[i,109]Type:
  'MIME-Version:',                   //[i,110]MIME-Version:
  'startni fajl:',                   //[i,111]start (file):
  'Content-Location:',                   //[i,112]Content-Location:
  'Content-Transfer-Encoding:',                   //[i,113]Content-Transfer-Encoding:
  'Charset:',                   //[i,114]Charset:
  'Product:',                   //[i,115]Product:
  'X-MAF:',                   //[i,116]X-MAF:
  'X-MIME:',                   //[i,117]X-MIME:
  'thread_index:',                   //[i,118]thread_index:
  'Content-Class:',                   //[i,119]Content-Class:
  'Delova',                   //[i,120]Parts
  'Boundary ',                   //[i,121]Boundary


  'Deo ',                   //[i,122] Part_
  'Content-Type:',                   //[i,123] Content-Type:

  'Charset:',                   //[i,124] Charset:
  'Content-Transfer-Encoding:',                   //[i,125] Content-Transfer-Encoding:
  'Content-Location:',                   //[i,126] Content-Location:
  'Content-ID:',                   //[i,127] Content-ID:
  'Content-Disposition:',                   //[i,128] Content-Disposition:
  'Filename:',                   //[i,129] Filename:
  'Name:',                   //[i,130] Name:
  'Pocetna linija:',                   //[i,131] Start line:
  'Krajnja linija:',                   //[i,132] End line:
  'Alternative:',                   //[i,133] Alternative:

  'Interni podaci:',                   //[i,134] Internal data:
  'Apsoluna (puna) putanja:',                   //[i,135] Absolute (full) path:
  'Nepromenjeno ime fajla:',                   //[i,136] Unchanged filename:
  'Snimljeno kao (lokalno ime fajla):',                   //[i,137] Saved as (local filename):
  'Vrsta kodiranja:',                   //[i,138] Encoding:
  'Prepoznato kao:',                   //[i,139] Recognized as:
  'Konacna ekstenzija fajla:',                   //[i,140] File final extension:
  'Velicina fajla:',                   //[i,141] File size:
  'Ovori fajl za pregled:',                   //[i,142] Open this file for preview:
  'ovde',                   //[i,143] here
  'ili',                   //[i,144] or
  'u novom tabulatoru/prozoru',                   //[i,145] in new tab/window

  'Odredi koliko detalja o mht fajlu ce da bude prikazano. 1=malo, 3=mnogo.',                   //[i,146]Select how much details about mht file will mht2htm write. 1=few, 3=lot.
  'Direktorijum postoji!',                   //[i,147]Directory exists!
  'Ciljni direktorijum vec postoji i program nece da pise preko njega.'+chr(13)+'Za nastavak je potrebno da se ukloni ciljni direktorijum'+chr(13)+'ili mht fajl iz liste i pritisne Start',                   //[i,148]Target directory already exists and will not be overwriten.'+chr(13)+'To continue remove target dir or mht file from list and press Start again

  'Nivo detalja 1 (nizak)',                   //[i,149]Detail level 1 (low)
  'Nivo detalja 2 (srednji)',                   //[i,150]Detail level 2 (medium)
  'Nivo detalja 3 (visok)',                   //[i,151]Detail level 3 (high)
  'GRESKA - Struktura ovog mht fajla nije ispravna.', //[i,152]Structure of this mht file is not good.
  'Fajl nije pronadjen. Ukoliko znate da fajl postoji probajte da mu promenite ime. ', //[i,153] [i,153]File not found. If you know that file exists try to rename it.
  'Dodaj folder', //[i,154]
  'Dodaj sve mht fajlove iz direktorijuma i svih poddirektorijuma.', //[i,155]
  '&U redu', //[i,156]
  '&Odustani', //[i,157]
  'Filter', //[i,158]
  'Odaberi sve fajlove iz direktorijuma (ukljucujuci sve poddirektorijume) koji se slazu sa filterom. Koristite jedan filter u jednom prolazu.', //[i,158]
  'sr',  //[i,160]en country code, used for help
  'recurzivno pretrazi poddirektorijume', // [i,161] recursively search sub directories
  'Dodaj fajlove', // [i,162] Add files
  'Dodaj ', // [i,163] Do you wish to add
  ' fajla u listu?', // [i,164] files to the list?
  'Greska pri kreiranju fajla ili direktorijuma', // [i,165] File/Directory creation error
  'mht2htm nije uspeo da kreira fajla ili direktorijuma. Proveri da li imas dozvole ya pisanje u ciljnom direktorijumu.', // [i,166] mht2htm didn''t succeed to create target file or directory. Please check if you have sufficient permissions over target directory.
  'Neispravan datum', // [i,167] Invalid date format
  'GRESKA - ciljni direktorijum ne moze da se kreira!', // [i,168] ERROR - can''t create ouptut directory!
  ' fajla nije obradjeno. Greske su zabelezene u "Konvertovano" listi.' // [i,169] files couldn''t be processed. Errors can be found in History list.
  ));






implementation


{
Delphi
ANSI_CHARSET	0	ANSI characters.
DEFAULT_CHARSET	1	Font is chosen based solely on Name and Size. If the described font is not available on the system, Windows will substitute another font.
SYMBOL_CHARSET	2	Standard symbol set.
MAC_CHARSET	77	Macintosh characters. Not available on NT 3.51.
SHIFTJIS_CHARSET	128	Japanese shift-JIS characters.
HANGEUL_CHARSET	129	Korean characters (Wansung).
JOHAB_CHARSET	130	Korean characters (Johab). Not available on NT 3.51

GB2312_CHARSET	134	Simplified Chinese characters (mainland china).
CHINESEBIG5_CHARSET	136	Traditional Chinese characters (Taiwanese).
GREEK_CHARSET	161	Greek characters. Not available on NT 3.51.
TURKISH_CHARSET	162	Turkish characters. Not available on NT 3.51
VIETNAMESE_CHARSET	163	Vietnamese characters. Not available on NT 3.51.
HEBREW_CHARSET	177	Hebrew characters. Not available on NT 3.51
ARABIC_CHARSET	178	Arabic characters. Not available on NT 3.51

BALTIC_CHARSET	186	Baltic characters. Not available on NT 3.51.
RUSSIAN_CHARSET	204	Cyrillic characters. Not available on NT 3.51.
THAI_CHARSET	222	Thai characters. Not available on NT 3.51
EASTEUROPE_CHARSET	238	Includes diacritical marks for eastern european countries. Not available on NT 3.51.
OEM_CHARSET	255	Depends on the codepage of the operating system.


Lazarus
  // font character sets
  ANSI_CHARSET        = 0;
  DEFAULT_CHARSET     = 1;
  SYMBOL_CHARSET      = 2;
  // added for ISO_8859_2 under gtk
  FCS_ISO_10646_1     = 4;  // Unicode;
  FCS_ISO_8859_1      = 5;  //  ISO Latin-1 (Western Europe);
  FCS_ISO_8859_2      = 6;  //  ISO Latin-2 (Eastern Europe);
  FCS_ISO_8859_3      = 7;  //  ISO Latin-3 (Southern Europe);
  FCS_ISO_8859_4      = 8;  //  ISO Latin-4 (Northern Europe);
  FCS_ISO_8859_5      = 9;  //  ISO Cyrillic;
  FCS_ISO_8859_6      = 10; //  ISO Arabic;
  FCS_ISO_8859_7      = 11; //  ISO Greek;
  FCS_ISO_8859_8      = 12; //  ISO Hebrew;
  FCS_ISO_8859_9      = 13; //  ISO Latin-5 (Turkish);
  FCS_ISO_8859_10     = 14; //  ISO Latin-6 (Nordic);
  FCS_ISO_8859_15     = 15; //  ISO Latin-9, or Latin-0 (Revised Western-European);
  //FCS_koi8_r          = 16; //  KOI8 Russian;
  //FCS_koi8_u          = 17; //  KOI8 Ukrainian (see RFC 2319);
  //FCS_koi8_ru         = 18; //  KOI8 Russian/Ukrainian
  //FCS_koi8_uni        = 19; //  KOI8 ``Unified'' (Russian, Ukrainian, and Byelorussian);
  //FCS_koi8_e          = 20; //  KOI8 ``European,'' ISO-IR-111, or ECMA-Cyrillic;
  // end of our own additions
  MAC_CHARSET         = 77;
  SHIFTJIS_CHARSET    = 128;
  HANGEUL_CHARSET     = 129;
  JOHAB_CHARSET       = 130;
  GB2312_CHARSET      = 134;
  CHINESEBIG5_CHARSET = 136;
  GREEK_CHARSET       = 161;
  TURKISH_CHARSET     = 162;
  VIETNAMESE_CHARSET  = 163;
  HEBREW_CHARSET      = 177;
  ARABIC_CHARSET      = 178;
  BALTIC_CHARSET      = 186;
  RUSSIAN_CHARSET     = 204;
  THAI_CHARSET        = 222;
  EASTEUROPE_CHARSET  = 238;
  OEM_CHARSET         = 255;
  // additional charsets

GTK

  AddCharsetEncoding(ANSI_CHARSET,        'iso8859',  '1',    false);
  AddCharsetEncoding(ANSI_CHARSET,        'iso8859',  '3',    false);
  AddCharsetEncoding(ANSI_CHARSET,        'iso8859',  '15',   false);
  AddCharsetEncoding(ANSI_CHARSET,        'ansi',     '0');
  AddCharsetEncoding(ANSI_CHARSET,        '*',        'cp1252');
  AddCharsetEncoding(ANSI_CHARSET,        'iso8859',  '*');
  AddCharsetEncoding(DEFAULT_CHARSET,     '*',        '*');
  AddCharsetEncoding(SYMBOL_CHARSET,      '*',        'fontspecific');
  AddCharsetEncoding(MAC_CHARSET,         '*',        'cpxxxx'); // todo
  AddCharsetEncoding(SHIFTJIS_CHARSET,    'jis',      '0',    true, true);
  AddCharsetEncoding(SHIFTJIS_CHARSET,    '*',        'cp932');
  AddCharsetEncoding(HANGEUL_CHARSET,     '*',        'cp949');
  AddCharsetEncoding(JOHAB_CHARSET,       '*',        'cp1361');
  AddCharsetEncoding(GB2312_CHARSET,      'gb2312',   '0',    true, true);
  AddCharsetEncoding(CHINESEBIG5_CHARSET, 'big5',     '0',    true, true);
  AddCharsetEncoding(CHINESEBIG5_CHARSET, '*',        'cp950');
  AddCharsetEncoding(GREEK_CHARSET,       'iso8859',  '7');
  AddCharsetEncoding(GREEK_CHARSET,       '*',        'cp1253');
  AddCharsetEncoding(TURKISH_CHARSET,     'iso8859',  '9');
  AddCharsetEncoding(TURKISH_CHARSET,     '*',        'cp1254');
  AddCharsetEncoding(VIETNAMESE_CHARSET,  '*',        'cp1258');
  AddCharsetEncoding(HEBREW_CHARSET,      'iso8859',  '8');
  AddCharsetEncoding(HEBREW_CHARSET,      '*',        'cp1255');
  AddCharsetEncoding(ARABIC_CHARSET,      'iso8859',  '6');
  AddCharsetEncoding(ARABIC_CHARSET,      '*',        'cp1256');
  AddCharsetEncoding(BALTIC_CHARSET,      'iso8859',  '13');
  AddCharsetEncoding(BALTIC_CHARSET,      'iso8859',  '4');  // northern europe
  AddCharsetEncoding(BALTIC_CHARSET,      'iso8859',  '14'); // CELTIC_CHARSET
  AddCharsetEncoding(BALTIC_CHARSET,      '*',        'cp1257');
  AddCharsetEncoding(RUSSIAN_CHARSET,     'iso8859',  '5');
  AddCharsetEncoding(RUSSIAN_CHARSET,     'koi8',     '*');
  AddCharsetEncoding(RUSSIAN_CHARSET,     '*',        'cp1251');
  AddCharsetEncoding(THAI_CHARSET,        'iso8859',  '11');
  AddCharsetEncoding(THAI_CHARSET,        'tis620',   '*',  true, true);
  AddCharsetEncoding(THAI_CHARSET,        '*',        'cp874');
  AddCharsetEncoding(EASTEUROPE_CHARSET,  'iso8859',  '2');
  AddCharsetEncoding(EASTEUROPE_CHARSET,  '*',        'cp1250');
  AddCharsetEncoding(OEM_CHARSET,         'ascii',    '0');
  AddCharsetEncoding(OEM_CHARSET,         'iso646',   '*',  true, true);
  AddCharsetEncoding(FCS_ISO_10646_1,     'iso10646', '1');
  AddCharsetEncoding(FCS_ISO_8859_1,      'iso8859',  '1');
  AddCharsetEncoding(FCS_ISO_8859_2,      'iso8859',  '2');
  AddCharsetEncoding(FCS_ISO_8859_3,      'iso8859',  '3');
  AddCharsetEncoding(FCS_ISO_8859_4,      'iso8859',  '4');
  AddCharsetEncoding(FCS_ISO_8859_5,      'iso8859',  '5');
  AddCharsetEncoding(FCS_ISO_8859_6,      'iso8859',  '6');
  AddCharsetEncoding(FCS_ISO_8859_7,      'iso8859',  '7');
  AddCharsetEncoding(FCS_ISO_8859_8,      'iso8859',  '8');
  AddCharsetEncoding(FCS_ISO_8859_9,      'iso8859',  '9');
  AddCharsetEncoding(FCS_ISO_8859_10,     'iso8859',  '10');
  AddCharsetEncoding(FCS_ISO_8859_15,     'iso8859',  '15');

}
end.
