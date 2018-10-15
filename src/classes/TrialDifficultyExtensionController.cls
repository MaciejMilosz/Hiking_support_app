public with sharing class TrialDifficultyExtensionController {


    private Trial__c currentTrial;
    private Trial_Level__mdt[] trialLevel;

    public TrialDifficultyExtensionController(ApexPages.StandardController controller) {
        this.currentTrial = [
                SELECT Id, Trial_Level__c
                FROM Trial__c
                WHERE Id = :ApexPages.currentPage().getParameters().get('id')
        ];

    }

    /*
        @Description: The method finds a metaData object by criteria that is set
        from the current record page "Trial_Level__c" field

        @param: currentTrail - stores Id and Trial_Level__c of the current Trail__c's record
                trialLevel - stores all fields of the Trial_Level__mdt

        @Returns: method returns list of the searched fields of the metaData object;
    */
    public Trial_Level__mdt[] getTrailDetails() {
        if (this.currentTrial.Trial_Level__c == null || this.currentTrial.Trial_Level__c == '--None--') {
            return this.trialLevel;
        }
        this.trialLevel = [
                SELECT Advanced_hiking_equipment_required__c, Advanced_hiking_footwear_required__c, Colour__c, Description__c,
                        Dogs_allowed__c, Experienced_hikers_only__c, Difficulty_Level__c, For_Beginners__c,
                        Kids_allowed__c, Water_required__c
                FROM Trial_Level__mdt
                WHERE Label = :this.currentTrial.Trial_Level__c
        ];

        return this.trialLevel;
    }


    /*
        @Description:  The method finds a metaData object by criteria that is set
        from the current record page "Trial_Level__c" field and gets the metaData object's field
        "Colour__c" value. Then it convert it into hexadecimal code.
        
        @param: chars - it is a list of all chars needed to convert the given number from "Colour__c" value
                colourValue - is a list where the "Colour__c" value is stored
                reminder - is an Integer value where modulo division is stored
                temp - temporary String variable where the value of colourValue is stored and processed
                colourValueInteger - an Integer variable is where the temp processed value is stored
                hexString = is a String variable where the hexadecimal code is stored

        @returns: String representation of the hexadecimal value
     */
    public String getColour() {
        String[] chars = new String[]{
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
        };

        Trial_Level__mdt[] colourValue = [
                SELECT Colour__c
                FROM Trial_Level__mdt
                WHERE Label = :this.currentTrial.Trial_Level__c
        ];

        Integer reminder;
        String hexString;
        String temp = String.valueOf(colourValue[0].Colour__c).replace('.0', '');
        Integer colourValueInteger = Integer.valueOf(temp);

        while (colourValueInteger > 0) {
            reminder = Math.mod(colourValueInteger, 16);

            hexString = chars[reminder] + hexString;

            colourValueInteger = colourValueInteger / 16;
        }
        hexString = hexString.replace('null', '');
        hexString = '#0' + hexString;

        return hexString;
    }

}