#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class InvBulkMaintenanceForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_ITEM_CODE := 0
  static FORM_UPDATE_GROUP := "G"


  __new(fn, formName, record) {
    base.__new(fn, formName, record)
    this.selectionFields := this.getSelectionFields(formName, record)
  }


  getSelectionFields(formName) {
    fields := {}

    if (formName == this.FORM_UPDATE_GROUP) {
      ; Fields for item code range.
      fields.push({ name: "start_item_code", description: "Enter item code to start the report with" })
      fields.push({ name: "end_item_code", description: "Enter item code to end the report with" })

      ; Fields for group range.
      fields.push({ name: "start_group", description: "Enter item group to start the report with. [HELP]" })
      fields.push({ name: "end_group", description: "Enter item group to end the report with. [HELP]" })

      ; Fields for brand range.
      fields.push({ name: "start_brand", description: "Enter item brand to start the report with. [HELP]" })
      fields.push({ name: "end_brand", description: "Enter item brand to end the report with. [HELP]" })

      ; Fields for item type range.
      fields.push({ name: "start_item_type", description: "Enter the item type to start at. [HELP]." })
      fields.push({ name: "end_item_type", description: "Enter the item type to end at." })

      ; Fields for condition.
      fields.push({ name: "start_condition", description: "Enter the condition to start at. [HELP]." })
      fields.push({ name: "end_condition", description: "Enter the condition to end at." })

      ; Fields for sales type.
      fields.push({ name: "start_sales_type", description: "Enter start sales type" })
      fields.push({ name: "end_sales_type", description: "Enter end sales type" })

      ; Fields for GTIN.
      fields.push({ name: "start_gtin", description: "Enter GTIN to start the report with" })
      fields.push({ name: "end_gtin", description: "Enter GTIN to end the report with" })

      ; Field for ABC class.
      fields.push({ name: "abc_class", description: "Enter a Item Class Code, <spaces> for all [HELP]" })
    }

    return fields
  }


  getFields(formName) {
    fields := {}

    if (formName == this.FORM_UPDATE_GROUP) {
      fields.push({ name: "new_group", description: "Enter the new item group to change to" })
      fields.push({ name: "report", description: "Produce a report of updates performed" })
    }

    return fields
  }


  submit(values) {
    this.submitForm(this.selectionFields, values)
    this.controller.activateHotkey("{ENTER 2}")
    this.submitForm(this.fields, values)
    this.controller.activateHotkey("{ENTER 3}")
  }


  submitForm(fields, values) {
    for index, field in fields {
      if (field.condition) {
        metCondition := this.testCondition(field.condition)
        if (!metCondition) {
          continue
        }
      }

      fieldName := field.name
      value := values[fieldName]
      this.controller.sendOnStatus(value, field.description)

      ; Close the form early if finish-at field given.
      if (fieldName == this.finishAtFieldName) {
        this.controller.activateHotkey("{F4}")
        this.controller.waitClientNotStatus(field.description)
      }
    }

    ; Wait until the form has closed after submitting final field.
    if (index == this.selectionFields.maxIndex()) {
      this.controller.waitClientNotStatus(field.description)
    }
  }
}