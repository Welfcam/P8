//Classe de gestion des Opportunités Salesforce. Utilise OpportunitySelector pour interagir avec la base de données.
public with sharing class OpportunityController {
    public static Opportunity getOpportunityById(Id opportunityId) {
        return OpportunitySelector.getOpportunityById(opportunityId);
    }

    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        return OpportunitySelector.getOpportunitiesByAccountId(accountId);
    }

    public static List<Opportunity> getOpportunitiesByStageName(String stageName) {
        return OpportunitySelector.getOpportunitiesByStageName(stageName);
    }

    public static Opportunity createOpportunity(Opportunity newOpp) {
        return OpportunitySelector.createOpportunity(newOpp);
    }

    public static Opportunity updateOpportunity(Opportunity oppToUpdate) {
        return OpportunitySelector.updateOpportunity(oppToUpdate);
    }

    public static void deleteOpportunityById(Id opportunityId) {
        OpportunitySelector.deleteOpportunityById(opportunityId);
    }

    public static void deleteOpportunitiesByAccountId(Id accountId) {
        OpportunitySelector.deleteOpportunitiesByAccountId(accountId);
    }

    //Méthode pour ajouter des participants au nombre de participants d'un opportunité existante
    public static void addParticipants(Opportunity opp, Integer nbPartToAdd) {
        Integer currentNbPart = opp.Number_Of_Participants__c.intValue();
        Integer newNbPart = currentNbPart + nbPartToAdd;
        opp.Number_Of_Participants__c = newNbPart;
        OpportunitySelector.updateOpportunity(opp);
    }

    //Méthode pour retirer des participants au nombre de participants d'un opportunité existante
    public static void removeParticipants(Opportunity opp, Integer nbPartToRemove) {
        Integer currentNbPart = opp.Number_Of_Participants__c.intValue();
        Integer newNbPart = currentNbPart - nbPartToRemove;
        opp.Number_Of_Participants__c = newNbPart;
        OpportunitySelector.updateOpportunity(opp);
    }
}