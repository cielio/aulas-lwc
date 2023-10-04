public with sharing class ContactTriggerHandler {
  public static void ValidaCPF(List<Contact> contacts) {
    CPFUtil cpfUtil = new CPFUtil();
    for (Contact contact : contacts) {
      if (CPFUtil.isValidCPF(contact.CPF__c)) {
        contact.CPF__c = CPFUtil.cpf;
      } else {
        contact.CPF__c.addError(CPFUtil.mensagem);
      }
    }
  }
}
