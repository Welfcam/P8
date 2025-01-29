//Trigger sur Trip, avant l'insertion ou la mise à jour. Utilise la méthode de TripTriggerController.
trigger TripTrigger on Trip__c (before insert, before update) {
    TripTriggerController.handleTripDates(Trigger.new); //Vérifie la cohérence des dates.
}