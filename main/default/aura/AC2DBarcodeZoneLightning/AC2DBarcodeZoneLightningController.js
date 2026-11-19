({
    doInit : function(component, event, helper) {
        console.log("*** inside DoInit");
    },   
    cssLoaded: function(component, event, helper){
        console.log("*** CSS loaded");
    },
    jsLoaded: function(component, event, helper){
        console.log("*** jquery and jsFile Loaded");
        var bartype=component.get("v.BrcdType");
        console.log("*** bartype :"+bartype);        
        if(bartype == 'qrcode'){
            console.log('*** In qrProcessor');            
            jQuery(function processQRCODEBarcode() {
                var height = component.get("v.BrcdHeight");
                var width = component.get("v.BrcdWidth");
                var correctLevel = 2;
                var parentId = 'brcode';
                console.log('*** parentId :'+parentId);
                var textEntered = component.get("v.Value");                
                if(height == '') height=150; 
                if(width== '') width=150;
                console.log('height : '+height+' width : '+width+' correctLevel : '+correctLevel+' parentId :'+parentId+' textEntered :'+textEntered);
                jQuery('#brcode').qrcode({
                    render: "canvas",
                    border: 20,
                    text: textEntered,
                    height: height,                                
                    width: width,
                    qrId: "BRCD"+parentId, 
                    correctLevel: correctLevel
                });
            });
        }
        else if(bartype == 'pdf417'){
            console.log('*** inside generatePDF417');
            jQuery(function processPDF417Barcode() {
                var textEntered = component.get("v.Value"); 
                console.log("*** textEntered:"+textEntered);
                try {  
                    barcode_data.PDF417.init(textEntered);
                } 
                catch(DOMException){
                    console.log("Error :"+DOMException);                    
                }
                console.log('PDF417 find');
                var barcode = barcode_data.PDF417.getBarcodeArray(),bw=2,bh=2,e="",canvas=document.createElement("canvas");
                canvas.width=bw*barcode.num_cols;
                canvas.height=bh*barcode.num_rows;
                var height= component.get("v.BrcdHeight")+'px';
                var width= component.get("v.BrcdWidth")+'px';
                canvas.style.height = height;
                canvas.style.width = width;
                if(height == '') canvas.style.height = '150px';
                if(width == '') canvas.style.width = '150px';
                //console.log('height : '+height+' width : '+width);
                canvas.setAttribute("id", "canvasIdbrcode");
                jQuery('#brcode').append(canvas);
                for(var ctx=canvas.getContext("2d"),y=0,r=0;r<barcode.num_rows;++r){
                    for(var x=0,c=0;c<barcode.num_cols;++c)
                        1==barcode.bcode[r][c]&&ctx.fillRect(x,y,bw,bh),x+=bw;y+=bh; 
                }
            });
        }
    },
})