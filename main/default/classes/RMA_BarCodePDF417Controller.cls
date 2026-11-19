public class RMA_BarCodePDF417Controller {
    public List<BarcodeZone__RMAPortal__c> rmaToInsert {get; set;}
    public BarcodeZone__RMAPortal__c rmaObject {get; set;}
    
    public RMA_BarCodePDF417Controller() {        
        rmaToInsert = new List<BarcodeZone__RMAPortal__c>();
        rmaObject = new BarcodeZone__RMAPortal__c();
        show();
    }
    
    
    public PageReference show() {
        //list<Id> ids = new List<Id>{'a019000000fH0pj','a019000000fH0s2'};
        //rmaToInsert = [SELECT Id,Name, PDF_417_Attachment_ID__c FROM RMAPortal__c where id in: ids order by Name ASC];
        list<String> names = new List<String>{'00000241','00000242','00000243','00000244'};        
        //list<String> names = new List<String>{'00000241','00000242'};        
        rmaToInsert = [SELECT Id, Name, PDF_417_Attachment_ID__c FROM RMAPortal__c where Name in: names order by Name ASC];
        system.debug('**rmaToInsert.size() : '+rmaToInsert.size());
        if(rmaToInsert.size() > 0){
            rmaObject = rmaToInsert[0];    
        }
        return null;
    }
}