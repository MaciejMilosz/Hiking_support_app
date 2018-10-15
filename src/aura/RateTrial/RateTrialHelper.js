({

    /**
        *   @author: Dragomir Rangelov
            @date: 11-10-2018
            @description: Queue up a remote method call to saveRating Apex controller to create a record
            @param:
            @returns:
        **/

    createRating: function(component, newRating) {
        var action = component.get("c.saveRating");

        action.setParams({
            "rating": newRating
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {

            }
        });
        $A.enqueueAction(action);

    },

})