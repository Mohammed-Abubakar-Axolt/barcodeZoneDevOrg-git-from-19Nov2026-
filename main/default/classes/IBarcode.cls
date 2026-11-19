public interface IBarcode {
  Boolean isValid(String brcd);
  String drawBarcode(String brcd, String BarcdHeight, String BarsWidth, Boolean brcdValHide);
}