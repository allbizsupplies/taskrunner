#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class StockTransferForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_BOM := "XB"
  static FORM_CORRECT := "C"
  static FORM_ENTRY := "E"
  

  getFields(formName) {
    fields := {}

    if (formName == this.FORM_ENTRY) {
      fields.push({ name: "item_code", description: "Please enter the required item code" })
      fields.push({ name: "reference", description: "Enter a reference for this transfer" })
      fields.push({ name: "reason", description: "Enter the reason for transferring stock" })
      fields.push({ name: "from_whs", description: "Warehouse to transfer stock from" })
      fields.push({ name: "qty", description: "Please enter the stock quantity required" })
      fields.push({ name: "uom", description: "Enter unit of measure for stock to transfer" })
      fields.push({ name: "to_whs", description: "Warehouse to transfer stock to" })
    }

    return fields
  }
}