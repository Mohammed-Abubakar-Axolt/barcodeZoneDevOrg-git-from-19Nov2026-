global with sharing class Community_Util {
    
    global static String baseURL    {get;set;}
    global static String commValue  {get;set;}
    global static String splitURL   {get;set;}
    global static String commAppend {get;set;}            
    
    global Community_Util() {}
    
    global static string communityValue() {        
                       
        commAppend = ''; 
        String PageURL1 = System.Url.getOrgDomainUrl().toExternalForm();
        String PageURL2 = ApexPages.currentPage().getUrl();
        baseURL = PageURL1+PageURL2;
        System.debug('**baseURL: '+baseURL); 
        if(baseURL != null && baseURL !=''){
            splitURL = baseURL.split('https://')[1];
            commValue = splitURL.substringBetween('/', '/');
            System.debug('Community Name: '+commValue);
                
            ConnectApi.CommunityPage coms = ConnectApi.Communities.getCommunities();
            List<ConnectApi.Community> allCommunities = coms.communities;
              
            if(allCommunities.size() > 0) {           
                for(ConnectApi.Community conCom : allCommunities) {        
                    if(commValue == conCom.urlPathPrefix) {                                              
                        commAppend = conCom.urlPathPrefix;break;
                    } 
                }            
            }                
        } 
        return commAppend;        
    }   
}