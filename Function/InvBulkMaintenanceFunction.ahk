#include Function/FunctionBase.ahk
#include Form/InvBulkMaintenanceForm.ahk


class InvBulkMaintenanceFunction extends FunctionBase {


  id := "INV.M170"
  
 
  getForm(formName) {
    return new InvBulkMaintenanceForm(this, formName, record)
  }


  updateGroup(record) {
    form := this.getForm(InvBulkMaintenanceForm.FORM_UPDATE_GROUP, record)
    form.open()
    form.submit(record)
  }
}
