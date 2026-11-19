({
	closeError : function(cmp,event){
        cmp.set("v.errorMsg",'');
    },
    
    initial : function(cmp, event, helper) {
        $A.util.removeClass(cmp.find('mainSpin'), "slds-hide");	//spinner show
        /*var action=cmp.get("c.fetchQuote");
        action.setParams({quoteId : cmp.get("v.quoteId")});
        action.setCallback(this,function(response){            
            if(response.getState()=="SUCCESS"){
                
                
                $A.util.addClass(cmp.find('mainSpin'), "slds-hide");	// Spinner hide
            }else{
				console.log('Error :',response.getError());
                var error=response.getError();
                cmp.set("v.errorMsg",error[0].message+' '+error[0].stackTrace);
			}
        });*/
        //$A.enqueueAction(action);
    },
})