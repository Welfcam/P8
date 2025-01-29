@isTest
private class OpportunityTriggerTest {

    //Test d'une Opportunité qui passe à Closed Won sans erreur sur les dates.
    @isTest
    static void testHandleOppClosedWonWithCorrectDates() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        testOpp.StageName = 'Closed Won';
        Test.startTest(); 
        update testOpp;
        Test.stopTest();
        Opportunity updatedOpp = [SELECT StageName FROM Opportunity WHERE Id = :testOpp.Id];
        List<Trip__c> createdTrip = [SELECT Id, Status__c FROM Trip__c WHERE Opportunity__r.Id = :testOpp.Id];
        List<Contract> updatedContract = [SELECT Id, Status FROM Contract WHERE OpportunityId__c = :testOpp.Id];
        Assert.areEqual('Closed Won', updatedOpp.StageName, 'Should return Closed Won');
        Assert.areEqual(1, createdTrip.size(), 'Should return 1 result'); //Création du voyage
        Assert.areEqual('To come', createdTrip[0].Status__c, 'Should return To come');
        Assert.areEqual(1, updatedContract.size(), 'Should return 1 result');
        Assert.areEqual('Activated', updatedContract[0].Status, 'Should return Activated'); //Mise à jour du statut du contrat
    }

    //Test de l'insertion d'une Opportunité avec une erreur sur les dates
    @isTest
    static void testHandleInsertOppWithErrorOnDates() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTestWithDateError(testAccount.Id, testDest.Id);
        Test.startTest();
        try {
            insert testOpp;
        } catch (DmlException e) {
            Assert.areEqual(e.getMessage().contains('The start date should be earlier than the end date'), true);
        }
        Test.stopTest();
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId = :testAccount.Id];
        Assert.areEqual(0, oppList.size(), 'Should return 0 results');
    }

    //Test de l'insertion d'une Opportunité avec un nombre de participants négatif
    @isTest
    static void testHandleInsertOppWithErrorOnParticipants() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTestWithNegativeParts(testAccount.Id, testDest.Id);
        Test.startTest();
        try {
            insert testOpp;
        } catch (DmlException e) {
            Assert.areEqual(e.getMessage().contains('The number of participants cannot be negative'), true);
        }
        Test.stopTest();
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId = :testAccount.Id];
        Assert.areEqual(0, oppList.size(), 'Should return 0 results');
    }

    //Test de la mise à jour d'une Opportunité avec un nombre de participants négatif
    @isTest
    static void testHandleUpdateOppWithErrorOnParticipants() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        testOpp.Number_Of_Participants__c = -2;
        Test.startTest();
        try {
            update testOpp;
        } catch (DmlException e) {
            Assert.areEqual(e.getMessage().contains('The number of participants cannot be negative'), true);
        }
        Test.stopTest();
        Opportunity notUpdatedOpp = [SELECT Id, Number_Of_Participants__c FROM Opportunity WHERE Id = :testOpp.Id];
        Assert.areEqual(10, notUpdatedOpp.Number_Of_Participants__c, 'Should return 10');
    }
    
    //Test d'un Opportunité qui passe à Proposal/Price Quote
    @isTest
    static void testHandleOppProposal() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        testOpp.StageName = 'Proposal/Price Quote';
        Test.startTest();
        update testOpp;
        Test.stopTest();
        Opportunity updatedOrder = [SELECT StageName FROM Opportunity WHERE Id = :testOpp.Id];
        Contract createdContract = [SELECT Id, Status FROM Contract WHERE OpportunityId__c = :testOpp.Id LIMIT 1];
        Assert.areEqual('Proposal/Price Quote', updatedOrder.StageName, 'Should return Proposal/Price Quote');
        Assert.areEqual('Draft', createdContract.Status, 'Should return Draft'); //Création du contrat associé
    }

    //Test d'une Opportunité qui passe à Negociation/Review
    @isTest
    static void testHandleOppNegociation() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        testOpp.StageName = 'Negotiation/Review';
        Test.startTest();
        update testOpp;
        Test.stopTest();
        Opportunity updatedOrder = [SELECT StageName FROM Opportunity WHERE Id = :testOpp.Id];
        Contract createdContract = [SELECT Id, Status FROM Contract WHERE OpportunityId__c = :testOpp.Id LIMIT 1];
        Assert.areEqual('Negotiation/Review', updatedOrder.StageName, 'Should return Negotiation/Review');
        Assert.areEqual('In Approval Process', createdContract.Status, 'Should return In Approval Process'); //Mise à jour du statut du contrat
    }
    
    //Test d'une opportunité qui passe à Closed Lost
    @isTest
    static void testHandleOppClosedLost() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        testOpp.StageName = 'Closed Lost';
        Test.startTest();
        update testOpp;
        Test.stopTest();
        Opportunity updatedOrder = [SELECT StageName FROM Opportunity WHERE Id = :testOpp.Id];
        Contract createdContract = [SELECT Id, Status FROM Contract WHERE OpportunityId__c = :testOpp.Id LIMIT 1];
        Assert.areEqual('Closed Lost', updatedOrder.StageName, 'Should return Closed Lost');
        Assert.areEqual('Cancelled', createdContract.Status, 'Should return Cancelled'); //Mise à jour du statut du contrat
    }
}