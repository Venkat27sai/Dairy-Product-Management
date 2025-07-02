public with sharing class ProductController {
    @AuraEnabled(cacheable=true)
    public static List<Product__c> getAllProducts() {
        return [SELECT Name, ProductType__c, Price__c FROM Product__c];
    }
}
