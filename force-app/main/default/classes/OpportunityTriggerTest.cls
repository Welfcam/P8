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

    //Test de la mise à jour de 3 opportunités à Closed Won sans erreur sur les dates
    @isTest
    static void testHandle3OppClosedWonWithCorrectDates() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Account testAccount2 = TestDataFactory.createAccountTest2();
        insert testAccount2;
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestList[0].Id);
        insert testOpp;
        Contract testContract1 = TestDataFactory.createContractTest(testOpp);
        insert testContract1;
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestList[1].Id);
        insert testOpp2;
        Contract testContract2 = TestDataFactory.createContractTest(testOpp2);
        insert testContract2;
        Opportunity testOpp3 = TestDataFactory.createOppTestWithLessThan10Participants(testAccount2.Id, testDestList[1].Id);
        insert testOpp3;
        Contract testContract3 = TestDataFactory.createContractTest(testOpp3);
        insert testContract3;
        List<Opportunity> oppListToUpdate = [SELECT Id, StageName FROM Opportunity];
        for(Opportunity opp : oppListToUpdate) {
            opp.StageName = 'Closed Won';
        }
        Test.startTest();
        update oppListToUpdate;
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, Status FROM Contract];
        List<Opportunity> oppList = [SELECT StageName FROM Opportunity];
        List<Trip__c> tripList = [SELECT Id, Status__c FROM Trip__c];
        Assert.areEqual('Closed Won', oppList[1].StageName, 'Should return Closed Won');
        Assert.areEqual(3, tripList.size(), 'Should return 3 results');
        Assert.areEqual('Activated', contractList[2].Status, 'Should return Activated');
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
    
    //Test d'une Opportunité qui passe à Proposal/Price Quote
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

    //Test de 3 Opportunités qui passent à Proposal/Price Quote
    @isTest
    static void testHandle3OppProposal() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Account testAccount2 = TestDataFactory.createAccountTest2();
        insert testAccount2;
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestList[0].Id);
        insert testOpp;
        Opportunity testOpp2 = TestDataFactory.createOppTest2(testAccount.Id, testDestList[1].Id);
        insert testOpp2;
        Opportunity testOpp3 = TestDataFactory.createOppTestWithLessThan10Participants(testAccount2.Id, testDestList[1].Id);
        insert testOpp3;
        List<Opportunity> oppListToUpdate = [SELECT Id, StageName FROM Opportunity];
        for(Opportunity opp : oppListToUpdate) {
            opp.StageName = 'Proposal/Price Quote';
        }
        Test.startTest();
        update oppListToUpdate;
        Test.stopTest();
        List<Contract> contractList = [SELECT Id, Status FROM Contract];
        List<Opportunity> oppList = [SELECT StageName FROM Opportunity];
        Assert.areEqual('Proposal/Price Quote', oppList[1].StageName, 'Should return Proposal/Price Quote');
        Assert.areEqual(3, contractList.size(), 'Should return 3 results');
        Assert.areEqual('Draft', contractList[2].Status, 'Should return Draft');
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