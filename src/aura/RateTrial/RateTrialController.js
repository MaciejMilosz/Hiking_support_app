({
    /**
    *   @author: Dragomir Rangelov
        @date: 15-10-2018
        @description: Set a rating from 1 - 5 to the current Trail and change the corresponding star images depending on user input
        @param:
        @returns:
    **/

    giveRating: function(component, event, helper) {

        var starNumber = event.currentTarget.getAttribute("id");
        component.set("v.newRating.Rating__c", starNumber);
        var starsIds = ['firstStar', 'secondStar', 'thirdStar', 'fourthStar', 'fifthStar'];

        for (var index = 0; index < starsIds.length; index++) {

            if (starNumber > 0) {
                component.find(starsIds[index]).getElement().src = 'https://cdn4.iconfinder.com/data/icons/CornerStone/PNG/star-4.png';
                starNumber--;
            } else {
                component.find(starsIds[index]).getElement().src = 'https://cdn4.iconfinder.com/data/icons/CornerStone/PNG/star-0.png';
            }
        }

    },

    /**
        *   @author: Dragomir Rangelov
            @date: 11-10-2018
            @description: Check if both text and rating are given valid values and call Helper to create record if they are
            @param:
            @returns:
        **/

    clickCreate: function(component, event, helper) {

        var validDescription = component.find('ratingForm').get('v.validity').valid;
        var rating = component.get("v.newRating");
        var ratingNumber = component.get("v.newRating.Rating__c");

        if (validDescription && ratingNumber > 0 && ratingNumber <= 5) {

            var trialId = component.get("v.recordId");
            component.set('v.newRating.Trial__c', trialId);
            helper.createRating(component, rating);

        } else {

            alert("please give a Rating before submitting!");

        }

    }

})