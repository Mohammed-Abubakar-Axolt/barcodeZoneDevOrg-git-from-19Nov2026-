public  class BrcdHelper {

public static Boolean patterMatcher(String regExp,String value){
  Pattern patObj = Pattern.compile(regExp);
  Matcher matObj = patObj.matcher(value);
  return matObj.matches();
}

// Barcode bars are table cells. The classic Visualforce PDF renderer resized those cells to fit their
// table; the Accessible (Tagged) PDF renderer does not. These helpers reproduce the classic sizes so
// barcodes render identically in both. Units are 1/20 px, the classic renderer's internal unit.
public static List<Integer> classicCellWidths(List<Integer> widths, Integer tableWidth, Boolean spreadExtra){
  List<Integer> w = new List<Integer>();
  Integer total = 0;
  for (Integer x : widths) { w.add(Math.max(x, 1)); total += Math.max(x, 1); }   // empty cells are at least 1 unit wide
  Integer available = (tableWidth == null) ? 0 : tableWidth - total;
  if (available < 0) {                                  // table narrower than its cells: shrink, last cell first
    Integer mw = total - w.size();
    for (Integer i = w.size() - 1; i >= 0 && mw > 0 && available < 0; i--) {
      Integer diff = w[i] - 1;
      Integer reduce = ((Long) available * diff / mw).intValue();
      w[i] += reduce; available -= reduce; mw -= diff;
    }
  } else if (available > 0 && spreadExtra) {            // table wider than its cells: spread the extra, first cell first
    Integer remaining = total;
    for (Integer i = 0; i < w.size() && remaining > 0; i++) {
      Integer add = ((Long) available * w[i] / remaining).intValue();
      available -= add; remaining -= w[i]; w[i] += add;
    }
  }
  return w;
}

public static String toPx(Integer units){
  return (Decimal.valueOf(units) / 20).setScale(2).toPlainString() + 'px';
}

}