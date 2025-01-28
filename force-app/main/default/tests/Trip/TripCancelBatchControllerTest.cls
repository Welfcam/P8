@isTest
private class TripCancelBatchControllerTest {

    @isTest
    static void testTripCancelBatch() {
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
        Trip__c initialTrip = [SELECT Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('To come', initialTrip.Status__c, 'Should return To Come');
        Test.startTest();
        TripCancelBatchController.runTripCancelBatch();
        Test.stopTest();
        Trip__c updatedTrip = [SELECT Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('Cancelled', updatedTrip.Status__c, 'Should return Cancelled');
    }
}