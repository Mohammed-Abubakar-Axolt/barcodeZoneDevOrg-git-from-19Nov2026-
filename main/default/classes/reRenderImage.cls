public class reRenderImage {
    public Contact Contact {get; set;}
    public reRenderImage(ApexPages.StandardController controller) {

    }
    
    public PageReference refreshImage(){
        system.debug('**Inside refreshImage : '+Contact.PDF_417_Attachment_ID__c);
        return null;
    }
}