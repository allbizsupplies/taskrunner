#include Function/FunctionBase.ahk
#include Form/PriceRecalcForm.ahk
#include XMLViewerController.ahk


class PriceRecalcFunction extends FunctionBase {


  id := "INV.M184" ;

  
  getForm(id) {
    return new PriceRecalcForm(this, id)
  }


  runRecalc(record) {
    mainForm := this.getForm(PriceRecalcForm.FORM_MAIN)
    mainForm.submit(record)

    batchForm := this.getForm(PriceRecalcForm.FORM_BATCH)
    batchForm.submit(record)

    xmlViewer = new XMLViewerController()
    xmlViewer.waitStatus("done")
    xmlViewer.close()
  }

}
