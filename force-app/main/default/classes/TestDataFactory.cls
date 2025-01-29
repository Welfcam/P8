@isTest
public class TestDataFactory {

    public static Account createAccountTest() {
        Account testAccount1 = new Account(
            Name = 'Entreprise 1',
            Type = 'Other',
            Industry = 'Chemicals',
            Phone = '234-567-8901',
            Website = 'test@test1234.com',
            BillingStreet = 'XYZ Street',
            BillingPostalCode = '12345',
            BillingCity = 'London',
            BillingCountry = 'United Kingdom'
        );
        return testAccount1;
    }

    public static Account createAccountTest2() {
        Account testAccount2 = new Account(
            Name = 'Entreprise 2',
            Type = 'Other',
            Industry = 'Other',
            Phone = '123-456-7890',
            Website = 'test@test5678.com',
            BillingStreet = 'Rue ABC',
            BillingPostalCode = '67890',
            BillingCity = 'Paris',
            BillingCountry = 'France'
        );
        return testAccount2;
    }

    public static List<Destination__c> createDestinationListTest() {
        List<Destination__c> destList = new List<Destination__c>();
        destList.add(new Destination__c(Name = 'Japan', Cost_Per_Person_Per_Day__c = 800));
        destList.add(new Destination__c(Name = 'Brazil', Cost_Per_Person_Per_Day__c = 500));
        return destList;
    }

    public static Destination__c createDestinationTest() {
        Destination__c testDest1 = new Destination__c(
            Name = 'United States',
            Cost_Per_Person_Per_Day__c = 700
        );
        return testDest1;
    }

    public static Opportunity createOppTest(Id accountId, Id destinationId) {
        Opportunity oppTest1 = new Opportunity(
            Name = 'Opp Test 1',
            AccountId = accountId,
            CloseDate = System.today().addMonths(1),
            StageName = 'Prospecting',
            Destination__c = destinationId,
            Number_Of_Participants__c = 10,
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(20)
        );
        return oppTest1;
    }

    public static Opportunity createOppTest2(Id accountId, Id destinationId) {
        Opportunity oppTest2 = new Opportunity(
            Name = 'Opp Test 2',
            AccountId = accountId,
            CloseDate = System.today().addMonths(1),
            StageName = 'Qualification',
            Destination__c = destinationId,
            Number_Of_Participants__c = 15,
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(20)
        );
        return oppTest2;
    }

    public static Opportunity createOppTestWithDateError(Id accountId, Id destinationId) {
        Opportunity oppTest3 = new Opportunity(
            Name = 'Opp Test Date Error',
            AccountId = accountId,
            CloseDate = System.today().addMonths(1),
            StageName = 'Prospecting',
            Destination__c = destinationId,
            Number_Of_Participants__c = 10,
            Start_Date__c = Date.today().addDays(20),
            End_Date__c = Date.today().addDays(10)
        );
        return oppTest3;
    }

    public static Opportunity createOppTestWithNegativeParts(Id accountId, Id destinationId) {
        Opportunity oppTest4 = new Opportunity(
            Name = 'Opp Test Participants Error',
            AccountId = accountId,
            CloseDate = System.today().addMonths(1),
            StageName = 'Prospecting',
            Destination__c = destinationId,
            Number_Of_Participants__c = -2,
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(20)
        );
        return oppTest4;
    }

    public static Opportunity createOppTestWithLessThan10Participants(Id accountId, Id destinationId) {
        Opportunity oppTest3 = new Opportunity(
            Name = 'Opp Test 5 Participants',
            AccountId = accountId,
            CloseDate = System.today().addMonths(1),
            StageName = 'Prospecting',
            Destination__c = destinationId,
            Number_Of_Participants__c = 5,
            Start_Date__c = Date.today().addDays(6),
            End_Date__c = Date.today().addDays(17)
        );
        return oppTest3;
    }

    public static Opportunity createOppTestTripOngoing(Id accountId, Id destinationId) {
        Opportunity oppTest4 = new Opportunity(
            Name = 'Opp Test Trip Ongoing',
            AccountId = accountId,
            CloseDate = System.today().addMonths(1),
            StageName = 'Prospecting',
            Destination__c = destinationId,
            Number_Of_Participants__c = 10,
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(5)
        );
        return oppTest4;
    }

    public static Opportunity createOppTestTripFinished(Id accountId, Id destinationId) {
        Opportunity oppTest5 = new Opportunity(
            Name = 'Opp Test Trip Finished',
            AccountId = accountId,
            CloseDate = System.today().addMonths(1),
            StageName = 'Prospecting',
            Destination__c = destinationId,
            Number_Of_Participants__c = 10,
            Start_Date__c = Date.today().addDays(-10),
            End_Date__c = Date.today().addDays(-1)
        );
        return oppTest5;
    }

    public static Contract createContractTest(Opportunity opp) {
        Contract contractTest1 = new Contract(
            AccountId = opp.AccountId,
            OpportunityId__c = opp.Id,
            Status = 'Draft',
            StartDate = opp.Start_Date__c,
            ContractTerm = 2
        );
        return contractTest1;
    }

    public static Contract createContractTest2(Opportunity opp) {
        Contract contractTest2 = new Contract(
            AccountId = opp.AccountId,
            OpportunityId__c = opp.Id,
            Status = 'Draft',
            StartDate = opp.Start_Date__c,
            ContractTerm = 1
        );
        return contractTest2;
    }

    public static Trip__c createTripTest(Opportunity opp) {
        Trip__c tripTest1 = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'To come',
            Destination__c = opp.Destination__c,
            Start_Date__c = opp.Start_Date__c,
            End_Date__c = opp.End_Date__c,
            Number_Of_Participants__c = opp.Number_Of_Participants__c,
            Total_Cost__c = opp.Total_Amount__c,
            AccountId__c = opp.AccountId
        );
        return tripTest1;
    }

    public static Trip__c createTripTest2(Opportunity opp) {
        Trip__c tripTest2 = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'To come',
            Destination__c = opp.Destination__c,
            Start_Date__c = opp.Start_Date__c,
            End_Date__c = opp.End_Date__c,
            Number_Of_Participants__c = opp.Number_Of_Participants__c,
            Total_Cost__c = opp.Total_Amount__c,
            AccountId__c = opp.AccountId
        );
        return tripTest2;
    }

    public static Trip__c createTripTestOngoing(Opportunity opp) {
        Trip__c tripTest3 = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'Ongoing',
            Destination__c = opp.Destination__c,
            Start_Date__c = opp.Start_Date__c,
            End_Date__c = opp.End_Date__c,
            Number_Of_Participants__c = opp.Number_Of_Participants__c,
            Total_Cost__c = opp.Total_Amount__c,
            AccountId__c = opp.AccountId
        );
        return tripTest3;
    }
}