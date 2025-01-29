//Classe de gestion des comptes Salesforce. Interagit avec la base de données.
public with sharing class AccountSelector {
    public static Account getAccountById(Id accountId) {
        return [SELECT Id, Name, Type, Industry, Phone, Website, BillingStreet, BillingPostalCode, BillingCity, BillingCountry 
                FROM Account 
                WHERE Id = :accountId LIMIT 1];
    }

    public static Account createAccount(Account account) {
        insert account;
        return account;
    }
    
    public static Account updateAccount(Account account) {
        update account;
        return account;
    }

    public static void deleteAccountById(Id accountId) {
        Account accountToDelete = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
        delete accountToDelete;
    }
}