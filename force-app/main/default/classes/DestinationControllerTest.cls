@isTest
private class DestinationControllerTest {

    //test de la création d'une Destination standard
    @isTest
    static void testCreateDestination() {
        Destination__c testDest = TestDataFactory.createDestinationTest();
        Test.startTest();
        Destination__c dest = DestinationController.createDestination(testDest);
        Test.stopTest();
        List<Destination__c> destList = [SELECT Id, Name FROM Destination__c WHERE Id = :dest.Id];
        Assert.areEqual(dest.Id, destList[0].Id, 'Should return dest Id');
        Assert.areEqual(dest.Name, destList[0].Name, 'Should return United States');
    }
    
    //Test de la création d'une Destination avec un coût par personne par jour négatif
    @isTest
    static void testCreateDestinationWithNegativeCost() {
        Destination__c testDest = new Destination__c(
            Name = 'France',
            Cost_Per_Person_Per_Day__c = -200
        );
        Test.startTest();
        try {
            DestinationController.createDestination(testDest);
        } catch (IllegalArgumentException e) {
            Assert.areEqual(e.getMessage().contains('The destination cost cannot be negative'), true);
        }
        Test.stopTest();
        List<Destination__c> destList = [SELECT Id FROM Destination__c];
        Assert.areEqual(0, destList.size(), 'Should return 0 results'); //Aucune insertion ne doit être effectuée
    }

    //Test de la récupération d'un Destination
    @isTest
    static void testGetDestinations() {
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Test.startTest();
        List<Destination__c> result = DestinationController.getDestinations();
        Test.stopTest();
        Assert.areEqual(testDestList[0].Name, result[0].Name, 'Should return Japan');
        Assert.areEqual(testDestList[1].Cost_Per_Person_Per_Day__c, result[1].Cost_Per_Person_Per_Day__c, 'Should return 500');
    }

    //Test de la mise à jour d'un Destination
    @isTest
    static void testUpdateDestinations() {
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Destination__c destToUpdate = testDestList[0];
        destToUpdate.Cost_Per_Person_Per_Day__c = 1000;
        Test.startTest();
        DestinationController.updateDestination(destToUpdate);
        Test.stopTest();
        Assert.areEqual(destToUpdate.Cost_Per_Person_Per_Day__c, testDestList[0].Cost_Per_Person_Per_Day__c, 'Should return 1000');
    }

    //Test de la mise à jour d'un Destination avec un coût par personne par jour négatif
    @isTest
    static void testUpdateDestinationWithNegativeCost() {
        Destination__c testDest = TestDataFactory.createDestinationTest();
        insert testDest;
        testDest.Cost_Per_Person_Per_Day__c = -50;
        Test.startTest();
        try {
            DestinationController.updateDestination(testDest);
        } catch (IllegalArgumentException e) {
            Assert.areEqual(e.getMessage().contains('The destination cost cannot be negative'), true);
        }
        Test.stopTest();
        Destination__c nonUpdatedTestDest = [SELECT Id, Cost_Per_Person_Per_Day__c FROM Destination__c WHERE Id = :testDest.Id];
        Assert.areEqual(700, nonUpdatedTestDest.Cost_Per_Person_Per_Day__c, 'Should return 700');
    }

    //Test de la suppression d'un Destination.
    @isTest
    static void testDeleteDestinations() {
        List<Destination__c> testDestList = TestDataFactory.createDestinationListTest();
        insert testDestList;
        Destination__c destToDelete = testDestList[0];
        Test.startTest();
        DestinationController.deleteDestination(destToDelete.Id);
        Test.stopTest();
        List<Destination__c> testDestList2 = [SELECT Id, Name, Cost_Per_Person_Per_Day__c FROM Destination__c]; 
        Assert.areEqual(1, testDestList2.size(), 'Should return 1');
        Assert.areEqual('Brazil', testDestList2[0].Name, 'Should return Brazil');
    }
}