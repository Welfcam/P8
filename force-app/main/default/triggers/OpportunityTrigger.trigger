//Trigger sur Opportunité. Utiliser les méthodes de OpportunityTriggerController
trigger OpportunityTrigger on Opportunity (before insert, before update, after update) {
   //Gère les actions à effectuer avant l'insertion ou la mise à jour d'une opportunité
   if(Trigger.isBefore) {
      OpportunityTriggerController.checkDates(Trigger.new); //vérification de la cohérence des dates saisies
      OpportunityTriggerController.checkNumberOfParticipants(Trigger.new); //vérification du nombre de participants (doit être >= 0)
   }
   //Gère les actions effectuée après la mise à jour d'une opportunité
   if(Trigger.isAfter) {
      OpportunityTriggerController.handleOppClosedWon(Trigger.new, Trigger.oldMap); //si passage du statut à Closed Won
      OpportunityTriggerController.handleOppProposal(Trigger.new, Trigger.oldMap); //si passage du statut à Proposal/Price Quote
      OpportunityTriggerController.handleOppNegotiation(Trigger.new, Trigger.oldMap); //si passage du statut à Negocation/Review
      OpportunityTriggerController.handleOppClosedLost(Trigger.new, Trigger.oldMap); //si passage du statut à Closed Lost
   }
}