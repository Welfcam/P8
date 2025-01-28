public with sharing class OpportunityTriggerController {
    public static void handleOppClosedWon(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        for(Opportunity opp: newOpps) {
            Opportunity oldOpp = oldOppsMap.get(opp.Id);
            if(opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                TripController.createTrip(opp);
                Contract contractToUpdate = ContractController.getContractByOppId(opp.Id);
                ContractController.updateContractStatus(contractToUpdate, 'Activated');
            }
        }
    }
    public static void handleOppProposal(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        for(Opportunity opp: newOpps) {
            Opportunity oldOpp = oldOppsMap.get(opp.Id);
            if(opp.StageName == 'Proposal/Price Quote' && oldOpp.StageName != 'Proposal/Price Quote') {
                ContractController.createContractwithStatusAndTerm(opp, 'Draft', 2);
            }
        }
    }

    public static void handleOppNegotiation(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        for(Opportunity opp: newOpps) {
            Opportunity oldOpp = oldOppsMap.get(opp.Id);
            if(opp.StageName == 'Negotiation/Review' && oldOpp.StageName != 'Negotiation/Review') {
                Contract contractToUpdate = ContractController.getContractByOppId(opp.Id);
                ContractController.updateContractStatus(contractToUpdate, 'In Approval Process');
            }
        }
    }

    public static void handleOppClosedLost(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        for(Opportunity opp: newOpps) {
            Opportunity oldOpp = oldOppsMap.get(opp.Id);
            if(opp.StageName == 'Closed Lost' && oldOpp.StageName != 'Closed Lost') {
                Contract contractToUpdate = ContractController.getContractByOppId(opp.Id);
                ContractController.updateContractStatus(contractToUpdate, 'Cancelled');
            }
        }
    }

    public static void checkDates(List<Opportunity> oppList) {
        for(Opportunity opp : oppList) {
            if(opp.Start_Date__c >= opp.End_Date__c) {
                opp.addError('The start date should be earlier than the end date');
            }
        }
    }

    public static void checkNumberOfParticipants(List<Opportunity> oppList) {
        for(Opportunity opp : oppList) {
            if(opp.Number_Of_Participants__c < 0) {
                opp.addError('The number of participants cannot be negative');
            }
        }
    }
}
