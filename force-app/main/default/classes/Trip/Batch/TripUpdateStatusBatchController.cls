public with sharing class TripUpdateStatusBatchController {
    public static void runTripUpdateStatusBatch() {
        TripUpdateStatusBatch newBatch = new TripUpdateStatusBatch();
        Database.executeBatch(newBatch);
    }
}