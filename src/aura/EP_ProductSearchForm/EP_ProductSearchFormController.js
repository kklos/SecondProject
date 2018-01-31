/**
 * Created by klaud on 27.01.2018.
 */
({
  searchProductsSetEvent: function(cmp, event, helper) {

      var productWarehouseCityValue = cmp.find("productWarehouseCity").get("v.value");
      var productNameValue = cmp.find("productName").get("v.value");
      var productCodeValue = cmp.find("productCode").get("v.value");

        console.log(productWarehouseCityValue);
         if (!productWarehouseCityValue && !productNameValue && !productCodeValue) {

                  console.log('type sth...');
                  helper.showToast(event, '', 'Please type something to Search', 'info');
                  return;
              }


    var myEvent = $A.get("e.c:EP_ProductSearchFormQuery");
    myEvent.setParams({
      "warehouseCity": productWarehouseCityValue,
      "name": productNameValue,
      "code": productCodeValue
    });
    myEvent.fire();
  },

  clearProductsSetEvent: function(cmp, event, helper) {
    var myEvent = $A.get("e.c:EP_ProductSearchFormQuery");
    myEvent.setParams({
      "warehouseCity": '',
      "name": '',
      "code": ''
    });
    myEvent.fire();

    cmp.find("productWarehouseCity").set("v.value", '');
    cmp.find("productName").set("v.value", '');
    cmp.find("productCode").set("v.value", '');
  },

})
