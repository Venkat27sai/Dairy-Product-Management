public with sharing class RevenueController {
    @AuraEnabled(cacheable=true)
    public static List<RevenueWrapper> getRevenue() {
        List<RevenueWrapper> revenueList = new List<RevenueWrapper>();
        
        // Query total revenue per product
        List<AggregateResult> results = [SELECT Product__c, SUM(TotalRevenue__c) totalRevenue FROM Sales__c GROUP BY Product__c];
        
        // Collect all Product IDs from the AggregateResult
        Set<Id> productIds = new Set<Id>();
        for (AggregateResult result : results) {
            productIds.add((Id) result.get('Product__c'));
        }
        
        // Query product names in one go to avoid repeated SOQL queries in the loop
        Map<Id, String> productNamesMap = new Map<Id, String>();
        for (Product__c prod : [SELECT Id, Name FROM Product__c WHERE Id IN :productIds]) {
            productNamesMap.put(prod.Id, prod.Name);
        }
        
        // Populate the revenueList with product names and total revenue
        for (AggregateResult result : results) {
            Id productId = (Id) result.get('Product__c');
            revenueList.add(new RevenueWrapper(
                productNamesMap.get(productId),
                (Decimal) result.get('totalRevenue')
            ));
        }
        
        return revenueList;
    }

    public class RevenueWrapper {
        @AuraEnabled public String ProductName;
        @AuraEnabled public Decimal TotalRevenue;

        public RevenueWrapper(String productName, Decimal totalRevenue) {
            this.ProductName = productName;
            this.TotalRevenue = totalRevenue;
        }
    }
}
