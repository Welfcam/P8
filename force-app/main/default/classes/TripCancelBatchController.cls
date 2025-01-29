//Controller pour exécuter le batch TripCancelBatch
public with sharing class TripCancelBatchController {
    public static void runTripCancelBatch() {
        //Création d'un nouveau TripCancelBatch
        TripCancelBatch newBatch = new TripCancelBatch();
        //Envoie le batch à la plateforme Salesforce qui l'éxécute
        Database.executeBatch(newBatch);
    }
}