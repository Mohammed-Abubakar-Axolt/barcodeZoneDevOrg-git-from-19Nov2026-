var $j =jQuery.noConflict();
    var SelectedRegArray = [];
    var barcode="";
    $j(document).ready(function(){
        
        var pressed = false;
        var chars = [];        
        
        $j(window).keypress(function(e) {
            chars.push(String.fromCharCode(e.which));
            if (pressed == false) {
                setTimeout(function() {
                    
                    if (chars.length >= 4 ){
                        barcode = chars.join("");
                        console.log('barcode : = ' + barcode);
                        myBarcode(barcode);
                            
                    }
                    chars = [];
                    pressed = false;
                }, 500);
            }
            pressed = true;
        }); // end of window key press function
        
        $j(window).keypress(function(e){
            if ( e.which === 13 ) {
                e.preventDefault();
            }
        }); // end of preventing from default enter
        
        // $j('#myModal').modal("show");
        // }
    });