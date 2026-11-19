@isTest(seeAllData = true)
public class AddProductToOppTestCases { 
    static testMethod void unitTest1(){
        Product2 prod=new Product2(Name='Soya Oil',IsActive=true,ProductCode='8906006720480',Description='Refined Soya oil',Family='Oil');
        insert prod; 
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry stanPbe=new PricebookEntry(IsActive=true,UnitPrice=5000,Pricebook2Id=pricebookId,Product2Id=prod.Id);
        insert stanPbe;       
        Pricebook2 customPb=new Pricebook2(Name='Custom Price Book',IsActive=true);
        insert customPb;
		PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPb.Id, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert customPrice;        
        Opportunity opp= new opportunity(Name='Dickenson Mobile Generators',CloseDate=System.today()+30,StageName='Qualification',Pricebook2Id=customPb.Id);
        insert opp; 
         Opportunity opp2= new opportunity(Name='Dickenson Mobile Generators',CloseDate=System.today()+30,StageName='Qualification');
        insert opp2; 
        OpportunityLineItem oli=new OpportunityLineItem(OpportunityId=opp.Id,Product2Id=prod.Id,UnitPrice=customPrice.UnitPrice,Quantity=10);
        insert oli;
        OpportunityLineItem oli2=new OpportunityLineItem(OpportunityId=opp.Id,Product2Id=prod.Id,UnitPrice=customPrice.UnitPrice,Quantity=10);
        insert oli2;
        
        
        AddProductToOpp.savePriBook(opp.Id,customPb.Name);        
        AddProductToOpp.searchProBarcode1(opp.Id,prod.ProductCode,customPb.Name);
       	AddProductToOpp.getProductList(prod.Name,prod.ProductCode,prod.Family,stanPbe.Name);
        AddProductToOpp.getProductList('','','None',stanPbe.Name);
        AddProductToOpp.initial(opp.Id);
        AddProductToOpp.initial(opp2.Id);
        AddProductToOpp.initialSec(stanPbe.Name);
        AddProductToOpp.initialth(opp.Id);
        AddProductToOpp.addProdLineItem(opp.Id, prod.Id, customPrice.UnitPrice,1, prod.Description);
        AddProductToOpp.addProdLineItem(opp.Id, prod.Id,500,1, prod.Description);
        
        List<OpportunityLineItem> oliList=new List<OpportunityLineItem>{oli};        
        List<String> listforDel = new List<String>{oli2.Id};        
        AddProductToOpp.manageProducts(oliList,listforDel);
    }
    
    static testMethod void unitTest2()
    {
        Product2 prod=new Product2(Name='Soya Oil',IsActive=true,ProductCode='8906006720480',Description='Refined Soya oil',Family='Oil');
        insert prod; 
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry stanPbe=new PricebookEntry(IsActive=true,UnitPrice=5000,Pricebook2Id=pricebookId,Product2Id=prod.Id);
        insert stanPbe;       
        Pricebook2 customPb=new Pricebook2(Name='Custom Price Book',IsActive=true);
        insert customPb; 
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPb.Id, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert customPrice;  
        Opportunity opp= new opportunity(Name='Dickenson Mobile Generators',CloseDate=System.today()+30,StageName='Qualification',Pricebook2Id=customPb.Id);
        insert opp;   
        
        AddProductToOpp.searchProBarcode1(opp.Id,prod.ProductCode,customPb.Name);
    }
    
    /*static testMethod void unitTest3(){
        Product2 prod=new Product2(Name='Soya Oil',IsActive=true,ProductCode='8906006720480',Description='Refined Soya oil',Family='Oil');
        insert prod; 
        Product2 prod2=new Product2(Name='Almond Oil',IsActive=true,ProductCode='8906006774321',Description='Refined Almond oil',Family='Oil');
        insert prod2; 
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry stanPbe=new PricebookEntry(IsActive=true,UnitPrice=5000,Pricebook2Id=pricebookId,Product2Id=prod.Id);
        insert stanPbe;
        PricebookEntry stanPbe1=new PricebookEntry(IsActive=true,UnitPrice=500,Pricebook2Id=pricebookId,Product2Id=prod2.Id);
        insert stanPbe1;
        Pricebook2 customPb=new Pricebook2(Name='Custom Price Book',IsActive=true);
        insert customPb;
		PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPb.Id, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert customPrice;
		//PricebookEntry customPrice1 = new PricebookEntry(Pricebook2Id = customPb.Id, Product2Id = prod2.Id, UnitPrice = 1200, IsActive = true);
        //insert customPrice1;        
        Opportunity opp= new opportunity(Name='Dickenson Mobile Generators',CloseDate=System.today()+30,StageName='Qualification',Pricebook2Id=customPb.Id);
        insert opp;        
        //OpportunityLineItem oli=new OpportunityLineItem(OpportunityId=opp.Id,Product2Id=prod.Id,UnitPrice=customPrice.UnitPrice,Quantity=10);
        //insert oli;
        OpportunityLineItem oli1=new OpportunityLineItem(OpportunityId=opp.Id,Product2Id=prod2.Id,UnitPrice=customPrice.UnitPrice,Quantity=10);
        insert oli1;
        
        AddProductToOpp.searchProBarcode1(opp.Id,prod.ProductCode,customPb.Name);
    }*/
}