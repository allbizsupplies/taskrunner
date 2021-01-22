#include Function/FunctionBase.ahk
#include Form/CancelOrderForm.ahk


class CancelOrderFunction extends FunctionBase {


  id := "SO.M025"
  
 
  getForm(formName, record) {
    return new CancelOrderForm(this, formName, record)
  }


  cancelRecord(record, openFindForm) {
    findForm := this.getForm(CancelOrderForm.FORM_FIND, record)
    if (openFindForm) {
      findForm.open()
    }
    findForm.submit(record)
    this.controller.activateHotkey("C")
    this.controller.activateHotkey("Y")
    reasonForm := this.getForm(CancelOrderForm.FORM_REASON, record)
    reasonForm.submit(record)
  }
}
