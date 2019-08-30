#include Function/FunctionBase.ahk
#include Form/PriceRuleForm.ahk


class PriceRuleFunction extends FunctionBase {


  id := "INV.M031"


  ; Hotkeys for forms.
  static FORM_FIND := "F"
  static FORM_CORRECT := "C"

  
  getForm(formName, record) {
    return new PriceRuleForm(this, formName, record)
  }


  ; @override
  open() {
    base.open()
    this.controller.activateHotkey("M")
  }


  updateRecord(record) {
    this.findRecord(record)

    form := this.getForm(this.FORM_CORRECT, record)
    form.open()
    form.submit(record)
  }


  findRecord(record) {
    form := this.getForm(this.FORM_FIND, record)

    form.open()
    form.submit(record)
  }

}
