import { LightningElement, wire } from 'lwc';
import getAllProducts from '@salesforce/apex/ProductController.getAllProducts';

export default class DairyProductsList extends LightningElement {
    dairyProducts;
    productColumns = [
        { label: 'Product Name', fieldName: 'Name' },
        { label: 'Product Type', fieldName: 'ProductType__c' },
        { label: 'Price', fieldName: 'Price__c', type: 'currency' }
    ];

    @wire(getAllProducts)
    wiredProducts({ data, error }) {
        if (data) {
            this.dairyProducts = data;
        } else if (error) {
            console.error(error);
        }
    }
}
