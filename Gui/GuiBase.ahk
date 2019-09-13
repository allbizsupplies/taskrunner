#include LegacyAHK.ahk


class GuiBase {
  

  __new(name, title) {
    AHK.gui(name . ":new", ["" ,title])
  }


  show() {
    AHK.gui("show")
  }


  addControl(control, x, y) {
    options := "x" . x . " y" . y 
    AHK.gui("add", [ control.getType(),  ])
  }

}