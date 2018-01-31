({
  init: function(cmp, event, helper) {

    helper.showHideSpinner(cmp, event, true);
    var productSearchName = event.getParam("name");
    var productSearchCode = event.getParam("code");
    var productSearchWarehouseCity = event.getParam("warehouseCity");

    var action = cmp.get("c.getResulsSearchTable");
    action.setParams({
      "name": productSearchName,
      "warehouseCity": productSearchWarehouseCity,
      "code": productSearchCode
    });
    action.setCallback(this, function(response) {
         helper.showHideSpinner(cmp, event, false);
      var state = response.getState();
      if (state === "SUCCESS" || state === "DRAFT") {
        console.log(response.getReturnValue());
        cmp.set("v.productResults", response.getReturnValue());



        var myEvent = $A.get("e.c:EP_WarehousesLocator");
        myEvent.setParams({
          "warehouses": response.getReturnValue()
        });
        myEvent.fire();

      } else if (state === "ERROR") {
        console.log('Error: ' + JSON.stringify(response.error));
      } else {
        console.log('Unknown problem, state: ' + response.state + ', error: ' + JSON.stringify(response.error));
      }
    });
    $A.enqueueAction(action);
  },

  onProductWarehouseSelect: function(cmp, event, helper) {
    console.log('OK');
    var productWarehouseSelectedId = event.getParam("productWarehouseId");
    console.log(productWarehouseSelectedId);
    cmp.set('v.selectedProductWarehouseId', productWarehouseSelectedId);
  }


})
