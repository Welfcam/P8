@isTest
private class TripCancelBatchSchedulerTest {

    @isTest
    static void testSchedulerToCancelTrip() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTestWithLessThan10Participants(testAccount.Id, testDest.Id);
        insert testOpp;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        insert testTrip;
        Assert.areEqual('To come', testTrip.Status__c);
        String jobName = 'Test Scheduler To Cancel Trip';
        TripCancelBatchScheduler testScheduler = new TripCancelBatchScheduler();
        String cronExp = '0 0 0 * * ?';
        Id jobId = System.schedule(jobName, cronExp, testScheduler);
        Test.startTest();
        Database.executeBatch(new TripCancelBatch());
        Test.stopTest();
        Trip__c testTripUpdated = [SELECT Id, Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('Cancelled', testTripUpdated.Status__c, 'Should return Cancelled');
    }
}