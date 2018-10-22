/**
 * Created by drang on 10/22/2018.
 */

trigger AverageRateTrigger on Rate__c (before insert, before update, before delete) {


    if (trigger.isInsert || Trigger.isUpdate) {
        for (Rate__c rate : Trigger.New) {

            Trial__c trial = [SELECT id,Average_rate_trigger__c FROM Trial__c Where id = :rate.Trial__c];
            Integer numOfRecords = [SELECT COUNT() From Rate__c where Trial__c = :trial.id];
            Decimal allRatings = trial.Average_rate_trigger__c * numOfRecords;

            if (Trigger.isInsert) {

                allRatings += rate.Rating__c;
                Decimal newAvgRating = allRatings / (numOfRecords + 1);
                trial.Average_rate_trigger__c = newAvgRating;

            }

            if (Trigger.isUpdate) {

                Decimal oldRating = Trigger.oldMap.get(rate.Id).Rating__c;
                allRatings -= oldRating;
                allRatings += rate.Rating__c;
                Decimal newAvgRating = allRatings / (numOfRecords);
                trial.Average_rate_trigger__c = newAvgRating;

            }

            upsert trial;

        }
    }

    if (trigger.isDelete) {
        for (Rate__c rate : Trigger.old) {

            Trial__c trial = [SELECT id,Average_rate_trigger__c FROM Trial__c Where id = :rate.Trial__c];
            Integer numOfRecords = [SELECT COUNT() From Rate__c where Trial__c = :trial.id];
            Decimal allRatings = trial.Average_rate_trigger__c * numOfRecords;
            system.debug(numOfRecords);

            if (numOfRecords > 1) {

                Decimal oldRating = rate.Rating__c;
                allRatings -= oldRating;
                Decimal newAvgRating = allRatings / (numOfRecords - 1);
                trial.Average_rate_trigger__c = newAvgRating;

            } else {
                trial.Average_rate_trigger__c = 0;
            }

            update trial;

        }
    }
}