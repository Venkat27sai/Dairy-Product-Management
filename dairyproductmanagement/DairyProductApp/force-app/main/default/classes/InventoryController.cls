public with sharing class InventoryController {
    @AuraEnabled(cacheable=true)
    public static List<Product__c> getInventory() {
        return [SELECT Name, ProductType__c, Price__c, Quantity__c FROM Product__c];
    }
}
