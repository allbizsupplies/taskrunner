#include Function/FunctionBase.ahk
#include Form/ContractMaintenanceForm.ahk


class ContractMaintenanceFunction extends FunctionBase {


  id := "AR.M186"
  
 
  getForm(formName, record) {
    return new ContractMaintenanceForm(this, formName, record)
  }


  createRecord(record) {
    ; Add the product to the contract.
    entryForm := this.getForm(ContractMaintenanceForm.FORM_ENTRY, record)
    entryForm.open()
    entryForm.submit(record)
    entryForm.close()

    ; Add the extra pricing info.
    this.updateRecord(record)
  }


  updateRecord(record) {
    this.findRecord(record)

    ; Submit the corrections.
    correctForm := this.getForm(ContractMaintenanceForm.FORM_CORRECT, record)
    correctForm.open()
    correctForm.submit(record)
  }


  findRecord(record) {
    form := this.getForm(ContractMaintenanceForm.FORM_FIND, record)
    form.open()
    form.submit(record)
  }


  deleteRecord(record) {
    this.findRecord(record)

    ; Remove the record.
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("Y")
  }
}
