@isTest
private class TripUpdateStatusBatchSchedulerTest {

    @isTest
    static void testSchedulerTripOngoing() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTestTripOngoing(testAccount.Id, testDest.Id);
        insert testOpp;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        insert testTrip;
        Assert.areEqual('To come', testTrip.Status__c);
        String jobName = 'Test Scheduler Trip Ongoing';
        TripUpdateStatusBatchScheduler testScheduler = new TripUpdateStatusBatchScheduler();
        String cronExp = '0 0 0 * * ?';
        Id jobId = System.schedule(jobName, cronExp, testScheduler);
        Test.startTest();
        Database.executeBatch(new TripUpdateStatusBatch());
        Test.stopTest();
        Trip__c testTripUpdated = [SELECT Id, Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('Ongoing', testTripUpdated.Status__c, 'Should return Ongoing');
    }

    @isTest
    static void testSchedulerTripFinished() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTestTripFinished(testAccount.Id, testDest.Id);
        insert testOpp;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        insert testTrip;
        Assert.areEqual('To come', testTrip.Status__c);
        String jobName = 'Test Scheduler Trip Finished';
        TripUpdateStatusBatchScheduler testScheduler = new TripUpdateStatusBatchScheduler();
        String cronExp = '0 0 0 * * ?';
        Id jobId = System.schedule(jobName, cronExp, testScheduler);
        Test.startTest();
        Database.executeBatch(new TripUpdateStatusBatch());
        Test.stopTest();
        Trip__c testTripUpdated = [SELECT Id, Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('Finished', testTripUpdated.Status__c, 'Should return Finished');
    }

    @isTest
    static void testSchedulerTripToCome() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        Trip__c testTrip = TestDataFactory.createTripTestOngoing(testOpp);
        insert testTrip;
        Assert.areEqual('Ongoing', testTrip.Status__c);
        String jobName = 'Test Scheduler Trip To come';
        TripUpdateStatusBatchScheduler testScheduler = new TripUpdateStatusBatchScheduler();
        String cronExp = '0 0 0 * * ?';
        Id jobId = System.schedule(jobName, cronExp, testScheduler);
        Test.startTest();
        Database.executeBatch(new TripUpdateStatusBatch());
        Test.stopTest();
        Trip__c testTripUpdated = [SELECT Id, Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('To come', testTripUpdated.Status__c, 'Should return To come');
    }


}