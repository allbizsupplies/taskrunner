#include %A_Scriptdir% ; Set includes directory
#include TaskRunner.ahk


; Collect command line arguments
args := []
Loop, %0% {
  i = %A_Index%
  args.push(%i%)
}

if (args[1] == "test") {
  args.removeAt(1)
  companyName := "TEST-Allbiz"
}
else {
  companyName := "Allbiz Supplies Pty. Ltd."
}

; Read the first command line argument as the task to be executed
task := args.removeAt(1)

; Notify user that task is about the begin
; MsgBox, 0, TaskRunner, Task to execute: %task%

; Execute the task, passing the rest of the CL args as function args
taskRunner := new TaskRunner(companyName)
taskRunner[task](args)

; Notify user that task is done
Sleep, 2000
MsgBox, 0, TaskRunner, Task Completed: %task%
ExitApp


^Esc::
  ExitApp
return

!Space::
  ExitApp
return

^+R::
  Reload
return

^`::
  Pause
return
