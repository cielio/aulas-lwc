import { LightningElement, api, track } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import consultarCEP from "@salesforce/apex/ConsultaCEPController.consultarCEP";
import atualizarEnderecoConta from "@salesforce/apex/ConsultaCEPController.atualizarEnderecoConta";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from 'lightning/refresh';

export default class ConsultaCEP extends NavigationMixin(LightningElement) {
  @api recordId;
  @track isModalOpen = false;
  @track cep;
  @track endereco = {
    cep: "",
    logradouro: "",
    localidade: "",
    uf: "",
    bairro: "",
    numero: ""
  };

  consultarCEP() {
    consultarCEP({ cep: this.cep })
      .then((result) => {
        this.endereco.cep = result.cep;
        this.endereco.logradouro = result.logradouro;
        this.endereco.localidade = result.localidade;
        this.endereco.uf = result.uf;
        this.endereco.bairro = result.bairro;

        this.handleToast(
          "Sucesso!",
          "Consulta realizada com Sucesso",
          "success"
        );
        console.log("Sucesso " + JSON.stringify(result));
        console.log("recordId " + JSON.stringify(this.recordId));
      })
      .catch((error) => {
        this.handleToast("Erro!", "Digite um CEP válido", "error");
        console.log("Error" + error);
      });
  }

  atualizarEnderecoConta() {
    atualizarEnderecoConta({
      consultaCEPTO: this.endereco,
      recordId: this.recordId
    })
      .then((result) => {
        this.closeModal();
        this.dispatchEvent(new RefreshEvent());
        this.handleToast(
          "Sucesso!",
          "Endereço da Conta Atualizo com Sucesso",
          "success"
        );
        console.log("Sucesso " + JSON.stringify(result));
      })
      .catch((error) => {
        this.handleToast(
          "Erro!",
          "Erro ao tentar atualizo o endereço da Conta",
          "error"
        );
        console.log("Error" + error);
      });
  }

  handleCEP(event) {
    const inputValue = event.target.value;
    const regex = /^[0-9]*$/; // Regex para aceitar apenas números
    if (regex.test(inputValue)) {
        this.cep = event.target.value;
    }
    event.target.value = this.cep;
    console.log("cep: " + JSON.stringify(this.cep));
  }

  handleInputChange(event) {
    const fieldName = event.target.name;
    this.endereco[fieldName] = event.target.value;
    console.log("endereço: " + JSON.stringify(this.endereco));
  }

  handleToast(title, message, variant) {
    const toastEvent = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    });
    this.dispatchEvent(toastEvent);
  }

  openModal() {
    this.limparCampos();
    this.isModalOpen = true;
  }
  closeModal() {
    this.limparCampos()
    this.isModalOpen = false;
  }

  limparCampos(){
    this.cep = '';
    this.endereco.cep = '';
    this.endereco.logradouro = '';
    this.endereco.localidade = '';
    this.endereco.uf = '';
    this.endereco.bairro = '';
  }
}
