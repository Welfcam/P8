@isTest
private class TripUpdateStatusBatchControllerTest {

    @isTest
    static void testTripUpdateStatusBatch() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;

        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        
        Opportunity testOpp1 = new Opportunity(
            Name = 'Opp Test 1',
            AccountId = testAccount.Id,
            CloseDate = Date.today().addDays(10),
            StageName = 'Closed Won',
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_Of_Participants__c = 12,
            Destination__c = testDest.Id
        );
        insert testOpp1;

        Trip__c tripToCome = new Trip__c(
            Status__c = 'Ongoing',
            Opportunity__c = testOpp1.Id,
            Destination__c = testOpp1.Destination__c,
            Start_Date__c = testOpp1.Start_Date__c,
            End_Date__c = testOpp1.End_Date__c
        );
        insert tripToCome;

        Opportunity testOpp2 = new Opportunity(
            Name = 'Opp Test 2',
            AccountId = testAccount.Id,
            CloseDate = Date.today().addDays(10),
            StageName = 'Closed Won',
            Start_Date__c = Date.today().addDays(-2),
            End_Date__c = Date.today().addDays(4),
            Number_Of_Participants__c = 10,
            Destination__c = testDest.Id
        );
        insert testOpp2;

        Trip__c tripOngoing = new Trip__c(
            Status__c = 'To come',
            Opportunity__c = testOpp2.Id,
            Destination__c = testOpp2.Destination__c,
            Start_Date__c = testOpp2.Start_Date__c,
            End_Date__c = testOpp2.End_Date__c
        );
        insert tripOngoing;

        Opportunity testOpp3 = new Opportunity(
            Name = 'Opp Test 3',
            AccountId = testAccount.Id,
            CloseDate = Date.today().addDays(10),
            StageName = 'Closed Won',
            Start_Date__c = Date.today().addDays(-10),
            End_Date__c = Date.today().addDays(-2),
            Number_Of_Participants__c = 15,
            Destination__c = testDest.Id
        );
        insert testOpp3;

        Trip__c tripFinished = new Trip__c(
            Status__c = 'Ongoing',
            Opportunity__c = testOpp3.Id,
            Destination__c = testOpp3.Destination__c,
            Start_Date__c = testOpp3.Start_Date__c,
            End_Date__c = testOpp3.End_Date__c
        );
        insert tripFinished;

        Test.startTest();
        TripUpdateStatusBatchController.runTripUpdateStatusBatch();
        Test.stopTest();

        Trip__c updatedTripToCome = [SELECT Status__c FROM Trip__c WHERE Id = :tripToCome.Id];
        Trip__c updatedTripOngoing = [SELECT Status__c FROM Trip__c WHERE Id = :tripOngoing.Id];
        Trip__c updatedTripFinished = [SELECT Status__c FROM Trip__c WHERE Id = :tripFinished.Id];
        Assert.areEqual('To come', updatedTripToCome.Status__c, 'Shoud return To come');
        Assert.areEqual('Ongoing', updatedTripOngoing.Status__c, 'Shoud return Ongoing');
        Assert.areEqual('Finished', updatedTripFinished.Status__c, 'Shoud return Finished');
    }
}