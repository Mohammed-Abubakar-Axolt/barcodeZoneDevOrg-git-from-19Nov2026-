public with sharing class PrintBarcodes {
    
    public List<String> myFields                                            { get; set; }
    public List<SelectOption> myFieldOptions                                { get; set; }
    public String mySelFields                                               { get; set; }
    public List<sObject> Records                                            { get; set; }           
    public List<BarcodeWrapper> BarcodeWrapperList                          { get; set; }
    public String BarcodeField                                              { get; set; }
    public String LabelField                                                { get; set; }
    public String myObject                                                  { get; set; }
    public String headVal                                                   { get; set; }
    public String footVal                                                   { get; set; }
    public String RecordName                                                { get; set; }
    public String brcdType                                                  { get; set; }
    public String BarcodeLoc                                                { get; set; }
    public String LabelLoc                                                  { get; set; }
    public Boolean BarcodeDisplay                                           { get; set; }
    public Boolean LabelDisplay                                             { get; set; }
    public Boolean Frame                                                    { get; set; }
    public Integer NoofColumns                                              { get; set; }
    public Integer NoofRows                                                 { get; set; }
    public String PageSize                                                  { get; set; }
    public String  errMsg                                                   { get; set; }
    public List<SelectOption> ObjectList                                    { get; set; }
    public List<SelectOption> BarcodeList                                   { get; set; }
    public List<SelectOption> LabelList                                     { get; set; }
    public List<SelectOption> FieldList                                     { get; set; }
    public List<String> FieldListSelecteds                                  { get; set; }
    public List<SelectOption> FieldListSelected                             { get; set; }
    public List<SelectOption> FieldListSelectedsOptions                     { get; set; }
    public Boolean selectAll                                                { get; set; }
    public integer selectAllCount                                           { get; set; }
    public List<BarcodeWrapper> BarcodeWrapperCol1                          { get; set; }
    public List<BarcodeWrapper> BarcodeWrapperCol2                          { get; set; }
    public List<BarcodeWrapper> BarcodeWrapperCol3                          { get; set; }
    public Map<String, String> valueLabel                                   { get; set; } 
    public Boolean showBarcode                                              { get; set; }
    
    public static Map<String, Schema.SObjectType> schemaMap                 { get; set; } 
    public Map<String, Schema.SObjectField> fieldMap                        { get; set; }
    public String pageTarget                                                { get; set; }
    
    
    public PrintBarcodes() { 
        system.debug('***Constructor call***');      
       
        List<Object> selectedIso = new List<Object>();
        ObjectList = new List<SelectOption>();
        BarcodeList = new List<SelectOption>();
        LabelList = new List<SelectOption>();
        FieldList = new List<SelectOption>();
        FieldListSelecteds = new List<String>();
        FieldListSelectedsOptions = new List<SelectOption>();
        myFields = new List<String>();
        valueLabel = new Map<String, String>();
        schemaMap = Schema.getglobalDescribe();
        selectAll = false;
        selectAllCount = 0;
        BarcodeLoc = 'Bottom';
        LabelLoc = 'Top';
        RecordName = '';
        NoofColumns = 1;
        NoofRows = 1;
        PageSize = '6in 4in';
        BarcodeDisplay = false;
        LabelDisplay = false;
        showBarcode = true;
        Frame = false;
        BarcodeWrapperList = new List<BarcodeWrapper>();
        BarcodeWrapperCol1 = new List<BarcodeWrapper>();
        BarcodeWrapperCol2 = new List<BarcodeWrapper>();
        BarcodeWrapperCol3 = new List<BarcodeWrapper>();
        Records = new List<sObject>();
        list_size = 50; 
        brcdType = 'code128';
        headVal = footVal = '';
        ObjectList.add(new SelectOption('', 'Select Object'));
        List<Schema.SObjectType> items = ProcessInstance.TargetObjectId.getDescribe().getReferenceTo();
        for(Schema.SObjectType item : items){
            if(!item.getDescribe().CustomSetting  && !item.getDescribe().getLabel().containsIgnoreCase('Deprecated')){
                  ObjectList.add(new SelectOption(item.getDescribe().getLocalName().toLowerCase() , item.getDescribe().getLabel() ));
            }
        }
        Map<String, Selectoption> mapping = new Map<String, Selectoption>();
        Integer counter = 1;
        for (Selectoption opt : ObjectList) {
            mapping.put((opt.getLabel() + counter++),opt);  
        }
        List<String> sortingKeys = new List<String>();
        sortingKeys.addAll(mapping.keySet());
        sortingKeys.sort();
        ObjectList.clear();
        for (String key : sortingKeys) {
            if(mapping.get(key).getValue() == 'Product2') ObjectList.add(mapping.get(key));
        }
        for (String key : sortingKeys) {
            if(mapping.get(key).getValue() != 'Product2') ObjectList.add(mapping.get(key));
        }
        myObject = 'Product2';        
        InitialfieldProps();
    }
    
    public void initLoad(){
        myObject = 'Product2';
        fieldProps(); 
    }
    
    public PageReference loadBarcodes(){        
        showBarcode = true;
        return null;
    }
    
    public void fieldProps() {
        FieldList = new List<SelectOption>();
        FieldListSelecteds = new List<String>();
        FieldListSelectedsOptions = new List<SelectOption>();
        myFields = new List<String>();
        valueLabel = new Map<String, String>();
        system.debug('### myObject : '+myObject);
        schemaMap = Schema.getglobalDescribe();
        BarcodeList = new List<SelectOption>();
        LabelList = new List<SelectOption>();
        BarcodeWrapperList = new List<BarcodeWrapper>();
        BarcodeWrapperCol1 = new List<BarcodeWrapper>();
        BarcodeWrapperCol2 = new List<BarcodeWrapper>();
        BarcodeWrapperCol3 = new List<BarcodeWrapper>();
        Records = new List<sObject>();
        BarcodeField = '';
        LabelField = '';
        
        if(myObject != '' && myObject != Null){
            fieldMap = (schemaMap.containsKey(myObject))?  schemaMap.get(myObject).getDescribe().fields.getMap() : schemaMap.get('BarcodeZone__'+myObject).getDescribe().fields.getMap();
            if(fieldMap.Values().size() > 0) {
                LabelList.add(new SelectOption('', '--None--'));
            }
            boolean assign = true;
            for(Schema.SObjectField sof : fieldMap.Values()){
                valueLabel.put(sof.getDescribe().getLocalName().toLowerCase(),sof.getDescribe().getLabel() );
                //if(sof.getDescribe().isAccessible() && sof.getDescribe().isUpdateable()){
                    if(String.valueof(sof.getDescribe().getType()) == 'String'){
                        if(assign) { BarcodeField = sof.getDescribe().getLocalName().toLowerCase(); assign = false;}
                        BarcodeList.add(new SelectOption(sof.getDescribe().getLocalName().toLowerCase() , sof.getDescribe().getLabel() ));
                        LabelList.add(new SelectOption(sof.getDescribe().getLocalName().toLowerCase() , sof.getDescribe().getLabel() ));
                    }
                //}
            }
            
            for(Schema.SObjectField sof : fieldMap.Values()){
                //if(sof.getDescribe().isAccessible() && sof.getDescribe().isUpdateable()){ 
                    FieldList.add(new SelectOption(sof.getDescribe().getLocalName().toLowerCase() , sof.getDescribe().getLabel() ));
                //} 
            }
            
            Map<String, Selectoption> mapping = new Map<String, Selectoption>();
            Integer counter = 1;
            for (Selectoption opt : FieldList) {
                mapping.put((opt.getLabel() + counter++),opt);
            }
            List<String> sortingKeys = new List<String>();
            sortingKeys.addAll(mapping.keySet());
            sortingKeys.sort();
            FieldList.clear();
            for (String key : sortingKeys) {
                FieldList.add(mapping.get(key));
            }
            Evaluate();
        }
    }
    
    public void InitialfieldProps() {
        valueLabel = new Map<String, String>();
        system.debug('### myObject : '+myObject);
        schemaMap = Schema.getglobalDescribe();
        BarcodeList = new List<SelectOption>();
        LabelList = new List<SelectOption>();
        BarcodeWrapperList = new List<BarcodeWrapper>();
        BarcodeWrapperCol1 = new List<BarcodeWrapper>();
        BarcodeWrapperCol2 = new List<BarcodeWrapper>();
        BarcodeWrapperCol3 = new List<BarcodeWrapper>();
        Records = new List<sObject>();
        BarcodeField = 'barcode__c';
        LabelField = 'name';
        mySelFields = '';
        if(myObject != '' && myObject != Null){
            fieldMap = (schemaMap.containsKey(myObject))?  schemaMap.get(myObject).getDescribe().fields.getMap() : schemaMap.get('BarcodeZone__'+myObject).getDescribe().fields.getMap();
            if(fieldMap.Values().size() > 0) {
                LabelList.add(new SelectOption('', '--None--'));
            }
            boolean assign = true;
            for(Schema.SObjectField sof : fieldMap.Values()){
                valueLabel.put(sof.getDescribe().getLocalName().toLowerCase(),sof.getDescribe().getLabel() );
                //if(sof.getDescribe().isAccessible() && sof.getDescribe().isUpdateable()){
                    if(String.valueof(sof.getDescribe().getType()) == 'String'){
                        if(assign) { BarcodeField = sof.getDescribe().getLocalName().toLowerCase(); assign = false;}
                        BarcodeList.add(new SelectOption(sof.getDescribe().getLocalName().toLowerCase() , sof.getDescribe().getLabel() ));
                        LabelList.add(new SelectOption(sof.getDescribe().getLocalName().toLowerCase() , sof.getDescribe().getLabel() ));
                    }
                //}
            }
            
            for(Schema.SObjectField sof : fieldMap.Values()){
                //if(sof.getDescribe().isAccessible() && sof.getDescribe().isUpdateable()){ 
                    FieldList.add(new SelectOption(sof.getDescribe().getLocalName().toLowerCase() , sof.getDescribe().getLabel() ));
                //}
            }
            
            Map<String, Selectoption> mapping = new Map<String, Selectoption>();
            Integer counter = 1;
            for (Selectoption opt : FieldList) {
                mapping.put((opt.getLabel() + counter++),opt);  
            }
            List<String> sortingKeys = new List<String>();
            sortingKeys.addAll(mapping.keySet());
            sortingKeys.sort();
            FieldList.clear();
            for (String key : sortingKeys) {
                FieldList.add(mapping.get(key));
            }
            Evaluate();
        }
    }
    
    public Void AddFields(){
    
       mySelFields = '';
       for(String s : myFields) {
           FieldListSelectedsOptions.add(new SelectOption(s,valueLabel.get(s)));
       }
       for(SelectOption SF : FieldListSelectedsOptions){
           Integer i = FieldList.size()-1;
           while(i>=0) {
               if(FieldList[i].getValue() == SF.getValue()){
                   FieldList.remove(i);
                   break;
               }
               i--;
           }
       }
       Evaluate();
       mySelFields = '';
       myFields = new List<String>();
    }
    
    public Void RemoveFields(){
        mySelFields = '';
        List<String> RL = new List<String>();
        for(String s : FieldListSelecteds) {
           Integer i = FieldListSelectedsOptions.size()-1;
           while(i>=0) {
               if(FieldListSelectedsOptions[i].getValue() == s){
                   FieldList.add(FieldListSelectedsOptions.remove(i));
                   break;
               }
               i--;
           }
        } 
        Map<String, Selectoption> mapping = new Map<String, Selectoption>();
        Integer counter = 1;
        for (Selectoption opt : FieldList) {
            mapping.put((opt.getLabel() + counter++),opt);  
        }
        List<String> sortingKeys = new List<String>();
        sortingKeys.addAll(mapping.keySet());
        sortingKeys.sort();
        FieldList.clear();
        for (String key : sortingKeys) {
            FieldList.add(mapping.get(key));
        }
        Evaluate();
    }
    
    public PageReference Evaluate() {
        try{
        selectAll = false;
        String recordNamePattern = '%'+recordName+'%';
        for(SelectOption s : FieldListSelectedsOptions){
           if(s.getValue() != 'Id' && LabelField != s.getValue() && BarcodeField != s.getValue()) mySelFields = mySelFields+','+s.getValue();
        }
            System.debug('mySelFields :'+mySelFields);
            System.debug('LabelField :'+LabelField);
            System.debug('BarcodeField :'+BarcodeField);
            System.debug('myObject :'+myObject);
            System.debug('recordNamePattern :'+recordNamePattern);
            String allStObject=System.Label.StandardOrderWOName;
            System.debug('allStObject :'+allStObject);
            List<String> lstAlpha = allStObject.split(',');
            System.debug('lstAlpha :'+lstAlpha);
            Boolean result=false;
            for(String str:lstAlpha){
                if(str == myObject) result=true;
            }
            System.debug('result :'+result);
            if(result){
                System.debug('case Object');
                /*if(LabelField == 'name' || BarcodeField == 'name'){
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(LabelField)+', '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) 
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern');
                }else{*/
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(LabelField)+', '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' Like :recordNamePattern');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) 
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' Like :recordNamePattern');
                //}
                total_size = Records.size();
                /*if(LabelField == 'name' || BarcodeField == 'name'){
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(LabelField)+', '+String.escapeSingleQuotes(BarcodeField)+' '+String.escapeSingleQuotes(mySelFields)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) 
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(BarcodeField)+ ' '+String.escapeSingleQuotes(mySelFields)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');
                }else{*/
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(LabelField)+' '+String.escapeSingleQuotes(BarcodeField)+ ', '+String.escapeSingleQuotes(mySelFields)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' Like :recordNamePattern limit :list_size offset :counter');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) 
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(BarcodeField)+ ' '+String.escapeSingleQuotes(mySelFields)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' Like :recordNamePattern limit :list_size offset :counter');
                //}
                BarcodeWrapperList = new List<BarcodeWrapper>();
                
                for(SObject sObj : Records){
                    BarcodeWrapper BW;
                    if(LabelField != Null && LabelField != '') BW = new BarcodeWrapper(String.valueof(sObj.get(BarcodeField)), String.valueof(sObj.get(LabelField)), String.valueof(sObj.get('Id')) );
                    else  BW = new BarcodeWrapper(String.valueof(sObj.get(BarcodeField)), '', String.valueof(sObj.get('Id')) );
                    BW.Id = String.valueof(sObj.Id);
                    BW.sObj = sObj;
                    system.debug('*** : BW.sObj : '+BW.sObj);
                    for(SelectOption s : FieldListSelectedsOptions){
                        //BW.sObj.put(s.getValue(),sObj.get(s.getValue()));
                    }
                    system.debug('*** sObj :'+sObj);
                    BarcodeWrapperList.add(BW);
                }
            }else{
                System.debug('Not standard Onject');
                if(LabelField == 'name' || BarcodeField == 'name'){
                    System.debug('1');
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(LabelField)+', '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) 
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern');
                }else{
                    System.debug('2');
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                        Records = Database.query('Select Id, Name, '+String.escapeSingleQuotes(LabelField)+', '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) 
                        Records = Database.query('Select Id, Name, '+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern');
                }
                total_size = Records.size();
                if(LabelField == 'name' || BarcodeField == 'name'){
                    System.debug('3');
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(LabelField)+', '+String.escapeSingleQuotes(BarcodeField)+' '+String.escapeSingleQuotes(mySelFields)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) 
                        Records = Database.query('Select Id, '+String.escapeSingleQuotes(BarcodeField)+ ' '+String.escapeSingleQuotes(mySelFields)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');
                }else{
                    System.debug('4');
                    if(LabelField != BarcodeField && LabelField != Null && LabelField != '')
                    Records = Database.query('Select Id, Name, '+String.escapeSingleQuotes(LabelField)+' '+String.escapeSingleQuotes(BarcodeField)+ ', '+String.escapeSingleQuotes(mySelFields)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(LabelField)+' != null and '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');
                    else if(LabelField == Null || LabelField == '' || LabelField == BarcodeField) {
                        System.debug('5');
                        List<String> selectedFields = new List<String>();
                        for (String field : mySelFields.split(',')) {
                            selectedFields.add(field.trim());
                        }
                        
                        // Debug the trimmed fields
                        System.debug('Trimmed Fields: ' + selectedFields);
                        
                        // Use a set to remove duplicates
                        Set<String> uniqueFields = new Set<String>(selectedFields);
                        
                        // Debug the unique fields
                        System.debug('Unique Fields Before Removal: ' + uniqueFields);
                        
                        // Remove 'Name' and BarcodeField if they exist
                        uniqueFields.remove('Name');
                        uniqueFields.remove(BarcodeField);
                        
                        // Convert back to a list and join fields for the query
                        String filteredSelFields = String.join(new List<String>(uniqueFields), ',');
                        
                        // Debug the filtered fields
                        System.debug('Filtered Fields (filteredSelFields): ' + filteredSelFields);
                        if(filteredSelFields != '' && filteredSelFields != null){
                             System.debug('In here for not null');
                            if (filteredSelFields.toLowerCase().contains('name')) {
                                System.debug('Name field is present');
                                Records = Database.query('Select Id'+String.escapeSingleQuotes(filteredSelFields)+ ','+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');//Name,
                            } else {
                                System.debug('Name field is not present');
                                Records = Database.query('Select Id, Name'+String.escapeSingleQuotes(filteredSelFields)+ ','+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');//Name,
                            }
                            
                        }else {
                            System.debug('In here for null-->');
                            Records = Database.query('Select Id, Name'+String.escapeSingleQuotes(filteredSelFields)+ ','+String.escapeSingleQuotes(BarcodeField)+' From ' +String.escapeSingleQuotes(myObject)+ ' Where '+String.escapeSingleQuotes(BarcodeField)+' != null and Name Like :recordNamePattern limit :list_size offset :counter');//Name,
                        }
                    }
                     }
                BarcodeWrapperList = new List<BarcodeWrapper>();
                
                for(SObject sObj : Records){
                    BarcodeWrapper BW;
                    if(LabelField != Null && LabelField != '') BW = new BarcodeWrapper(String.valueof(sObj.get(BarcodeField)), String.valueof(sObj.get(LabelField)), String.valueof(sObj.get('Name')) );
                    else  BW = new BarcodeWrapper(String.valueof(sObj.get(BarcodeField)), '', String.valueof(sObj.get('Name')) );
                    BW.Id = String.valueof(sObj.Id);
                    BW.sObj = sObj;
                    system.debug('*** : BW.sObj : '+BW.sObj);
                    for(SelectOption s : FieldListSelectedsOptions){
                        //BW.sObj.put(s.getValue(),sObj.get(s.getValue()));
                    }
                    system.debug('*** sObj :'+sObj);
                    BarcodeWrapperList.add(BW);
                }
            }
        
        mySelFields = '';
        FieldListSelecteds = new List<String>();
        system.debug('BarcodeWrapperList Size :'+BarcodeWrapperList.size());
        system.debug('### BarcodeWrapperList : 317'+BarcodeWrapperList);
        //myFields = new List<String>();
        }catch(Exception e){System.debug('Exception :'+e.getMessage()+' @Line Number :'+e.getLineNumber());}
        return Null;        
    }    
   
    public PageReference PrintPreview() {
        system.debug('arshad PrintPreview called');
        BarcodeWrapperCol1 = new List<BarcodeWrapper>();
        BarcodeWrapperCol2 = new List<BarcodeWrapper>();
        BarcodeWrapperCol3 = new List<BarcodeWrapper>();
        Integer i, j, k;  
        i = j = k = 0;
        Boolean exist = false;
        
        for(BarcodeWrapper PW : BarcodeWrapperList){
            if(PW.selected){
                exist = true;
                if(NoofColumns == 3){
                    if(i==j && i==k) { BarcodeWrapperCol1.add(PW); i++; }
                    else if(j==k) { BarcodeWrapperCol2.add(PW); j++;  }
                    else { BarcodeWrapperCol3.add(PW); k++; }
                }
                else if(NoofColumns == 2){
                    if(i==j) { BarcodeWrapperCol1.add(PW); i++; }
                    else { BarcodeWrapperCol2.add(PW); j++;  }
                }
                else BarcodeWrapperCol1.add(PW);
            }
        }
        if(!exist) BarcodeWrapperCol1.add(new BarcodeWrapper('', '',''));
       
        if(brcdType =='code128' || brcdType == 'code39' || brcdType =='ean8' || brcdType == 'ean13'){ 
            system.debug('arshad PrintPreview return Page.PrintBarcodesPDF');
            return Page.PrintBarcodesPDF;
        } 
        else if(brcdType =='qrcode' || brcdType == 'pdf417') {
            system.debug('arshad PrintPreview return Page.PrintBarcodes2DPDF'); 
            system.debug('BarcodeWrapperCol1: '+BarcodeWrapperCol1.size()+' ,BarcodeWrapperCol2: '+BarcodeWrapperCol2.size()+' ,BarcodeWrapperCol3: '+BarcodeWrapperCol3.size()); 
             for(BarcodeWrapper PW : BarcodeWrapperCol1){
                 system.debug('BarcodeWrapperCol1: '+PW.Barcode);
             }
            return Page.PrintBarcodes2DPDF;
        } 
        else return null;
        
    }
        
    public Void selectAll(){
        Boolean showPreview=false;
         for(BarcodeWrapper PW : BarcodeWrapperList){
           
            if(selectAll) PW.selected = true; else PW.selected = false;
            if(PW.selected)showPreview=true;
        }
          if(pageTarget=='showPreview' && showPreview==false){pageTarget='';}
        else{
            pageTarget='showPreview';
        }
    }
    
    public Void deselect(){          
          selectAll = false;
        Boolean showPreview=false;
        for(BarcodeWrapper PW : BarcodeWrapperList){
            if(PW.selected)showPreview=true;
        }
        if(showPreview){pageTarget='showPreview';}
        else{
            pageTarget='';
        }
         /* if(list_size == selectAllCount)
            selectAll = true;
           else selectAll = false;*/
          
    }   
    
    public Void Top(){
        List<SelectOption> mysel = new List<SelectOption>();
        for(Integer ik=0; ik<FieldListSelecteds.size(); ik++) {
            Integer i = 0;
            while(i<FieldListSelectedsOptions.size()) {
               if(FieldListSelectedsOptions[i].getValue() == FieldListSelecteds[ik]){
                   mysel.add(FieldListSelectedsOptions.remove(i));
                   break;
               }
               i++;
            }
        }
        for(Integer ik=0; ik<FieldListSelectedsOptions.size(); ik++) {
            mysel.add(FieldListSelectedsOptions[ik]);
        }
        FieldListSelectedsOptions = mysel;
    }
    public Void Bottom(){
        List<SelectOption> mysel = new List<SelectOption>();
        for(Integer ik=0; ik<FieldListSelecteds.size(); ik++) {
            Integer i = 0;
            while(i<FieldListSelectedsOptions.size()) {
               if(FieldListSelectedsOptions[i].getValue() == FieldListSelecteds[ik]){
                   mysel.add(FieldListSelectedsOptions.remove(i));
                   break;
               }
               i++;
            }
        }
        for(Integer ik=0; ik<mysel.size(); ik++) {
            FieldListSelectedsOptions.add(mysel[ik]);
        }
    }
    
    public Void Up(){
        for(Integer ik=0; ik<FieldListSelecteds.size(); ik++) {
            Integer i = 1;
            while(i<FieldListSelectedsOptions.size()) {
               if(FieldListSelectedsOptions[i].getValue() == FieldListSelecteds[ik]){
                   SelectOption temp = FieldListSelectedsOptions[i-1];
                   FieldListSelectedsOptions[i-1] = FieldListSelectedsOptions[i];
                   FieldListSelectedsOptions[i] = temp;
                   break;
               }
               i++;
            }
        }
    }
    
    public Void Down(){
        for(Integer ik=FieldListSelecteds.size()-1; ik>=0; ik--) {
            Integer i = FieldListSelectedsOptions.size()-2;
            while(i>=0) {
               if(FieldListSelectedsOptions[i].getValue() == FieldListSelecteds[ik]){
                   SelectOption temp = FieldListSelectedsOptions[i+1];
                   FieldListSelectedsOptions[i+1] = FieldListSelectedsOptions[i];
                   FieldListSelectedsOptions[i] = temp;
                   break;
               }
               i--;
            }
        }
    }
    
    public Void BarcodeLocSwitch(){
       BarcodeLoc = (LabelLoc == 'Top')? 'Bottom' : 'Top';
    }
    
    public Void LabelLocSwitch(){
       LabelLoc = (BarcodeLoc == 'Top')? 'Bottom' : 'Top';
    }
    
    public PageReference customCon() { return null; }
    
    public PageReference customConEval() { return null; }
   
   /* ------------------------------------ Custom Pagination Start --------------------------------------*/
   
   public integer counter=0;  
   public integer list_size { get; set; } 
   public integer total_size; 

   public PageReference Beginning() { 
      Evaluate();
      counter = 0;
      return null;
   }

   public PageReference Previous() { 
      
      counter = (counter - list_size > 0)? counter - list_size : 0;
      Evaluate();
      return null;
   }

   public PageReference Next() { 
      counter += list_size;
      Evaluate();
      return null;
   }

   public PageReference End() { 
      counter = total_size - math.mod(total_size, list_size);
      Evaluate();
      return null;
   }

   public Boolean getDisablePrevious() { 
      if (counter>0) return false; else return true;
   }

   public Boolean getDisableNext() { 
      if (counter + list_size < total_size) return false; else return true;
   }

   public Integer getTotal_size() {
      return total_size;
   }
   
   public Integer getlistsize() {
      return list_size;
   }

   public Integer getPageNumber() {
      return counter/list_size + 1;
   }
   
   public Integer getcounter() {
      return counter;
   }

   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }
   
   /* ------------------------------------ Custom Pagination End --------------------------------------*/
   
    public class BarcodeWrapper {
        public String Name                    { get; set; }
        public String Barcode                 { get; set; }
        public String Label                   { get; set; }
        public Boolean selected               { get; set; }
        public Product2 products              { get; set; }
        //public Product_Service__c product     { get; set; }
        public String Id                      { get; set; }
        public sObject sObj                   { get; set; }
        
        public BarcodeWrapper(String bar, String lab) { }
        public BarcodeWrapper(String bar, String lab, String nam) { 
            Name = nam;
            Barcode = bar;
            Label = lab;
            selected = false;
           // product = new Product_Service__c();
            products = new Product2();
            Id = ''; 
        }
    }
}