({
    doInit: function (component, event, helper) {
        var days = event.getSource().get('v.value');
        helper.init(component, days);
    }
});