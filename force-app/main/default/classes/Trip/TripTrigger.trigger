trigger TripTrigger on Trip__c (before insert, before update) {
    TripTriggerController.handleTripDates(Trigger.new);
}