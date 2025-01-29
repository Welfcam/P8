//Permet de planifier l'exécution automatique du batch TripCancelBatch par Salesforce 
//Appelle la méthode runTripCancelBatch de TripCancelBatchController
public with sharing class TripCancelBatchScheduler implements Schedulable {
    public static void execute(SchedulableContext context) {
        TripCancelBatchController.runTripCancelBatch();
    }
}