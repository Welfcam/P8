public with sharing class TripCancelBatchScheduler implements Schedulable {
    public static void execute(SchedulableContext context) {
        TripCancelBatchController.runTripCancelBatch();
    }
}