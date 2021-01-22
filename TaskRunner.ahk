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
#include Function/WebSortcodeFunction.ahk



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


  adjustment(args) {
    inputFile := args[1]
    dataReader := new DataReader(inputFile)
    function := new StockAdjustmentFunction(this.controller)
    function.open()
    for index, item in dataReader.data {
      function.createAdjustment(item)
    }
  }


  contract(args) {
    operation := args[1] . "Record"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new ContractMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  contract_item(args) {
    operation := args[1] . "Record"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new ContractFunction(this.controller)
    function.open()
    for index, item in dataReader.data {
      function.open()
      function.openContract(item)
      function[operation](item)
      function.close()
    }
  }


  ci(args) {
    this.contract_item(args)
  }


  product(args) {
    operation := args[1] . "Record"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  p(args) {
    this.product(args)
  }


  product_group(args) {
    op := args[1]
    operation := args[1] . "Group"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new InvBulkMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  pg(args) {
    this.product_group(args)
  }


  product_gtin(args) {
    op := args[1]
    operation := args[1] . "GtinRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  pgtin(args) {
    this.product_gtin(args)
  }


  product_price(args) {
    op := args[1]
    operation := args[1] . "PriceRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  pp(args) {
    this.product_price(args)
  }


  product_supplier(args) {
    operation := args[1] . "SupplierRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_supplier_header(args) {
    if (args[1] != "update") {
      throw { what: "Only update is supported for supplier_header", file: A_LineFile, line: A_LineNumber }
    }
    operation := "updateSupplierRecordHeaderOnly"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  ps(args) {
    this.product_supplier(args)
  }


  product_warehouse(args) {
    operation := args[1] . "WarehouseRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  pw(args) {
    this.product_warehouse(args)
  }


  product_web_sortcode(args) {
    operation := args[1] . "Record"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new WebSortcodeFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_bullet_points(args) {
    operation := args[1] . "BulletPointsRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new WebSortcodeFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  pws(args) {
    this.product_web_sortcode(args)
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


  price_rule(args) {
    operation := args[1] . "Record"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new PriceRuleFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  sales_order(args) {
    if (args[1] == "cancel") {
      inputFile := args[2]
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
  }


  stock_transfer(args) {
    operation := args[1] . "StockTransfer"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockTransferFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  tickets(args) {
    inputFile := args[1]
    dataReader := new DataReader(inputFile)
    function := new ShelfTicketsFunction(this.controller)
    function.open()
    function.prepareRapidEntry()
    for index, item in dataReader.data {
      function.enterTicketItemCode(item)
    }
    function.close()
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
