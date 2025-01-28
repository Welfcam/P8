public with sharing class TripCancelBatchController {
    public static void runTripCancelBatch() {
        TripCancelBatch newBatch = new TripCancelBatch();
        Database.executeBatch(newBatch);
    }
}