//Classe de gestion des Comptes Salesforce. Utilise AccountSelector pour interagir avec la base de données
public with sharing class AccountController {
    public static Account getAccountById(Id accountId) {
        return AccountSelector.getAccountById(accountId);
    }

    public static Account createAccount(Account account) {
        if (String.isEmpty(account.Name)) {
            throw new IllegalArgumentException('The Name field is required.');
        }
        return AccountSelector.createAccount(account);
    }

    public static Account updateAccount(Account account) {
        return AccountSelector.updateAccount(account);
    }

    public static void deleteAccountById(Id accountId) {
        AccountSelector.deleteAccountById(accountId);
    }
}