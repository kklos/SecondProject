/**
 * Created by klaud on 29.01.2018.
 */
({
   showPointerInMap: function (cmp, event) {
       var warehouse = cmp.get('v.warehouse');
           var myEventWarehouse = $A.get("e.c:EP_WarehouseLocatorMarker");
           myEventWarehouse.setParams({"warehouse": warehouse });
           myEventWarehouse.fire();

           var myEventWarehouseProductSelected = $A.get("e.c:EP_ProductWarehouseSelect");
           console.log(myEventWarehouseProductSelected);
           console.log(warehouse.ProductWarehouseId);
            myEventWarehouseProductSelected.setParams({"productWarehouseId": warehouse.ProductWarehouseId});
            myEventWarehouseProductSelected.fire();

           var cmpTarget = cmp.find('tableOneRow');
   }
})