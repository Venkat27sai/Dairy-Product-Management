import { LightningElement, wire } from 'lwc';
import getInventory from '@salesforce/apex/InventoryController.getInventory';

export default class InventoryManagement extends LightningElement {
    inventory;
    columns = [
        { label: 'Product Name', fieldName: 'Name' },
        { label: 'Product Type', fieldName: 'ProductType__c' },
        { label: 'Price', fieldName: 'Price__c', type: 'currency' },
        { label: 'Quantity Available', fieldName: 'Quantity__c', type: 'number' }
    ];

    @wire(getInventory)
    wiredInventory({ data, error }) {
        if (data) {
            this.inventory = data;
        } else if (error) {
            console.error(error);
        }
    }
}
