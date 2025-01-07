trigger OpportunityTrigger on Opportunity (after update) {
    for(Opportunity opp: Trigger.New) {
        if(opp.StageName == 'Closed Won' && (Trigger.oldMap.get(opp.Id).StageName != 'Closed Won')) {
            if(opp.Start_Date__c >= opp.End_Date__c) {
                opp.addError('The start date should be earlier than the end date');
            } else {
                OpportunityTriggerController.createTrip(opp);
            }
        }
    }
}