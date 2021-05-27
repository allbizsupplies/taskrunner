Pronto Taskrunner
=================

This app automates the process of entering data in the Pronto Xi Thin Client.

Installation
------------

1. Download **pronto_task.exe**.
2. Optionally, add this file's location to your `Path` environment variable.

Usage
-----

1. Log into Pronto Thin Client and select company "Allbiz Supplies Pty. Ltd."
2. Open a terminal and run a command from the list below.

Commands
--------

### create_stock_adjustment

Adjust stock quantities.

Command example: `pronto_task.exe create_stock_adjustment yourcsvfile.csv`

Required function: INV.T011 (Inventory > Inventory Transactions ? Adjust Item Levels)

#### Data Layout

| Column name | Required | Description                                                                                 |
| :---------- | :------- | :------------------------------------------------------------------------------------------ |
| `item_code` | Required | The item code.                                                                              |
| `uom`       | Optional | The unit of measure to use for this adjustment. Leave blank to use the item's default UOM.  |
| `whs`       | Required | The warehouse to use for this adjustment. Leave blank to use the items's default warehouse. |
| `reference` | Optional | A brief note (max 12 characters) for the adjustment.                                        |
| `reason`    | Required | A valid reason code to categorise this stock adjustment (e.g. `01` for stock take)          |
| `qty`       | Required | The quantity to adjust. Use a negative quantity to reduce stock                             |

### cancel_sales_orders

Cancel sales orders in bulk.

Command example: `pronto_task.exe cancel_sales_order yourcsvfile.csv`

Required function: SO.M025 (Sales Orders > Cancel Orders)

#### Data Layout

| Column name | Required | Description                                                   |
| :---------- | :------- | :------------------------------------------------------------ |
| `order_no`  | Required | The sales order number without any alphabetical suffix.       |
| `bo_suffix` | Optional | The alphabetical suffix for the sales order number, or blank. |
