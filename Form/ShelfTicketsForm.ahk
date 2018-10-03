#include %A_Scriptdir%/Function/FunctionBase.ahk
#include %A_Scriptdir%/Form/FormBase.ahk


class ShelfTicketsForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_RAPID_ENTRY := "E"
  static FORM_REPORT := ""


  getFields(formName) {    
    fields := {}

    if (formName == this.FORM_RAPID_ENTRY) {
      fields.push({ name: "item_code", description: "Enter item code label needed for. [UP] [DOWN]" })
    }

    if (formName == this.FORM_REPORT) {
      fields.push({ name: "sequence", description: "Print labels in (G)roup, (S)Item Code, (F)ifo, (B)in location or s(U)pplier seq" })
      fields.push({ name: "format", description: "O-Custom label formats, N-Normal, Y-Prodigy formats" })
      fields.push({ name: "method", description: "(Y)es, labels only where details changed since specified date or (R)apid entry" })
    }

    return fields
  }


  submit(values) {
    for index, field in this.fields {
      if (field.condition) {
        metCondition := this.testCondition(field.condition)
        if (!metCondition) {
          continue
        }
      }

      fieldName := field.name
      value := values[fieldName]
      this.controller.sendOnStatus(value, field.description)
    }
  }
}