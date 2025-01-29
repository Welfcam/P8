//Classe de gestion des Destinations. Utilise DestinationSelector pour interagir avec la base de données.
public with sharing class DestinationController {
    public static List<Destination__c> getDestinations() {
       return DestinationSelector.getDestinations();
    }

    public static Destination__c createDestination(Destination__c newDestination) {
        //vérifie que le coût par personne par jour de la destination n'est pas négatif
        if(newDestination.Cost_Per_Person_Per_Day__c < 0) { 
            throw new IllegalArgumentException('The destination cost cannot be negative');
        }
        return DestinationSelector.createDestination(newDestination);
    }

    public static Destination__c updateDestination(Destination__c destinationToUpdate) {
        //vérifie que le coût par personne par jour de la destination n'est pas négatif
        if(destinationToUpdate.Cost_Per_Person_Per_Day__c < 0) {
            throw new IllegalArgumentException('The destination cost cannot be negative');
        }
        return DestinationSelector.updateDestination(destinationToUpdate);
    }

    public static void deleteDestination(Id destinationId) {
        DestinationSelector.deleteDestination(destinationId);
    }
}
