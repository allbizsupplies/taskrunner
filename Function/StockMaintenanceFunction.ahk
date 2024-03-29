#include Function/FunctionBase.ahk
#include Form/StockMaintenanceForm.ahk


class StockMaintenanceFunction extends FunctionBase {


  id := "INV.M138"


  ; Hotkeys for sub-functions.
  static FUNC_WAREHOUSE := "W"
  static FUNC_PRICE := "P"
  
 
  getForm(formName, record) {
    return new StockMaintenanceForm(this, formName, record)
  }


  updatePriceRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_PRICE_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_PRICE_CORRECT, record)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    correctForm.close()
  }


  updateRecord(record) {
    this.findRecord(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_CORRECT, record)
    correctForm.open()
    correctForm.submit(record)
  }


  updateSupplierRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_CORRECT, record)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    correctForm.close()
  }


  updateSupplierRecordHeaderOnly(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_HEADER_CORRECT, record)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    this.controller.activateHotkey("{F4}")
    correctForm.close()
  }


  updateGtinRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct gtin record
    findForm := this.getForm(StockMaintenanceForm.FORM_GTIN_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_GTIN_CORRECT, record)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    correctForm.close()
  }


  updateWarehouseRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_WAREHOUSE_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Submit the corrections
    correctForm := this.getForm(StockMaintenanceForm.FORM_WAREHOUSE_CORRECT, record)
    this.controller.activateHotkey("C")
    correctForm.submit(record)
    correctForm.close()
  }


  createRecord(record) {
    entryForm := this.getForm(StockMaintenanceForm.FORM_ENTRY, record)
    entryForm.open()
    entryForm.submit(record)

    supplierEntryForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_ENTRY, record)
    supplierEntryForm.submit(record)
    ; Close dialog for next supplier record.
    this.controller.cancelForm()
    this.controller.closeFunction()

    priceEntryForm := this.getForm(StockMaintenanceForm.FORM_PRICE_ENTRY, record)
    priceEntryForm.submit(record)
    ; Close dialog for next price record.
    this.controller.cancelForm()
    this.controller.closeFunction()

    warehouseEntryForm := this.getForm(StockMaintenanceForm.FORM_WAREHOUSE_ENTRY, record)
    warehouseEntryForm.submit(record)
    ; Close dialog for next warehouse record.
    this.controller.cancelForm()
    this.controller.closeFunction()

    gtinEntryForm := this.getForm(StockMaintenanceForm.FORM_GTIN_ENTRY, record)
    gtinEntryForm.open()
    gtinEntryForm.submit(record)
    ; Close dialog for next gtin record.
    gtinEntryForm.close()
    this.controller.closeFunction()

    ; Close dialog for next master record.
    this.controller.closeFunction()
  }


  createSupplierRecord(record) {
    this.findRecord(record)

    entryForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_ENTRY, record)
    entryForm.open()
    entryForm.submit(record)
    ; Close dialog for next supplier record.
    entryForm.close()
    this.controller.closeFunction()
  }


  createPriceRecord(record) {
    this.findRecord(record)

    priceEntryForm := this.getForm(StockMaintenanceForm.FORM_PRICE_ENTRY, record)
    priceEntryForm.open()
    priceEntryForm.submit(record)
    ; Close dialog for next gtin record.
    priceEntryForm.close()
    this.controller.closeFunction()
  }


  createGtinRecord(record) {
    this.findRecord(record)

    gtinEntryForm := this.getForm(StockMaintenanceForm.FORM_GTIN_ENTRY, record)
    gtinEntryForm.open()
    gtinEntryForm.submit(record)
    ; Close dialog for next gtin record.
    gtinEntryForm.close()
    this.controller.closeFunction()
  }


  findRecord(record) {
    form := this.getForm(StockMaintenanceForm.FORM_FIND, record)
    form.open()
    form.submit(record)
  }


  deleteRecord(record) {
    this.findRecord(record)

    ; Remove the record
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("Y")
  }


  deletePriceRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct price record.
    findForm := this.getForm(StockMaintenanceForm.FORM_PRICE_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Remove the record.
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("Y")

    ; Close the price record modal.
    this.controller.activateHotkey("{ESC}")
  }


  deleteSupplierRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct supplier record
    findForm := this.getForm(StockMaintenanceForm.FORM_SUPPLIER_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Remove the record
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("Y")
    this.controller.activateHotkey("{ESC}")
  }

  deleteGtinRecord(record) {
    this.findRecord(record)

    ; Navigate to the correct gtin record
    findForm := this.getForm(StockMaintenanceForm.FORM_GTIN_FIND, record)
    findForm.open()
    findForm.submit(record)

    ; Remove the record
    this.controller.activateHotkey("R")
    this.controller.activateHotkey("N")
    this.controller.activateHotkey("{Enter}")
    this.controller.activateHotkey("Y")
    this.controller.activateHotkey("{ESC}")
  }

}
