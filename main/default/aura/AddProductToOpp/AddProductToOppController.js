({
    
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
    },
    
    hideSpinner : function(component,event,helper){
        component.set("v.Spinner", false);
    },
    
    addProductsTab :function(component,event,helper){
        component.set("v.name",'');
        component.set("v.proCode",'');
        component.set("v.prodFam",'None');
        component.set("v.scanValue",'');
        component.set("v.productTab",true);
        component.set("v.manageTab", false);
        component.set("v.addprodTab",true);
        component.set("v.manageProdTab", false);
        var a = component.get("c.initial1");
        $A.enqueueAction(a);
        component.set("v.Spinner", false);
    },
    manageProductsTab :function(component,event,helper){
        component.set("v.productTab",false);
        component.set("v.manageTab", true);
        component.set("v.manageProdTab", true);
        component.set("v.addprodTab",false); 
        helper.initial3(component,event);
        component.set("v.Spinner", false);
    },
    
    focusTOscan : function (component, event,helper) {
        component.set("v.scanValue",'');
        console.log('<==  focusonscan  ==>');
        helper.focusTOscan(component, event); 
        component.set("v.Spinner", false);
    },
    
    savePricebook :function(component, event, helper) {
        var pricebook=component.get("v.allpribook");
        console.log("Pricebook for opportunity :",pricebook);
        var action = component.get("c.savePriBook");
        action.setParams({
            selRecord : component.get("v.recordId"),
            pricebook : pricebook
        });
        action.setCallback(this, function(response){
            $A.get('e.force:refreshView').fire();
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                'title': 'Success',
                'type': 'success',
                'mode': 'dismissable',
                'message': 'Pricebook added to Opportunity'
            });
            toastEvent.fire();
            component.set("v.pricebookSelected", false);
            var a = component.get("c.initial1");
            $A.enqueueAction(a);
            component.set("v.Spinner", false);
        });
        $A.enqueueAction(action);
    },
    
    initial1: function(component, event, helper) {  
        component.set("v.addprodTab",true);
        var action = component.get("c.initial");
        action.setParams({selRecord : component.get("v.recordId")});
        action.setCallback(this, function(response){
            var STATE = response.getState();
            console.log(STATE);
            if(STATE === "SUCCESS") {
                console.log("Initial res :",response.getReturnValue());
                //component.set("v.pricebook",response.getReturnValue().pricebookentry.Pricebook2.Name);
                //console.log("***PriceBook :",component.get("v.pricebook"));
                component.set("v.isRecFetch", true);                
                component.find("price_book").set("v.options", response.getReturnValue().priBook);
                component.find("profamily_List").set("v.options", response.getReturnValue().prodFam);				
                console.log("pricebook initial1 :",component.get("v.pribook"));
                var pricebook=component.get("v.pribook");
                if(pricebook == undefined){
                    component.set("v.pricebookSelected", true);
                    component.find("allpricebook").set("v.options", response.getReturnValue().allpriBook);
                }                    
                else
                    helper.initial2(component,event);
                
                helper.initial3(component,event);
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);        	
    },
    
    getProduct: function(component, event, helper){
        console.log("PriceBook :",component.get("v.pribook"));
        var name=component.get("v.name");
        var proCode = component.get("v.proCode");
        var family=component.get("v.prodFam");
        var action= component.get("c.getProductList");
        action.setParams({
            name : name,
            proCode : proCode,
            family : family,
            price : component.get("v.pribook")
        });
        action.setCallback(this, function(response){
            var STATE = response.getState();
            if(STATE === "SUCCESS"){
                console.log("pro list :",response.getReturnValue());
                component.set("v.listOfProduct", response.getReturnValue());
                component.set("v.isRecFetch", true);
                console.log("List :",component.get("v.listOfProduct"));
                component.set("v.Spinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    
    searchProBarcode : function(component, event, helper) {
        console.log("addProductTab :",component.get("v.addprodTab"));
        if(component.get("v.addprodTab") == false){
            component.set("v.Spinner", false);
        }
        if(component.get("v.addprodTab")){	
        	console.log("Barcode scan");
        	console.log("barcode :",component.get("v.scanValue"));        
            if(component.get("v.scanValue") == ''){
                component.set("v.Spinner", false);
                return;                
            } 
            var action = component.get("c.searchProBarcode1");
            action.setParams({
                recordId : component.get("v.recordId"),
                barcode : component.get("v.scanValue"),
                price : component.get("v.pribook")
            });
            action.setCallback(this, function(response){
                var STATE = response.getState();
                console.log(STATE);
                if(STATE === "SUCCESS") {    
                    console.log('scan res :',response.getReturnValue());
                    component.set("v.scanProduct", response.getReturnValue());
                    if(component.get("v.scanProduct").length == 0){
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            'title': 'Error',
                            'type': 'error',
                            'mode': 'dismissable',
                            'message': 'Product not found'
                        });
                        toastEvent.fire();
                    }else{
                        $A.get('e.force:refreshView').fire();
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            'title': 'Success',
                            'type': 'success',
                            'mode': 'dismissable',
                            'message': 'Product added to Line Item'
                        });
                        toastEvent.fire(); 
                    }                    
                    component.set("v.scanValue",'');
                    component.set("v.Spinner", false);
                }
            });
            $A.enqueueAction(action);             
        }
    },
    
    NavRecord : function (component, event) {
        var RecId = event.getSource().get("v.title");
        var RecUrl = "/" + RecId;
        window.open(RecUrl,'_blank');
    },
    
    addProduct :function(component, event, helper) {  
        var myList = component.get("v.listOfProduct");
        for(var i=0;i<myList.length;i++){
            console.log("inside loop");
            if(myList[i].checkSelected){
                var selProduct=myList[i];	console.log("selProduct :",selProduct);
                var selPro=selProduct.product.Product2.Id;
                var UnitPrice=selProduct.product.UnitPrice;
                var quantity=selProduct.quantity;
                var desr=selProduct.product.Product2.Description;
                console.log("prodId :",selPro+"  UnitPrice:",UnitPrice+"  quantity:",quantity+"   Desr:",desr);
                if(UnitPrice == undefined || quantity == undefined){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        'title': 'Error',
                        'type': 'error',
                        'mode': 'dismissable',
                        'message': 'Unit Price and Quantity are required'
                    });
                    toastEvent.fire();
                }else{
                    var action=component.get("c.addProdLineItem");
                    action.setParams({
                        recordId1 :component.get("v.recordId"),
                        selPro :selPro,
                        UnitPrice : UnitPrice,
                        quantity :quantity,
                        description :desr
                    });
                    component.set("v.ifSuccess", true);
                    $A.enqueueAction(action);
                }                
            }
        }
        var ifSuccess=component.get("v.ifSuccess");
        console.log("ifSuccess :",ifSuccess);
        if(ifSuccess == true){
            $A.get('e.force:refreshView').fire();
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                'title': 'Success',
                'type': 'success',
                'mode': 'dismissable',
                'message': 'Products added to Line Item'
            });
            toastEvent.fire();
            component.set("v.isProSel",false);  
            component.set("v.Spinner", false);
            var dismissActionPanel = $A.get("e.force:closeQuickAction");
            dismissActionPanel.fire();            
        }        
    },
    
    checkboxSelect :function(component, event, helper) {
        var checkbox=event.getSource().get("v.value");
        var count= component.get("v.counter");
        if(checkbox == true){count++;}            
        else{count--;}
        component.set("v.counter", count);
        if(count > 0)    
            component.set("v.isProSel", true);
        else
            component.set("v.isProSel", false);        
    },    
    
    manageProduct :function(component,event,helper){
        var selIdforDel=[];
        var myListforDel=component.get("v.listforDel");
        for(var i=0;i<myListforDel.length;i++){
            var selProduct=myListforDel[i];
            selIdforDel.push(selProduct.Id);
        }
        var myOLIList=component.get("v.listOfOli");
        console.log("myOLIList :",myOLIList);
                
        var action= component.get("c.manageProducts");
        action.setParams({
            oliList : myOLIList,
            listforDel : selIdforDel
        });
        action.setCallback(this, function(response){
            var STATE = response.getState();
            console.log(STATE);
            if(STATE === "SUCCESS"){
                $A.get('e.force:refreshView').fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    'title': 'Success',
                    'type': 'success',
                    'mode': 'dismissable',
                    'message': 'Products Updated to Line Item'
                });
                toastEvent.fire();
                component.set("v.Spinner", false);
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
                dismissActionPanel.fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    removeRow : function(component,event,helper){
        var oliList = component.get("v.listOfOli"); 
        var index=event.currentTarget.dataset.service;
        console.log('Index :'+index);
        var listforDel = component.get("v.listforDel");
        var removedItem=oliList[index];
        listforDel.push(removedItem);
        console.log("removedItem :",removedItem);
        oliList.splice(index, 1);
        component.set("v.listforDel",listforDel);
        console.log("list for del :",component.get("v.listforDel"));
        component.set("v.listOfOli", oliList);
        
        /*var oliList = component.get("v.listOfOli");        
        var listforDel = component.get("v.listforDel");
        var removedItem = event.currentTarget.value;
        listforDel.push(removedItem);
        console.log("removedItem :",removedItem);
        oliList.splice(removedItem, 1);
        component.set("v.listforDel",listforDel);
        console.log("list for del :",component.get("v.listforDel"));
        component.set("v.listOfOli", oliList);*/
        
    },
    
    
    handleDrag : function(cmp, event, helper) {
        cmp.set("v.DragIndex", event.target.id);
    },
    
    allowDrop : function(cmp, event, helper) {
        event.preventDefault();
    },
    
    handleDrop : function(cmp, event, helper) {        
        var DragIndex = parseInt(cmp.get("v.DragIndex"));
        var indexVal=parseInt(event.currentTarget.getAttribute('data-index'));
        var listOfOli = cmp.get("v.listOfOli"); 
        var ShiftElement = listOfOli[DragIndex];
        listOfOli.splice(DragIndex, 1);                                          
        listOfOli.splice(indexVal, 0 , ShiftElement);
        cmp.set("v.listOfOli", listOfOli);
    },
    
})