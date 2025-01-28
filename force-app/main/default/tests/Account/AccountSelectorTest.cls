@isTest
private class AccountSelectorTest {

    @isTest
    static void testCreateAccount() {
        Account testAccount = TestDataFactory.createAccountTest();
        Test.startTest();
        Account insertedAccount = AccountSelector.createAccount(testAccount);
        Test.stopTest();
        List<Account> acctList = [SELECT Id FROM Account WHERE Id = :insertedAccount.Id];
        Assert.areEqual('Entreprise 1', insertedAccount.Name, 'Should return Entreprise 1');
        Assert.areEqual(1, acctList.size(), 'Should return 1');
        Assert.areEqual(insertedAccount.Id, acctList[0].Id, 'Should return inserted Account Id');
    }

    @isTest
    static void testGetAccountById() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Test.startTest();
        Account acct = AccountSelector.getAccountById(testAccount.Id);
        Test.stopTest();
        Assert.areEqual('Entreprise 1', acct.Name, 'Should return Entreprise 1');
        Assert.areEqual('United Kingdom', acct.BillingCountry, 'Should return United Kingdom');
    }

    @isTest
    static void testUpdateAccount() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        testAccount.BillingCity = 'Manchester';
        Test.startTest();
        AccountSelector.updateAccount(testAccount);
        Test.stopTest();
        Assert.areEqual('Entreprise 1', testAccount.Name, 'Should return Entreprise 1');
        Assert.areEqual('Manchester', testAccount.BillingCity, 'Should return Manchester');
    }    

    @isTest
    static void testDeleteAccountById() {
        Account testAccount = TestDataFactory.createAccountTest();
        Account testAccount2 = TestDataFactory.createAccountTest2();
        List<Account> acctToInsert = new List<Account>();
        acctToInsert.add(testAccount);
        acctToInsert.add(testAccount2);
        insert acctToInsert;
        Test.startTest();
        AccountSelector.deleteAccountById(testAccount.Id);
        List<Account> acctList = [SELECT Id, Name FROM Account];
        Test.stopTest();
        Assert.areEqual(1, acctList.size(), 'Should return 1');
        Assert.areEqual('Entreprise 2', acctList[0].Name, 'Should return Entreprise 2');
    }
}