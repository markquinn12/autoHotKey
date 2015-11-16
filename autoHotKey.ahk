;########################################## Resources #############################################################
;Tested for Windows 7 only
;# Win (Windows logo key) 
;! Alt 
;^ Control 
;+ Shift 
;&  An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.  

;########################################## Commands ##############################################################
; Win-C: open a command prompt for active window or else c:
; Win-B: open the documents folder
; Win-K: open the documents folder
; Win-H: open the HEAD folder
; Win-M: open misc.txt file in notepad++ and place cursor at end of file
; CTRL+X: copy highlighted text, open my misc.txt file in notepad++, place cursor at end of file, jump to new line and paste text
; Win-N: open selected file in notepad++
; Win-J: open Jboss deploy directory
; Win-A: opens autohotkey file
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim folder
; Win-.: opens the Tortoise SVN commit screen at our head directory
; Win-/: opens the Tortoise SVN log screen at our head directory
; Win-I: runs our system interface bat file

;########################################## HotStrings #############################################################
; passkey: enters my passpack key
; mvnc: sends mvn clean install
; mvns: sends mvn clean install -DskipTests
; mvnr: runs maven clean install on head directory 
; mvnw: runs maven clean install -DskipTests on bagmanager-webapp directory
; mvnj: runs maven clean install -DskipTests on bagmanager-junit directory
; mvnb: runs maven clean install -DskipTests on the bagmanager directory

;########################################## Global Variables ######################################################
global headDirectory := "C:\HEAD"
global bagmanagerDocs := "C:\Users\bagmanager\Dropbox\Bagmanager"
global bmgrDirectory := "C:\appl\sita\bmgr"

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

;########################################### Win-B ##################################################################
; Win-B: open the documents folder
#b::
	Run, %bagmanagerDocs%
return

;########################################### Win-K ##################################################################
; Win-K: open the documents folder (Win-L logs me out of the machine!)
#k::
	Run, %jbossLogs%
return

;########################################### Win-H ##################################################################
; Win-H: open the HEAD folder
#h::
	Run, %headDirectory%
return

;########################################### Win-J ##################################################################
; Win-J: open the Jboss deploy folder
#j::
	Run, %deployDirectory%
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

;####################################################################################################################
;########################################### Numpad keys ############################################################
;####################################################################################################################

;########################################### CRTL-Numpad1 ###########################################################
; CRTL-Numpad1: open google.ie in a new tab
^NumPad1::
	Run, chrome.exe www.google.ie
return

;########################################### CRTL-Numpad2 ###########################################################
; CRTL-Numpad2: open our tpOnDemand taskboard in chrome
^NumPad2::
	Run, chrome.exe https://eugene.tpondemand.com
return

;########################################### CRTL-Numpad3 ###########################################################
; CRTL-Numpad3: open our jenkins dashboard in chrome
^NumPad3::
	Run, chrome.exe "http://57.4.2.190:8080/view/Bag Manager/"
return

;########################################### CRTL-Numpad4 ###########################################################
; CRTL-Numpad4: open my trello dashboard in chrome
^NumPad4::
	Run, chrome.exe "https://trello.com/b/P7shweeR/to-do-list"
return

;########################################### CRTL-Numpad5 ###########################################################
; CRTL-Numpad5: open our slack dashboard
^NumPad5::
	Run, chrome.exe "https://bagmanager.slack.com"
return

;########################################### CRTL-Numpad6 ###########################################################
; CRTL-Numpad6: open our klocworks dashboard
^NumPad6::
	Run, chrome.exe "http://klocwork_lakloxs001p.dc.sita.aero:8080/portal/Portal.html"
return

;########################################### CRTL-Numpad7 ###########################################################
; CRTL-Numpad7: open google mail in chrome
^NumPad7::
	Run, chrome.exe "https://mail.google.com/mail"
return

;########################################### CRTL-Numpad8 ###########################################################
; CRTL-Numpad8: open google mail in chrome
^NumPad8::
	Run, chrome.exe "https://www.passpack.com/online/"
return

;####################################################################################################################
;########################################### HotStrings #############################################################
;####################################################################################################################

;########################################### passkey ################################################################
; hotstring for passpack key: send my passpack key
::passkey::not checking this in!
return

;########################################### mvnc ###################################################################
; hotstring to send mvn clean install
::mvnc::
	Send, mvn clean install
return

;########################################### mvns ###################################################################
; hotstring to send mvn clean install -DskipTests
::mvns::
	Send, mvn clean install -DskipTests
return

;########################################### mvnr ###################################################################
; hotstring to run mvn clean install -DskipTests on our head directory
::mvnr::
	commands=
		(join&
			cd %headDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### mvnw ####################################################################
; hotstring to run mvn clean install -DskipTests on our webapp directory
::mvnw::
	commands=
		(join&
			cd %webappDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### mvnj ####################################################################
; hotstring to run mvn clean install -DskipTests on our junit directory
::mvnj::
	commands=
		(join&
			cd %junitDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### mvnb ####################################################################
; hotstring to run mvn clean install -DskipTests on our bagmanagerDirectory directory
::mvnb::
	commands=
		(join&
			cd %bagmanagerDirectory%
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return