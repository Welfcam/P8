public with sharing class TripUpdateStatusBatchScheduler implements Schedulable {
    public static void execute(SchedulableContext context) {
        TripUpdateStatusBatchController.runTripUpdateStatusBatch();
    }
}