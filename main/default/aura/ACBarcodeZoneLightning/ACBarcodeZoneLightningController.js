({
    doInit : function(component, event, helper) {
        console.log("*** inside DoInit"); 
        console.log("*** before Fetching barcodeImage");        
        var action = component.get("c.brcodeImage");
        console.log("setting parameter")
        action.setParams({
            "Brcd" : component.get("v.Value"),
            "BarcdType" : component.get("v.BrcdType"),
            "BarcdHeight" : component.get("v.BrcdHeight"),
            "BarWidth" : component.get("v.BarsWidth"),
            "brcdValHide" : component.get("v.hideText"),
        });
        action.setCallback(this, function(response) {
            console.log("inside BrcodeImage");
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.response1", response.getReturnValue());
                //console.log(' response.getReturnValue()'+ response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
})