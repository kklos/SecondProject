/**
 * Created by klaud on 27.01.2018.
 */
({
  geocodeAdddress: function(address, helper) {



    //    var url = "https://maps.google.com/maps/api/geocode/json?address="+address+"&sensor=false&connect-src=self";
    //
    //
    //    var jsonResult;
    //
    //    $.getJSON(url, function(data) {
    //        console.log(data);
    //    });
    //
    //    var xhr = new XMLHttpRequest();
    //    xhr.open('GET', url, true);
    //    xhr.responseType = 'json';
    //    xhr.onload = function() {
    //      var status = xhr.status;
    //      if (status === 200) {
    //
    //          console.log(data.results[0].geometry.location.lng);
    //          console.log(data.results[0].geometry.location.lat);
    //      } else {
    //      }
    //    };
    //    xhr.send();
  },

  showMoreDetails: function(component, event, marker, warehouse) {
    console.log(warehouse);
    console.log(marker);
    if (!marker._popup) {
      marker.bindPopup(warehouse.Name + '</br>Quantity: ' + warehouse.Quantity +
      '</br>Location: ' + warehouse.WarehouseStreet +
        '</br>More details: <a href="https://mechanics-dev-ed.lightning.force.com/' +
        warehouse.ProductWarehouseId + '">CLICK!</a>').openPopup();
    }

  },

  clearSelectedMarkersHlp: function(component, event) {
    var latLng;
    var markerAdded;
    var map = component.get('v.map');
    var allMarkers = component.get('v.markers');
    var updatedMarkers = [];
    var warehouses = component.get('v.warehouses');

    for (var i = 0; i < allMarkers.length; i++) {
      map.removeLayer(allMarkers[i]);
    }

    for (var i = 0; i < warehouses.length; i++) {
      var warehouse = warehouses[i];
      console.log(warehouse);
      latLng = [warehouse.WarehouseLat, warehouse.WarehouseLng];
      markerAdded = L.marker(latLng, {
        warehouse: warehouse
      }).addTo(map);
      updatedMarkers.push(markerAdded);
    }

    component.set('v.markers', updatedMarkers);

      var myEventWarehouseProductSelected = $A.get("e.c:EP_ProductWarehouseSelect");
      console.log(myEventWarehouseProductSelected);
      myEventWarehouseProductSelected.setParams({"productWarehouseId": 'xyz'});
       myEventWarehouseProductSelected.fire();

  }

})
