/**
 * Created by drang on 10/19/2018.
 */

public with sharing class TrialCoordinatesExtension {

        private Trial__c currentTrial;

        public TrialCoordinatesExtension(ApexPages.StandardController controller) {
            currentTrial = [
                    SELECT Id, Start_point__Latitude__s, Start_point__Longitude__s, End_point__Latitude__s, End_point__Longitude__s
                    FROM Trial__c
                    WHERE Id = :ApexPages.currentPage().getParameters().get('id')
            ];
        }

        public Trial__c getTrial(){
            return currentTrial;
        }
    }