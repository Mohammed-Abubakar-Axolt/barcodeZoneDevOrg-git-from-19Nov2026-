public class BarcodeFactory {
  private static BarcodeFactory factObj;
  
  //singlton implimentation
  private BarcodeFactory(){
    // make constructor hidden
  }
  
  public static BarcodeFactory createFactoryObject(){
    if(factObj == null){
      factObj = new BarcodeFactory();
    }
    return factObj;
  }
  
  public IBarcode createBarcodeObject(String BarcdType){
    /*if(BarcdType.equalsIgnoreCase('code39')){
      return new Code39Controller();
    }else if(BarcdType.equalsIgnoreCase('code128')){
      return new Code128Controller();
    }else if(BarcdType.equalsIgnoreCase('ean13')){
      return new Ean13Controller();
    }else if(BarcdType.equalsIgnoreCase('ean8')){
      return new Ean8Controller();      
    }else if(BarcdType.equalsIgnoreCase('qrcode')){            
        return new QrCodeController();
    }else if(BarcdType.equalsIgnoreCase('pdf417')){            
        return new PDF417Controller();
    }*/
    if(BarcdType.equalsIgnoreCase('code39')){
      return new Code39Controller();
    }else if(BarcdType.equalsIgnoreCase('code128')){
      return new Code128Controller();
    }else if(BarcdType.equalsIgnoreCase('ean13')){
      return new Ean13Controller();
    }else if(BarcdType.equalsIgnoreCase('ean8')){
      return new Ean8Controller();      
    }else if(BarcdType.equalsIgnoreCase('qrcode')){            
        return new QrCodeController();
    }else if(BarcdType.equalsIgnoreCase('pdf417')){            
        return new PDF417Controller();
    }/*else if(BarcdType.equalsIgnoreCase('datamatrix')){
        return new DataMatixCodeController();
    }*/
    return null;
  }
  
  

}