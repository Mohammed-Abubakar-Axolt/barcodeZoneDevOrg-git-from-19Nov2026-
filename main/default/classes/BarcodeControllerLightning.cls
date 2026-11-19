global class BarcodeControllerLightning {    
    
    public BarcodeControllerLightning(String BarcdHeight, String BarWidth){ 
        if(BarcdHeight == null || BarcdHeight == ''){ BarcdHeight = '40'; } 
        if(BarWidth == null || BarWidth == ''){ BarWidth = '4'; } 
    }
    
    public static String BrcdCanvas;
    public static String errormessage='Value doesn\'t match barcode type';
    @AuraEnabled
    public static String brcodeImage(String Brcd, String BarcdType, String BarcdHeight, String BarWidth, Boolean brcdValHide){        
        System.debug('Inside barcodeImage method');
        drawBarcode(Brcd, BarcdType, BarcdHeight, BarWidth, brcdValHide);
        if(BrcdCanvas == null){system.debug('====> BrcdCanvas '+BrcdCanvas);return errormessage;}   else return BrcdCanvas;        
    }
    
    public BarcodeControllerLightning(ApexPages.StandardController controller){ }
    
    @auraEnabled
    public static String drawBarcode(String Brcd, String BarcdType, String BarcdHeight, String BarWidth, Boolean brcdValHide){
        system.debug('called drawBarcode');
        System.debug('BarcdType in drawBarcode :'+BarcdType);
        IBarcode brcdObj = BarcodeFactoryLightning.createBarcodeObject(BarcdType);
        system.debug('*** brcdObj '+brcdObj);
        if(brcdObj != null && brcdObj.isValid(Brcd)){
            if(BarcdHeight == null || BarcdHeight == '') BarcdHeight = '40'; 
            if(BarWidth == null || BarWidth == '') BarWidth = '4';
            BrcdCanvas = brcdObj.drawBarcode(Brcd, BarcdHeight, BarWidth, brcdValHide);
        }
        return null;
    }   
}