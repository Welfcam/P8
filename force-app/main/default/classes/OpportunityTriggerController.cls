//Classe de gestion des évènements déclenchés par OpportunityTrigger.
public with sharing class OpportunityTriggerController {
    //Si l'opportunité passe à Closed Won, un voayage est crée (rattaché à l'opportunité) et le contrat rattaché à l'opportunité passe au statut 'Activated'
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

    //Si l'opportunité passe à Proposal/Price Quote, un contrat est créé au statut Draft avec un terme de 2 mois.
    public static void handleOppProposal(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        for(Opportunity opp: newOpps) {
            Opportunity oldOpp = oldOppsMap.get(opp.Id);
            if(opp.StageName == 'Proposal/Price Quote' && oldOpp.StageName != 'Proposal/Price Quote') {
                ContractController.createContractwithStatusAndTerm(opp, 'Draft', 2);
            }
        }
    }

    //Si l'opportunité passe à Negociation/Review, le contrat associé passe au statut 'In Approval Process'
    public static void handleOppNegotiation(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        for(Opportunity opp: newOpps) {
            Opportunity oldOpp = oldOppsMap.get(opp.Id);
            if(opp.StageName == 'Negotiation/Review' && oldOpp.StageName != 'Negotiation/Review') {
                Contract contractToUpdate = ContractController.getContractByOppId(opp.Id);
                ContractController.updateContractStatus(contractToUpdate, 'In Approval Process');
            }
        }
    }

    //Si l'opportunité passe à Closed Lost, le contrat associé passe au statut 'Cancelled'
    public static void handleOppClosedLost(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        for(Opportunity opp: newOpps) {
            Opportunity oldOpp = oldOppsMap.get(opp.Id);
            if(opp.StageName == 'Closed Lost' && oldOpp.StageName != 'Closed Lost') {
                Contract contractToUpdate = ContractController.getContractByOppId(opp.Id);
                ContractController.updateContractStatus(contractToUpdate, 'Cancelled');
            }
        }
    }

    //Vérifie que la date de début de l'Opportunité n'est pas supérieure à la date de fin
    public static void checkDates(List<Opportunity> oppList) {
        for(Opportunity opp : oppList) {
            if(opp.Start_Date__c >= opp.End_Date__c) {
                opp.addError('The start date should be earlier than the end date');
            }
        }
    }

    //Vérifie que le nombre de participants n'est pas négatif
    public static void checkNumberOfParticipants(List<Opportunity> oppList) {
        for(Opportunity opp : oppList) {
            if(opp.Number_Of_Participants__c < 0) {
                opp.addError('The number of participants cannot be negative');
            }
        }
    }
}
