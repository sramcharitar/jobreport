

$(document).ready(function() {
					   
/*******************************************************/
/* Hide element via JS
/*******************************************************/
		   
	$(".rbc-jshide").hide();
	
/*******************************************************/
/* Click for more...
/*******************************************************/			
		
	$(".rbc-clickformore-trigger").click(function(){
		var triggerelement = $(this);
		var targetelement = $(this).metadata().targetelement;
		$(targetelement).animate({
			height: 'toggle'
		  }, 500, function() {
			$(triggerelement).parent(".rbc-clickformore-trigger-container").hide();
		  });
		return false;    
	});	
	


});
