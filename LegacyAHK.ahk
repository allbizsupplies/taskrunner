

; OOP wrapper for AHK functions
class AHK {


  joinArgs(args) {
    options := ""
    for arg in args {
      options := options . arg . "," 
    }
    return options
  }


  controlGetText(classname, winTitle) {
    ControlGetText, text, %classname%, %winTitle%
    return text
  }


  lowercase(string) {
    StringLower, lowerCaseString, string
    return lowerCaseString
  }


  send(string) {
    Send, %string%
  }


  sleep(duration) {
    Sleep, %duration%
  }
}