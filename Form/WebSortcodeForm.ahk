#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class WebSortcodeForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_FIND := "F"
  static FORM_CORRECT := "C"


  getFields(formName) {
    fields := {}

    if (formName == this.FORM_FIND) {
      fields.push({ name: "item_code", description: "Enter the stockcode" })
    }

    if (formName == this.FORM_CORRECT) {
      fields.push({ name: "web_sortcode", description: "Enter the web sort code" })
      fields.push({ name: "web_active", description: "Web flag" })
    }

    return fields
  }
}