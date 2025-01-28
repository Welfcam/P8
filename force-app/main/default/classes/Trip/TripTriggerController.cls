public with sharing class TripTriggerController {
    public static void handleTripDates(List<Trip__c> trips) {
        for(Trip__c trip: trips) {
            if(trip.Start_Date__c >= trip.End_Date__c) {
                trip.addError('The start date should be earlier than the end date');
            }
        }
    }
}
