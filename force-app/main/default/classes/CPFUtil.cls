public with sharing class CPFUtil {
  private final String MENSAGEM_FORMATO_INVALIDO = 'Formato inválido. O CPF deve conter 11 dígitos numéricos, sem pontos, traços ou caracteres especiais.';
  private final String MENSAGEM_SEQUENCIA_INVALIDA = 'CPF inválido. CPFs com números em sequência ou repetidos não são aceitos.';
  private final String MENSAGEM_CPF_INVALIDO = 'CPF inválido. O CPF deve conter 11 dígitos numéricos válidos.';
  
  public String cpf { get; private set; }
  public String mensagem { get; private set; }

  public CPFUtil() {
  }

  public Boolean isValidCPF(String cpf) {
    if (isValidFormatCPF(cpf)) {
      if (containsSequentialNumbers(cpf)) {
        this.mensagem = MENSAGEM_SEQUENCIA_INVALIDA;
        return false;
      }
      Integer d1 = Integer.valueOf(cpf.substring(9, 10));
      Integer d2 = Integer.valueOf(cpf.substring(10, 11));
      System.debug('Digito 1: ' + d1);
      System.debug('Digito 2: ' + d2);

      Integer calcD1 = 0;
      Integer calcD2 = 0;

      for (Integer i = 0; i < 9; i++) {
        calcD1 += Integer.valueOf(cpf.substring(i, i + 1)) * (10 - i);
        System.debug('calcD1: ' + calcD1);
      }

      calcD1 = 11 - Math.mod(calcD1, 11);
      System.debug('calcD1: se ta igual ' + calcD1);
      if (calcD1 > 9) {
        calcD1 = 0;
      }
      //adiciona o calculo do primeiro digito para calcular o segundo
      calcD2 += calcD1 * 2;

      for (Integer i = 0; i < 9; i++) {
        calcD2 += Integer.valueOf(cpf.substring(i, i + 1)) * (11 - i);
        System.debug('calcD2: ' + calcD2);
      }
      calcD2 = 11 - Math.mod(calcD2, 11);
      System.debug('calcD2: se ta igual ' + calcD2);

      if (calcD2 > 9) {
        calcD2 = 0;
      }

      if (d1 == calcD1 && d2 == calcD2) {
        return true;
      }

      this.mensagem = MENSAGEM_CPF_INVALIDO;
      return false;
    }

    this.mensagem = MENSAGEM_FORMATO_INVALIDO;
    return false;
  }
  public Boolean isValidFormatCPF(String cpf) {
    if (cpf == null) {
      return false;
    }

    if (Pattern.matches('^[0-9]+$', cpf) && cpf.length() == 11) {
      this.cpf = cpf;
      return true;
    } else {
      return false;
    }
  }
  public Boolean containsSequentialNumbers(String cpf) {
    if (
      cpf == '00000000000' ||
      cpf == '11111111111' ||
      cpf == '22222222222' ||
      cpf == '33333333333' ||
      cpf == '44444444444' ||
      cpf == '55555555555' ||
      cpf == '66666666666' ||
      cpf == '77777777777' ||
      cpf == '88888888888' ||
      cpf == '99999999999' ||
      cpf == '12345678910' ||
      cpf == '12345678900' 
    ) {
      return true;
    }
    return false;
  }
}
