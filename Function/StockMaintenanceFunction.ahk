#include %A_Scriptdir%/Function/FunctionBase.ahk
#include %A_Scriptdir%/Form/StockMaintenanceForm.ahk


class StockMaintenanceFunction extends FunctionBase {


  id := "INV.M138"


  ; Hotkeys for sub-functions.
  static FUNC_WAREHOUSE := "W"
  static FUNC_PRICE := "P"
  
 
  getForm(formName) {
    return new StockMaintenanceForm(this, formName)
  }


  updatePriceRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_PRICE_FIND)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_PRICE_CORRECT)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    correctForm.close()
  }


  updateRecord(record) {
    this.findRecord(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_CORRECT)
    correctForm.open()
    correctForm.submit(record)
  }


  updateSupplierRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_FIND)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_CORRECT)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    correctForm.close()
  }


  updateWarehouseRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_WAREHOUSE_FIND)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_WAREHOUSE_CORRECT)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    correctForm.close()
  }


  createRecord(record) {
    entryForm := this.getForm(StockMaintenanceForm.FORM_ENTRY)
    entryForm.open()
    entryForm.submit(record)

    supplierEntryForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_ENTRY)
    supplierEntryForm.submit(record)
    ; Close dialog for next supplier record.
    this.controller.cancelForm()
    this.controller.closeFunction()

    priceEntryForm := this.getForm(StockMaintenanceForm.FORM_PRICE_ENTRY)
    priceEntryForm.submit(record)
    ; Close dialog for next price record.
    this.controller.cancelForm()
    this.controller.closeFunction()

    warehouseEntryForm := this.getForm(StockMaintenanceForm.FORM_WAREHOUSE_ENTRY)
    warehouseEntryForm.submit(record)
    ; Close dialog for next warehouse record.
    this.controller.cancelForm()
    this.controller.closeFunction()

    barcodeEntryForm := this.getForm(StockMaintenanceForm.FORM_WAREHOUSE_ENTRY)
    barcodeEntryForm.open()
    barcodeEntryForm.submit(record)
    ; Close dialog for next barcode record.
    this.controller.cancelForm()
    this.controller.closeFunction()

    ; Close dialog for next master record.
    this.controller.closeFunction()
  }


  findRecord(record) {
    form := this.getForm(StockMaintenanceForm.FORM_FIND)
    form.open()
    form.submit(record)
  }


  deleteRecord(record) {
    this.findRecord(record)

    ; Remove the record
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("Y")
  }


  deleteSupplierRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_FIND)
    findForm.open()
    findForm.submit(record)

    ; Remove the record
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("Y")
    this.controller.activateHotkey("{ESC}")
  }

}
