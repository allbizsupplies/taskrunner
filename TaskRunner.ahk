#include %A_Scriptdir% ; Set includes directory
#include DataReader.ahk
#include ThinClientController.ahk
#include Function/ContractFunction.ahk
#include Function/InvBulkMaintenanceFunction.ahk
#include Function/ShelfTicketsFunction.ahk
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


  product(args) {
    operation := args[1] . "Record"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_group(args) {
    op := args[1]
    operation := args[1] . "Group"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new InvBulkMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_gtin(args) {
    op := args[1]
    operation := args[1] . "GtinRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_price(args) {
    op := args[1]
    operation := args[1] . "PriceRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_supplier(args) {
    operation := args[1] . "SupplierRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_warehouse(args) {
    operation := args[1] . "WarehouseRecord"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new StockMaintenanceFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  product_web_sortcode(args) {
    operation := args[1] . "Record"
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new WebSortcodeFunction(this.controller)
    this.run(function, operation, dataReader.data)
  }


  price_recalc(args) {
    inputFile := args[2]
    dataReader := new DataReader(inputFile)
    function := new PriceRecalcFunction(this.controller)

    for index, item in data {
      function.open()
      function.runRecalc(item)
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
