public with sharing class TripCancelBatch implements Database.Batchable<Trip__c> {
    public Iterable<Trip__c> start(Database.BatchableContext context) {
        Iterable<Trip__c> query = [SELECT Id, Status__c, Opportunity__r.Start_Date__c, Opportunity__r.Number_of_Participants__c FROM Trip__c];
        return query;
    }

    public void execute(Database.BatchableContext context, List<Trip__c> scope) {
        for(Trip__c trip : scope) {
            Date startDate = trip.Opportunity__r.Start_Date__c;
            Date today = Date.today();
            Integer daysDifference = startDate.daysBetween(today);
            Boolean isTripToCome = trip.Status__c == 'To come';
            Boolean isLessThan10Participants = trip.Opportunity__r.Number_of_Participants__c < 10;
            Boolean isStartingWithin7Days = daysDifference <= 7;
            if(isTripToCome && isStartingWithin7Days && isLessThan10Participants) {
                trip.Status__c = 'Cancelled';
            }
        }
        update scope;
    }

    public void finish(Database.BatchableContext context) {
        System.debug('Finished !');
    }                    
}

