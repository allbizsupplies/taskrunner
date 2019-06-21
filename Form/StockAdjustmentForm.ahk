#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class StockAdjustmentForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_ENTRY := ""


  __new(fn, formName, record) {
    this.controller := fn.controller
    this.fields := this.getFields(formName, record)
    this.hotkey := formName
  }


  getFields(formName, record) {    
    fields := {}
    uom := record["uom"]

    if (uom == "BOX")
      precision := 2
    else 
      precision := 3

    if (formName == this.FORM_ENTRY) {
      fields.push({ name: "item_code", description: "Enter item code to adjust. [HELP]" })
      fields.push({ name: "uom", description: "Enter unit of measure to use, " . uom . " [HELP]" })
      fields.push({ name: "whs", description: "Enter the warehouse to adjust. [HELP]" })
      fields.push({ name: "reference", description: "Reference for this adjustment." })
      fields.push({ name: "reason", description: "Enter the reason for adjusting the stock level" })
      fields.push({ name: "qty", description: "Enter amount of adjustment in '" . uom . "' units, max of " . precision . " decimals allowed" })
    }

    return fields
  }
}