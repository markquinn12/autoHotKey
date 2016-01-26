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
; Win-M: open misc.txt file in notepad++ and place cursor at end of file
; CTRL-X: copy highlighted text, open my misc.txt file in notepad++, place cursor at end of file, jump to new line and paste text
; Win-N: open selected file in notepad++
; Win-A: opens autohotkey file
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim
; Win-.: opens the Tortoise SVN commit screen at our head directory
; Win-/: opens the Tortoise SVN log screen at our head directory
; Win-I: runs our system interface bat file
; WIN-Z: open chrome and search Google for selection, text copied to clipboard or open URL
; WIN-W: open the screenshots folder and open the last created file
; Win-,: runs sonar
; CTRL-V: allows ctrl-v in command window

;########################################## HotStrings #############################################################
; #pass: enters my passpack key
; #test : sends "mvn clean install"
; #skip: sends "mvn clean install -DskipTests"
; #sonar : sends "mvn sonar:sonar"
; #mvnr : runs "maven clean install -DskipTests" on head directory 
; #mvnw : runs "maven clean install -DskipTests" on bagmanager-webapp directory
; #mvnj : runs "maven clean install -DskipTests" on bagmanager-junit directory
; #mvnb : runs "maven clean install -DskipTests" on the bagmanager directory
; `   : pressing the tilda key - "`" will send "backspace"

;########################################## Global Variables ######################################################
global headDirectory := "C:\HEAD"
global bagmanagerDocs := "C:\Users\bagmanager\Dropbox\Bagmanager"
global bmgrDirectory := "C:\appl\sita\bmgr"
global chrome := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

global jbossLogs := "C:\jbdevstudio64\runtimes\jboss-eap\standalone\log"
global deployDirectory := bmgrDirectory . "\deploy"
global notePadPlusPlus := "C:\Program Files (x86)\Notepad++\notepad++.exe"
global miscFile := bagmanagerDocs . "\Misc docs\misc.txt"
global aFileToCopy := "C:\BSM's\BSM Types\aFileToCopy.txt"
global bimDirectory := bmgrDirectory . "\input\bim"
global autohotKeyFile := "C:\GitRepositories\autoHotKey\autoHotKey.ahk"
global tortoiseSvn := "C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe"
global webappDirectory := headDirectory . "\bagmanager\bagmanager-webapp"
global junitDirectory := headDirectory . "\bagmanager\bagmanager-junit"
global bagmanagerDirectory := headDirectory . "\bagmanager"
global systemInterfaceDirectory := bmgrDirectory . "\system-interface\bin"
global systemInterface := "sysi-bootstrap-console.bat"
global serviceContainerDirectory := headDirectory . "\bagmanager\bagmanager-service-container"
global sonarDirectory := "C:\sonar-3.7.4\bin\windows-x86-64\"
global sonar := "StartSonar.bat"
global systemInterfaceLogs := "C:\var\log\bagmanager"
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

;########################################### Win-M ##################################################################
; Win-M: open my misc.txt file in notepad++ and place cursor at end of file
#m::
	run, %notePadPlusPlus% %miscFile%
	sleep 500
	Winwaitactive, ahk_class Notepad++
	ControlGetFocus, control, A
	Send ^{End}
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

;########################################### Win-A ##################################################################
; Win-A: open my autoHotKey.txt file in notepad++ and place cursor at end of file
#a::
	run, %notePadPlusPlus% %autohotKeyFile%
	sleep 500
	Winwaitactive, ahk_class Notepad++
	ControlGetFocus, control, A
	Send ^{Home}
return

;########################################### Win-I ##################################################################
; Win-I: start the system interface bat file
#i::	
	commands=
		(join&
			cd %systemInterfaceDirectory%
			%systemInterface%
		)
	runwait, %comspec% /k %commands%	
return

;########################################### Win-, ##################################################################
; Win-I: starts sonar
#,::	
	commands=
		(join&
			cd %sonarDirectory%
			%sonar%
		)
	runwait, %comspec% /k %commands%	
return

;########################################### Win-. ##################################################################
; Win-.: Opens the Tortoise SVN commit screen at our source code root
#.::
	cmd = %tortoiseSvn% /command:commit /path:%headDirectory% /notempfile /closeonend:3
	run, %cmd%, %pth%,.
return

;########################################### Win-/ ##################################################################
; Win-/: Opens the Tortoise SVN log screen at our source code root
#/::
	cmd = %tortoiseSvn% /command:log /path:%headDirectory% /notempfile /closeonend:3
	run, %cmd%, %pth%,
return

;########################################### CTRL-X #################################################################
; CTRL+X: copy highlighted text, open my misc.txt file in notepad++, place cursor at end of file, jump to new line and paste text
^x::
	Send ^{c}
	run, %notePadPlusPlus% %miscFile%
	sleep 500
	Winwaitactive, ahk_class Notepad++
	ControlGetFocus, control, A
	Send ^{End}
	Send  {Enter}{Home}{Enter}
	Send ^{v}
	Send ^{s}
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

;########################################### CTRL-V (CMD) ####################################################
; Allows Ctrl-V in cmd window.
#IfWinActive ahk_class ConsoleWindowClass
^V::
	SendInput {Raw}%clipboard%
return
#IfWinActive

;####################################################################################################################
;########################################### HotStrings #############################################################
;####################################################################################################################

;########################################### #mvnr ###################################################################
; hotstring to run mvn clean install -DskipTests on our head directory
:*:#mvnr::
	commands=
		(join&
			cd %headDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### #mvnw ####################################################################
; hotstring to run mvn clean install -DskipTests on our webapp directory
:*:#mvnw::
	commands=
		(join&
			cd %webappDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### #mvnj ####################################################################
; hotstring to run mvn clean install -DskipTests on our junit directory
:*:#mvnj::
	commands=
		(join&
			cd %junitDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### #mvnb ####################################################################
; hotstring to run mvn clean install -DskipTests on our bagmanagerDirectory directory
:*:#mvnb::
	commands=
		(join&
			cd %bagmanagerDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;###########################################    `     ###################################################################
; converts "`" - tilda to the backspace key - no more left arm stretching!
$`::Backspace
return

;########################################### ?ip ###################################################################
; hotstring open command line and send ipconfig
:*:?ip::
	commands=
		(join&
			ipconfig
		)
	runwait, %comspec% /k %commands%	
return

;####################################################################################################################
;########################################### GUIs ###################################################################
;####################################################################################################################

;########################################### WIN-CAPSLOCK #################################################################### 
;Open a GUI to show all hot keys - hot strings - needs to be manually maintained
#CapsLock::
; Create the ListView with two columns
Gui 3:Default
Gui, Add, ListView, r30 w500 gMyListView, Shortcut|Command|Description|

LV_Add("", "Win-C", "#c", "Open a command prompt for active window or else c:")
LV_Add("", "Win-M", "#m", "Open misc.txt file in notepad++ and place cursor at end of file")
LV_Add("", "CTRL-X", "^x", "Copy highlighted text to the the misc.txt file in notepad++")
LV_Add("", "Win-N", "#n", "Open selected file in notepad++")
LV_Add("", "Win-A", "#a", "Opens autohotkey file")
LV_Add("", "Win-.", "#.", "Opens the Tortoise SVN commit window at the head directory")
LV_Add("", "Win-/", "#/", "Opens the Tortoise SVN log window at the head directory")
LV_Add("", "Win-I", "#i", "Runs the system interface bat file")
LV_Add("", "Win-Z", "#z", "Open chrome and search Google for text selected or open URL")
LV_Add("", "Win-,", "#,", "Runs sonar")
LV_Add("", "Win-W", "#w", "Opens the screenshots folder and open the last created file")
LV_Add("", "CTRL-V", "^v", "Allows ctrl-v in command window")
LV_Add("", "", "", "")
LV_Add("", "#mvnr", "#mvnr", "runs 'maven clean install -DskipTests' on head directory")
LV_Add("", "#mvnw", "#mvnw", "runs 'maven clean install -DskipTests' on bagmanager-webapp directory")
LV_Add("", "#mvnj", "#mvnj", "runs 'maven clean install -DskipTests' on bagmanager-junit directory")
LV_Add("", "#mvnb", "#mvnb", "runs 'maven clean install -DskipTests' on the bagmanager directory")
LV_Add("", "`", "`", "pressing the tilda key - '`' will send 'backspace'")

LV_ModifyCol(1,50)
LV_ModifyCol(2,70)
LV_ModifyCol(3,355)

; Display the window and return. The script will be notified whenever the user double clicks a row or presses enter
Gui, Show
return

MyListView3:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo, 2) 
	Gui Cancel
	Send, %RowText%
}
return	
	
;###############################################################################################################################