import { LightningElement, wire } from 'lwc';
import getRevenue from '@salesforce/apex/RevenueController.getRevenue';

export default class RevenueTracking extends LightningElement {
    revenueData;
    revenueColumns = [
        { label: 'Product Name', fieldName: 'ProductName' },
        { label: 'Total Revenue', fieldName: 'TotalRevenue', type: 'currency' }
    ];

    @wire(getRevenue)
    wiredRevenue({ data, error }) {
        if (data) {
            this.revenueData = data;
        } else if (error) {
            console.error(error);
        }
    }
}
