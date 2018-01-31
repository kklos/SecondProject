/**
 * Created by klaud on 27.01.2018.
 */

public with sharing class EP_ResultsSearchTable {

    public class TableWrapper {

        @AuraEnabled
        public Id ProductWarehouseId;
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public String WarehouseCity;
        @AuraEnabled
        public Decimal Quantity;
        @AuraEnabled
        public String WarehouseStreet;
        @AuraEnabled
        public String WarehouseCountry;
        @AuraEnabled
        public Decimal WarehouseLat;
        @AuraEnabled
        public Decimal WarehouseLng;

        public TableWrapper(Id productWarehouseId, String name, String warehouseCity, Decimal quantity, String warehouseStreet, String warehouseCountry,
                Decimal warehouseLat, Decimal warehouseLng) {
            this.ProductWarehouseId = productWarehouseId;
            this.Name = name;
            this.WarehouseCity = warehouseCity;
            this.Quantity = quantity;
            this.WarehouseStreet = warehouseStreet;
            this.WarehouseCountry = warehouseCountry;
            this.WarehouseLat = warehouseLat;
            this.WarehouseLng = warehouseLng;
        }
    }

    @AuraEnabled
    public static List<TableWrapper> getResulsSearchTable(String name, String warehouseCity, String code) {
        System.debug(warehouseCity);

        List<TableWrapper> productsTable = new List<TableWrapper>();
        List<EP_ProductWarehouse__c> warehouses = new List<EP_ProductWarehouse__c>();
        List<Product2> products = new List<Product2>();

        if (!(String.isBlank(name) && String.isBlank(warehouseCity) && String.isBlank(code))) {
            List<String> queryComponents = new String[]{
                    MM_Tools.createQueryComponent('Product__r.Name', name),
                    MM_Tools.createQueryComponent('Warehouse__r.City__c', warehouseCity),
                    MM_Tools.createQueryComponent('Product__r.ProductCode', code)
            };
            String databaseQuery = MM_Tools.createSearchMechanicsQuery(
                    'SELECT Id, Warehouse__r.City__c, Warehouse__r.Location__Latitude__s, Warehouse__r.Location__Longitude__s,'
                            + 'Warehouse__r.Street__c, Warehouse__r.Country__c, '
                            + 'Quantity__c, Product__r.Name, Product__r.ProductCode  FROM EP_ProductWarehouse__c WHERE ',
                    queryComponents
            );

            System.debug(databaseQuery);
            warehouses = Database.query(databaseQuery);

            for (EP_ProductWarehouse__c warehouse : warehouses) {
                if (warehouse.Warehouse__r.Location__Latitude__s != null) {
                    System.debug(warehouse.Product__r.Name);
                    TableWrapper tableWrapper = new TableWrapper(warehouse.Id, warehouse.Product__r.Name, warehouse.Warehouse__r.City__c, warehouse.Quantity__c, warehouse.Warehouse__r.Street__c,
                            warehouse.Warehouse__r.Country__c, warehouse.Warehouse__r.Location__Latitude__s, warehouse.Warehouse__r.Location__Longitude__s);
                    productsTable.add(tableWrapper);
                }
            }
        }

        return productsTable;

    }


}