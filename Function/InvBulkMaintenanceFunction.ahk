#include Function/FunctionBase.ahk
#include Form/InvBulkMaintenanceForm.ahk


class InvBulkMaintenanceFunction extends FunctionBase {


  id := "INV.M111"
  
 
  getForm(formName) {
    return new InvBulkMaintenanceForm(this, formName)
  }


  updateGroup(record) {
    form := this.getForm(InvBulkMaintenanceForm.FORM_UPDATE_GROUP)
    form.open()
    form.submit(record)
  }
}
