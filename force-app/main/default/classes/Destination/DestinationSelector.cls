public with sharing class DestinationSelector {
    public static List<Destination__c> getDestinations() {
        return [SELECT Id, Name, Cost_Per_Person_Per_Day__c FROM Destination__c];
    }

    public static Destination__c createDestination(Destination__c newDestination) {
        insert newDestination;
        return newDestination;
    }

    public static Destination__c updateDestination(Destination__c destinationToUpdate) {
        update destinationToUpdate;
        return destinationToUpdate;
    }

    public static void deleteDestination(Id destinationId) {
        Destination__c destinationToDelete = [SELECT Id FROM Destination__c WHERE Id = :destinationId];
        delete destinationToDelete;
    }
}