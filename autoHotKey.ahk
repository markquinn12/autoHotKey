;########################################## Resources ########################################################
;# Win (Windows logo key) 
;! Alt 
;^ Control 
;+ Shift 
;&  An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.  
;########################################## Commands ########################################################
; Win-C: open a command prompt for active window or else c:
; Win-B: open the documents folder
; Win-K: open the documents folder
; Win-H: open the HEAD folder
; Win-M: open misc.txt file in notepad++ and place cursor at end of file
; CTRL+SHIFT+C: copy highlighted text, open my misc.txt file in notepad++, place cursor at end of file, jump to new line and paste text
; Win-N: open selected file in notepad++
; Win-J: open Jboss deploy directory
; Win-I: send: mvn clean install
; Win-S: send: mvn clean install -DskipTests
; Win-A: opens autohotkey file
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim folder
; Win-R: runs maven clean install on head directory
; Win-W: runs maven clean install -DskipTests on bagmanager-webapp

;########################################## Commands ########################################################
; passkey: enters my passpack key

;########################################### Win-C ###########################################################
; Win-C: open a command prompt for active window or else c:
;   - if a folder window is active, the command prompt will start in that directory;
;   - otherwise the command prompt will open in whatever directory you specify as the default below
#c::
	WinGetTitle,activeWinTitle,A
	WinGetClass,activeWinClass,A
	if (activeWinClass = "CabinetWClass" or activeWinClass = "ExploreWClass")
		Run,%ComSpec%,%activeWinTitle%
	else
		; change "C:\Temp" to whatever default directory you want
		Run,%ComSpec%,C:\
return

;########################################### Win-B ###########################################################
; Win-B: open the documents folder
#b::
	Run, "C:\Users\bagmanager\Dropbox\Bagmanager"
return

;########################################### Win-K ###########################################################
; Win-K: open the documents folder (Win-L logs me out of the machine!)
#k::
	Run, "C:\jbdevstudio\runtimes\jboss-eap\standalone\log"
return

;########################################### Win-H ###########################################################
; Win-H: open the HEAD folder
#h::
	Run, "C:\HEAD"
return

;########################################### Win-J ###########################################################
; Win-J: open the Jboss deploy folder
#j::
	Run, "C:\appl\sita\bmgr\deploy"
return

;########################################### Win-M ###########################################################
; Win-M: open my misc.txt file in notepad++ and place cursor at end of file
#m::
run, "C:\Program Files (x86)\Notepad++\notepad++.exe" C:\Users\bagmanager\Dropbox\Bagmanager\Misc docs\misc.txt
sleep 500
Winwaitactive, ahk_class Notepad++
ControlGetFocus, control, A
Send ^{End}
return

;########################################### Win-N ###########################################################
; Win-N: open selected file in notepad++
#n::
ClipSaved := ClipboardAll
Send ^c
ClipWait
FullPath := Clipboard
run, "C:\Program Files (x86)\Notepad++\notepad++.exe" %FullPath%
Clipboard := ClipSaved
ClipSaved =
return

;########################################### Win-I ###########################################################
; Win-I: send: mvn clean install
#i::
	 Send, mvn clean install
return


;########################################### Win-S ###########################################################
; Win-S: send: mvn clean install -DskipTests
#s::
	 Send, mvn clean install -DskipTests
return

;########################################### Win-Q ###########################################################
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim folder
#q::
	 FileCopy, C:\BSM's\BSM Types\aFileToCopy.txt, C:\appl\sita\bmgr\input\bim
return

;########################################### Win-R ###########################################################
; Win-R: run maven clean install on our head directory
#r::
	commands=
		(join&
			cd C:\HEAD\
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### Win-W ###########################################################
; Win-W: run maven clean install -DskipTests on our bagmanager-webapp
#w::
	commands=
		(join&
			cd C:\HEAD\bagmanager\bagmanager-webapp\
			mvn clean install -DskipTests
		)
	runwait, %comspec% /k %commands%
return

;########################################### Win-A ###########################################################
; Win-A: open my autoHotKey.txt file in notepad++ and place cursor at end of file
#a::
run, "C:\Program Files (x86)\Notepad++\notepad++.exe" C:\GitRepositories\autoHotKey\autoHotKey.ahk
sleep 500
Winwaitactive, ahk_class Notepad++
ControlGetFocus, control, A
Send ^{Home}
return

;########################################### CTRL+SHIFT+C ###########################################################
; CTRL+SHIFT+C: copy highlighted text, open my misc.txt file in notepad++, place cursor at end of file, jump to new line and paste text
^+c::
Send ^{c}
run, "C:\Program Files (x86)\Notepad++\notepad++.exe" C:\Users\bagmanager\Dropbox\Bagmanager\Misc docs\misc.txt
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
	Run, chrome.exe https://eugene.tpondemand.com/RestUI/Board.aspx?invite&acid=6C17D8319C81AC3D36AFAD64CAE08A28#page=board/5001197856453400685&appConfig=eyJhY2lkIjoiNUE2ODU3NUVFN0M1MzA0QzM5QTA5MENERkU0MjVFQkUifQ==
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

