/**
 * Created by drang on 10/19/2018.
 */

public with sharing class TrialCoordinatesExtension {

        private Trial__c currentTrial;

        public TrialCoordinatesExtension(ApexPages.StandardController controller) {
            controller.addFields(new String[]{'Start_point__c','End_point__c'});
            currentTrial = (Trial__c) controller.getRecord();
        }

        public Trial__c getTrial(){
            return currentTrial;
        }
    }