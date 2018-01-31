/**
 * Created by klaud on 27.01.2018.
 */

public with sharing class EP_WarehouseLocator {

    @AuraEnabled
    public static List<EP_Warehouse__c> findAll() {
        //String url = 'https://maps.google.com/maps/api/geocode/json?address='+address+'&sensor=false';
        //getLatLng();
        return [
                SELECT id, name, Location__Latitude__s, Location__Longitude__s
                FROM EP_Warehouse__c
                WHERE Location__Latitude__s != NULL AND Location__Longitude__s != NULL
                LIMIT 50
        ];
    }

    public static void getLatLng() {
        String url = 'http://maps.google.com/maps/api/geocode/json?address=WarszawaSzpitalna&sensor=false?key=AIzaSyAJimkfxVWt9yNuH-CwXROG7NpVclGbcMo';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            String JSON = response.getBody();
            Integer indexOfLocation = JSON.indexOf('location');
            String locationDetails = JSON.substring(indexOfLocation, indexOfLocation + 95);
            System.debug(locationDetails);
            Integer indexOfLat = locationDetails.indexOf('"lat" : ');
            Integer indexOfLng = locationDetails.indexOf('"lng" : ');
            String Lat = locationDetails.substring(indexOfLat + 8, indexOfLat + 17);
            String Lng = locationDetails.substring(indexOfLng + 8, indexOfLng + 17);
            System.debug(Lat);
            System.debug(Lng);
            Decimal LatDec = 0;
            Decimal LngDec = 0;
            LatDec = Decimal.valueOf(Lat);
            LngDec = Decimal.valueOf(Lng);

            System.debug(LatDec);
            System.debug(LngDec);

        }

        //add some records with only address,
        // first without update records - set field Location__c with values from google maps

        //firstly - do binding map with table
    }

}

