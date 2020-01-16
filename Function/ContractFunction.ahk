#include Function/FunctionBase.ahk
#include Form/ContractForm.ahk


class ContractFunction extends FunctionBase {


  id := "INV.M111"
  
 
  getForm(formName) {
    return new ContractForm(this, formName, record)
  }


  createRecord(record) {
    ; Add the product to the contract.
    entryForm := this.getForm(ContractForm.FORM_ENTER_PRODUCT, record)
    entryForm.open()
    entryForm.submit(record)
    entryForm.close()

    ; Add the extra pricing info.
    this.updateRecord(record)
  }


  updateRecord(record) {
    this.findRecord(record)

    ; Submit the corrections.
    correctForm := this.getForm(ContractForm.FORM_DETAIL, record)
    correctForm.open()
    correctForm.submit(record)
  }


  findRecord(record) {
    form := this.getForm(ContractForm.FORM_FIND_PRODUCT, record)
    form.open()
    form.submit(record)
  }


  ; Opens the Function in the thin client.
  openContract(record) {
    form := this.getForm(ContractForm.FORM_OPEN_CONTRACT, record)
    form.submit(record)
  }


  deleteRecord(record) {
    this.findRecord(record)

    ; Remove the record.
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("Y")
  }
}
