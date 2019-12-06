#include Form/FormBase.ahk


; Controller for Pronto functions. Handles operations in functions.
class FunctionBase {


  __new(controller) {
    this.controller := controller
  }


  ; Opens the Function in the thin client.
  open() {
    id := this.id
    ; Launch function using F11 shortcut dialog
    this.controller.launchFunction(this.id)
  }


  ; Opens the Function in the thin client.
  close() {
    this.controller.closeFunction()
  }


  cRecord(record) {
    this.createRecord(record)
  }


  dRecord(record) {
    this.deleteRecord(record)
  }


  uRecord(record) {
    this.updateRecord(record)
  }
  
}