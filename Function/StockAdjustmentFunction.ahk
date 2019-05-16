#include Function/FunctionBase.ahk
#include Form/StockAdjustmentForm.ahk


class StockAdjustmentFunction extends FunctionBase {


  id := "INV.T011"
  
 
  getForm(formName, record) {
    return new StockAdjustmentForm(this, formName, record)
  }


  createAdjustment(record) {
    form := this.getForm(StockAdjustmentForm.FORM_ENTRY, record)
    form.submit(record)
    form.confirm()
  }
}
