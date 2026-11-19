public class DataMatixCodeController implements IBarcode{

    public DataMatixCodeController(){}
    
    public virtual Boolean isValid(String brcd){
        return true;
    }

    public virtual String drawBarcode(String brcd, String height, String BarsWidth, Boolean brcdValHide){

        return brcd;
    }

}