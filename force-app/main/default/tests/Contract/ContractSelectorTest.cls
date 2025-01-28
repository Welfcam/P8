@isTest
private class ContractSelectorTest {

    @isTest
    static void testCreateContract() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        Test.startTest();
        Contract insertedContract = ContractSelector.createContract(testContract);
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, ContractTerm FROM Contract WHERE Id = :insertedContract.Id];
        Assert.areEqual(2, contractList[0].ContractTerm, 'Should return 2');
        Assert.areEqual(1, contractList.size(), 'Should return 1');
        Assert.areEqual(insertedContract.Id, contractList[0].Id, 'Should return Inserted Contract Id');
    }

    @isTest
    static void testGetContractByOppId() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        Test.startTest();
        Contract contract = ContractSelector.getContractByOppId(testOpp.Id);
        Test.stopTest();
        Assert.areEqual(contract.Id, testContract.Id, 'Should return contract Id');
        Assert.areEqual(contract.OpportunityId__c, testContract.OpportunityId__c);
    }

    @isTest
    static void testGetContractByAccountId() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        Test.startTest();
        List<Contract> results = ContractSelector.getContractsByAccountId(testAccount.Id);
        Test.stopTest();
        Assert.areEqual(results[0].Id, testContract.Id, 'Should return contract Id');
        Assert.areEqual(results[0].AccountId, testContract.AccountId);
    }

    @isTest
    static void testUpdateContract() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        testContract.Status = 'Activated';
        Test.startTest();
        ContractSelector.updateContract(testContract);
        Test.stopTest();
        Assert.areEqual('Activated', testContract.Status, 'Should return Activated');
    }

    @isTest
    static void testDeleteContractById() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        List<Opportunity> testOppList = new List<Opportunity>();
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestination.Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        insert testOppList;
        List<Contract> testContractList = new List<Contract>();
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        Contract testContract2 = TestDataFactory.createContractTest2(testOpp2);
        testContractList.add(testContract);
        testContractList.add(testContract2);
        insert testContractList;
        Test.startTest();
        ContractSelector.deleteContractById(testContract2.Id);
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, OpportunityId__c, ContractTerm FROM Contract];
        Assert.areEqual(1, contractList.size(), 'Should return 1');
        Assert.areEqual(testOpp.Id, contractList[0].OpportunityId__c, 'Should return testOpp Id');
        Assert.areEqual(2, contractList[0].ContractTerm, 'Should return 2');
    }

    @isTest
    static void testDeleteContractByOpportunityId() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        List<Opportunity> testOppList = new List<Opportunity>();
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestination.Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        insert testOppList;
        List<Contract> testContractList = new List<Contract>();
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        Contract testContract2 = TestDataFactory.createContractTest2(testOpp2);
        testContractList.add(testContract);
        testContractList.add(testContract2);
        insert testContractList;
        Test.startTest();
        ContractSelector.deleteContractByOpportunityId(testOpp2.Id);
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, OpportunityId__c, ContractTerm FROM Contract];
        Assert.areEqual(1, contractList.size(), 'Should return 1');
        Assert.areEqual(testOpp.Id, contractList[0].OpportunityId__c, 'Should return testOpp Id');
        Assert.areEqual(2, contractList[0].ContractTerm, 'Should return 2');
    }

    @isTest
    static void testDeleteContractByAccountId() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        List<Opportunity> testOppList = new List<Opportunity>();
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestination.Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        insert testOppList;
        List<Contract> testContractList = new List<Contract>();
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        Contract testContract2 = TestDataFactory.createContractTest2(testOpp2);
        testContractList.add(testContract);
        testContractList.add(testContract2);
        insert testContractList;
        Test.startTest();
        ContractSelector.deleteContractsByAccountId(testAccount.Id);
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, AccountId, ContractTerm FROM Contract];
        Assert.areEqual(0, contractList.size(), 'Should return 0');
    }
}