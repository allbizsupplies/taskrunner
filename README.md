# Pronto Taskrunner

This app automates the process of entering data in the Pronto Xi Thin Client.

## Installation

1. Download **pronto_task.exe**.
2. Optionally, add this file's location to your `Path` environment variable.

## Usage

This program reads data from a CSV file and enters it into Pronto using keyboard macros. (That is, it simulates a person typing on a keyboard.)

Before running any of the commands below, you need to have a few thing ready:

1. Log into Pronto Thin Client and select the company "Allbiz Supplies Pty. Ltd."
2. Create a CSV file with the data you want to enter into Pronto.
3. Open Powershell or `cmd.exe`, and make sure you are in a folder where you can run `pronto_task.exe` and have access to your CSV file.

### Preparing your data file.

Your CSV file must be tab-delimited (AKA tab-separated), instead of comma-separated. The first row must include the headers for the columns. The heading names are not case-sensitive, and you can use spaces instead of underscores. (e.g. `item_code` and `Item Code` are the same.)

You can quickly create a tab-delimited file by copy-pasting your table from Excel into a plain text file in Notepad. (Your file can have any extension you want; it doesn't have to be `.csv`.)

### Executing a command

To execute a command, type the command - as shown in the command examples below - into your Powershell or `cmd` prompt. Instead of `yourcsvfile.csv`, use the filename you've given to your tab-delimited CSV. This taskrunner will focus on the Thin Client, check that the correct company has been selected, and begin running a function.

You cannot use your computer while the command is running.

To stop a command from executing, press `Ctrl+Escape`.

## Commands

### create_stock_adjustment

Adjust stock quantities.

Command example: `pronto_task.exe create_stock_adjustment yourcsvfile.csv`

Required function: `INV.T011` (Inventory > Inventory Transactions ? Adjust Item Levels)

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

Required function: `SO.M025` (Sales Orders > Cancel Orders)

#### Data Layout

| Column name | Required | Description                                                   |
| :---------- | :------- | :------------------------------------------------------------ |
| `order_no`  | Required | The sales order number without any alphabetical suffix.       |
| `bo_suffix` | Optional | The alphabetical suffix for the sales order number, or blank. |

### price_recalc

Do a price recalc for ranges of products.

Command example: `pronto_task.exe price_recalc yourcsvfile.csv`

Required function: `INV.M184` (Inventory > Prices Control > Recalculate Prices)

#### Data Layout

| Column name         | Required | Description                                                                 |
| :------------------ | :------- | :-------------------------------------------------------------------------- |
| `start_item_code`   | Required | The start item code                                                         |
| `end_item_code`     | Required | The end item code                                                           |
| `start_group`       | Optional | The start item group                                                        |
| `end_group`         | Optional | The end item group                                                          |
| `start_price_group` | Optional | The start price group ("Price Algor" in the Inventory Maintenance function) |
| `end_price_group`   | Optional | The end price group ("Price Algor" in the Inventory Maintenance function)   |
| `start_region`      | Optional | The start price region                                                      |
| `end_region`        | Optional | The end price region                                                        |

### transfer_stock

Transfer stock between warehouses.

Command example: `pronto_task.exe transfer_stock yourcsvfile.csv`

Required function: `INV.T019` (Inventory > Inventory Transactions > Transfer Items (Direct))

#### Data Layout

| Column name | Required | Description                                                                                |
| :---------- | :------- | :----------------------------------------------------------------------------------------- |
| `item_code` | Required | The item code.                                                                             |
| `reference` | Optional | A brief note (max 12 characters) for the adjustment.                                       |
| `reason`    | Required | A valid reason code to categorise this stock adjustment (e.g. `01` for stock take).        |
| `from_whs`  | Required | The warehouse the stock is to be transferred from.                                         |
| `to_whs`    | Required | The warehouse the stock is to be transferred to.                                           |
| `qty`       | Required | The quantity to transfer.                                                                  |
| `uom`       | Optional | The unit of measure to use for this adjustment. Leave blank to use the item's default UOM. |

### update_product

Update a product's stock master

Command example: `pronto_task.exe update_product yourcsvfile.csv`

Required function: `INV.M138` (Inventory > Inventory Maintenance > Inventory Maintenance/Enquiry)

#### Data Layout

| Column name   | Required   | Description                                                                           |
| :------------ | :--------- | :------------------------------------------------------------------------------------ |
| `item_code`   | Required   | The item code.                                                                        |
| `desc_line_1` | Optional   | The first line of the product description.                                            |
| `desc_line_2` | Optional   | The first line of the product description.                                            |
| `desc_line_3` | Optional   | The first line of the product description.                                            |
| `apn`         | Optional   | The manufacturer's product code.                                                      |
| `group`       | Optional   | The product group (This has no effect if this item has stock on hand).                |
| `item_type`   | Optional\* | The item type (This is required if any of the items in the data have type `K`).       |
| `condition`   | Optional   | The item's status (e.g. I=Inactive).                                                  |
| `abc_class`   | Optional   | The ABC class for the item.                                                           |
| `price_group` | Optional   | The price group (labelled as "Price Algor" in the thin client).                       |
| `brand`       | Optional   | The supplier corresponding to the product's brand or manufacturer.                    |
| `uom`         | Optional   | The product's unit of measure. (This should be omitted for items with stock on hand.) |

### update_product_gtin

Update a product's GTIN record(s)

Command example: `pronto_task.exe update_product_gtin yourcsvfile.csv`

Required function: `INV.M138` (Inventory > Inventory Maintenance > Inventory Maintenance/Enquiry)

#### Data Layout

| Column name       | Required | Description                                                    |
| :---------------- | :------- | :------------------------------------------------------------- |
| `item_code`       | Required | The item code.                                                 |
| `gtin`            | Required | The GTIN.                                                      |
| `uom`             | Required | The existing unit of measure for this GTIN.                    |
| `new_uom`         | Optional | The new unit of measure for this GTIN.                         |
| `conv_factor`     | Required | The existing conversion factor for this GTIN.                  |
| `new_conv_factor` | Optional | The new conversion factor for this GTIN.                       |
| `length`          | Optional | The length of the item/package that this GTIN refers to.       |
| `width`           | Optional | The width of the item/package that this GTIN refers to.        |
| `height`          | Optional | The height of the item/package that this GTIN refers to.       |
| `weight`          | Optional | The weight of the item/package that this GTIN refers to.       |
| `own_box`         | Optional | The package code for this GTIN. Leave blank if not applicable. |
| `publish`         | Required | Y = Publish this GTIN; N = Don't publish this GTIN.            |

### update_product_price

Update a product's price record(s)

Command example: `pronto_task.exe update_product_price yourcsvfile.csv`

Required function: `INV.M138` (Inventory > Inventory Maintenance > Inventory Maintenance/Enquiry)

#### Data Layout

| Column name    | Required | Description                                                            |
| :------------- | :------- | :--------------------------------------------------------------------- |
| `item_code`    | Required | The item code.                                                         |
| `price_region` | Required | The price region code. Leave blank to select the default price region. |
| `price_rule`   | Optional | The price rule (algorithm) for this price region.                      |
| `price_0`      | Optional | The lavel 0 price, excl. GST.                                          |
| `qty_1`        | Optional | The level 1 quantity.                                                  |
| `price_1`      | Optional | The lavel 1 price, excl. GST.                                          |
| `qty_2`        | Optional | The level 2 quantity.                                                  |
| `price_2`      | Optional | The lavel 2 price, excl. GST.                                          |
| `qty_3`        | Optional | The level 3 quantity.                                                  |
| `price_3`      | Optional | The lavel 3 price, excl. GST.                                          |
| `qty_4`        | Optional | The level 4 quantity.                                                  |
| `price_4`      | Optional | The lavel 4 price, excl. GST.                                          |
| `rrp_ex`       | Optional | The RRP, excl. GST.                                                    |
| `rrp_inc`      | Optional | The RRP, incl. GST.                                                    |
| `prom_start`   | Optional | The start date for the promotional price, excl GST.                    |
| `prom_end`     | Optional | The end date for the promotional price, excl GST.                      |
| `prom_price`   | Optional | The promotional price, excl GST.                                       |

### update_product_supplier

Update a product's stock supplier record(s)

Command example: `pronto_task.exe update_product_supplier yourcsvfile.csv`

Required function: `INV.M138` (Inventory > Inventory Maintenance > Inventory Maintenance/Enquiry)

#### Data Layout

| Column name           | Required | Description                                                                              |
| :-------------------- | :------- | :--------------------------------------------------------------------------------------- |
| `item_code`           | Required | The item code.                                                                           |
| `supplier`            | Required | The supplier code.                                                                       |
| `supp_item_code`      | Optional | The supplier's product code.                                                             |
| `supp_priority`       | Optional | The supplier's priority (1 = highest).                                                   |
| `supp_uom`            | Required | The supplier's unit of measure.                                                          |
| `supp_conv_factor`    | Required | The UOM conversion factor (This is ignored if `supp_uom` matches the item's sell UOM).   |
| `supp_pack_qty`       | Optional | The multiple of units that must be ordered.                                              |
| `supp_eoq`            | Optional | The minimum number of items that must be ordered. (Usually the same as `supp_pack_qty`.) |
| `supp_price`          | Optional | The supplier's price.                                                                    |
| `supp_price_conv`     | Optional | The conversion factor for the supplier's price.                                          |
| `supp_new_price_date` | Optional | The supplier's future price.                                                             |
| `supp_new_price`      | Optional | The date that the supplier's price will take effect.                                     |

### update_product_warehouse

Update a product's warehouse record(s)

Command example: `pronto_task.exe update_product_warehouse yourcsvfile.csv`

Required function: `INV.M138` (Inventory > Inventory Maintenance > Inventory Maintenance/Enquiry)

#### Data Layout

| Column name    | Required | Description                                 |
| :------------- | :------- | :------------------------------------------ |
| `item_code`    | Required | The item code.                              |
| `whse`         | Required | The warehouse code.                         |
| `bin_loc`      | Optional | The BIN location for the product.           |
| `bulk_loc`     | Optional | The bulk storage location for the product.  |
| `average_cost` | Optional | The average cost of the product.            |
| `minimum`      | Optional | The minimum stock quantity for the product. |
| `maximum`      | Optional | The maximum stock quantity for the product. |

### update_web_data

Update a product's web status and description

Command example: `pronto_task.exe update_web_data yourcsvfile.csv`

Required function: `ZWEB.X001` (Web Data / eChoice Integration > Stock Code Web Data Review)

**Note: you need to open this function manually before running this command.**

#### Data Layout

| Column name  | Required | Description                                                  |
| :----------- | :------- | :----------------------------------------------------------- |
| `stock_code` | Required | The item code.                                               |
| `web_desc`   | Required | The product description to be displayed on the online store. |
| `online`     | Optional | Y = display this product on the online store.                |
