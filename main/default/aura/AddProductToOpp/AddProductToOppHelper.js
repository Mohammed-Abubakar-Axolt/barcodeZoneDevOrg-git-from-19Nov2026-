({
	focusTOscan:function(component, event){ 
        $(document).ready(function() {
            component.set("v.scanValue",'');  
            var barcode = "";
            var pressed = false;
            var chars = [];
            $(window).keypress(function(e) {
                chars.push(String.fromCharCode(e.which));                      
                if (pressed == false) {
                    setTimeout(function() {
                        if (chars.length >= 4) {
                            var barcode = chars.join("");
                            barcode = barcode.trim();
                            console.log('barcode@: '+barcode.trim());
                            component.set("v.scanValue",barcode);
                        }
                        chars = [];
                        pressed = false;
                    },0);                                  
                }              
                pressed = true; 
            }); // end of window key press function
            $(window).keydown(function(e){
                if ( e.which === 13 ) { 
                    e.preventDefault();
                }
            });            
        });       
    },
    
    initial2 : function(component,event) {
		var pricebook=component.get("v.pribook");
        //console.log("pricebook  :",pricebook);
        var action = component.get("c.initialSec");
        action.setParams({ price : pricebook });
        action.setCallback(this, function(response){
            var STATE = response.getState();
            console.log(STATE);
            if(STATE === "SUCCESS") {
                console.log("initi2 :",response.getReturnValue());
                component.set("v.isRecFetch", true);
                component.set("v.listOfProduct", response.getReturnValue());   
                console.log("listOfProduct :",component.get("v.listOfProduct"));
                //component.find("barinput").focus();                          
            }
        });
        $A.enqueueAction(action);
	},
    
    initial3 :function(component,event) {
    	var action = component.get("c.initialth");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response){
            var STATE = response.getState();
            console.log(STATE);
            if(STATE === "SUCCESS") {
                console.log("initi3 :",response.getReturnValue());
                component.set("v.listOfOli", response.getReturnValue().oli);   
                console.log("listOfOLI :",component.get("v.listOfOli")); 
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    },
})