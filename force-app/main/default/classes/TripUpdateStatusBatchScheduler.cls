//Permet de planifier l'exécution automatique du batch TripUpdateStatusBatch par Salesforce 
//Appelle la méthode runTripUpdateStatusBatch de TripUpdateStatusBatchController
public with sharing class TripUpdateStatusBatchScheduler implements Schedulable {
    public static void execute(SchedulableContext context) {
        TripUpdateStatusBatchController.runTripUpdateStatusBatch();
    }
}