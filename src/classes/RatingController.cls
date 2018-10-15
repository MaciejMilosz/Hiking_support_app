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

        Rate__c[] oldRating= [Select id From Rate__c Where (CreatedById = :UserInfo.getUserId() AND Trial__c = :rating.Trial__c)];

        if(oldRating.size() > 0){
            oldRating[0].Rating__c = rating.Rating__c;
            oldRating[0].Description__c = rating.Description__c;
            update oldRating[0];
        } else{
            insert rating;
        }

        return rating;
    }

}