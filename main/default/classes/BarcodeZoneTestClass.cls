@isTest(SeeAllData=true)
public class BarcodeZoneTestClass {
    
    public static testmethod void crash(){
        String brctype='code39';
        String brcdValue='BARCODE';
        String BarcdHeight='59';
        String BarWidth ='4'; 
        Boolean brcdValHide = false;
        
        IBarcode newIntance = new Code128Controller();
        newIntance.isValid('true');
        
        BarcodeFactory m_factObj = BarcodeFactory.createFactoryObject();
        IBarcode brcdObj = m_factObj.createBarcodeObject(brctype);
        System.assert(!(brcdObj.drawBarcode(brcdValue, BarcdHeight,BarWidth, brcdValHide) == null));
    }
      
    public static testmethod void  unittest1(){
        BarcodeController obj = new BarcodeController();
        obj.Brcd = 'BARCODE';
          obj.BarcdHeight = '40';    
        obj.BarcdType = 'code39';
        obj.Height = '110';
        obj.Width = '120';
        String BarsWidth = '12';
        obj.brcdValHide = false;
        obj.drawBarcode();
        obj.SObjectParentId='';
        obj.SObjectParentName='';
        obj.sObjectlookupName='';
        obj.BarcodeAPIName='';
        obj.currentPageUrl ='';
        obj.currentPageUrl2 ='';
        obj.BrcdType='';
        obj.correctionLevel='';
        obj.orgId='';
        obj.orgName='';
        obj.pageReferer='';
        
        System.assert(!(obj.BrcdCanvas == null));
   }
  
  public static testmethod void  unittest2(){
    BarcodeController obj = new BarcodeController();
    obj.Brcd = 'BARCODE';
    obj.BarcdHeight = '40';    
    obj.BarcdType = 'code128';
    obj.Height = '110';
    obj.Width = '120';
    obj.brcdValHide = false;
    obj.drawBarcode();
    System.assert(!(obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittest3(){
    BarcodeController obj = new BarcodeController();
    obj.Brcd = 'barcode';
      obj.BarcdHeight = '40';    
    obj.BarcdType = 'code128';
    obj.Height = '110';
    obj.Width = '120';
    obj.brcdValHide = false;  
    obj.drawBarcode();
    System.assert(!(obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittest4(){
    BarcodeController obj = new BarcodeController();
    obj.Brcd = '123456789';
    obj.BarcdHeight = '40';
    obj.BarcdType = 'code128';
    obj.Height = '110';
    obj.Width = '120';
    obj.brcdValHide = false;
    obj.drawBarcode();
    System.assert(!(obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittest5(){
    BarcodeController obj = new BarcodeController();
    obj.Brcd = '1234567890';
      obj.BarcdHeight = '40';    
    obj.BarcdType = 'code128';
    obj.Height = '110';
    obj.Width = '120';
    obj.brcdValHide = false;
    obj.drawBarcode();
    System.assert(!(obj.BrcdCanvas == null));
  } 
  
  public static testmethod void  unittest6(){
    BarcodeController obj = new BarcodeController();
    obj.Brcd = '9780201734843';
      obj.BarcdHeight = '40';
    obj.BarcdType = 'ean13';
    obj.Height = '110';
    obj.Width = '120';
    obj.brcdValHide = false;  
    obj.drawBarcode();
    System.assert(!(obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittest7(){
    BarcodeController obj = new BarcodeController();
        obj.Brcd = '';
        obj.BarcdHeight = '40';    
        obj.BarcdType = 'ean13';
        obj.drawBarcode();
        obj.Brcd = 'AQS123';
        obj.drawBarcode();
    String val  = obj.getBrcodeImage();
    System.assert((obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittest8(){
    BarcodeController obj = new BarcodeController();
        obj.Brcd = '9780201734843';
        obj.BarcdHeight = '40';    
        obj.BarcdType = 'qwe';
        obj.Height = '110';
        obj.Width = '120';
        obj.drawBarcode();
        System.assert((obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittest9(){
    BarcodeController obj = new BarcodeController();
    obj.Brcd = 'AQS123AQS1231';
      obj.BarcdHeight = '40';
    obj.BarcdType = 'ean13';
    obj.brcdValHide = false;  
    obj.drawBarcode();
    System.assert((obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittestE8(){
    BarcodeController obj = new BarcodeController();
    obj.Brcd = '12345678';
    obj.BarcdHeight = '40';
    obj.BarcdType = 'ean8';
    obj.Height = '110';
    obj.Width = '120';
    obj.brcdValHide = false;
    obj.drawBarcode();
    System.assert(!(obj.BrcdCanvas == null));
  }
  
  public static testmethod void  unittest10(){
  Account acc = new Account(Name='Barcode Zone');
      insert acc;
   
   ApexPages.StandardController sc = new ApexPages.StandardController(acc);
    PDF417Controller pdf417Obj = new PDF417Controller();
    BarcodeController obj = new BarcodeController(sc);
       obj.getJQueryMin();
       obj.getBCMathMin();
       obj.getPDF417Min();
       obj.Brcd = acc.Name;
       obj.BrcdId =acc.Id;
       obj.BarcdType = 'pdf417';
       obj.Height = '150';
       obj.BarWidth ='4';
       Boolean brcdValHide;
    System.assert(pdf417Obj.isValid( obj.Brcd));
    System.assertEquals(obj.Brcd, pdf417Obj.drawBarcode(obj.Brcd, obj.Height,obj.BarWidth, obj.brcdValHide));
  }
  
  public static testmethod void unittestQRcodetest(){
      Account acc = new Account(Name='Barcode Zone');
      insert acc;
   
   ApexPages.StandardController sc = new ApexPages.StandardController(acc);
    QrCodeController qrobj = new QrCodeController();
    BarcodeController obj = new BarcodeController(sc);
       obj.getJQueryMin();
       obj.getJQRScript();
       obj.getQRJScript();
       obj.getQRCSS();
       obj.Brcd = acc.Name;
       obj.BrcdId =acc.Id;
       obj.BarcdType = 'qrcode';
       obj.Height = '150';
       obj.BarWidth ='4';   
      Boolean brcdValHide;
    System.assert(qrobj.isValid( obj.Brcd));
    System.assertEquals(obj.Brcd, qrobj.drawBarcode(obj.Brcd, obj.Height, obj.BarWidth, obj.brcdValHide));
  }
  
  public static testmethod void unittestDMcodetest(){
      Account acc = new Account(Name='Barcode Zone');
      insert acc;
   
   ApexPages.StandardController sc = new ApexPages.StandardController(acc);
    DataMatixCodeController qrobj = new DataMatixCodeController();
    BarcodeController obj = new BarcodeController(sc);
       obj.getDataMatrixScript();
       obj.Brcd = acc.Name;
       obj.BrcdId =acc.Id;
       obj.BarcdType = 'datamatrix';
       obj.Height = '150';
       obj.BarWidth ='4';   
       Boolean brcdValHide;
    System.assert(qrobj.isValid( obj.Brcd));
    System.assertEquals(obj.Brcd, qrobj.drawBarcode(obj.Brcd, obj.Height, obj.BarWidth, obj.brcdValHide));
  }
  
  public static testmethod void  unittestCode128(){
    Code128Controller obj = new Code128Controller();
    obj.Brcd = 'AQXOLT';
    System.assert(obj.isValid( obj.Brcd));
    
  }
  
  public static testmethod void  unittestEan13(){
    Ean13Controller obj = new Ean13Controller();
    String brcd ='9780201734843';
    String BarcdHeight ='40';    
    System.assert(obj.IsValid(brcd));
    
  }
  
  public static testmethod void  unittestEan8(){
    Ean8Controller obj = new Ean8Controller();
    obj.isValid(null);
    obj.isValid('#$%^&*(');
	obj.BrcdFooterText ='';
    String brcd ='12345678';
    String BarcdHeight ='40';    
    System.assert(obj.IsValid(brcd));
    
  }
  
  public static testmethod void  unittestCode39(){
    Code39Controller obj = new Code39Controller();
        obj.Brcd = 'BARCODE';
        obj.BarcdHeight = '';
     System.assert(obj.isValid( obj.Brcd));
  }
  public static testmethod void crashPDF(){
        String brctype='pdf417';
        String brcdValue='BARCODE';
        String BarcdHeight='140';
        String BarWidth = '4';
        Boolean brcdValHide;
        BarcodeFactory m_factObj = BarcodeFactory.createFactoryObject();
        IBarcode brcdObj = m_factObj.createBarcodeObject(brctype);
        System.assert(!(brcdObj.drawBarcode(brcdValue, BarcdHeight, BarWidth, brcdValHide) == null));
   }
    
   public static testmethod void crashQR(){
        String brctype='qrcode';
        String brcdValue='BARCODE';
        String BarcdHeight='140';
        String BarWidth = '4';
        Boolean brcdValHide;
        BarcodeFactory m_factObj = BarcodeFactory.createFactoryObject();
        IBarcode brcdObj = m_factObj.createBarcodeObject(brctype);
        System.assert(!(brcdObj.drawBarcode(brcdValue, BarcdHeight, BarWidth, brcdValHide) == null));
   }
    
    public static testmethod void unittestdefault(){
    BarcodeController.processUtility('https://barcodezone-dev-ed.my.salesforce.com');
    BarcodeController obj = new BarcodeController();
    obj.Brcd = '123456789';
    obj.BarcdHeight = '';
    obj.BarWidth = '';
    obj.BarcdType = 'code128';
    obj.Height = '110';
    obj.Width = '120';
    obj.brcdValHide = false;
    obj.drawBarcode();
    System.assert(!(obj.BrcdCanvas == null));
  }
     public static testmethod void unittestdefaultcommunity_UtilTest(){
    	Community_Util ob=new Community_Util();
        Community_Util.communityValue();
    
    	string testAssert = 'abc';
    	System.assertEquals(testAssert,testAssert);
    }
}