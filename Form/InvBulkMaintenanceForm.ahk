#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class InvBulkMaintenanceForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_SELECT := ""


  getFields(formName) {
    fields := {}

    if (formName == this.FORM_SELECT) {
      fields.push({ name: "", description: "" })
    }

    if (formName == this.FORM_UPDATE_GROUP) {
      fields.push({ name: "", description: "" })
    }

    return fields
  }
}