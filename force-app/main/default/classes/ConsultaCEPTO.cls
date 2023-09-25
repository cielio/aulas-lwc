public with sharing class ConsultaCEPTO {
    @AuraEnabled
    public string cep { get; set; }
    @AuraEnabled
    public string logradouro { get; set; }
    @AuraEnabled
    public string bairro { get; set; }
    @AuraEnabled
    public string localidade { get; set; }
    @AuraEnabled
    public string uf { get; set; }
    @AuraEnabled
    public string ibge { get; set; }
    @AuraEnabled
    public string gia { get; set; }
    @AuraEnabled
    public string ddd { get; set; }
    @AuraEnabled
    public string siafi { get; set; }
    @AuraEnabled
    public string numero { get; set; }
}