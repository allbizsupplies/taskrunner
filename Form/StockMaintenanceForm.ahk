#include Function/FunctionBase.ahk
#include Form/FormBase.ahk


class StockMaintenanceForm extends FormBase {


  ; Hotkeys for forms.
  static FORM_BOM := "XB"
  static FORM_CORRECT := "C"
  static FORM_ENTRY := "E"
  static FORM_FIND := "F"
  static FORM_GTIN_CORRECT := "GC"
  static FORM_GTIN_ENTRY := "GE"
  static FORM_GTIN_FIND := "GF"
  static FORM_PRICE_CORRECT := "PC"
  static FORM_PRICE_ENTRY := "PE"
  static FORM_PRICE_FIND := "PF"
  static FORM_SUPPLIER_CORRECT := "SC"
  static FORM_SUPPLIER_ENTRY := "SE"
  static FORM_SUPPLIER_FIND := "SF"
  static FORM_WAREHOUSE_STOCK_ADJUST := "WA"
  static FORM_WAREHOUSE_CORRECT := "WC"
  static FORM_WAREHOUSE_ENTRY := "WE"
  static FORM_WAREHOUSE_FIND := "WF"
  

  getFields(formName, record) {
    fields := {}

    if (formName == this.FORM_FIND or formName == this.FORM_ENTRY) {
      fields.push({ name: "item_code", className: "Edit31", description: "Enter the required item code" })
    }

    if (formName == this.FORM_CORRECT or formName == this.FORM_ENTRY) {
      ; Figure out the classname for the item type field
      ; (Expected to be Edit5 or Edit6)
      ; @todo Perform this check after opening the form.
      if (strlen(this.controller.getText("Edit5")) == 1) {
        item_type_className := "Edit5"
      }
      else {
        item_type_className := "Edit6"
      }


      fields.push({ name: "desc_line_1", className: "Edit1", description: "1st line of Item Description" })
      fields.push({ name: "desc_line_2", className: "Edit2", description: "2nd line of Item Description" })
      fields.push({ name: "desc_line_3", className: "Edit3", description: "3rd line of Item Description" })
      fields.push({ name: "apn", className: "Edit4", description: "Enter alternative part #, alpha part code or ""@"" to generate next GS1 #" })
      fields.push({ name: "group", condition: ["Static11", "0.000", "="], className: "Edit31", description: "Enter item group. [HELP]" })
      fields.push({ name: "item_type", className: "", description: "Enter the stock type code, ie S=Stocked item, press help for more" })
      fields.push({ name: "condition", className: "", description: "Space=Normal,No supply,[HELP]" })
      fields.push({ name: "abc_class", className: "", description: "Enter a Item Class Code [HELP]" })
      fields.push({ name: "process_req", className: "", description: "Enter A to Z , see [HELP] I=Indirect Item   (only used for Gift Vouchers)" })
      fields.push({ name: "warranty", className: "", description: "Enter warranty terms type flag A to Z" })
      fields.push({ name: "web_ribbon", className: "", description: "Enter first sort code/user group" })
      fields.push({ name: "sales_type", className: "", description: "Enter the sales type code [HELP]" })
      fields.push({ name: "price_group", className: "", description: "Enter second sort key/user group" })
      ; fields.push({ name: "storage_type", className: "", description: "Enter storage type - [HELP]" })
      fields.push({ name: "traceability", className: "", description: "Y=Serialised,L=Lot/Batch track,P=P/O track,W=Warranty(service Only)" })
      fields.push({ name: "brand", className: "", description: "Brand Code" })
      fields.push({ name: "uom", className: "", description: "Enter the unit description. [HELP]" })
      fields.push({ name: "alt_uom", className: "", description: "Enter the alternative unit description. [HELP]" })
      fields.push({ name: "conv_factor", condition: ["Edit17", "", "!="], className: "Edit33", description: "Alt. unit qty x this conv. factor = Base unit qty [HELP]" })
      fields.push({ name: "pack_uom", className: "", description: "Enter the pack unit description. [HELP]" })
      fields.push({ name: "pack_qty", className: "", description: "Enter the number of units in a pack" })
      fields.push({ name: "flc_page", className: "", description: "Enter import tariff item code (Press [HELP] for table of duty rates)" })
      fields.push({ name: "std_cost", className: "", description: "Enter the standard cost of this item" })
      fields.push({ name: "std_cost_conv", className: "", description: "Number of units prices and costs relate to" })
      fields.push({ name: "repl_cost", className: "", description: "Enter the replacement cost for this item" })
      fields.push({ name: "sales_cost", className: "", description: "Enter the sales stock cost for this item" })
      fields.push({ name: "excise_qty", className: "", description: "Enter excise quantity" })
      fields.push({ name: "bom", condition: [item_type_className, "K", "="], className: "", description: "Enter the BOM ID to use to cost this inventory item" })
      fields.push({ name: "reorder_policy", className: "", description: "Stock Reorder Report Policy, does not affect MRP. See [HELP]" })
      fields.push({ name: "planning_policy", className: "", description: "Planning Policy : used by the MRP System only. See [HELP]" })
      fields.push({ name: "buyer_code", className: "", description: "Enter the reorder buyer code. (see help)" })
      fields.push({ name: "use_mss_price", className: "", description: "Price protection claim can be raised for this item, [Y]es, [N]o" })
      fields.push({ name: "alloc_code", className: "", description: "Enter store allocation code" })
    }

    if (formName == this.FORM_PRICE_FIND or formName == this.FORM_PRICE_ENTRY) {
      fields.push({ name: "price_region", className: "Edit1", description: "Enter the multiple price region code or spaces if not used" })
    }

    if (formName == this.FORM_PRICE_CORRECT or formName == this.FORM_PRICE_ENTRY) {
      fields.push({ name: "price_rule", className: "Edit2", description: "Enter the pricing algorithm code 1 to 0 or A to Z" })
      fields.push({ name: "disc", className: "Edit3", description: "Enter the discount matrix code for this item code" })
      fields.push({ name: "price_0", className: "Edit4", description: "Enter the wholesale price" })
      fields.push({ name: "qty_1", className: "Edit5", description: "Enter the first qty break if any else [ENTER]" })
      fields.push({ name: "price_1", className: "Edit6", description: "Enter the first qty break price or discount" })
      fields.push({ name: "qty_2", className: "Edit7", description: "Enter the second qty break if any else [ENTER]" })
      fields.push({ name: "price_2", className: "Edit8", description: "Enter the second qty break price or discount" })
      fields.push({ name: "qty_3", className: "Edit9", description: "Enter the third qty break if any else [ENTER]" })
      fields.push({ name: "price_3", className: "Edit10", description: "Enter the third qty break price or discount" })
      fields.push({ name: "qty_4", className: "Edit11", description: "Enter the fourth qty break if any else [ENTER]" })
      fields.push({ name: "price_4", className: "Edit12", description: "Enter the fourth qty break price or discount" })
      fields.push({ name: "rrp_ex", className: "Edit13", description: "Recommended retail price NOT including tax" })
      fields.push({ name: "rrp_inc", className: "Edit14", description: "Enter the Retail Price Including Tax" })
      fields.push({ name: "prom_start", className: "Edit15", description: "Enter the promotional start date" })
      fields.push({ name: "prom_end", className: "Edit16", description: "Enter the promotional end date" })
      fields.push({ name: "prom_price", condition: ["Edit15", "", "!="], className: "Edit17", description: "Enter the promotional price (tax exclusive)" })
    }

    if (formName == this.FORM_SUPPLIER_FIND or formName == this.FORM_SUPPLIER_ENTRY) {
      fields.push({ name: "supplier", className: "Edit1", description: "Enter supplier name (or warehouse if manufactured/distributed)" })
    }

    if (formName == this.FORM_SUPPLIER_CORRECT or formName == this.FORM_SUPPLIER_ENTRY) {
      fields.push({ name: "supp_item_code", className: "Edit2", description: "Enter supplier item code (Default finished goods warehouse if manufactured)" })
      fields.push({ name: "supp_priority", className: "Edit3", description: "Enter a value in the range 1 to 9 (1=High,9=Low)" })
      fields.push({ name: "supp_uom", className: "Edit4", description: "Enter the supplier/manufacture unit description" })

      ; Only include the conversion factor if we are updating it.
      ; This means that conv factor cannot be set when supp UOM == sell UOM.
      if(record["supp_conv_factor"] != "" && record["supp_conv_factor"] > 1)
        fields.push({ name: "supp_conv_factor", className: "Edit5", description: "Conv. between supplier/manuf units and selling units" })

      fields.push({ name: "supp_pack_qty", className: "Edit6", description: "Enter number of items in a pack" })
      fields.push({ name: "supp_eoq", className: "Edit7", description: "Enter the minimum amount to purchase at any time" })
      fields.push({ name: "supp_last_buy_date", className: "Edit8", description: "Enter the last date the goods were ordered" })
      fields.push({ name: "supp_price", className: "Edit9", description: "Enter the current buy price of goods in foreign currency" })
      fields.push({ name: "supp_price_conv", className: "Edit10", description: "Enter the quantity of items that the price relates to" })
      fields.push({ name: "supp_currency", className: "Edit11", description: "Enter currency for supplier for this item code" })
      fields.push({ name: "supp_disc", className: "Edit12", description: "Enter supplier discount override per cent" })
      fields.push({ name: "supp_new_price_date", className: "Edit13", description: "Enter effective date for supplier's new buy price" })
      fields.push({ name: "supp_new_price", className: "Edit14", description: "Enter Supplier's New Buy Price for this stock line." })
    }

    if (formName == this.FORM_WAREHOUSE_FIND or formName == this.FORM_WAREHOUSE_ENTRY) {
      fields.push({ name: "whse", className: "Edit1", description: "Enter the warehouse for this warehouse" })
    }

    if (formName == this.FORM_WAREHOUSE_CORRECT or formName == this.FORM_WAREHOUSE_ENTRY) {
      fields.push({ name: "bin_loc", description: "Enter the picking bin location" })
      fields.push({ name: "bulk_loc", description: "Enter bulk location code (if any)" })
      fields.push({ name: "average_cost", condition: ["Static10", "0.000", "="], className: "Edit7", description: "Please enter warehouse average cost" })
      fields.push({ name: "minimum", description: "Enter the stock level at which reordering should be done" })
      fields.push({ name: "maximum", description: "Enter maximum amount of stock to be stored in warehouse" })
      fields.push({ name: "min_cover", description: "Enter minimum number of days to cover with this warehouse" })
      fields.push({ name: "max_cover", description: "Enter maximum number of days to cover with this warehouse" })
      fields.push({ name: "months_active", description: "Enter number of months this item has been active" })
      fields.push({ name: "replenish_multiple", description: "Enter replenish multiple for this receiving whse, this is only used in DRP" })
    }

    if (formName == this.FORM_GTIN_FIND) {
      fields.push({ name: "conv_factor", className: "", description: "Quantity this trade unit number represents" })
      fields.push({ name: "uom", className: "", description: "Saleable unit description e.g. EACH,KG,MTR,... [HELP]" })
      fields.push({ name: "gtin", className: "", description: "Enter Global Trade Item number or @ to generate a new GS1 number" })
    }

    if (formName == this.FORM_GTIN_ENTRY or formName == this.FORM_GTIN_CORRECT) {
      fields.push({ name: "gtin", className: "", description: "Enter Global Trade Item number or @ to generate a new GS1 number" })
    }

    if (formName == this.FORM_GTIN_ENTRY) {
      fields.push({ name: "uom", className: "", description: "Saleable unit description e.g. EACH,KG,MTR,... [HELP]" })
      fields.push({ name: "conv_factor", className: "", description: "Quantity this trade unit number represents" })
    }

    if (formName == this.FORM_GTIN_CORRECT) {
      fields.push({ name: "new_uom", className: "", description: "Saleable unit description e.g. EACH,KG,MTR,... [HELP]" })
      fields.push({ name: "new_conv_factor", className: "", description: "Quantity this trade unit number represents" })
    }

    if (formName == this.FORM_GTIN_CORRECT or formName == this.FORM_GTIN_ENTRY) {
      fields.push({ name: "length", className: "", description: "Enter the length in metres" })
      fields.push({ name: "width", className: "", description: "Enter the width in metres" })
      fields.push({ name: "height", className: "", description: "Enter the height in metres" })
      fields.push({ name: "weight", className: "", description: "Enter the weight in KG" })
      fields.push({ name: "own_box", className: "", description: "Does this item use its own box.  Any value in this field means YES. (ScanPack)" })
      fields.push({ name: "publish", className: "", description: "Is this GTIN to be published?" })
    }

    return fields
  }
  
}