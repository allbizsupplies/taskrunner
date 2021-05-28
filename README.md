# Pronto Taskrunner

This app automates the process of entering data in the Pronto Xi Thin Client.

## Installation

1. Download **pronto_task.exe**.
2. Optionally, add this file's location to your `Path` environment variable.

## Usage

1. Log into Pronto Thin Client and select company "Allbiz Supplies Pty. Ltd."
2. Open a terminal and run a command from the list below.

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

