#include Function/FunctionBase.ahk
#include Form/WebSortcodeForm.ahk


class WebSortcodeFunction extends FunctionBase {


  id := "" ; @todo figure out how to launch this function


  ; Hotkeys for forms.
  static FORM_FIND := "F"
  static FORM_CORRECT := "C"

  
  getForm(formName) {
    return new WebSortcodeForm(this, formName)
  }


  ; @override
  open() {
    ; Just focus on Pronto since we can't launch
    ; this crappy hack function directly
    this.controller.focusClient()
    
    ; @todo figure out how to launch this function
  }


  updateRecord(record) {
    this.findRecord(record)

    form := this.getForm(this.FORM_CORRECT)
    form.open()
    form.submit(record)
  }


  findRecord(record) {
    form := this.getForm(this.FORM_FIND)
    form.open()
    form.submit(record)
  }

}
