$(document).ready(function () {

	$('#accordion').accordion({		
		heightStyle: "content",
		collapsible: true,
		header: "h3",
		event: false,
		/*active: false*/
	});
					 	
	$('#accordion :button.next').each(function (index, e) {
		//Move to the next Panel
		function skip(skip) {
			var edit = $(".edit");
			var h3 = $("#accordion h3");
			var headnum = $(".number");    
			
			$('#accordion').accordion('activate', index + skip);	
			for (var i=0;i<edit.length;i++)
			{
				edit[index].style.display="block";
				edit[index + skip].style.display="none";
				$(edit[index + skip]).addClass('activated');
				$(h3[index + skip]).addClass('current');
				$(h3[index]).removeClass('current');
				$(h3[index]).addClass('activated');
				$(h3[index + skip]).addClass('activated');
				$(headnum[index]).append('<span class="checked"></span>');
				$(headnum[index + skip]).append('<span class="checked"></span>');
			}
		}
		//Onclick next panel		
		$(e).click(function() {	 	
			skip(1);																
		});				 	
	});	
	

//Activates first panel if query string activate is equals 1
var activate = GetQueryStringParams('activate');
	
if (activate == 1) {
	$('#accordion').accordion('activate', 0);	
	$( "#get-started" ).hide();
	$( "#start-over" ).show();
}
	
}); 

function edit(panel) {
	var panelplus = panel +1;
	var edit = $(".edit");
	var activated = $(".activated");
	var h3 = $("#accordion h3");
	
	if ($(h3[panel]).hasClass('activated')) {
		$( "#accordion" ).accordion({ active: panel });	
		$(activated).show();
		$(edit[panel]).hide();
		$(h3).removeClass('current');
		$(h3[panel]).addClass('current');	
	}
} 

function getStarted() {
	var h3 = $("#accordion h3");
		
	$(h3[0]).addClass('current');	
	$( "#accordion" ).accordion({ active: 0 });
	$( "#get-started" ).hide();
	$( "#cancel" ).hide();
	$( "#start-over" ).show();
	$( "#close" ).show();
}

function startOver() {

	var edit = $(".edit");
	var activated = $(".activated");
	var h3 = $("#accordion h3");
	var h3image = $("#accordion h3 span.number span.checked");
 	
 	$(edit['0']).hide();
	$(edit['1']).hide();
	$(edit['2']).hide();
	$(edit['3']).hide();
		
	$(h3).removeClass('current');
	$(h3).removeClass('activated');
	$(h3image).remove();
	
	$( "#accordion" ).accordion({ active: 0});
	$(h3[0]).addClass('current');	
	
	$( "#print" ).hide();
	$( "#close" ).hide();
}

function register() {
	var edit = $(".edit");
	var h3 = $("#accordion h3");
	$(edit['0']).hide();
	$(edit['1']).hide();
	$(edit['2']).hide();
	$(edit['3']).hide();
	$(h3[2]).removeClass('current').addClass('activated');	
	$( "#accordion" ).accordion({ active: 3});
	$(h3[3]).addClass('current');	
	$( "#print" ).show();
	$( "#close" ).show();
	$( "#start-over" ).hide();
}

function GetQueryStringParams(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) 
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) 
        {
            return sParameterName[1];
        }
    }
}