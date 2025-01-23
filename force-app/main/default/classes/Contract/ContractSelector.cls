public with sharing class ContractSelector {
    public static Contract createContract(Contract contract) {
        insert contract;
        return contract;
    }

    public static Contract getContractByOppId(Id opportunityId) {
        return [SELECT Id, ContractNumber, AccountId, OpportunityId__c, Status, StartDate, EndDate, ContractTerm 
                FROM Contract 
                WHERE OpportunityId__c = :opportunityId 
                LIMIT 1];
    }

    public static List<Contract> getContractsByAccountId(Id accountId) {
        return [SELECT Id, ContractNumber, AccountId, OpportunityId__c, Status, StartDate, EndDate, ContractTerm 
                FROM Contract 
                WHERE AccountId = :accountId];
    }

    public static Contract updateContract(Contract contractToUpdate) {
        update contractToUpdate;
        return contractToUpdate;
    }

    public static void deleteContractById(Id contractId) {
        Contract contractToDelete = [SELECT Id FROM Contract WHERE Id = :contractId LIMIT 1];
        delete contractToDelete;
    }

    public static void deleteContractByOpportunityId (Id opportunityId) {
        Contract contractToDelete = [SELECT Id FROM Contract WHERE OpportunityId__c = :opportunityId LIMIT 1];
        delete contractToDelete; 
    }

    public static void deleteContractsByAccountId (Id accountId) {
        List<Contract> contractsListToDelete = [SELECT Id FROM Contract WHERE AccountId = :accountId];
        delete contractsListToDelete;
    }
}