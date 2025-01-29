//Classe de gestion des Contrats Salesforce. Utiliser ContractSelector pour interagir avec la base de données
public with sharing class ContractController {
    public static Contract createContractWithStatusAndTerm(Opportunity opp, String status, Integer contractTerm) {
        Contract newContract = new Contract(
            AccountId = opp.AccountId,
            OpportunityId__c = opp.Id,
            Status = status,
            StartDate = opp.Start_Date__c,
            ContractTerm = contractTerm
        );
        return ContractSelector.createContract(newContract);
    }

    public static Contract getContractByOppId(Id oppId) {
        return ContractSelector.getContractByOppId(oppId);
    }

    public static List<Contract> getContractsByAccountId(Id accountId) {
        return ContractSelector.getContractsByAccountId(accountId);
    }

    public static Contract updateContractStatus(Contract contractToUpdate, String status) {
        contractToUpdate.status = status;
        return ContractSelector.updateContract(contractToUpdate);
    }

    public static void deleteContractById(Id contractId) {
        ContractSelector.deleteContractById(contractId);
    }

    public static void deleteContractByOpportunityId(Id opportunityId) {
        ContractSelector.deleteContractByOpportunityId(opportunityId);
    }
    
    public static void deleteContractsByAccountId(Id accountId) {
        ContractSelector.deleteContractsByAccountId(accountId);
    }
}    