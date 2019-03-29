#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode, Input ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force
AutoTrim, Off ; Allow values to begin/end with whitespace characters such as `t.

#include LegacyAHK.ahk


class XMLViewerController {


	__new(windowTitle = "Pronto Xi Report Viewer") {
		this.windowTitle := windowTitle
	}


	; Gets the message displayed in the client's status bar.
	waitStatus(status, duration := 600)	{
		title := this.windowTitle
    statusBarPart := 1
    interval := 1000

    ; Wait for duration (in seconds) for status to change
    StatusBarWait, %status%, %duration%, %statusBarPart%, %title%,, %interval%
	}


	close() {
		AHK.send("{ESC}")
	}
}
