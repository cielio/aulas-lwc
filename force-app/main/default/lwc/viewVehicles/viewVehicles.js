import { LightningElement, wire } from 'lwc';
import getVehicles from '@salesforce/apex/Vehicles.getVehicles'
import persistPurchase from '@salesforce/apex/Vehicles.persistPurchase'

export default class ViewVehicles extends LightningElement {
    vehicles;

    @wire(getVehicles)
    wireVehicles({data, erro}){
        if (data) {
            this.vehicles = data;
            console.log('Deu bom '+ JSON.stringify(data));
        }
        else{
            console.log('Deu bom '+ erro);
        }
    }

    purchase(event){
        var targetId = event.currentTarget.dataset.id;
        console.log('sucesso' + targetId);
        persistPurchase({carId: targetId})
        .then(result => {
            console.log('sucesso' +result);
        })
        .catch(error => {
            console.log('sucesso' +error);
        })
    }
}