trigger OpportunityTrigger on Opportunity (before insert, before update, after update) {
   if(Trigger.isBefore) {
      OpportunityTriggerController.checkDates(Trigger.new);
      OpportunityTriggerController.checkNumberOfParticipants(Trigger.new);
   }
   if(Trigger.isAfter) {
      OpportunityTriggerController.handleOppClosedWon(Trigger.new, Trigger.oldMap);
      OpportunityTriggerController.handleOppProposal(Trigger.new, Trigger.oldMap);
      OpportunityTriggerController.handleOppNegotiation(Trigger.new, Trigger.oldMap);
      OpportunityTriggerController.handleOppClosedLost(Trigger.new, Trigger.oldMap);
   }
}