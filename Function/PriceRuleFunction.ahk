#include Function/FunctionBase.ahk
#include Form/PriceRuleForm.ahk


class PriceRuleFunction extends FunctionBase {


  id := "INV.M031"

  
  getForm(formName, record) {
    return new PriceRuleForm(this, formName, record)
  }


  ; @override
  open() {
    base.open()
    this.controller.activateHotkey("M")
  }


  createRecord(record) {
    form := this.getForm(PriceRuleForm.FORM_ENTRY, record)
    form.open()
    form.submit(record)
  }


  updateRecord(record) {
    this.findRecord(record)

    form := this.getForm(PriceRuleForm.FORM_CORRECT, record)
    form.open()
    form.submit(record)
  }


  findRecord(record) {
    form := this.getForm(PriceRuleForm.FORM_FIND, record)

    form.open()
    form.submit(record)
  }

}
