$(document).ready(function(){
	window.a = '';
	window.b = '';
	window.c = '';
			
		$('.device1but').click(function(){
 			if($('.device1img').attr('src')=='images/bulbon.png')
			{
				$('.device1img').attr('src','images/bulboff.png');
				$(".device1but").val("OFF");
				$(".device1but").text("ON");
				//a ='a0';
				
			}
		else if($('.device1img').attr('src')=='images/bulboff.png')
			{
			 	$('.device1img').attr('src','images/bulbon.png');
			 	$(".device1but").text("OFF");
			 	$(".device1but").val("ON");
			 	//a = 'a1';
				
			}
	});


$('.reset').click(function(){
		$(".device1but").val("a0");
		$('.device1img').attr('src','images/bulboff.png');
		$(".device1but").text("ON"); 			
	});


$(document).click(function() {

		var r1light1 = $(".device1but").val();
		$('.data2').text(r1light1);
  	 	$.get('php/room1.php', { light1:r1light1}, function(data){

		});
});

    });

