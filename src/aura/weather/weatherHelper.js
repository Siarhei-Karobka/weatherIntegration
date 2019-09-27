({
    init: function (component, days) {
        var action = component.get("c.getWeather");

        action.setParams({
            "city": component.get('v.choosedCity'),
            "days": days
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var responseObj = JSON.parse(response.getReturnValue());
                if (responseObj !== null) {
                    var cityInfo = {
                        city_name: responseObj.city_name,
                        country_code: responseObj.country_code
                    };
                    component.set('v.cityData', responseObj.data);
                    component.set("v.cityInfo", cityInfo);
                    component.set("v.showErrors", false);
                } else {
                    component.set("v.showErrors", true);
                }
            }
        });
        $A.enqueueAction(action);
    }
});