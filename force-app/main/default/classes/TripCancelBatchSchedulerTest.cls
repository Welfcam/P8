@isTest
private class TripCancelBatchSchedulerTest {

    @isTest
    static void testSchedulerToCancelTrip() {
        //Création d'enregistrements pour le test
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        //Création d'une opportunité avec moins de 10 participants, date de début dans 6 jours
        Opportunity testOpp = TestDataFactory.createOppTestWithLessThan10Participants(testAccount.Id, testDest.Id);
        insert testOpp;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp); //Création d'un voyage relié à l'opportunité
        insert testTrip;
        Assert.areEqual('To come', testTrip.Status__c); //vérification du statut actuel (avant batch) du voyage
        String jobName = 'Test Scheduler To Cancel Trip'; //définition de jobName
        TripCancelBatchScheduler testScheduler = new TripCancelBatchScheduler();
        String cronExp = '0 0 0 * * ?'; //planification avec une expression cron, exécution quotidienne à minuit
        Id jobId = System.schedule(jobName, cronExp, testScheduler);
        //Exécution du batch
        Test.startTest();
        Database.executeBatch(new TripCancelBatch());
        Test.stopTest();
        //Vérification après exécution : Voyage 'Cancelled'
        Trip__c testTripUpdated = [SELECT Id, Status__c FROM Trip__c WHERE Id = :testTrip.Id];
        Assert.areEqual('Cancelled', testTripUpdated.Status__c, 'Should return Cancelled');
    }
}