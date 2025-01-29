@isTest
private class TripTriggerTest {

    //Test de l'insertion d'un voyage avec une erreur sur les dates.
    @isTest
    static void testInsertTripWithDateError() {
        Account testAccount = TestDataFactory.createAccountTest();
        insert testAccount;
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        Opportunity testOpp = TestDataFactory.createOppTest(testAccount.Id, testDest.Id);
        insert testOpp;
        Trip__c testTrip = new Trip__c(
            Opportunity__c = testOpp.Id,
            Destination__c = testDest.Id,
            Start_Date__c = Date.today().addDays(20),
            End_Date__c = Date.today().addDays(10)
        );
        Test.startTest();
        try {
            insert testTrip;
        } catch (DmlException e) {
            Assert.areEqual(e.getMessage().contains('The start date should be earlier than the end date'), true);
        }    
        Test.stopTest();
        List<Trip__c> tripList = [SELECT Id FROM Trip__c];
        Assert.areEqual(0, tripList.size(), 'Should return 0 results');
    }
}