#include Function/FunctionBase.ahk
#include Form/WebSortcodeForm.ahk


class WebSortcodeFunction extends FunctionBase {


  id := "" ; @todo figure out how to launch this function


  getForm(formName, record) {
    return new WebSortcodeForm(this, formName, record)
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

    form := this.getForm(WebSortcodeForm.FORM_CORRECT, record)
    form.open()
    form.submit(record)
  }


  updateBulletPointsRecord(record) {
    this.findRecord(record)

    ; Clear the existing bullet points
    this.controller.activateHotkey("B")
    loop, 20 
    {
      this.controller.activateHotkey("R")
      this.controller.activateHotkey("Y")
    }

    ; Insert the new bullet points
    entryForm := this.getForm(WebSortcodeForm.FORM_BULLET_POINTS_ENTRY, record)
    entryForm.open()
    entryForm.submit(record)
    ; Close line for next gtin record.
    entryForm.close()
    this.controller.closeFunction()
  }


  findRecord(record) {
    form := this.getForm(WebSortcodeForm.FORM_FIND, record)

    form.open()
    form.submit(record)
  }

}
