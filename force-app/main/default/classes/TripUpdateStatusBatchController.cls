//Controller pour exécuter le batch TripUpdateStatusBatch
public with sharing class TripUpdateStatusBatchController {
    public static void runTripUpdateStatusBatch() {
        //Création d'un nouveau TripUpdateStatusBatch
        TripUpdateStatusBatch newBatch = new TripUpdateStatusBatch();
        //Envoie le bacth à la plateforme Salesforce qui l'exécute
        Database.executeBatch(newBatch);
    }
}