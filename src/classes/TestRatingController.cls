/**
 * Created by drang on 10/15/2018.
 */

@isTest
public with sharing class TestRatingController {

    @isTest
    static void testSaveNewRating(){

        Mountains__c testMountain = new Mountains__c(Name = 'Rila');
        insert testMountain;

        Trial__c testTrial = new Trial__c(Mountains__c = testMountain.Id , Name = 'testTrial');
        insert testTrial;

        Rate__c testRating = new Rate__c(Trial__c = testTrial.Id , Rating__c = 5, Description__c = 'awesome');

        Test.startTest();
        RatingController.saveRating(testRating);
        Test.stopTest();

        Rate__c savedRating = [Select id,Trial__c,Rating__c, Description__c  FROM Rate__c LIMIT 1];

        System.assertEquals(savedRating, testRating);
        System.assertEquals(savedRating.Description__c, testRating.Description__c);
        System.assertEquals(savedRating.Rating__c, testRating.Rating__c);


    }

    @isTest
    static void testUpdateExistingRating(){

        Mountains__c testMountain = new Mountains__c(Name = 'Rila');
        insert testMountain;

        Trial__c testTrial = new Trial__c(Mountains__c = testMountain.Id , Name = 'testTrial');
        insert testTrial;

        Rate__c initialRating = new Rate__c(Trial__c = testTrial.Id , Rating__c = 5, Description__c = 'awesome');
        insert initialRating;

        Rate__c newRating = new Rate__c(Trial__c = testTrial.Id , Rating__c = 4, Description__c = 'very challenging');

        Test.startTest();
        RatingController.saveRating(newRating);
        Test.stopTest();

        Rate__c savedRating = [Select id,Trial__c,Rating__c, Description__c  FROM Rate__c LIMIT 1];

        System.assertEquals(savedRating, newRating);
        System.assertEquals(savedRating.Description__c, newRating.Description__c);
        System.assertEquals(savedRating.Rating__c, newRating.Rating__c);
    }


}