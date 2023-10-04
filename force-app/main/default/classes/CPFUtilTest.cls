@isTest
public class CPFUtilTest {

    @isTest
    static void testIsValidCPF() {
        CPFUtil cpfUtil = new CPFUtil();
        // Casos de teste válidos
        System.assert(cpfUtil.isValidCPF('10526698756') == true, 'CPF válido não foi reconhecido.');

        // Casos de teste inválidos
        System.assert(cpfUtil.isValidCPF('12345678900') == false, 'CPF com números sequenciais não foi rejeitado.');
        System.assert(cpfUtil.isValidCPF('111.111.111-11') == false, 'CPF com formatação inválida não foi rejeitado.');
        System.assert(cpfUtil.isValidCPF('123.456.789-01') == false, 'CPF com formatação inválida não foi rejeitado.');
        System.assert(cpfUtil.isValidCPF('12345678901') == false, 'CPF com dígitos verificadores inválidos não foi rejeitado.');
    }

    @isTest
    static void testIsValidFormatCPF() {
        CPFUtil cpfUtil = new CPFUtil();
        // Casos de teste válidos
        System.assert(cpfUtil.isValidFormatCPF('12345678909') == true, 'CPF com formato válido não foi reconhecido.');

        // Casos de teste inválidos
        System.assert(cpfUtil.isValidFormatCPF('123.456.789-01') == false, 'CPF com formatação inválida não foi rejeitado.');
        System.assert(cpfUtil.isValidFormatCPF('123456789012') == false, 'CPF com formato inválido não foi rejeitado.');
        System.assert(cpfUtil.isValidFormatCPF('abcdefghijk') == false, 'CPF não numérico não foi rejeitado.');
        System.assert(cpfUtil.isValidFormatCPF(null) == false, 'CPF nulo não foi rejeitado.');
    }

    @isTest
    static void testContainsSequentialNumbers() {
        CPFUtil cpfUtil = new CPFUtil();
        // Casos de teste válidos
        System.assert(cpfUtil.containsSequentialNumbers('00000000000') == true, 'CPF com números sequenciais não foi reconhecido.');

        // Casos de teste inválidos
        System.assert(cpfUtil.containsSequentialNumbers('10526698756') == false, 'CPF sem números sequenciais foi erroneamente reconhecido como inválido.');
    }
}
