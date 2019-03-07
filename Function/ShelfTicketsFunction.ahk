#include Function/FunctionBase.ahk
#include Form/ShelfTicketsForm.ahk


class ShelfTicketsFunction extends FunctionBase {


  id := "INV.R089"

 
  getForm(formName) {
    return new ShelfTicketsForm(this, formName)
  }


  prepareRapidEntry() {
    ; Submit the start of the report form with no values.
    reportForm := this.getForm(ShelfTicketsForm.FORM_REPORT)
    reportForm.submit({ sequence: "B", format: "O", method: "R" })

    ; Open the rapid entry form.
    rapidEntryForm := this.getForm(ShelfTicketsForm.FORM_RAPID_ENTRY)
    rapidEntryForm.open()
  }

  
  enterTicketItemCode(record) {
    ; Submit the codes
    rapidEntryForm := this.getForm(ShelfTicketsForm.FORM_RAPID_ENTRY)
    rapidEntryForm.submit(record)
  }
}
