/**
 * Created by hstoy on 10/16/2018.
 */

@isTest
private class TestTrialDifficultyExtensionController {

    @isTest static void testController() {

        Mountains__c m = new Mountains__c(Name = 'Test Mountain');
        insert m;

        Trial__c trialTest = new Trial__c(Name = 'Test Trial',
                Mountains__c = m.Id , Trial_Level__c = 'Level 1' );
        insert trialTest;

        PageReference pageReference = Page.TrialDifficultyInformation;
        Test.setCurrentPage(pageReference);

        ApexPages.StandardController sc = new ApexPages.StandardController(trialTest);
        ApexPages.currentPage().getParameters().put('id', trialTest.Id);

        TrialDifficultyExtensionController ex = new TrialDifficultyExtensionController(sc);

        ex.getTrailDetails();
        ex.getColour();

        Trial__c trialTest1 = new Trial__c(Name = 'Test1 Trial',
                Mountains__c = m.Id);
        insert trialTest1;

        sc = new ApexPages.StandardController(trialTest1);
        ApexPages.currentPage().getParameters().put('id', trialTest1.Id);
        ex = new TrialDifficultyExtensionController(sc);
        ex.getTrailDetails();
    }

}