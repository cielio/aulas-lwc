public with sharing class ConsultaCEPController {
  @AuraEnabled
  public static ConsultaCEPTO consultarCEP(String cep) {
    try {
      //URL do serviço ViaCEP com base no CEP fornecido
      String url = 'https://viacep.com.br/ws/' + cep + '/json/';

      //Faz uma solicitação HTTP GET para o serviço ViaCEP
      HttpRequest req = new HttpRequest();
      req.setEndpoint(url);
      req.setMethod('GET');

      //Faz a solicitação HTTP e obtenha a resposta
      Http http = new Http();
      HttpResponse res = http.send(req);

      //Verifica se a solicitação foi bem-sucedida
      String responseBody = res.getBody();
      if (res.getStatusCode() == 200 && !responseBody.contains('erro')) {
  
        // Converte o JSON para ConsultaCEPTO
        ConsultaCEPTO consultaCEPResponse = (ConsultaCEPTO) JSON.deserialize(
          responseBody,
          ConsultaCEPTO.class
        );

        return consultaCEPResponse;
      }

      System.debug('Erro na solicitação HTTP: ' + res.getBody());
      return null;

    } catch (Exception e) {
      System.debug('Exceção ao fazer a solicitação HTTP: ' + e.getMessage());
      return null;
    }
  }

  @AuraEnabled
  public static void atualizarEnderecoConta(
    ConsultaCEPTO consultaCEPTO,
    Id recordId
  ) {
    try {
      Account acc = [
        SELECT
          Id,
          BillingCity,
          BillingState,
          BillingPostalCode,
          BillingCountry,
          BillingStreet
        FROM Account
        WHERE Id = :recordId
      ];
      acc.BillingCity = consultaCEPTO.localidade;
      acc.BillingState = consultaCEPTO.uf;
      acc.BillingPostalCode = consultaCEPTO.cep;
      acc.BillingCountry = 'Brasil';
      acc.BillingStreet =
        consultaCEPTO.logradouro +
        ', ' +
        consultaCEPTO.numero;
      update acc;
    } catch (Exception e) {
      // Lidar com exceções aqui, como erro de rede ou formato JSON inválido
      System.debug('Erro aotentar ao atulizar Conta: ' + e.getMessage());
    }
  }
}
