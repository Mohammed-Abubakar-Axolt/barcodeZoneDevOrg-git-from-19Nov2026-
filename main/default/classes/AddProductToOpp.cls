public with sharing class AddProductToOpp {
    
    @AuraEnabled
    public static void savePriBook(Id selRecord, String pricebook){
        System.debug('selRecord  :'+selRecord +'    pricebook :'+pricebook);
        Pricebook2 pb = [Select Id from Pricebook2 where Name like :pricebook Limit 1];
        Opportunity opp=new Opportunity();
        opp.Id=selRecord;
        opp.Pricebook2Id = pb.Id;
        upsert opp;
    }
    
    @AuraEnabled
    public static List<SObJectResult> searchProBarcode1(String recordId, String barcode, String price) {
        system.debug('barcode :'+barcode);
        //Product2 prod=[Select Id,Name from Product2 where ProductCode like :barcode];
        //Opportunity opp=[Select Id,Pricebook2Id from opportunity where Id =:recordId];     
        //PricebookEntry pbe1 =[Select Id, Name from PricebookEntry where Pricebook2Id =: opp.Pricebook2Id AND Product2Id =:prod.Id Limit 1];
        List<PricebookEntry> sObjectResultList = new List<PricebookEntry>();
        sObjectResultList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where ProductCode like :barcode AND IsActive=TRUE) AND IsActive=TRUE];
        if(sObjectResultList.size() != 0){
            for(PricebookEntry pbe : sObjectResultList){
            OpportunityLineItem opline= new OpportunityLineItem();
            List<OpportunityLineItem> oli = [Select Id,Product2Id,UnitPrice,Quantity from OpportunityLineItem where OpportunityId =: recordId AND Product2Id =:pbe.Product2.Id AND UnitPrice =:pbe.UnitPrice];
            if(oli.size() != 0){
                for(OpportunityLineItem oli2 : oli){
                    if(oli2.Product2Id == pbe.Product2.Id && oli2.UnitPrice == pbe.UnitPrice){
                        oli2.UnitPrice = pbe.UnitPrice;
                        oli2.Quantity = oli2.Quantity + 1;
                        update oli2;
                    }else{
                        opline.OpportunityId = recordId;
                        //opline.PricebookEntryId=pbe1.Id;
                        opline.Product2Id = pbe.Product2.Id;
                        opline.UnitPrice = pbe.UnitPrice;
                        opline.Quantity = 1;
                        insert opline;
                    }
                }
            }else{
                opline.OpportunityId = recordId;
                //opline.PricebookEntryId=pbe1.Id;
                opline.Product2Id = pbe.Product2.Id;
                opline.UnitPrice = pbe.UnitPrice;
                opline.Quantity = 1;
                insert opline;
            }
            product2 pdesc= [Select Id,Name from product2 where Id =: pbe.Product2.Id];
            pdesc.Description = pbe.product2.description;
            upsert pdesc;
            }
        }
        
        List<SObJectResult> proList=new List<SObJectResult>();
        for(PricebookEntry obj: sObjectResultList)  proList.add(new SObjectResult(obj));
        
        return proList;
    }
    
    @AuraEnabled
    public static List<SObJectResult> getProductList(String name, String proCode, String family, String price){  
        String name1='%'+name+'%';
        List<PricebookEntry> productList = new List<PricebookEntry>();
        if(name == '' && proCode == '' && family != 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where Family like :family AND IsActive=TRUE) AND IsActive=TRUE];
        else if(name != '' && proCode == '' && family == 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where Name like :name1 AND IsActive=TRUE) AND IsActive=TRUE];
        else if(name == '' && proCode != '' && family == 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where ProductCode like :proCode AND IsActive=TRUE) AND IsActive=TRUE];
        else if(name != '' && proCode != '' && family == 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where Name like :name1 AND ProductCode like :proCode AND IsActive=TRUE) AND IsActive=TRUE];
        else if(name == '' && proCode != '' && family != 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where ProductCode like :proCode AND Family like :family AND IsActive=TRUE) AND IsActive=TRUE];
        else if(name != '' && proCode == '' && family != 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where Name like :name1 AND Family like :family AND IsActive=TRUE) AND IsActive=TRUE];        
        else if(name != '' && proCode != '' && family != 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where Name like :name1 AND ProductCode like :proCode AND Family like :family AND IsActive=TRUE) AND IsActive=TRUE];        
        else if(name == '' && proCode == '' && family == 'None') productList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where IsActive=TRUE) AND IsActive=TRUE];
        
        List<SObJectResult> proList=new List<SObJectResult>();
        for(PricebookEntry obj: productList) proList.add(new SObjectResult(obj));  
        
        return proList;
    }
    
    @AuraEnabled
    public static comWrap initial(String selRecord){
        comWrap comW = new comWrap();
        //List<Pricebook2> priBooks = [Select Id,Name from Pricebook2 where IsActive=true];
        //for(Pricebook2 pb : priBooks) comW.priBook.add(new SelectOptions(pb.Name, pb.Name));               
        Opportunity opp = [Select Id, Name, Pricebook2.Name From opportunity Where Id =: selRecord];
        if(opp.Pricebook2.Name != null){
            comW.priBook.add(new SelectOptions(opp.Pricebook2.Name,opp.Pricebook2.Name));
        
        	Schema.DescribeFieldResult fieldResult1 = product2.Family.getDescribe();
            List < Schema.PicklistEntry > ple1 = fieldResult1.getPicklistValues();
            for(Schema.PicklistEntry f: ple1) comW.prodFam.add(new SelectOptions(f.getLabel(), f.getValue()));        
        }else{
            List<Pricebook2> priBooks = [Select Id,Name from Pricebook2 where IsActive=true];
        	for(Pricebook2 pb : priBooks) comW.allpriBook.add(new SelectOptions(pb.Name, pb.Name));   
        }
        return comW;
    }
    
    @AuraEnabled
    public static List<SObJectResult> initialSec(String price){ 
        List<PricebookEntry> sObjectResultList = new List<PricebookEntry>();
        sObjectResultList = [Select UnitPrice,Product2.Id,Product2.Name,Product2.ProductCode,Product2.Description from PricebookEntry where Pricebook2Id IN (SELECT Id FROM PriceBook2 WHERE Name like :price) AND Product2Id IN (Select Id From Product2 where IsActive=TRUE) AND IsActive=TRUE Limit 50];
        List<SObJectResult> proList=new List<SObJectResult>();
        for(PricebookEntry obj: sObjectResultList) proList.add(new SObJectResult(obj));            
        
        return proList;
    }
    
    @AuraEnabled
    public static SObJectResult initialth(String recordId){
    	SObJectResult proList=new SObJectResult();
        List<OpportunityLineItem> oliList=new List<OpportunityLineItem>(); 
        List<OpportunityLineItem> oli = [Select Id,Product2Id,Quantity,UnitPrice,Description,product2.Name from OpportunityLineItem where OpportunityId =:recordId Order By SortOrder];
        for(OpportunityLineItem oli2: oli) oliList.add(oli2); 
        proList.oli=oliList;
        return proList;
    }
    
    @AuraEnabled
    public static void addProdLineItem(String recordId1, String selPro, Decimal UnitPrice, Decimal quantity, String description){
        
        system.debug('recordId :'+recordId1+'   selPro :'+selPro +'   UnitPrice :'+UnitPrice +'   quantity:'+quantity);
        Opportunity opp=[Select Id,Pricebook2Id from opportunity where Id =:recordId1];     
        PricebookEntry pbe =[Select Id, Name from PricebookEntry where Pricebook2Id =: opp.Pricebook2Id AND Product2Id =:selPro Limit 1];
        OpportunityLineItem opline= new OpportunityLineItem();
        List<OpportunityLineItem> oli = [Select Id,Product2Id,UnitPrice,Quantity from OpportunityLineItem where OpportunityId =: recordId1 AND Product2Id =:selPro AND UnitPrice =:UnitPrice];
        if(oli.size() != 0){
            for(OpportunityLineItem oli2 : oli){
                if(oli2.Product2Id == selPro && oli2.UnitPrice == UnitPrice){
                    oli2.UnitPrice = UnitPrice;
                    oli2.Quantity = oli2.Quantity + quantity;
                    update oli2;
                }else{
                    opline.OpportunityId = recordId1;
                    opline.PricebookEntryId=pbe.Id;
                    opline.Product2Id = selPro;
                    opline.UnitPrice = UnitPrice;
                    opline.Quantity = quantity;
                    insert opline;
                }
        	}
        }else{
            opline.OpportunityId = recordId1;
            opline.PricebookEntryId=pbe.Id;
            opline.Product2Id = selPro;
            opline.UnitPrice = UnitPrice;
            opline.Quantity = quantity;
            insert opline;
        }
        product2 pdesc= [Select Id,Name from product2 where Id =: selPro];
        pdesc.Description = description;
        upsert pdesc;
    }
    
    @AuraEnabled
    public static void manageProducts(List<OpportunityLineItem> oliList, List<String> listforDel){
        //System.debug('oliList :'+oliList); System.debug('listforDel :'+listforDel);
        List<OpportunityLineItem> selforDel=[Select Id,Name from OpportunityLineItem where Id IN :listforDel];       
       
        for(integer i=0; i < oliList.size(); i++) oliList[i].sortOrder=i;        
        if(oliList.size() > 0) update oliList;        
        if(selforDel.size() > 0) delete selforDel;       
    }
    
    public class SObJectResult {
        @AuraEnabled public PricebookEntry product	{ get; set; }
        @AuraEnabled public List<OpportunityLineItem> oli	{ get; set; }
        @AuraEnabled public Decimal quantity	{ get; set; }
        public SObJectResult(PricebookEntry pro) {  
            product = pro;
            quantity = 1;
        }
        public SObJectResult(){
            oli = new List<OpportunityLineItem>();
        }
    }
    
    public class comWrap {
        @AuraEnabled public List<selectOptions> allpriBook 		{ get; Set; }
        @AuraEnabled public List<selectOptions> priBook 		{ get; Set; }
    	@AuraEnabled public List<selectOptions> prodFam 	{ get; Set; }
        @AuraEnabled public Opportunity pricebookentry 	{ get; Set; }
        
        public comWrap() {
            allpriBook = new List<selectOptions>();
            priBook = new List<selectOptions>();
            prodFam = new List<selectOptions>();
            pricebookentry = new Opportunity();
        }
    }
    public class selectOptions {
        @AuraEnabled public String label     { get; set; }
        @AuraEnabled public String value     { get; set; }
        //@AuraEnabled public Boolean selected { get; set; }
        
        public selectOptions(String lab, string val) {
            label = lab;
            value = val;
            //selected = false;
        }
        /*public selectOptions(String lab, string val, Boolean sel) {
            label = lab;
            value = val;
            selected = sel;
        }*/
    }

}