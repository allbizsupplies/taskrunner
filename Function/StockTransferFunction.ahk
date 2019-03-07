#include Function/FunctionBase.ahk
#include Form/StockTransferForm.ahk


class StockTransferFunction extends FunctionBase {


  id := "INV.T019"


  ; Hotkeys for sub-functions.
  static FUNC_WAREHOUSE := "W"
  static FUNC_PRICE := "P"
  
 
  getForm(formName) {
    return new StockTransferForm(this, formName)
  }


  createStockTransfer(record) {
    entryForm := this.getForm(StockTransferForm.FORM_ENTRY)
    entryForm.submit(record)
    ; Need to manually submit transfer after form is completed
    this.controller.activateHotkey("{Enter}")
  }

}
