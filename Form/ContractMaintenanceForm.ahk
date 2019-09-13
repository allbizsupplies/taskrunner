#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class ContractMaintenanceForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_ENTRY := "E"
  static FORM_FIND := "F"
  static FORM_CORRECT := "C"


  getFields(formName, record) {
    fields := {}

    if (formName == this.FORM_FIND) {
      fields.push({ name: "customer", description: "Enter the customer. [HELP]" })
    }

    if (formName == this.FORM_CORRECT) {
      loop, 6
      {
        index := a_index
        fields.push({ name: "contract_" . index, description: "Please enter the required contract number" })

        ; Skip the date fields if the contract row is empty.
        contract := record["contract_" . index]
        if (contract != "" and contract != "{DEL}") {
          fields.push({ name: "start_date_" . index, description: "Please enter the required start date of the contract" })
          fields.push({ name: "end_date_" . index, description: "Please enter the required end date of the contract" })
        }
      }

      loop, 4
      {
        index := a_index
        fields.push({ name: "report_" . index, description: "Please enter the report number required" })
      }
    }

    return fields
  }


  ; @override Added delay because consecutive fields have same status.
  submit(values) {
    for index, field in this.fields {
      fieldName := field.name
      value := values[fieldName]
      this.controller.sendOnStatus(value, field.description)

      sleep, 100

      ; Close the form early if finish-at field given.
      if (fieldName == this.finishAtFieldName) {
        this.controller.activateHotkey("{F4}")
        this.controller.waitClientNotStatus(field.description)
      }

      ; Wait until the form has closed after submitting final field.
      if (index == this.fields.maxIndex()) {
        this.controller.waitClientNotStatus(field.description)
      }
    }
  }
}
