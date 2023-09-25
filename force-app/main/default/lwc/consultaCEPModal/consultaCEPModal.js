import { track, api } from 'lwc';
import LightningModal from 'lightning/modal';
import consultarCEP from '@salesforce/apex/ConsultaCEPController.consultarCEP'
import atualizarEnderecoConta from '@salesforce/apex/ConsultaCEPController.atualizarEnderecoConta'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class ConsultaCEPModal extends LightningModal {
    @api recordId;
    cep;
    @track endereco = {
        cep: '',
        logradouro: '',
        localidade: '',
        uf: '',
        bairro: '',
        numero: '',
    };

    consultarCEP(){
        consultarCEP({cep: this.cep})
        .then(result => {
            this.endereco.cep = result.cep;
            this.endereco.logradouro = result.logradouro;
            this.endereco.localidade = result.localidade;
            this.endereco.uf = result.uf;
            this.endereco.bairro = result.bairro;

            this.handleToast('Sucesso!', 'Consulta realizada com Sucesso', 'success')
            console.log('Sucesso ' + JSON.stringify(result));
            console.log('recordId ' + JSON.stringify(this.recordId));
        })
        .catch(error => {
            this.handleToast('Erro!', 'Digite um CEP válido', 'error')
            console.log('Error' +error);
        })
    }

    atualizarEnderecoConta(){
        //location.reload();
        atualizarEnderecoConta({consultaCEPTO: this.endereco, recordId: this.recordId})
        .then(result => {
            this.handleToast('Sucesso!', 'Consulta realizada com Sucesso', 'success')
            console.log('Sucesso ' + JSON.stringify(result));

        })
        .catch(error => {
            this.handleToast('Erro!', 'Digite um CEP válido', 'error')
            console.log('Error' +error);
        })
    }

    handleCEP(event){
        this.cep = event.target.value;
        console.log('cep: ' + JSON.stringify(this.cep));
    }

    handleInputChange(event) {
        const fieldName = event.target.name;
        this.endereco[fieldName] = event.target.value;
        console.log('endereço: ' + JSON.stringify(this.endereco));
    }

    handleToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(toastEvent);
    }

    handleOkay() {
        this.close('okay');
    }
}