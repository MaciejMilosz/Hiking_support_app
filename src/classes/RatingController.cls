/**
 * Created by drang on 10/11/2018.
 */

public with sharing class RatingController {

    /**
    *    @author: Dragomir Rangelov
        @date: 11-10-2018
        @description: check if current user has given a rating to selected trial. Update the old one, or create a new one if none exists.
        @param: Rate__c rating - rating object that contains description and rating given by the user
        @returns: newly created or updated rating record
    **/

    @AuraEnabled
    public static Rate__c saveRating(Rate__c rating) {

        Rate__c[] oldRating= [Select id From Rate__c Where (CreatedById = :UserInfo.getUserId() AND Trial__c = :rating.Trial__c) LIMIT 1];

        if(!oldRating.isEmpty()){
            rating.Id = oldRating[0].Id;
        }
        upsert rating;

        return rating;
    }

}