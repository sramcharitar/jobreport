$(document).ready(function() {

/*******************************************************/
/* Click Outside Plugin
/*******************************************************/
						   
/*
 * jQuery outside events - v1.1 - 3/16/2010
 * http://benalman.com/projects/jquery-outside-events-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
/*(function($,c,b){$.map("click dblclick mousemove mousedown mouseup mouseover mouseout change select submit keydown keypress keyup".split(" "),function(d){a(d)});a("focusin","focus"+b);a("focusout","blur"+b);$.addOutsideEvent=a;function a(g,e){e=e||g+b;var d=$(),h=g+"."+e+"-special-event";$.event.special[e]={setup:function(){d=d.add(this);if(d.length===1){$(c).bind(h,f)}},teardown:function(){d=d.not(this);if(d.length===0){$(c).unbind(h)}},add:function(i){var j=i.handler;i.handler=function(l,k){l.target=k;j.apply(this,arguments)}}};function f(i){$(d).each(function(){var j=$(this);if(this!==i.target&&!j.has(i.target).length){j.triggerHandler(e,[i.target])}})}}})(jQuery,document,"outside");*/

/*******************************************************/
/* Overlays
/*******************************************************/	

	$(".rbc-overlay-trigger").bind('click mouseover',function(event){
	
		var triggerelement = $(this);
		var triggericon = $(triggerelement).find(".rbc-triggericon");
		var triggercontainer = $(triggerelement).closest(".rbc-overlay-trigger-container");
		var triggertype = $(triggercontainer).metadata().triggertype;
		var triggeroverlay = $(triggercontainer).find(".rbc-overlay");	
		var opencloseidentifier = $(triggercontainer).find(".rbc-opencloseidentifier");
		var closebutton = $(triggercontainer).find(".rbc-overlay-close");
		var hiddenclosebutton = $(triggercontainer).find(".rbc-overlay-close-hidden");
		
	
		/* Toggle trigger icon */
		function fntoggletriggericonon() {
			if ($(triggericon).hasClass("rbc-triggericon-toggle")) {
				var src = $(triggericon).attr("src").replace("expand", "collapse");
				$(triggericon).attr("src", src);
				var alt = $(triggericon).attr("alt").replace("Expand", "Collapse");
				$(triggericon).attr("alt", alt);
			}
		}
		function fntoggletriggericonoff() {
			$(".rbc-triggericon-toggle").each(function(){
			   var src = $(this).attr("src").replace("collapse", "expand");
				$(this).attr("src", src);
				var alt = $(this).attr("alt").replace("Collapse", "Expand");
				$(this).attr("alt", alt);			
			});			
		}
		
		/* Show/Hide Overlays */
		function showoverlay() {
			$(triggercontainer).addClass("active");
			$(triggeroverlay).animate({ 
				opacity: "show"
				}, 100 );
			fntoggletriggericonon();
			$(opencloseidentifier).show();
		}
		function hideoverlay() {
			$(triggercontainer).removeClass("active");
			$(triggeroverlay).animate({ 
				opacity: "hide"
				}, 100 );
			fntoggletriggericonoff();
			$(opencloseidentifier).hide();
		}
		
		function hidealloverlays() {
			$(".rbc-overlay").hide();
			$(".rbc-opencloseidentifier").hide();
			$(".rbc-overlay-trigger-container").removeClass("active");
			fntoggletriggericonoff();
		}
		
		
		/* Click on click trigger */
		if ((triggertype == 'click') && (event.type == 'click')) {
			if ($(opencloseidentifier).is(":hidden")) {
				hidealloverlays();
				showoverlay();
			} else {
				hideoverlay();
			}
			return false;
		}
		
		/* Click on mouseover trigger */
		if ((triggertype == 'mouseover') && (event.type == 'click')) {
			if ($(opencloseidentifier).is(":hidden")) {
				hidealloverlays();
				showoverlay();
			} else {
				hideoverlay();
			}
			return false;
		}
		
		
		/* Mouseover on mouseover trigger */
		if ((triggertype == 'mouseover') && (event.type == 'mouseover')) {
			if ($(opencloseidentifier).is(":hidden")) {
				hidealloverlays();
				showoverlay();
			}
		}
		
		
		/* Click on or blur close buttons */
		$(".rbc-overlay-close, .rbc-overlay-close-hidden").bind('click',function(event){
			hidealloverlays();
			return false;
		});
		$(".rbc-overlay-close-hidden").bind('blur',function(event){
			hidealloverlays();
		});
		
		/* Clicking outside overlay, close overlay */
		$(triggercontainer).bind('clickoutside',function(event){
			hideoverlay();
		})
		
		/* Mousing outside mouseover overlay, close overlay */
		$(triggercontainer).bind('mouseleave',function(event){
			if ((triggertype == 'mouseover')) {
				hidealloverlays();
			}
		});
		
											 
	});
	})