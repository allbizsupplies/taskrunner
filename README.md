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

### cancel_sales_orders

Cancel sales orders in bulk.

Command example: `pronto_task.exe caancel_sales_order yourcsvfile.csv`

Required function: SO.M025 (Sales Orders > Cancel Orders)

#### data layout

| Column name | Required | Description                                                  |
| :---------- | :------- | :----------------------------------------------------------- |
| `order_no`  | Required | the sales order number without any alphabetical suffix       |
| `bo_suffix` | Optional | the alphabetical suffix for the sales order number, or blank |
