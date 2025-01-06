public with sharing class OpportunityTriggerController {
    public static void createTrip(Opportunity opp) {

        Trip__c newTrip = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'To come'
        );
        insert newTrip;
    }
}