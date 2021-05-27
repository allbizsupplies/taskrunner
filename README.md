Pronto Taskrunner
=================

This app automates the process of entering data in the Pronto Xi Thin Client.

Installation
------------

1. Download **task.exe**.
2. Optionally, add this file's location to your `Path` environment variable.

Usage
-----

1. Log into Pronto Thin Client and select company "Allbiz Supplies Pty. Ltd."
2. Open a terminal and run a command from the list below.

Commands
--------

### **SO.M025** Sales Orders > Cancel Orders

Cancel sales orders in bulk.

#### Usage

Create a tab-delimited CSV file with the following columns:

| Column name | Required | Description                                                  |
| :---------- | :------- | :----------------------------------------------------------- |
| `order_no`  | Required | the sales order number without any alphabetical suffix       |
| `bo_suffix` | Optional | the alphabetical suffix for the sales order number, or blank |

Run this command: `task.exe sales_order cancel yourcsvfile.csv`.
