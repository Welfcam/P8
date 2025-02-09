@isTest
private class TripSelectorTest {

    //Test de la création d'un voyage standard
    @isTest
    static void testCreateTrip() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        Test.startTest();
        Trip__c insertedTrip = TripSelector.createTrip(testTrip);
        Test.stopTest();
        List<Trip__c> tripList = [SELECT Id, Status__c, Opportunity__c FROM Trip__c WHERE Id = :insertedTrip.Id];
        Assert.areEqual(1, tripList.size(), 'Should return 1');
        Assert.areEqual('To come', tripList[0].Status__c, 'Should return To come');
        Assert.areEqual(insertedTrip.Id, tripList[0].Id, 'Should return Inserted Trip Id');
    }

    //Test de la récupétation d'un voyage par son Id
    @isTest
    static void testGetTripById() {
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
        List<Trip__c> testTripList = new List<Trip__c>();
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        Trip__c testTrip2 = TestDataFactory.createTripTest(testOpp2);
        testTripList.add(testTrip);
        testTripList.add(testTrip2);
        insert testTripList;
        Test.startTest();
        Trip__c trip = TripSelector.getTripById(testTrip.Id);
        Test.stopTest();
        Assert.areEqual(testOpp.Id, trip.Opportunity__c, 'Should return testOpp Id');
    }

    //Test de la récupération des voyages associés à un compte, via l'Id du compte
    @isTest
    static void testGetTripsByAccountId() {
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
        List<Trip__c> testTripList = new List<Trip__c>();
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        Trip__c testTrip2 = TestDataFactory.createTripTest(testOpp2);
        testTripList.add(testTrip);
        testTripList.add(testTrip2);
        insert testTripList;
        Test.startTest();
        List<Trip__c> tripList = TripSelector.getTripsByAccountId(testAccount.Id);
        Test.stopTest();
        Assert.areEqual(2, tripList.size(), 'Should return 2 results');
        Assert.areEqual(testOpp.Id, tripList[0].Opportunity__c, 'Should return testOpp Id');
    }

    //Test de la récupération de tous les voyages associés à une même destination
    @isTest
    static void testGetTripsByDestinationId() {
        List<Account> testAcctList = new List<Account>();
        Account testAccount = TestDataFactory.createAccountTest();
        Account testAccount2 = TestDataFactory.createAccountTest2();
        testAcctList.add(testAccount);
        testAcctList.add(testAccount2);
        insert testAcctList;
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        List<Opportunity> testOppList = new List<Opportunity>();
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestList[0].Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest(testAccount.Id, testDestList[1].Id);
        Opportunity testOpp3 = TestDataFactory.createOppTest(testAccount2.Id, testDestList[1].Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        testOppList.add(testOpp3);
        insert testOppList;
        List<Trip__c> testTripList = new List<Trip__c>();
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        Trip__c testTrip2 = TestDataFactory.createTripTest(testOpp2);
        Trip__c testTrip3 = TestDataFactory.createTripTest(testOpp3);
        testTripList.add(testTrip);
        testTripList.add(testTrip2);
        testTripList.add(testTrip3);
        insert testTripList;
        Test.startTest();
        List<Trip__c> tripList = TripSelector.getTripsByDestinationId(testDestList[1].Id);
        Test.stopTest();
        Assert.areEqual(2, tripList.size(), 'Should return 2 results');
        Assert.areEqual(testTrip2.Id, tripList[0].Id, 'Should return testTrip2 Id');
        Assert.areEqual(testTrip3.Id, tripList[1].Id, 'Should return testTrip3 Id');
    }

    //Test de la mise à jour d'un voyage
    @isTest
    static void testUpdateTrip() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDestination = TestDataFactory.createDestinationTest();
        insert testDestination;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestination.Id);
        insert testOpp;
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        insert testTrip;
        testTrip.Status__c = 'Cancelled';
        Test.startTest();
        TripSelector.updateTrip(testTrip);
        Test.stopTest();
        Assert.areEqual('Cancelled', testTrip.Status__c, 'Should return Cancelled');
    }

    //Test de la suppression d'un voyage par son Id
    @isTest
    static void testDeleteTripById() {
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
        List<Trip__c> testTripList = new List<Trip__c>();
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        Trip__c testTrip2 = TestDataFactory.createTripTest(testOpp2);
        testTripList.add(testTrip);
        testTripList.add(testTrip2);
        insert testTripList;
        Test.startTest();
        tripSelector.deleteTripById(testTrip2.Id);
        Test.stopTest();
        List<Trip__c> tripList = [SELECT Id, Status__c, Opportunity__c FROM Trip__c];
        Assert.areEqual(1, tripList.size(), 'Should return 1');
        Assert.areEqual(testOpp.Id, tripList[0].Opportunity__c, 'Should return testOpp Id');
    }

    //Test de la suppression des voyages associés à un compte, via l'Id du compte
    @isTest
    static void testDeleteTripsByAccountId() {
        List<Account> testAcctList = new List<Account>();
        Account testAccount = TestDataFactory.createAccountTest();
        Account testAccount2 = TestDataFactory.createAccountTest2();
        testAcctList.add(testAccount);
        testAcctList.add(testAccount2);
        insert testAcctList;
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        List<Opportunity> testOppList = new List<Opportunity>();
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDestList[0].Id);
        Opportunity testOpp2 = TestDataFactory.createOppTest(testAccount.Id, testDestList[1].Id);
        Opportunity testOpp3 = TestDataFactory.createOppTest(testAccount2.Id, testDestList[1].Id);
        testOppList.add(testOpp);
        testOppList.add(testOpp2);
        testOppList.add(testOpp3);
        insert testOppList;
        List<Trip__c> testTripList = new List<Trip__c>();
        Trip__c testTrip = TestDataFactory.createTripTest(testOpp);
        Trip__c testTrip2 = TestDataFactory.createTripTest(testOpp2);
        Trip__c testTrip3 = TestDataFactory.createTripTest(testOpp3);
        testTripList.add(testTrip);
        testTripList.add(testTrip2);
        testTripList.add(testTrip3);
        insert testTripList;
        Test.startTest();
        TripSelector.deleteTripsByAccountId(testAccount.Id);
        Test.stopTest();
        List<Trip__c> tripList = [SELECT Id, Opportunity__c, AccountId__c, Status__c FROM Trip__c];
        Assert.areEqual(1, tripList.size(), 'Should return 1 result');
        Assert.areEqual(testAccount2.Id, tripList[0].AccountId__c, 'Should return testAccount2 Id');
    }
}