public class PDF417Controller implements IBarcode{
    
    public PDF417Controller(){}
    
    public virtual Boolean isValid(String brcd){
        return true;
    }

    public virtual String drawBarcode(String brcd, String height, String barwidth, Boolean brcdValHide){
        return brcd;
    }
}