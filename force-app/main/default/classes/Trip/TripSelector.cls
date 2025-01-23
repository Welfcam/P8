public with sharing class TripSelector {
    public static Trip__c createTrip(Trip__c trip) {
        insert trip;
        return trip;
    }
    
    public static Trip__c getTripById(Id tripId) {
        return [SELECT Id, Name, Status__c, Opportunity__c, AccountId__c, Destination__c, Start_Date__c, End_Date__c, Number_of_Participants__c 
                FROM Trip__c 
                WHERE Id = : tripId LIMIT 1];
    }

    public static List<Trip__c> getTripsByAccountId(Id accountId) {
        return [SELECT Id, Name, Status__c, Opportunity__c FROM Trip__c WHERE AccountId__c = :accountId];
    }

    public static List<Trip__c> getTripsByDestinationId(Id destinationId) {
        return [SELECT Id, Name, Status__c, Opportunity__c, AccountId__c FROM Trip__c WHERE Destination__c = :destinationId];
    }

    public static Trip__c updateTrip(Trip__c tripToUpdate) {
        update tripToUpdate;
        return tripToUpdate;
    }

    public static void deleteTripById(Id tripId) {
        Trip__c tripToDelete = [SELECT Id FROM Trip__c WHERE Id = :tripId LIMIT 1];
        delete tripToDelete;
    }

    public static void deleteTripsByAccountId(Id accountId) {
        List<Trip__c> tripListToDelete = [SELECT Id FROM Trip__C WHERE AccountId__c = :accountId];
        delete tripListToDelete;
    }
}
