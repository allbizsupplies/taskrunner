#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode, Input ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force
AutoTrim, Off ; Allow values to begin/end with whitespace characters such as `t.

#include LegacyAHK.ahk


class ThinClientController {


	__new(companyName = "Allbiz Supplies Pty. Ltd.") {
		this.companyName := companyName
		this.statusBarClassname := this.GetStatusBarClassname()
	}


	; Sends a hotkey as keyboard input
	activateHotkey(hotkey) {
		AHK.send(hotkey)
	}


	closeAlert() {
		AHK.send("{ESC}")
	}


	closeFunction() {
		AHK.send("{ESC}")
	}


	cancelForm(id) {
		AHK.send("{ESC}")
	}


	; Sets focus on Pronto Xi thin client.
	focusClient()	{
		title := this.companyName

		; Throw fatal error if Pronto cannot be focused.
		IfWinNotExist, %title%
		{
			fatalError("Could not focus on Pronto thin client. Check that Pronto is open on live company.")
		}

		; Set focus on Pronto. 
		WinActivate, %Title%
	}


	; Gets the message displayed in the client's status bar.
	getClientStatus()	{
		return AHK.controlGetText(this.statusBarClassname, this.companyName)
	}


	; Gets the classname for the thin client status bar.
	getStatusBarClassname()	{
		; Get the size and position of the thin client
		this.focusClient()
		WinGetPos, winXPos, winYPos, winWidth, winHeight
		
		MouseGetPos, mouseOrigXPos, mouseOrigYPos
		
		; Move the mouse over the status bar, which is in the bottom left of the window.
		mouseXPos := winXPos + 28
		mouseYPos := winYPos + winHeight - 5
		MouseMove, mouseXPos, mouseYPos

		; Get the classname of the component under the mouse.
		MouseGetPos,,,, statusBarClassname
		return statusBarClassname

		; Return the mouse to its original position.
		MouseMove, mouseOrigXPos, mouseOrigYPos
	}


	getText(classname) {
		return AHK.controlGetText(classname, this.companyName)
	}


	launchFunction(id) {
		AHK.send("{F11}")
		status = Module and function code, separated by a "." OR Alias
		this.sendOnStatus(id, status)
	}


	; Pastes tab-separated list of values into inputs
	; using Pronto's Shift+Insert paste macro.
	paste(string)	{
		; Set the system's clipboard value.
		clipboard := string

		; Fire Pronto's special paste function.
		AHK.send("+{INSERT}")
	}


	; Sends keyboard input after thin client displays
	; given status message.
	sendOnStatus(string, status) {
		; Append Enter keystroke to the input.
		string = %string%{ENTER}
		this.waitClientStatus(status)
		AHK.send(string)
	}


	; Checks the value of the client's status bar message until it
	; matches the given value.
	waitClientStatus(value) {
		Loop
		{
			statusMessage := this.getClientStatus()
			if (statusMessage = value)
			{
				return
			}
			; Notify the user if more than 2000 checks have been performed.
			else if (A_Index > 2000)
			{
				errorMessage = Waiting for status: "%value%"`nStatus is currently "%statusMessage%"
				error(errorMessage)
			}
			
			; Wait 5ms before checking the status again.
			Sleep, 5
		}
	}


	; Checks the value of the client's status bar message until it
	; no longer matches the given value.
	waitClientNotStatus(value) {
		Loop
		{
			statusMessage := this.getClientStatus()
			if (statusMessage != value)
			{
				return
			}
			; Notify the user if more than 20 checks have been performed.
			else if (A_Index > 200)
			{
				errorMessage = Waiting for disappearance of status: "%value%"`nStatus is currently "%statusMessage%"
				error(errorMessage)
			}
			
			; Wait 5ms before checking the status again.
			Sleep, 5
		}
	}

}


; Displays an error alert.
error(message) {
	MsgBox, 4, Error, %message%`n`nContinue?
	IfMsgBox Yes
		this.focusClient()
	else
		ExitApp
}


; Displays an error alert and terminates the program.
fatalError(message) {
	MsgBox, 0, Fatal Error, %message%`n`nThe script will now close.
	ExitApp
}


; Prints a message to stdout.
consoleLog(message) {
	FileAppend, %message%`n, *
}