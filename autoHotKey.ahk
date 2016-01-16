;########################################## Resources #############################################################
;Tested for Windows 7 only
;########################################## List of hotkeys #######################################################
;# Win (Windows logo key) 
;! Alt 
;^ Control 
;&  An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.  
;+ Shift 

;########################################## GUIs ##############################################################
; Win-CapsLock : Opens a GUI with a list of allhotkeys and hotstrings - needs to be manually maintained
; #ip : opens a GUI with list of IP addresses

;########################################## Commands ##############################################################
; Win-C: open a command prompt for active window or else c:
; Win-B: open the documents folder
; Win-K: open the Jboss logs folder
; Win-H: open the HEAD folder
; WIN-\: open the bagmanager\bagmanager-service-container directory
; Win-M: open misc.txt file in notepad++ and place cursor at end of file
; CTRL-X: copy highlighted text, open my misc.txt file in notepad++, place cursor at end of file, jump to new line and paste text
; Win-N: open selected file in notepad++
; Win-J: open Jboss deploy directory
; Win-A: opens autohotkey file
; Win-Q: copy bsm file: aFileToCopy.txt to input/bim
; Win-.: opens the Tortoise SVN commit screen at our head directory
; Win-/: opens the Tortoise SVN log screen at our head directory
; Win-I: runs our system interface bat file
; WIN-Z: open chrome and search Google for selection, text copied to clipboard or open URL
; WIN-W: open the screenshots folder and open the last created file
; Win-,: runs sonar
; Win-w: oepns the system-interface logs directory
; CTRL-V: allows ctrl-v in command window
; F4: sends my password for agora
; F7: Opens lotus notes

;########################################## HotStrings #############################################################
; #pass: enters my passpack key
; #test : sends "mvn clean install"
; #skip: sends "mvn clean install -DskipTests"
; #sonar : sends "mvn sonar:sonar"
; #mvnr : runs "maven clean install -DskipTests" on head directory 
; #mvnw : runs "maven clean install -DskipTests" on bagmanager-webapp directory
; #mvnj : runs "maven clean install -DskipTests" on bagmanager-junit directory
; #mvnb : runs "maven clean install -DskipTests" on the bagmanager directory
; #dd : hotstring to insert the date
; #tt : hotstring to insert the time
; #dt : hotstring to insert the date time
; #127 : hotstring to enter 127.0.0.1
; #print : hotstring to enter printer config for reconnecting
; ### : will generate a line of hashes
; *** : will generate a line of stars 
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

;########################################### Win-B ##################################################################
; Win-B: open the documents folder
#b::
	Run, %bagmanagerDocs%
return

;########################################### Win-W ##################################################################
; Win-W: open the screenshots folder and open the last created file
#w::
	Run, %screenshotsDirectory%
	
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

;########################################### Win-Y ##################################################################
; Win-Y: open the system-interface logs folder
#y::
	Run, %systemInterfaceLogs%
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

;########################################### Win-\ ##################################################################
; Win-H: open the bagmanager\bagmanger-service-container directory
#\::
	Run, %serviceContainerDirectory%
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

;########################################### F4 ###################################################################
; hotkey when f4 is pressed sends my agora password
F4::
	Send, Not checking this in!{Enter}
return

;######################################### F7 ####################################################
; Switches to lotus notes
#IfWinExist ahk_class SWT_Window0
F7::WinActivate  ; Activates the window found by #IfWin.

;####################################################################################################################
;########################################### Numpad keys ############################################################
;####################################################################################################################

;########################################### CRTL-Numpad1 ###########################################################
; CRTL-Numpad1: open google.ie in a new tab
^NumPad1::
	Run, %chrome% www.google.ie
return

;########################################### CRTL-Numpad2 ###########################################################
; CRTL-Numpad2: open our tpOnDemand taskboard in chrome
^NumPad2::
	Run, %chrome% https://eugene.tpondemand.com
return

;########################################### CRTL-Numpad3 ###########################################################
; CRTL-Numpad3: open our jenkins dashboard in chrome
^NumPad3::
	Run, %chrome% "http://57.4.2.190:8080/view/Bag Manager/"
return

;########################################### CRTL-Numpad4 ###########################################################
; CRTL-Numpad4: open my trello dashboard in chrome
^NumPad4::
	Run, %chrome% "https://trello.com/b/P7shweeR/to-do-list"
return

;########################################### CRTL-Numpad5 ###########################################################
; CRTL-Numpad5: open our slack dashboard
^NumPad5::
	Run, %chrome% "https://bagmanager.slack.com"
return

;########################################### CRTL-Numpad6 ###########################################################
; CRTL-Numpad6: open our klocworks dashboard
^NumPad6::
	Run, %chrome% "http://klocwork_lakloxs001p.dc.sita.aero:8080/portal/Portal.html"
return

;########################################### CRTL-Numpad7 ###########################################################
; CRTL-Numpad7: open google mail in chrome
^NumPad7::
	Run, %chrome% "https://mail.google.com/mail"
return

;########################################### CRTL-Numpad8 ###########################################################
; CRTL-Numpad8: open google mail in chrome
^NumPad8::
	Run, %chrome% "https://www.passpack.com/online/"
return

;####################################################################################################################
;########################################### HotStrings #############################################################
;####################################################################################################################

;########################################### #pass ################################################################
; hotstring for passpack key: send my passpack key
::#pass::never!!
return

;########################################### #test ###################################################################
; hotstring to send mvn clean install
:*:#test::
	Send, mvn clean install
return

;########################################### #skip ###################################################################
; hotstring to send mvn clean install -DskipTests
:*:#skip::
	Send, mvn clean install -DskipTests
return

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

;########################################### #dd ####################################################################
; hotstring to insert the date
:*:#dd::
    FormatTime, CurrentDateTime,, yyyy-MM-dd
    SendInput %CurrentDateTime%
return

;########################################### #tt ####################################################################
; hotstring to insert the time
:*:#tt::
    FormatTime, CurrentDateTime,, HH:mm
    SendInput %CurrentDateTime%
return
	
;########################################### #dt ####################################################################
; hotstring to insert the date time
:*:#dt::
    FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm
    SendInput %CurrentDateTime%
return

;########################################### #127 ####################################################################
; hotstring to enter 127.0.0.1
:*:#127::127.0.0.1
	return

;###########################################  ###  ###################################################################
; hotstring to send line of hashes
:*:###::
	Send, {#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}{#}#}{#}{#}{#}{#}{#}{#}{#}{#}
return

;############################################ *** ####################################################################
; hotstring to send line of *'s
:*:***::
	Send, **********************************************************************************************************************
return

;########################################### #printer ####################################################################
; hotstring to enter printer settings
:*:#printer::\\ltrfps01
return


;########################################### #sonar ###################################################################
; hotstring to send: mvn sonar:sonar
:*:#sonar::
	Send, mvn sonar:sonar
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

;########################################### #jk ###################################################################
:*:#jk::John Krzymuski 

;########################################### #serial ###################################################################
; hotstring to send code for serializing request and response data
:*:#serial::

SendInput `
(
String requestString = SerializerUtil.convertObjectToString ( requestDTO );
System.out.println ( requestString );

String reponseString = SerializerUtil.convertObjectToString ( responseDTO );
System.out.println ( reponseString );
)
return

;########################################### #xmltest ###################################################################
; hotstring to send examples for asserting Junit XML test responses
:*:#xmltest::

SendInput `
(
<expectedResponse class="aero.sita.bagmanager.response.package.name.goes.here">
<resultDTO>
<result>SUCCESS</result>
<resultCode>BAGSVC_S_1001</resultCode>
</resultDTO>
</expectedResponse>
<printResponseXML>false</printResponseXML>
<expectedResponseObject>
<expectedObjectList>
<expectedObject class="aero.sita.bagmanager.junit.message.ExpectedObject">
<xPathDesc>Insert your Xpath description here</xPathDesc>
<xPath>//insert/xPath/here</xPath>
<value>true</value>
</expectedObject>
</expectedObjectList>
</expectedResponseObject>
<expectedDBResult>
<dbResultList>
<dbResult class="aero.sita.bagmanager.junit.message.DBResult">
<queryDesc>Insert SQL query description here</queryDesc>
<query>select count(*) from person where first_name ='joe'</query>
<expectedCount>1</expectedCount>
</dbResult>
</dbResultList>
</expectedDBResult>
)
return
	
;####################################################################################################################
;########################################### GUIs ###################################################################
;####################################################################################################################

;########################################### #ip #################################################################### 
;Open a GUI and lets user select IP address
:*:#ip:: 
; Create the ListView with two columns
Gui 1:Default
Gui, Add, ListView, r27 w300 gMyListView, Description|IP Address

LV_Add("", "Corporate VM1", "57.5.3.148")
LV_Add("", "Corporate VM2", "57.5.3.149")
LV_Add("", "Corporate VM3", "57.4.2.130")
LV_Add("", "Corporate VM4", "57.4.2.134")
LV_Add("", "Corporate VM5", "57.4.2.137")
LV_Add("", "Corporate VM9", "57.4.2.152")
LV_Add("", "Corporate London DB", "57.5.27.15")
LV_Add("", "Corporate Baglab", "57.4.2.139")
LV_Add("", "Corporate BAGCVS", "57.5.3.147")
LV_Add("", "Corporate SVN", "57.6.248.31")
LV_Add("")
LV_Add("", "LAB VM1", "10.40.16.91")
LV_Add("", "LAB VM2", "10.40.16.92")
LV_Add("", "LAB VM3", "10.40.16.93")
LV_Add("", "LAB VM4", "10.40.16.94")
LV_Add("", "LAB VM5", "10.40.16.95")
LV_Add("", "LAB VM9", "10.40.16.100")
LV_Add("", "LAB BAGCVS", "10.40.16.51")
LV_Add("", "LAB SVN", "57.6.248.31")
LV_Add("")
LV_Add("", "NATD VM1", "10.185.40.65")
LV_Add("", "NATD VM2", "10.185.40.66")
LV_Add("", "NATD VM3", "10.185.40.67")
LV_Add("", "NATD VM4", "10.185.40.68")
LV_Add("", "NATD VM5", "10.185.40.84")
LV_Add("", "NATD VM9", "10.185.40.69")	
LV_Add("", "NATD BAGCVS", "10.185.40.82")
LV_Add("")
LV_Add("", "Shared Drive", "10.60.101.152")

LV_ModifyCol()  ; Auto-size each column to fit its contents.

; Display the window and return. The script will be notified whenever the user double clicks a row or presses enter
Gui, Show
return

; Bug with enter key, can't get it to work after the 2nd time GUI is shown to the user
#IfWinActive ahk_class AutoHotkeyGUI
Enter::	
RowNumber = 0  ; This causes the first loop iteration to start the search at the top of the list.
	GuiControlGet, FocusedControl, FocusV
	RowNumber := LV_GetNext(0, "Focused")
	LV_GetText(TEXT, RowNumber, 2) 
	Gui Cancel
	Send, %TEXT%
return

Esc::
	Gui Cancel
return

#IfWinActive

MyListView:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo , 2)  ;Get the text from the row's first field.
	Gui Cancel
	Send, %RowText%
}
return

;########################################### WIN-CAPSLOCK #################################################################### 
;Open a GUI to show all hot keys - hot strings - needs to be manually maintained
#CapsLock::
; Create the ListView with two columns
Gui 3:Default
Gui, Add, ListView, r30 w500 gMyListView, Shortcut|Command|Description|

LV_Add("", "Win-C", "#c", "Open a command prompt for active window or else c:")
LV_Add("", "Win-B", "#b", "Open my documents folder")
LV_Add("", "Win-K", "#k", "Open the Jboss logs folder")
LV_Add("", "Win-H", "#h", "Open the HEAD source folder")
LV_Add("", "Win-\", "#\", "Open the bagmanager\bagmanager-service-container directory")
LV_Add("", "Win-M", "#m", "Open misc.txt file in notepad++ and place cursor at end of file")
LV_Add("", "CTRL-X", "^x", "Copy highlighted text to the the misc.txt file in notepad++")
LV_Add("", "Win-N", "#n", "Open selected file in notepad++")
LV_Add("", "Win-J", "#j", "Open Jboss deploy directory")
LV_Add("", "Win-A", "#a", "Opens autohotkey file")
LV_Add("", "Win-.", "#.", "Opens the Tortoise SVN commit window at the head directory")
LV_Add("", "Win-/", "#/", "Opens the Tortoise SVN log window at the head directory")
LV_Add("", "Win-I", "#i", "Runs the system interface bat file")
LV_Add("", "Win-Z", "#z", "Open chrome and search Google for text selected or open URL")
LV_Add("", "Win-,", "#,", "Runs sonar")
LV_Add("", "Win-Y", "#y", "Opens the system-interface logs folder")
LV_Add("", "Win-W", "#w", "Opens the screenshots folder and open the last created file")
LV_Add("", "CTRL-V", "^v", "Allows ctrl-v in command window")
LV_Add("", "F4", "F4", "Sends my password for Agora")
LV_Add("", "F7", "F7", "Opens lotus notes")
LV_Add("", "", "", "")
LV_Add("", "#ip", "#ip", "Opens a GUI of useful IP addresses")
LV_Add("", "#pass", "#pass", "Sends my passpack key")
LV_Add("", "#test", "#test", "sends 'mvn clean install'")
LV_Add("", "#skip", "#skip", "sends 'mvn clean install -DskipTests'")
LV_Add("", "#sonar", "#sonar", "sends 'mvn sonar:sonar'")
LV_Add("", "#mvnr", "#mvnr", "runs 'maven clean install -DskipTests' on head directory")
LV_Add("", "#mvnw", "#mvnw", "runs 'maven clean install -DskipTests' on bagmanager-webapp directory")
LV_Add("", "#mvnj", "#mvnj", "runs 'maven clean install -DskipTests' on bagmanager-junit directory")
LV_Add("", "#mvnb", "#mvnb", "runs 'maven clean install -DskipTests' on the bagmanager directory")
LV_Add("", "#dd", "#dd", "hotstring to insert the date")
LV_Add("", "#tt", "#tt", "hotstring to insert the time")
LV_Add("", "#dt", "#dt", "hotstring to insert the dateTime")
LV_Add("", "#127", "#127", "hotstring to insert 127.0.0.1")
LV_Add("", "#print", "#print", "hotstring to enter printer config for reconnecting")
LV_Add("", "#serial", "#serial", "will insert the serialization utiliity methods")
LV_Add("", "#xmltest", "#xmltest", "will insert xml test assertion structure")
LV_Add("", "###", "###", "will generate a line of hashes")
LV_Add("", "***", "***", "will generate a line of stars ")
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