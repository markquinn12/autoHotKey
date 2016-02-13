;########################################## Resources #############################################################
;Tested for Windows 7 only
;########################################## List of hotkeys #######################################################
;# Win (Windows logo key) 
;! Alt 
;^ Control 
;&  An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.  
;+ Shift 

;########################################## Commands ##############################################################
; Win-C: open a command prompt for active window or else c:
; Win-N: open selected file in notepad++
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim
; WIN-Z: open chrome and search Google for selection, text copied to clipboard or open URL
; WIN-W: open the screenshots folder and open the last created file

;########################################## HotStrings #############################################################
; `   : pressing the tilda key - "`" will send "backspace"/

;########################################## Global Variables ######################################################
global bagmanagerDocs := "C:\Users\bagmanager\Dropbox\Bagmanager"
global bmgrDirectory := "C:\appl\sita\bmgr"
global chrome := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

global notePadPlusPlus := "C:\Program Files (x86)\Notepad++\notepad++.exe"
global aFileToCopy := "C:\BSM's\BSM Types\aFileToCopy.txt"
global bimDirectory := bmgrDirectory . "\input\bim"
global screenshotsDirectory := bagmanagerDocs . "\myScreenShots"

;####################################################################################################################
;########################################### Commands ###############################################################
;####################################################################################################################

;########################################### Win-C ##################################################################
; Win-C: open a command prompt for active window or else c:
;   - if a folder window is active, the command prompt will start in that directory;
;   - otherwise the command prompt will open in whatever directory you specify as the default below
#c::
	WinGetTitle,activeWinTitle,A
	WinGetClass,activeWinClass,A
	if (activeWinClass = "CabinetWClass" or activeWinClass = "ExploreWClass")
		Run,%ComSpec%,%activeWinTitle%
	else
		Run,%ComSpec%,C:\
return

;########################################### Win-W ##################################################################
; Win-W: open the screenshots folder and open the last created file
#w::
	; Run, %screenshotsDirectory%
	
	Loop, %screenshotsDirectory%\*.png
	{
		If (A_LoopFileTimeCreated>Rec)
		{
			FPath=%A_LoopFileFullPath%
			Rec=%A_LoopFileTimeCreated%
		}
	}	
	
	Run %Fpath%
	
return

;########################################### Win-N ##################################################################
; Win-N: open selected file in notepad++
#n::
	ClipSaved := ClipboardAll
	Send ^c
	ClipWait
	FullPath := Clipboard
	run, %notePadPlusPlus% %FullPath%
	Clipboard := ClipSaved
	ClipSaved =
return

;########################################### Win-Q ##################################################################
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim folder
#q::
	 Run, %bimDirectory%
	 FileCopy, %aFileToCopy%, %bimDirectory%
return

;########################################### WIN-Z #################################################################
;Open chrome and search Google for selection, text copied to clipboard or open URL
#z:: 
;Copy Clipboard to prevClipboard variable, clear Clipboard. 
  prevClipboard := ClipboardAll
  Clipboard = 
;Copy current selection, continue if no errors.
  SendInput, ^c 
  ClipWait, 2
  if !(ErrorLevel) {
;Convert Clipboard to text, auto-trim leading and trailing spaces and tabs.
    Clipboard = %Clipboard%
;Clean Clipboard: change carriage returns to spaces, change >=1 consecutive spaces to +
    Clipboard := RegExReplace(RegExReplace(Clipboard, "\r?\n"," "), "\s+","+")
;Open URLs, Google non-URLs. URLs contain . but do not contain + or .. or @
    if Clipboard contains +,..,@ 
      Run, %chrome% www.google.ie/search?q=%Clipboard%
    else if Clipboard not contains .
      Run, %chrome% www.google.ie/search?q=%Clipboard%
    else
      Run, %chrome% %Clipboard%
  } 
;Restore Clipboard, clear prevClipboard variable.
  Clipboard := prevClipboard
  prevClipboard =
return

;####################################################################################################################
;########################################### HotStrings #############################################################
;####################################################################################################################

;###########################################    `     ###################################################################
; converts "`" - tilda to the backspace key - no more left arm stretching!
$`::Backspace
return