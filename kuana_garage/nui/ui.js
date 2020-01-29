
$(document).ready(function(){

 window.addEventListener( 'message', function( event ) {
        var item = event.data;
        if ( item.showPlayerKey == true ) {
            $("body").css("background-image", "url('oie_transparent.png')");

            $('body').css('display','block');
        } else if ( item.showPlayerKey == false ) { // Hide the menu

            $('body').css('display','none');
            $('body').css('background-color','transparent important!');
            $("body").css("background-image","none");

        }
 } );
        
        $("#bt1").click(function(){
            $.post('http://kuana_garage/bt1', JSON.stringify({}));2

        });

        $("#bt2").click(function(){
            $.post('http://kuana_garage/bt2', JSON.stringify({}));2

        });
	
	

})
