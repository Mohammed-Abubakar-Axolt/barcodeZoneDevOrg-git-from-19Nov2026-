global class BarcodeController {
  public String Brcd{get; set;}
  public String Height{get; set;}
  public String Width{get; set;}
  public String BarcdType{get; set;}
  public String BrcdCanvas{get; set;}
  public String BarcdHeight{get; set;}
  public String BrcdId{get; set;}
  public String BrcdType{get; set;}
  public String BarWidth{get; set;}
  public String correctionLevel{get;set;} 
  private BarcodeFactory m_factObj;
  public String SObjectParentId{get; set;}
  public String SObjectParentName{get; set;}  
  public String sObjectlookupName{get; set;}
  public String BarcodeAPIName{get; set;}
  public String currentPageUrl {get; set;}
  public String currentPageUrl2 {get; set;}  
  public boolean brcdValHide {get;set;}
  public static boolean isCommunityEnabled {get; set;}
  public String orgId {get; set;}
  public string orgName {get; set;}
  public List<ConnectApi.Community> allCommunitiesList {get; set;}
  public static string comAppend {get; set;}        
  
    public static String baseURL     {get;set;}
    public static String commValue   {get;set;}
    public static String splitURL    {get;set;}
    public static String commAppend  {get;set;}           
    public String pageReferer {get;set;} 
    
  public BarcodeController(){ 
    
      if(BarcdHeight == null || BarcdHeight == ''){
        BarcdHeight = '40';
      } 
      if(BarWidth == null || BarWidth == ''){
        BarWidth = '4';
      } 
      
         
    m_factObj = BarcodeFactory.createFactoryObject();
  }
  
  //Global method use for any utility
  @RemoteAction 
    global static String processUtility(string hostReferer) {
        System.debug('hostRefererr :'+hostReferer);
         
         System.debug(doRefererProcessing(hostReferer));
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        if(gd.containsKey('Network')){
           system.debug('Community is enabled!');
           isCommunityEnabled = true;            
        }
        else{
           system.debug('Community is disabled!');
           isCommunityEnabled = false;
        }           
        
        comAppend = '';
        commAppend = '';  

        baseURL = hostReferer;
        System.debug('**baseURL: '+baseURL); 
        if(baseURL != null && baseURL != ''){
            splitURL = baseURL.split('https://')[1];
            commValue = splitURL.substringBetween('/', '/');
            System.debug('Community Name: '+commValue);
                
            ConnectApi.CommunityPage coms = ConnectApi.Communities.getCommunities();
            List<ConnectApi.Community> allCommunities = coms.communities;
              
            if(allCommunities.size() > 0) {           
                for(ConnectApi.Community conCom : allCommunities) {        
                    if(commValue == conCom.urlPathPrefix) {                                              
                        commAppend = conCom.urlPathPrefix;
                        break;
                    } 
                }            
            }                
        }    
        system.debug('**commAppend Before IfElse : '+commAppend);
        if(commAppend == null || commAppend == '') {
            comAppend = '';
        } else {
            comAppend = '/' + commAppend;
        }
    //comAppend = '/barcode';        
    system.debug('**comAppend After IfElse : '+comAppend);          
        
        return comAppend;
    }
      
  public static string doRefererProcessing(string hostReferer) {
     
     return '';
  }
  
  public String getBrcodeImage(){
      BrcdCanvas=null;
      drawBarcode();
      system.debug('=====>BrcdCanvas  :'+BrcdCanvas);
      if(BrcdCanvas == null) { return 'Value doesn\'t match barcode type';}    else return BrcdCanvas;
  }
  
  public BarcodeController(ApexPages.StandardController controller){

  }
  
  
  public PageReference drawBarcode(){
    IBarcode brcdObj = m_factObj.createBarcodeObject(BarcdType);
    if(brcdObj != null && brcdObj.isValid(Brcd)){
        if(BarcdHeight == null || BarcdHeight == ''){
            BarcdHeight = '40';
        } 
        if(BarWidth == null || BarWidth == ''){
            BarWidth = '4';
        }   
         //Brcd = Brcd.replace(' ', '_'); 
      BrcdCanvas = brcdObj.drawBarcode(Brcd, BarcdHeight, BarWidth,brcdValHide);
    }
    
    return null;
  }
    
   public Component.Apex.IncludeScript getJQueryMin() {
        
        Component.Apex.IncludeScript jsScript = new Component.Apex.IncludeScript();
            jsScript.expressions.value = '{!URLFOR($Resource.BarcodeZone, \'BarcodeZone/js/jquery-1.6.2.min.js\')}';
        return jsScript;
    }
    
    public Component.Apex.IncludeScript getBCMathMin() {
        
        Component.Apex.IncludeScript jsScript = new Component.Apex.IncludeScript();
            jsScript.expressions.value = '{!URLFOR($Resource.BarcodeZone, \'BarcodeZone/js/pdf417/bcmath-min.js\')}';
        return jsScript;
    } 
    
    public Component.Apex.IncludeScript getPDF417Min() {
        
        Component.Apex.IncludeScript jsScript = new Component.Apex.IncludeScript();
            jsScript.expressions.value = '{!URLFOR($Resource.BarcodeZone, \'BarcodeZone/js/pdf417/pdf417-min.js\')}';
        return jsScript;
    }
    
    public Component.Apex.IncludeScript getQRJScript() {
        system.debug('----->Qrcode loaded ');
        Component.Apex.IncludeScript jsScript = new Component.Apex.IncludeScript();
            jsScript.expressions.value = '{!URLFOR($Resource.BarcodeZone, \'BarcodeZone/js/qr/Qrcode.js\')}';
        return jsScript;
    }
    
    public Component.Apex.IncludeScript getJQRScript() {
        system.debug('----->jqueryQrcode loaded ');
        Component.Apex.IncludeScript jsScript = new Component.Apex.IncludeScript();
            jsScript.expressions.value = '{!URLFOR($Resource.BarcodeZone, \'BarcodeZone/js/qr/jqueryQrcode.js\')}';
        return jsScript;
    }
    
    public Component.Apex.IncludeScript getDataMatrixScript() {
        
        Component.Apex.IncludeScript jsScript = new Component.Apex.IncludeScript();
            jsScript.expressions.value = '{!URLFOR($Resource.BarcodeZone, \'BarcodeZone/js/datamatrix/DataMatrix.js\')}';
        return jsScript;
    }
    
    public String getQRCSS(){
        return '{!URLFOR($Resource.BarcodeZone, \'BarcodeZone/css/Qrcode.css\')}';
    } 
    
}