public with sharing class TripUpdateStatusBatch implements Database.Batchable<Trip__c> {
    public Iterable<Trip__c> start(Database.BatchableContext context) {
        Iterable<Trip__c> query = [SELECT Id, Status__c, Start_Date__c, End_Date__c, Number_of_Participants__c FROM Trip__c];
        return query;
    }

    public void execute(Database.BatchableContext context, List<Trip__c> scope) {
        for(Trip__c trip : scope) {
            Date startDate = trip.Start_Date__c;
            Date endDate = trip.End_Date__c;
            Date today = Date.today();
            if(today < startDate) {
                trip.Status__c = 'To come';
            } else if(today >= startDate && today <= endDate) {
                trip.Status__c = 'Ongoing';
            } else if(today > endDate) {
                trip.Status__c = 'Finished';
            }
        }
        update scope;
    }

    public void finish(Database.BatchableContext context) {
        System.debug('Finished !');
    }                    
}