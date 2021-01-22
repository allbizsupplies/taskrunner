#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class CancelOrderForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_FIND := "F"
  static FORM_CANCEL := "C"
  static FORM_REASON := "R"
  

  getFields(formName) {
    fields := {}

    if (formName == this.FORM_FIND) {
      fields.push({ name: "order_no", description: "Please enter the required sales order" })
      fields.push({ name: "bo_suffix", description: "Please enter backorder suffix or return if not applicable" })
    }

    if (formName == this.FORM_REASON) {
      fields.push({ name: "reason_code", description: "Enter the reason code for this operation" })
    }

    return fields
  }
}