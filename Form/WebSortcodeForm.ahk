#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class WebSortcodeForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_FIND := "F"
  static FORM_CORRECT := "C"
  static FORM_BULLET_POINTS_ENTRY := "BE"

  getFields(formName, record) {
    fields := {}

    if (formName == this.FORM_FIND) {
      fields.push({ name: "item_code", description: "Enter the stockcode" })
    }

    if (formName == this.FORM_CORRECT) {
      fields.push({ name: "web_sortcode", description: "Enter the web sort code" })
      fields.push({ name: "web_active", description: "Web flag" })
    }

    if (formName == this.FORM_BULLET_POINTS_ENTRY) {
      loop
      {
        sequence_fieldname = seq_%a_index%
        bullet_point_fieldname = bullet_point_%a_index%
        if (record[bullet_point_fieldname] != "") {
          fields.push({ name: sequence_fieldname, description: " **Enter Help Text in quotes**" })
          fields.push({ name: bullet_point_fieldname, description: " **Enter Help Text in quotes**" })
        }
        else {
          break
        }
      }
    }

    return fields
  }
}