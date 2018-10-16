/**
 * Created by hstoy on 10/16/2018.
 */

@isTest
private class TestTrialDifficultyExtensionController {

    @isTest static void testController() {

        Mountains__c m = new Mountains__c(Name = 'Test Mountain');
        insert m;

        Trial__c trialTest = new Trial__c(Name = 'Test Trial',
                Mountains__c = m.Id, Trial_Level__c = 'Level 1');
        insert trialTest;


        PageReference pageReference = Page.TrialDifficultyInformation;
        Test.setCurrentPage(pageReference);

        ApexPages.StandardController sc = new ApexPages.StandardController(trialTest);
        ApexPages.currentPage().getParameters().put('id', trialTest.Id);

        TrialDifficultyExtensionController ex = new TrialDifficultyExtensionController(sc);

        Trial_Level__mdt returnedObject = ex.getTrailDetails();
        System.assertNotEquals(null, returnedObject);

        String returnedColour = ex.getColour();
        System.assertEquals('#0d26', returnedColour);

        trialTest.Trial_Level__c = null;
        update trialTest;


        sc = new ApexPages.StandardController(trialTest);
        ApexPages.currentPage().getParameters().put('id', trialTest.Id);
        ex = new TrialDifficultyExtensionController(sc);

        Trial_Level__mdt returnedNullObject = ex.getTrailDetails();
        System.assertEquals(null, returnedNullObject);

    }

}