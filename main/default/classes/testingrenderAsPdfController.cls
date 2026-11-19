public class testingrenderAsPdfController {
    public String barcodeValue { get; set; }
    public String pdf417HtmlString                                           { get; set; }  
    
    public testingrenderAsPdfController() {
        // Set the barcode value to be displayed
        barcodeValue = '1234567890';
        
        pdf417HtmlString = '';
    }
    
    public void generatePDFAndCreateAttachment() {
        PageReference pageRef = Page.pdf417Testing; //PageReference('https://barcodezone-dev-ed--barcodezone.vf.force.com/apex/pdf417Testing?barcodeValue=ArshadTesting');
        String htmlstring = '';
        String finalhtmlstring = '';
        
        htmlstring = pageRef.getContent().toString();
        system.debug('htmlstring ~>'+htmlstring); 

        String newstr = htmlstring.substringBetween('<div id="arshad">','</div>');
        system.debug('newstr~>'+newstr);
        
        pdf417HtmlString = htmlstring;
        
        
        //return '';
        Blob pdfBlob;
        PageReference pageRef2 = Page.TestBarcode;
        pdfBlob = pageRef2.getContentAsPDF();
        Attachment attachment = new Attachment();
        attachment.ParentId = '0012v00003YQlaqAAD';  // Set the parent record ID to associate the attachment with
        attachment.Name = 'GeneratedPDFbyArshad.pdf';
        attachment.Body = pdfBlob;
        Database.insert(attachment);
    }
}