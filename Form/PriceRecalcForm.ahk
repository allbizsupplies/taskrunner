#include Form/FormBase.ahk


class PriceRecalcForm extends FormBase {


  ; forms.
  static FORM_MAIN := 0
  static FORM_BATCH := 1


  getFields(form) {
    fields := {}

    if (form == this.FORM_MAIN) {
      fields.push({ name: "sequence", description: "S - Item or G - Item Group sequence" })
      fields.push({ name: "detail", description: "Is a full detailed report required, or only a summary?" })
      fields.push({ name: "basis", description: "M - Markup, P - Percentage increase of current prices, A - Apply price rules" })
      fields.push({ name: "update", description: "Y - update prices, N - only reports change" })
      fields.push({ name: "update_drop", description: "(Y)es update even if price is less than old price, (N)o don't" })
      fields.push({ name: "update_zero", description: "(Y)es update even if original price is zero" })
      fields.push({ name: "start_item_code", description: "Enter item code to start the report with" })
      fields.push({ name: "end_item_code", description: "Enter item code to end the report with" })
      fields.push({ name: "start_group", description: "Enter item group to start the report with. [HELP]" })
      fields.push({ name: "end_group", description: "Enter item group to end the report with. [HELP]" })
      fields.push({ name: "start_class", description: "Enter the stock classification to start the report" })
      fields.push({ name: "end_class", description: "Enter the stock classification to end the report" })
      fields.push({ name: "start_price_group", description: "Enter start user group. [HELP]" })
      fields.push({ name: "end_price_group", description: "Enter end user group. [HELP]" })
      fields.push({ name: "start_region", description: "Enter the region to start the report. [HELP]" })
      fields.push({ name: "end_region", description: "Enter the region to end the report. [HELP]" })
      fields.push({ name: "rule", description: "Blank all rules applied or Enter rule you wish to apply" })
      fields.push({ name: "warehouse", description: "Enter warehouse to use for average price calculations" })
      fields.push({ name: "level_0", description: "Y - will be updated, N - not changed" })
      fields.push({ name: "level_1", description: "Y - will be updated, N - not changed" })
      fields.push({ name: "level_2", description: "Y - will be updated, N - not changed" })
      fields.push({ name: "level_3", description: "Y - will be updated, N - not changed" })
      fields.push({ name: "level_4", description: "Y - will be updated, N - not changed" })
      fields.push({ name: "rrp", description: "Y - will be updated, N - not changed" })
      fields.push({ name: "rrp_inc", description: "Y - will be updated, N - not changed" })
    }

    if (form == this.FORM_MAIN) {
      fields.push({ name: "batch", description: "I - run immediately, B - submit to batch, S - save parameters" })
    }

    return fields
  }
}