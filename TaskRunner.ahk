#include %A_Scriptdir% ; Set includes directory
#include DataReader.ahk
#include ThinClientController.ahk
#include Function/CancelOrderFunction.ahk
#include Function/ContractFunction.ahk
#include Function/ContractMaintenanceFunction.ahk
#include Function/InvBulkMaintenanceFunction.ahk
#include Function/PriceRecalcFunction.ahk
#include Function/PriceRuleFunction.ahk
#include Function/ShelfTicketsFunction.ahk
#include Function/StockAdjustmentFunction.ahk
#include Function/StockMaintenanceFunction.ahk
#include Function/WebStockcodeReviewFunction.ahk


class TaskRunner {
  

  __new(companyName = "Allbiz Supplies Pty. Ltd.") {
    this.controller := new ThinClientController(companyName)
  }


  run(function, operation, data) {
    function.open()
    for index, item in data {
      function[operation](item)
    }
  }


  doOperation(function_class, operation, inputfile) {
    dataReader := new DataReader(inputFile)
    function := new function_class(this.controller)
    function.open()
    for index, item in dataReader.data {
      function[operation](item)
    }
  }


  create_stock_adjustment(args) {
    inputFile := args[1]
    this.doOperation(StockAdjustmentFunction, "createAdjustment", inputFile)
  }


  cancel_sales_order(args) {
    inputFile := args[1]
    dataReader := new DataReader(inputFile)
    function := new CancelOrderFunction(this.controller)
    function.open()
    this.controller.waitClientStatus("Please enter the required sales order")
    for index, item in dataReader.data {
      openFindForm := index > 1
      function.cancelRecord(item, openFindForm)
    }
    function.close()
  }


  price_recalc(args) {
    inputFile := args[1]
    dataReader := new DataReader(inputFile)
    function := new PriceRecalcFunction(this.controller)

    for index, item in dataReader.data {
      function.open()
      function.runRecalc(item)
      function.close()
    }
  }


  update_contract(args) {
    inputFile := args[1]
    this.doOperation(ContractMaintenanceFunction, "updateRecord", inputFile)
  }


  update_contract_item(args) {
    inputFile := args[1]
    dataReader := new DataReader(inputFile)
    function := new ContractFunction(this.controller)
    function.open()
    for index, item in dataReader.data {
      function.open()
      function.openContract(item)
      function["updateRecord"](item)
      function.close()
    }
  }


  update_product(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "updateRecord", inputFile)
  }


  update_product_group(args) {
    inputFile := args[1]
    this.doOperation(InvBulkMaintenanceFunction, "updateGroup", inputFile)
  }


  update_product_gtin(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "updateGtinRecord", inputFile)
  }


  update_product_price(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "updatePriceRecord", inputFile)
  }


  create_product_supplier(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "createSupplierRecord", inputFile)
  }


  update_product_supplier(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "updateSupplierRecord", inputFile)
  }


  delete_product_supplier(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "deleteSupplierRecord", inputFile)
  }


  update_product_supplier_header(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "updateSupplierRecordHeaderOnly", inputFile)
  }


  update_product_warehouse(args) {
    inputFile := args[1]
    this.doOperation(StockMaintenanceFunction, "updateWarehouseRecord", inputFile)
  }


  update_price_rule(args) {
    inputFile := args[1]
    this.doOperation(PriceRuleFunction, "updateRecord", inputFile)
  }


  transfer_stock(args) {
    inputFile := args[1]
    this.doOperation(StockTransferFunction, "createStockTransfer", inputFile)
  }


  update_web_data(args) {
    inputFile := args[1]
    this.doOperation(WebStockcodeReviewFunction, "updateRecord", inputFile)
  }


	showGUI() {
		global ActiveItem
		global TaskProgress

		; Add progress indicator elements
		Gui, Add, Text, ym, Item
		Gui, Add, Text,, Progress
		Gui, Add, Edit, ym vActiveItem +ReadOnly
		Gui, Add, Edit, vTaskProgress +ReadOnly

		; Display the GUI as an unfocusable window that is always on top
		; of other windows.
		Gui, +AlwaysOnTop
		Gui, Show, x0 y28 noActivate, %title%

    TaskProgress := 0
	}


  updateTaskStatus(index, item) {
		global ActiveItem
		global TaskProgress

    ActiveItem := item
    TaskProgress := index
  }
  
}
