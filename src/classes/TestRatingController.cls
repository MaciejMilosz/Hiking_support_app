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

        Rate__c savedRating = [Select id,Trial__c,Rating__c, Description__c  FROM Rate__c Where Trial__c = :testTrial.Id AND Rating__c = 5 AND Description__c = 'awesome'];
        System.assertEquals(savedRating, testRating);

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

        Rate__c savedRating = [Select id,Trial__c,Rating__c, Description__c  FROM Rate__c Where Trial__c = :testTrial.Id AND Rating__c = 4 AND Description__c = 'very challenging'];
        System.assertEquals(savedRating, newRating);

    }


}