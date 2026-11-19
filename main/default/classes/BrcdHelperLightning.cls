public class BrcdHelperLightning {
    @AuraEnabled
    public static Boolean patterMatcher(String regExp,String value){
        System.debug('Inside BrcdHelperLightning apex class');
        Pattern patObj = Pattern.compile(regExp);
        Matcher matObj = patObj.matcher(value);
        return matObj.matches();  
    }
}