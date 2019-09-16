/**
 * Created by OK on 16.09.2019.
 */
({
    init: function (component) {
        var action = component.get("c.getWeather");

        action.setParams({"city": component.get('v.choosedCity')});
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.cityInfo", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
});