@isTest
private class OpportunityControllerTest {

    //Test de la création d'une Opportunité standard
    @isTest
    static void testCreateOpportunity() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        Test.startTest();
        Opportunity insertedOpp = OpportunityController.createOpportunity(testOpp);
        Test.stopTest();
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE Id = :insertedOpp.Id];
        Assert.areEqual('Opp Test 1', insertedOpp.Name, 'Should return Opp Test 1');
        Assert.areEqual(1, oppList.size(), 'Should return 1');
        Assert.areEqual(insertedOpp.Id, oppList[0].Id, 'Should return insertedOpp Id');
    }

    //Test de la récupération d'une Opportunité par son Id
    @isTest
    static void testGetOpportunityById() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Test.startTest();
        Opportunity opp = OpportunityController.getOpportunityById(testOpp.Id);
        Test.stopTest();
        Assert.areEqual('Opp Test 1', opp.Name, 'Should return Opp Test 1');
        Assert.areEqual('Prospecting', opp.StageName, 'Should return Prospecting');
    }

    //Test de la récupération des Opportunités reliées à un compte, via l'Id du compte
    @isTest
    static void testGetOpportunitiesByAccountId() {
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
        Test.startTest();
        List<Opportunity> oppList = OpportunityController.getOpportunitiesByAccountId(testAccount.Id);
        Test.stopTest();
        Assert.areEqual(2, oppList.size(), 'Should return 2 results');
        Assert.areEqual('Opp Test 1', oppList[0].Name, 'Should return Opp Test 1');
        Assert.areEqual(15, oppList[1].Number_Of_Participants__c, 'Should return 15');
    }

    //Test de la récupération de toutes les Opportunités ayant le même stageName
    @isTest
    static void testGetOpportunitiesByStageName() {
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
        Test.startTest();
        List<Opportunity> oppList = OpportunityController.getOpportunitiesByStageName('Prospecting');
        Test.stopTest();
        Assert.areEqual(1, oppList.size(), 'Should return 1 result');
        Assert.areEqual('Opp Test 1', oppList[0].Name, 'Should return Opp Test 1');
    }

    //Test de la mise à jour d'une opportunité
    @isTest
    static void testUpdateOpportunity() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        testOpp.StageName = 'Qualification';
        Test.startTest();
        OpportunityController.updateOpportunity(testOpp);
        Test.stopTest();
        Assert.areEqual('Opp Test 1', testOpp.Name, 'Should return Opp Test 1');
        Assert.areEqual('Qualification', testOpp.StageName, 'Should return Qualification');
    }

    //Test de la suppression d'une Opporunité par son Id
    @isTest
    static void testDeleteOpportunityById() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        List<Opportunity> testOppList = new List<Opportunity>();
        //Création de 2 opportunités.
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestination.Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        insert testOppList;
        Test.startTest();
        OpportunityController.deleteOpportunityById(testOpp.Id); //Suppression de l'Opportunité 1
        Test.stopTest();
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity];
        //Vérifie qu'il reste l'Opportunité 2 seule.
        Assert.areEqual(1, oppList.size(), 'Should return 1 opportunity');
        Assert.areEqual(testOpp2.Name, oppList[0].Name, 'Should return Opp Test 2');
    }

    //Test de la suppression des Opportunités reliées à un compte, via l'Id de compte.
    @isTest
    static void testDeleteOpportunityByAccountId() {
        List<Account> testAcctList = new List<Account>();
        Account testAccount = TestDataFactory.createAccountTest();
        Account testAccount2 = TestDataFactory.createAccountTest2();
        //Création de 2 comptes
        testAcctList.add(testAccount);
        testAcctList.add(testAccount2);
        insert testAcctList;
        List<Destination__c> testDestinationList = TestDataFactory.createDestinationListTest();
        insert testDestinationList;
        List<Opportunity> testOppList = new List<Opportunity>();
        //Création de 2 opportunités, chacune reliée à un compte.
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestinationList[0].Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount2.Id, testDestinationList[1].Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        insert testOppList;
        Test.startTest();
        OpportunityController.deleteOpportunitiesByAccountId(testAccount2.Id); //Suppression de l'Opportunité reliée au Compte 2
        Test.stopTest();
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity];
        //Vérifie qu'il reste bien l'opportunité 1
        Assert.areEqual(1, oppList.size(), 'Should return 1');
        Assert.areEqual(testOpp.Name, oppList[0].Name, 'Should return Opp Test 1');   
    }

    //Test de l'ajout de participants au nombre de participants actuel d'une Opportunité.
    @isTest
    static void testAddParticipants() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        //Création d'une Opportunité avec 10 participants
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        Test.startTest();
        OpportunityController.addParticipants(testOpp, 3);
        Test.stopTest();
        Assert.areEqual(13, testOpp.Number_Of_Participants__c, 'Should return 13');
    }

    //Test du la suppression de participants au nombre de participants actuel d'une Opportunité.
    @isTest
    static void testRemoveParticipants() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        //Création d'une Opportunité avec 10 participants
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        Test.startTest();
        OpportunityController.removeParticipants(testOpp, 3);
        Test.stopTest();
        Assert.areEqual(7, testOpp.Number_Of_Participants__c, 'Should return 7');
    }
}