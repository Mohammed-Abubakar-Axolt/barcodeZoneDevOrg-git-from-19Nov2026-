@isTest(seeAllData = true)
private class PrintBarcodesTestCases {
    
    static testMethod void PrintBarcodesUnitTest2() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.myObject = 'Product2';
        obj.initLoad();  
        System.assertEquals('Product2',obj.myObject);
    }
    
    static testMethod void PrintBarcodesUnitTest3() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.showBarcode = true;
        obj.loadBarcodes(); 
        System.assert(obj.loadBarcodes()== null);
    }
    
    static testMethod void PrintBarcodesUnitTest4() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.showBarcode = false;
        obj.loadBarcodes();  
        System.assert(obj.loadBarcodes() == null);
    }
    
    static testMethod void PrintBarcodesUnitTest5() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.mySelFields = '';
        obj.myObject = 'Order';
        obj.LabelField='ProductCode';
        Product2 prod=new Product2(Name='Test',IsActive=true,ProductCode='8906006720480',Description='Refined Soya oil',Family='Oil');
        insert prod; 
        obj.recordName='Test';
        obj.Evaluate();
        obj.FieldListSelecteds.add('Description');
        obj.FieldListSelectedsOptions = new List<SelectOption>();
        obj.FieldListSelectedsOptions.add(new SelectOption('active', 'Active'));
        obj.FieldListSelectedsOptions.add(new SelectOption('Name', 'Name'));
        obj.FieldListSelectedsOptions.add(new SelectOption('code', 'Code'));
        obj.FieldListSelectedsOptions.add(new SelectOption('Description', 'Description'));
        obj.AddFields();
        String BarcdType='';
        IBarcode brcdObj = BarcodeFactoryLightning.createBarcodeObject(BarcdType);
        System.assertEquals('',obj.mySelFields);
    }
    
    static testMethod void PrintBarcodesUnitTest6() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.mySelFields = '';
        obj.errMsg='';
        obj.FieldListSelecteds.add('active');
        obj.FieldListSelecteds.add('Name');
        obj.FieldListSelecteds.add('code');
        obj.FieldListSelecteds.add('Description');
        obj.FieldListSelectedsOptions = new List<SelectOption>();
        obj.FieldListSelectedsOptions.add(new SelectOption('active', 'Active'));
        obj.FieldListSelectedsOptions.add(new SelectOption('Name', 'Name'));
        obj.FieldListSelectedsOptions.add(new SelectOption('code', 'Code'));
        obj.FieldListSelectedsOptions.add(new SelectOption('Description', 'Description'));
        obj.Down();  
        obj.Top();  
        obj.Bottom();  
        obj.Up();  
        obj.RemoveFields();  
        obj.FieldListSelected = new List<SelectOption>();
        obj.FieldListSelected.add(new SelectOption('active', 'Active'));
        obj.myFieldOptions = new List<SelectOption>();
        obj.myFieldOptions.add(new SelectOption('active', 'Active'));
        System.assertEquals('',obj.mySelFields);
    }
    
    static testMethod void PrintBarcodesUnitTest7() {
        PrintBarcodes obj = new PrintBarcodes();
        PrintBarcodes.BarcodeWrapper ob1=new PrintBarcodes.BarcodeWrapper('a','b','c');
        PrintBarcodes.BarcodeWrapper ob2=new PrintBarcodes.BarcodeWrapper('a','b');
        List<PrintBarcodes.BarcodeWrapper> ob=new List<PrintBarcodes.BarcodeWrapper>();
        for(PrintBarcodes.BarcodeWrapper br : ob){
            br=new PrintBarcodes.BarcodeWrapper('a','b','c');
            br.selected=true;
        }
         List<PrintBarcodes.BarcodeWrapper> objj=new List<PrintBarcodes.BarcodeWrapper>();
        for(PrintBarcodes.BarcodeWrapper br : objj){
            br=new PrintBarcodes.BarcodeWrapper('a','b');
            br.selected=true;
        }
        boolean exist=true;
        obj.NoofColumns = 3;
        obj.brcdType='qrcode';
        obj.PrintPreview();  
        System.assert(obj.loadBarcodes() == null);
    }
    
    static testMethod void PrintBarcodesUnitTest8() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.selectAll=true;
        obj.selectAll();  
        obj.LabelField=Null;
        obj.BarcodeField='ProductCode';
        obj.recordName='Test';
        obj.myObject='Product2';
        Product2 prod=new Product2(Name='Test',IsActive=true,ProductCode='8906006720480',Description='Refined Soya oil',Family='Oil');
        insert prod; 
        obj.Evaluate();
        obj.brcdType ='code128';
        obj.PrintPreview();
        //System.assertEquals(true,obj.selectAll);
    }
    
    static testMethod void PrintBarcodesUnitTest9() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.selectAll=false;
        obj.deselect();  
        System.assertEquals(false,obj.selectAll);
    }
    
    static testMethod void PrintBarcodesUnitTest10() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.Top(); 
        obj.Bottom(); 
        obj.Up();
        obj.Down();
        System.assert(obj.loadBarcodes() == null);
    }
    
    static testMethod void PrintBarcodesUnitTest11() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.BarcodeLocSwitch();
        obj.LabelLocSwitch();
        obj.customCon();
        obj.customConEval();
        System.assert(obj.loadBarcodes() == null);
    }
    
    static testMethod void PrintBarcodesUnitTest12() {
        PrintBarcodes obj = new PrintBarcodes();
        obj.Beginning();
        obj.Previous();
        obj.Next();
        obj.End();
        obj.getDisablePrevious();
        obj.getDisableNext();
        obj.getTotal_size();
        obj.getlistsize();
        obj.getPageNumber();
        obj.getcounter();
        obj.getTotalPages();
        System.assert(obj.loadBarcodes() == null);
    }
}