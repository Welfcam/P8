@isTest
private class DestinationSelectorTest {

    //Test de la création d'une Destination
    @isTest
    static void createTestDestination() {
        Destination__c testDest = TestDataFactory.createDestinationTest();
        Test.startTest();
        Destination__c dest = DestinationSelector.createDestination(testDest);
        Test.stopTest();
        List<Destination__c> destList = [SELECT Id, Name FROM Destination__c WHERE Id = :dest.Id];
        Assert.areEqual(dest.Id, destList[0].Id, 'Should return dest Id');
        Assert.areEqual(dest.Name, destList[0].Name, 'Should return United States');
    }

    //Test de la récupération de toutes les Destinations
    @isTest
    static void getTestDestinations() {
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Test.startTest();
        List<Destination__c> result = DestinationSelector.getDestinations();
        Test.stopTest();
        Assert.areEqual(testDestList[0].Name, result[0].Name, 'Should return Japan');
        Assert.areEqual(testDestList[1].Cost_Per_Person_Per_Day__c, result[1].Cost_Per_Person_Per_Day__c, 'Should return 500');
    }

    //Test de la mise à jour d'une Destination
    @isTest
    static void testUpdateDestination() {
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Destination__c destToUpdate = testDestList[0];
        destToUpdate.Cost_Per_Person_Per_Day__c = 1000;
        Test.startTest();
        DestinationSelector.updateDestination(destToUpdate);
        Test.stopTest();
        Assert.areEqual(destToUpdate.Cost_Per_Person_Per_Day__c, testDestList[0].Cost_Per_Person_Per_Day__c, 'Should return 1000');
    }

    //Test de la suppression d'un destination
    @isTest
    static void testDeleteDestination() {
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Destination__c destToDelete = testDestList[0];
        Test.startTest();
        DestinationSelector.deleteDestination(destToDelete.Id);
        Test.stopTest();
        List<Destination__c> testDestList2 = [SELECT Id, Name, Cost_Per_Person_Per_Day__c FROM Destination__c]; 
        Assert.areEqual(1, testDestList2.size(), 'Should return 1');
        Assert.areEqual('Brazil', testDestList2[0].Name, 'Should return Brazil');
    }
}