;########################################## Resources ########################################################
;# Win (Windows logo key) 
;! Alt 
;^ Control 
;+ Shift 
;&  An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.  
;########################################## Commands ########################################################
; Win-C: open a command prompt for active window or else c:
; Win-B: open the documents folder
; Win-K: open the documents folder (Win-L logs me out of the machine!)
; Win-H: open the HEAD folder
; Win-M: open my misc.txt file in notepad++
; Win-N: open selected file in notepad++
; Win-J: open Jboss deploy directory
; Win-I: send: mvn clean install
; Win-S: send: mvn clean install -DskipTests
; Win-Y: send my passpack key
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim folder
; Win-R: runs maven clean install on head directory
; Win-W: runs maven clean install -DskipTests on bagmanager-webapp

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
; Win-M: open my misc.txt file in notepad++
#m::
run, "C:\Program Files (x86)\Notepad++\notepad++.exe" C:\Users\bagmanager\Dropbox\Bagmanager\Misc docs\misc.txt
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

;########################################### Win-Y ###########################################################
; Win-Y: send my passpack key
#y::
	Send, my passpack key - not really though!
return
