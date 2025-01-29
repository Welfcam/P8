//Batch Apex pour mettre à jour le statut des voyages en fonction des dates de voyage
public with sharing class TripUpdateStatusBatch implements Database.Batchable<Trip__c> {
    //Récupère les enregistrements à traiter par le Batch
    public Iterable<Trip__c> start(Database.BatchableContext context) {
        Iterable<Trip__c> query = [SELECT Id, Status__c, Start_Date__c, End_Date__c, Number_of_Participants__c FROM Trip__c];
        return query;
    }

    public void execute(Database.BatchableContext context, List<Trip__c> scope) {
        for(Trip__c trip : scope) {
            Date startDate = trip.Start_Date__c;
            Date endDate = trip.End_Date__c;
            Date today = Date.today();
            //Si la date de début est supérieure à aujourd'hui, le statut du voyage passe à 'To come' (dans le cas où il ne le serait pas déjà)
            if(today < startDate) {
                trip.Status__c = 'To come';
            //Si aujoud'hui se situe entre la date de début et la date de fin, le statut du voyage passe à 'On going'
            } else if(today >= startDate && today <= endDate) {
                trip.Status__c = 'Ongoing';
            //Si aujourd'hui se situe après la date de fin de voyage, le statut pas à 'Finished'    
            } else if(today > endDate) {
                trip.Status__c = 'Finished';
            }
        }
        //Mise à jour des enregistrements modifiés
        update scope;
    }

    //Méthode exécutée après la fin du batch
    public void finish(Database.BatchableContext context) {
        System.debug('Finished !');
    }                    
}