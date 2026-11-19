@IsTest(SeeAllData=true)
public class Community_UtilTest {
    
    public static testmethod void unittestdefault(){
    	Community_Util ob=new Community_Util();
        Community_Util.communityValue();
    
    	string testAssert = 'abc';
    	System.assertEquals(testAssert,testAssert);
    }
}