#include Function/FunctionBase.ahk
#include Form/InvBulkMaintenanceForm.ahk


class InvBulkMaintenanceFunction extends FunctionBase {


  id := "INV.M111"
  
 
  getSelectionForm(formName) {
    return new InvBulkMaintenanceForm(this, formName)
  }


  updateGroup(record) {
    selectonForm := this.getSelectionForm(InvBulkMaintenanceForm.FORM_UPDATE_GROUP)
    selectonForm.open()
    selectonForm.submit(record)

    ; @todo
  }
}
