public with sharing class OpportunitySelector {    
    public static Opportunity getOpportunityById(Id opportunityId) {
        return [SELECT Id, Name, AccountId, Type, CloseDate, StageName, Destination__r.Name, Number_Of_Participants__c, Trip_Duration__c, Start_Date__c, End_Date__c, Total_Amount__c
                FROM Opportunity
                WHERE Id = :opportunityId];
    }
    
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        return [SELECT Id, Name, Type, CloseDate, StageName, Destination__r.Name, Number_Of_Participants__c, Trip_Duration__c, Start_Date__c, End_Date__c, Total_Amount__c 
                FROM Opportunity 
                WHERE AccountId = :accountId];
    }

    public static List<Opportunity> getOpportunitiesByStageName(String stageName) {
        return [SELECT Id, Name, Type, CloseDate, StageName, Destination__r.Name, Number_Of_Participants__c, Trip_Duration__c, Start_Date__c, End_Date__c, Total_Amount__c
                FROM Opportunity
                WHERE StageName = :stageName];
    }

    public static Opportunity createOpportunity(Opportunity newOpp) {
        insert newOpp;
        return newOpp;
    }

    public static Opportunity updateOpportunity(Opportunity oppToUpdate) {
        update oppToUpdate;
        return oppToUpdate;
    }

    public static void deleteOpportunityById(Id opportunityId) {
        Opportunity oppToDelete = [SELECT Id FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
        delete oppToDelete;
    }

    public static void deleteOpportunitiesByAccountId(Id accountId) {
        List<Opportunity> oppListToDelete = [SELECT Id FROM Opportunity WHERE AccountId = :accountId];
        delete oppListToDelete;
    }

    
}