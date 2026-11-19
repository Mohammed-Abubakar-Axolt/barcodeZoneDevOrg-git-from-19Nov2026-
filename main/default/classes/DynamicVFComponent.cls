public class DynamicVFComponent {
    public List<Account> accList {get; set;}
    
    public DynamicVFComponent(ApexPages.StandardController controller) {
        accList = new List<Account>();
        accList = [Select Id, Name from Account where Id != null limit 10];
    }
    
    public Component.Apex.PageBlock getAccountDetails(){
        //Component.Apex.form pageForm = new Component.Apex.form();
            Component.Apex.PageBlock pageBlk = new Component.Apex.PageBlock(); 
                Component.Apex.PageBlockTable pageBlkTable = new Component.Apex.PageBlockTable(var = 'a', value = accList);
                    //pageBlkTable.columns =3;
                    //pageBlkTable.border= '10' ;           
                    Component.Apex.Column accName = new Component.Apex.Column();
                    accName.expressions.value= '{!a.Name}';
                    //accName.expressions.title='{!a.Id}'; 
                    Component.Apex.Column accId = new Component.Apex.Column();
                    accId.expressions.value = '{!a.Id}';
                    Component.Apex.Column accLink = new Component.Apex.Column(headerValue = 'Link');
                    //Component.Apex.outputLink accLinks = new Component.Apex.outputLink();
                    //accLinks.expressions.value='/'+'{!a.Id}';
                    //accLink.expressions.title='{!a.Id}';   
                    //accLinks.expressions.value = '{!a.Id}';
                    //accLinks.expressions.value = '{!a.Id}'; 
                    
                    
                    Component.Apex.outputLink accLinks = new Component.Apex.outputLink();
                    accLinks.expressions.value='/'+'{!a.Id}';
                    accLinks.expressions.title='{!a.Id}';                     
                    
                                   
                    accLink.childComponents.add(accLinks);                    
                    pageBlkTable.childComponents.add(accName);
                    pageBlkTable.childComponents.add(accId);                                        
                    pageBlkTable.childComponents.add(accLink);
            pageBlk.childComponents.add(pageBlkTable);
            pageBlk.title = 'Accounts';  
            //pageForm.childComponents.add(pageBlk); 
        return pageBlk;        
    }

}