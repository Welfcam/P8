public with sharing class TripController {
    public static Trip__c createTrip(Opportunity opp){
        Trip__c newTrip = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'To come',
            Destination__c = opp.Destination__c,
            Start_Date__c = opp.Start_Date__c,
            End_Date__c = opp.End_Date__c,
            Number_Of_Participants__c = opp.Number_Of_Participants__c,
            Total_Cost__c = opp.Total_Amount__c,
            AccountId__c = opp.AccountId
        );
        return TripSelector.createTrip(newTrip);
	}

    public static Trip__c getTripById(Id tripId) {
        return TripSelector.getTripById(tripId);
    }

    public static List<Trip__c> getTripsByAccountId(Id accountId) {
        return TripSelector.getTripsByAccountId(accountId);
    }

    public static List<Trip__c> getTripsByDestinationId(Id destinationId) {
        return TripSelector.getTripsByDestinationId(destinationId);
    }

    public static Trip__c updateTrip(Trip__c tripToUpdate) {
        return TripSelector.updateTrip(tripToUpdate);
    }

    public static void deleteTripById(Id tripId) {
        TripSelector.deleteTripById(tripId);
    }

    public static void deleteTripsByAccountId(Id accountId) {
        TripSelector.deleteTripsByAccountId(accountId);
    }

	 
}