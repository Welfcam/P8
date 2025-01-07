trigger TripTrigger on Trip__c (before update) {
    for(Trip__c trip: Trigger.New) {
        if (trip.Opportunity__r.Start_Date__c >= trip.Opportunity__r.End_Date__c) {
            trip.addError('The start date should be earlier than the end date');
            }
        }
    }