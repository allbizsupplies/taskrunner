#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class WebStockcodeReviewForm extends FormBase {

  ; Hotkeys for forms.
  static FORM_FIND := "F"
  static FORM_CORRECT := "C"

  getFields(formName, record) {
    fields := {}

    if (formName == this.FORM_FIND) {
      fields.push({ name: "stock_code", description: "stock-code - Alpha-numeric. Size = 30" })
    }

    if (formName == this.FORM_CORRECT) {
      fields.push({ name: "web_desc", description: "Web Description" })
      fields.push({ name: "online", description: "Online State Y or N" })
    }

    return fields
  }
}