({
  doInit: function(component, event, helper) {

  },

  jsLoaded: function(component, event, helper) {
    console.log('leaflet');
    var map = L.map('map', {
      zoomControl: true,
      zoom: 1,
      zoomAnimation: false,
      fadeAnimation: true,
      markerZoomAnimation: true
    }).setView([52.229439, 21.012688], 10);
    L.tileLayer(
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', {
        attribution: 'Tiles © Esri'
      }).addTo(map);

    //                  let easyButtonInstance = L.easyButton('leaflet-bar', function(btn, map){
    //                      helper.clearSelectedMarkersHlp(component, event);
    //                  });
    //                  easyButtonInstance.addTo(map);
    component.set("v.map", map);
  },

  afterEasyButton: function(component, event, helper) {
  },

  setAllMarkers: function(component, event, helper) {

    var warehouses = event.getParam("warehouses");
    var allMarkers = component.get('v.markers');
    var updatedMarkers = [];
    var markerAdded;
    var latLng;
    component.set("v.warehouses", warehouses);
    component.set('v.buttonDisabled', true);
    var map = component.get('v.map');

    if (allMarkers) {
      for (var i = 0; i < allMarkers.length; i++) {
        map.removeLayer(allMarkers[i]);
      }
    }

       console.log(warehouses );
    if(warehouses && warehouses.length != 0 ){
        console.log(2);
        component.set('v.buttonDisabled', false);
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


//    for(var i = 0; i < updatedMarkers.length; i++){
//         var warehouse = warehouses[i];
//         updatedMarkers[i].on('click', function(event) {
//              helper.showMoreDetails(component, event, updatedMarkers[i], warehouse);
//            });
//    }
    component.set('v.markers', updatedMarkers);

  },

  setOneMarker: function(component, event, helper) {
    var map = component.get('v.map');
    var warehouse = event.getParam("warehouse");
    var allMarkers = component.get('v.markers');
    var selectedMarkers = [];
    console.log(allMarkers);

    for (var i = 0; i < allMarkers.length; i++) {
      map.removeLayer(allMarkers[i]);
    }


    var latLng = [warehouse.WarehouseLat, warehouse.WarehouseLng];
    var markerAdded = L.marker(latLng, {
      warehouse: warehouse
    }).addTo(map);
    map.panTo(latLng);
    markerAdded.on('click', function(event) {
      helper.showMoreDetails(component, event, markerAdded, warehouse);
    });
    allMarkers.push(markerAdded);

  },

  clearSelectedMarkers: function(component, event, helper) {
    helper.clearSelectedMarkersHlp(component, event);
  }
})
