@isTest
public class ConsultaCEPControllerTest {

    @isTest
    static void testConsultarCEP() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpViaCEPResponseGenerator());

        String validCEP = '01001000';
        ConsultaCEPTO resultado = ConsultaCEPController.consultarCEP(validCEP);

        System.assertNotEquals(null, resultado);
        System.assertEquals('01001-000', resultado.cep);
        System.assertEquals('São Paulo', resultado.localidade);
        System.assertEquals('SP', resultado.uf);

        String invalidCEP = '00000000';

        ConsultaCEPTO erro = ConsultaCEPController.consultarCEP(invalidCEP);

        System.assertEquals(null, erro);
    }

    @isTest
    static void testAtualizarEnderecoConta() {
        Account contaTeste = new Account(
            Name = 'Minha Conta de Teste',
            BillingCity = 'Cidade Original',
            BillingState = 'Estado Original',
            BillingPostalCode = '12345-678',
            BillingCountry = 'País Original',
            BillingStreet = 'Rua Original'
        );
        insert contaTeste;

        ConsultaCEPTO consultaCEPTO = new ConsultaCEPTO();
        consultaCEPTO.cep = '01001-000';
        consultaCEPTO.logradouro = 'Praça da Sé';
        consultaCEPTO.bairro = 'Sé';
        consultaCEPTO.localidade = 'São Paulo';
        consultaCEPTO.uf = 'SP';
        consultaCEPTO.ibge = '3550308';
        consultaCEPTO.gia = '1004';
        consultaCEPTO.ddd = '11';
        consultaCEPTO.siafi = '7107';
        consultaCEPTO.numero = '1'; 

        Test.startTest();
        ConsultaCEPController.atualizarEnderecoConta(consultaCEPTO, contaTeste.Id);
        Test.stopTest();

        Account contaAtualizada = [SELECT BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingStreet FROM Account WHERE Id = :contaTeste.Id];

        System.assertEquals('São Paulo', contaAtualizada.BillingCity);
        System.assertEquals('SP', contaAtualizada.BillingState);
        System.assertEquals('01001-000', contaAtualizada.BillingPostalCode);
        System.assertEquals('Brasil', contaAtualizada.BillingCountry);
        System.assertEquals('Praça da Sé, 1', contaAtualizada.BillingStreet);
    }
}