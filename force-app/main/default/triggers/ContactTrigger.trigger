trigger ContactTrigger on Contact(before insert, before update) {
  if (Trigger.isBefore && Trigger.isUpdate) {
    if (!Trigger.new.isEmpty()) {
        //ContactTriggerHandler.ValidaCPF(Trigger.new);
    }
  }
}
