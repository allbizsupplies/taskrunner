#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class PriceRuleForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_FIND := "F"
  static FORM_CORRECT := "C"


  getFields(formName) {
    fields := {}

    if (formName == this.FORM_FIND || formName == this.FORM_CORRECT) {
      fields.push({ name: "price_rule", description: "Price type code" })
    }

    if (formName == this.FORM_CORRECT) {
      loop, 7
      {
        index := a_index - 1
        fields.push({ name: "basis_" . index, description: "Base on which factor will be applied to" })
        fields.push({ name: "factor_" . index, description: "Factor used to multiply with the base" })
        fields.push({ name: "detail_" . index, description: "Details of the calculations" })
      }
    }

    return fields
  }
}