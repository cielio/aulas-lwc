import { LightningElement, api } from 'lwc';
import ConsultaCEPModal from 'c/consultaCEPModal';
import { NavigationMixin } from 'lightning/navigation';

export default class ConsultaCEP extends NavigationMixin(LightningElement) {
    @api recordId; 

    async handleClick() {
        this.navigateToObjectHome();
        const result = await ConsultaCEPModal.open({
            size: 'medium',
            recordId: this.recordId
        });
        // if modal closed with X button, promise returns result = 'undefined'
        // if modal closed with OK button, promise returns result = 'okay'
        console.log(result);
    }

    navigateToObjectHome() {
        // Navigate to the Account home page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Account',
                recordId: this.recordId,
                actionName: 'view',
            },
        });
    }
}