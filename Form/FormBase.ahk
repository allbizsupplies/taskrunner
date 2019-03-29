

class FormBase {


  __new(fn, formName) {
    this.controller := fn.controller
    this.fields := this.getFields(formName)
    this.hotkey := formName
  }


  open() {
    hotkey := this.hotkey
    this.controller.activateHotkey(this.hotkey)
  }


  close() {
    this.controller.activateHotkey("{ESC}")
  }


  finishAt(fieldName) {
    this.finishAtFieldName := fieldName 
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


  testCondition(condition) {
    className := condition[1]
    value := condition[2]
    operator := condition[3]

    fieldValue := this.controller.getText(className)

    if (operator == "=") {
      return fieldValue == value
    }
    else if (operator == "==") {
      return fieldValue == value
    }
    else if (operator == "!=") {
      return fieldValue <> value
    }
    else if (operator == ">") {
      return fieldValue > value
    }
    else if (operator == "<") {
      return fieldValue < value
    }
    else if (operator == ">=") {
      return fieldValue >= value
    }
    else if (operator == "<=") {
      return fieldValue <= value
    }

    return False
  }
}