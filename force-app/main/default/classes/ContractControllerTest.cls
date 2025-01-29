@isTest
private class ContractControllerTest {

    //Test de la création d'un contrat avec un statut et un terme, rattaché à une opportunité (elle-même rattachée à un compte et une destination) 
    @isTest
    static void createTestContract() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Test.startTest();
        Contract insertedContract = ContractController.createContractwithStatusAndTerm(testOpp, 'Draft', 2);
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, ContractTerm FROM Contract WHERE Id = :insertedContract.Id];
        Assert.areEqual(2, contractList[0].ContractTerm, 'Should return 2');
        Assert.areEqual(1, contractList.size(), 'Should return 1');
        Assert.areEqual(insertedContract.Id, contractList[0].Id, 'Should return Inserted Contract Id');
    }

    //Test de la récupération d'un contrat par son Id
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
        Contract contract = ContractController.getContractByOppId(testOpp.Id);
        Test.stopTest();
        Assert.areEqual(contract.Id, testContract.Id, 'Should return contract Id');
        Assert.areEqual(contract.OpportunityId__c, testContract.OpportunityId__c);
    }

    //Test de la récupération des contrats rattachés à un compte, via l'Id du compte.
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
        List<Contract> results = ContractController.getContractsByAccountId(testAccount.Id);
        Test.stopTest();
        Assert.areEqual(results[0].Id, testContract.Id, 'Should return contract Id');
        Assert.areEqual(results[0].AccountId, testContract.AccountId);
    }

    //Test de la mise à jour d'un contrat existant
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
        Test.startTest();
        ContractController.updateContractStatus(testContract, 'Activated');
        Test.stopTest();
        Assert.areEqual('Activated', testContract.Status, 'Should return Activated');
    }

    //Test de la suppression d'un contrat par son Id
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
        testContractList.add(testContract2); //création de 2 contrats
        insert testContractList;
        Test.startTest();
        ContractController.deleteContractById(testContract2.Id); //le contrat2 est supprimé
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, OpportunityId__c, ContractTerm FROM Contract];
        //Vérifie que contrat1 est le seul restant
        Assert.areEqual(1, contractList.size(), 'Should return 1');
        Assert.areEqual(testOpp.Id, contractList[0].OpportunityId__c, 'Should return testOpp Id');
        Assert.areEqual(2, contractList[0].ContractTerm, 'Should return 2');
    }

    //Test de la suppression d'un contrat par l'Id de l'Opportunité associée.
    @isTest
    static void testDeleteContractByOpportunityId() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        List<Opportunity> testOppList = new List<Opportunity>();
        //Création de 2 opportunités
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestination.Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2); 
        insert testOppList;
        List<Contract> testContractList = new List<Contract>();
        //Création de 2 contrats rattachés chacun à une opportunité.
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        Contract testContract2 = TestDataFactory.createContractTest2(testOpp2);
        testContractList.add(testContract); 
        testContractList.add(testContract2);
        insert testContractList;
        Test.startTest();
        ContractController.deleteContractByOpportunityId(testOpp2.Id); //Suppression du contrat de l'Opportunité 2
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, OpportunityId__c, ContractTerm FROM Contract];
        //Vérifie qu'il reste bien le contrat de l'opportunité 1
        Assert.areEqual(1, contractList.size(), 'Should return 1');
        Assert.areEqual(testOpp.Id, contractList[0].OpportunityId__c, 'Should return testOpp Id');
        Assert.areEqual(2, contractList[0].ContractTerm, 'Should return 2');
    }

    //Test de la suppression des contrats rattachés à un compte, via l'Id du compte.
    @isTest
    static void testDeleteContractByAccountId() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        List<Opportunity> testOppList = new List<Opportunity>();
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestination.Id);
        //Création de 2 opportunités pour 1 compte
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        insert testOppList;
        List<Contract> testContractList = new List<Contract>();
        //Création de 2 contrats rattachés chacun à une opportunité (même compte)
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        Contract testContract2 = TestDataFactory.createContractTest2(testOpp2);
        testContractList.add(testContract);
        testContractList.add(testContract2);
        insert testContractList;
        Test.startTest();
        ContractController.deleteContractsByAccountId(testAccount.Id); //Suppression des contrats du compte
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, AccountId, ContractTerm FROM Contract];
        //Vérifie que les 2 contrats on été supprimés.
        Assert.areEqual(0, contractList.size(), 'Should return 0');
    }
}