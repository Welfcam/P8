@isTest
private class TripCancelBatchTest {

    //Test du Batch avec un voyage de moins de 10 participants et une start date dans 6 jours
    @isTest
    static void testTripCancelBatchLessThan10Participants() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTestWithLessThan10Participants(testAccount.Id, testDest.Id);
        insert testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        insert testTrip;
        Test.startTest();
        TripCancelBatch batch = new TripCancelBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        Trip__c updatedTrip = [SELECT Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('Cancelled', updatedTrip.Status__c, 'Should return Cancelled');
    }

    //Test du Batch avec un voyage de 10 participants et une start date dans 6 jours
    @isTest
    static void testTripCancelBatchWith10Participants() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTestWithLessThan10Participants(testAccount.Id, testDest.Id);
        insert testOpp;
        testOpp.Number_Of_Participants__c = 10; //Mise à jour du nombre de participants de l'Opportunité
        update testOpp;
        Contract testContract = TestDataFactory.createContractTest(testOpp);
        insert testContract;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp); //Création d'un voyage associé à l'opportunité
        insert testTrip;
        Test.startTest();
        TripCancelBatch batch = new TripCancelBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        Trip__c nonUpdatedTrip = [SELECT Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('To come', nonUpdatedTrip.Status__c, 'Should return To come'); //Le voyage n'a pas été mis à jour par le Batch
    }
}