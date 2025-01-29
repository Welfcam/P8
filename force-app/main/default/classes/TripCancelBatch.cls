//Batch Apex pour annuler les voyages qui ont moins de 10 participant à 7 jours de la date de début du voyage
public with sharing class TripCancelBatch implements Database.Batchable<Trip__c> {
    //Récupère les enregistrements à traiter par le Batch
    public Iterable<Trip__c> start(Database.BatchableContext context) {
        Iterable<Trip__c> query = [SELECT Id, Status__c, Start_Date__c, Number_of_Participants__c FROM Trip__c];
        return query;
    }

    //Si le voyage est en statut 'To come', le nombre de participant <10 et qu'il y a 7 jours ou 
    //moins entre aujourd'hui et la date de début, le statut du voyage passe à 'Cancelled'
    public void execute(Database.BatchableContext context, List<Trip__c> scope) {
        for(Trip__c trip : scope) {
            //Calcul des conditions d'annulation
            Date startDate = trip.Start_Date__c;
            Date today = Date.today();
            Integer daysDifference = startDate.daysBetween(today);
            Boolean isTripToCome = trip.Status__c == 'To come';
            Boolean isLessThan10Participants = trip.Number_of_Participants__c < 10;
            Boolean isStartingWithin7Days = daysDifference <= 7;
            //Vérification des conditions pour annuler le voyage
            if(isTripToCome && isStartingWithin7Days && isLessThan10Participants) {
                trip.Status__c = 'Cancelled';
            }
        }
        //Mise à jour des enregistrement modifiés s'il y en a
        update scope;
    }

    //Méthode exécutée après la fin du batch
    public void finish(Database.BatchableContext context) {
        System.debug('Finished !');
    }                    
}

