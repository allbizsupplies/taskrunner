#include Function/FunctionBase.ahk
#include Form/WebStockcodeReviewForm.ahk


class WebStockcodeReviewFunction extends FunctionBase {


  id := "" ; @todo figure out how to launch this function


  getForm(formName, record) {
    return new WebStockcodeReviewForm(this, formName, record)
  }


  ; @override
  open() {
    ; Just focus on Pronto since we can't launch
    ; this crappy hack function directly
    this.controller.focusClient()
    
    ; @todo figure out how to launch this function
  }


  updateRecord(record) {
    this.findRecord(record)

    form := this.getForm(WebStockcodeReviewForm.FORM_CORRECT, record)
    form.open()
    form.submit(record)
  }


  findRecord(record) {
    form := this.getForm(WebStockcodeReviewForm.FORM_FIND, record)

    form.open()
    form.submit(record)
  }

}
