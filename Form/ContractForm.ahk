#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class ContractForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_OPEN_CONTRACT := ""
  static FORM_ENTER_PRODUCT := "C"
  static FORM_FIND_PRODUCT := "F"
  static FORM_DETAIL := "D"


  getFields(formName) {
    fields := {}

    if (formName == this.FORM_OPEN_CONTRACT) {
      fields.push({ name: "contract", description: "Please enter the required contract number" })
      ; fields.push({ name: "cust_type", description: "Please enter the customer type to base price default" })
    }

    if (formName == this.FORM_FIND_PRODUCT) {
      fields.push({ name: "item_code", description: "" })
    }

    if (formName == this.FORM_ENTER_PRODUCT) {
      fields.push({ name: "item_code", description: "The item code used in our system" })
      fields.push({ name: "qty_1", description: "" })
      fields.push({ name: "price_1", description: "" })
      fields.push({ name: "qty_2", description: "" })
      fields.push({ name: "price_2", description: "" })
      fields.push({ name: "qty_3", description: "" })
      fields.push({ name: "price_3", description: "" })
      fields.push({ name: "start_date", description: "" })
      fields.push({ name: "end_date", description: "" })
    }

    if (formName == this.FORM_DETAIL) {
      fields.push({ name: "qty_1", description: "Enter the quantity break required" })
      fields.push({ name: "price_1", description: "Enter the quantity break price required" })
      fields.push({ name: "qty_2", description: "Enter the quantity break required" })
      fields.push({ name: "price_2", description: "Enter the quantity break price required" })
      fields.push({ name: "qty_3", description: "Enter the quantity break required" })
      fields.push({ name: "price_3", description: "Enter the quantity break price required" })
      fields.push({ name: "qty_4", description: "Enter the quantity break required" })
      fields.push({ name: "price_4", description: "Enter the quantity break price required" })
      fields.push({ name: "qty_5", description: "Enter the quantity break required" })
      fields.push({ name: "price_5", description: "Enter the quantity break price required" })
      fields.push({ name: "qty_6", description: "Enter the quantity break required" })
      fields.push({ name: "price_6", description: "Enter the quantity break price required" })
    }

    return fields
  }
}