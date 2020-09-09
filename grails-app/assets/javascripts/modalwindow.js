/********************************************************************/
/* Modal Window - INTERAD - 2015 MAR 08 - NO TABINDEX MODIFICATIONS */
/********************************************************************/

// starter functions, getting the page ready to adjust size, and making the enter key work from the start.
$(document).ready(function() {
    //this is making the modal the right size from the start
    var maxHeight = $(window).height()*.80;
	$('.rbc-modalwindow-content').css('max-height', maxHeight);
    
    //this is making the modal size adjust when the browser window changes
    $(window).resize(function() {
    	var maxHeight = $(window).height()*.80;
		$('.rbc-modalwindow-content').css('max-height', maxHeight);
	});
	
	// assuring that enter key opens the modal
	$('.rbc-modalwindow-trigger').keydown(function(e){
		// selecting the correct event type based on browser type
		var keycode = (event.keyCode ? event.keyCode : event.which);
    	if(keycode == 13){
    		// this is checking to make sure two triggers aren't being fired at the same time
    		if(!$('.rbc-modalwindow-trigger').click(function(){return true;})){
       			$(this).trigger("click");
       		}
    	}
	});
});

// This is a list of tab-able elements, this is used later to add tabindexes where they are appropriate
var focusableElementsString = "a[href], area[href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), iframe, object, embed, *[tabindex], *[contenteditable]";	

// Function to listen for tab key presses
function trapTabKey(obj, evt) {

    // if tab or shift-tab pressed
    if (evt.which == 9) {

        // get list of all children elements in given object
        var o = obj.find('*');

        // get list of focusable items
        // Added the not to the end, this removes the negative -1 indexes from tab order
        var focusableItems = o.filter(focusableElementsString).filter(':visible').not('[tabindex=-1]');

        // get currently focused item
        var focusedItem = jQuery(':focus');

        // get the number of focusable items
       	var numberOfFocusableItems = focusableItems.length

        // get the index of the currently focused item
        var focusedItemIndex = focusableItems.index(focusedItem);
		
		// shift tab
        if (evt.shiftKey) {
            //back tab
            // if focused on first item (0) and user preses back-tab, go to the last focusable item
            // this was 1 before, but now that all the tabindex = -1 are removed its no longer an issue
            // user clicks on the background the focus equals -1, force back to last tabbable item
            if (focusedItemIndex == 0 || focusedItemIndex == -1) {
                focusableItems.get(numberOfFocusableItems - 1).focus();
                evt.preventDefault();
            } 
            
        } else {
            //forward tab
            // if focused on the last item and user preses tab, go to the first focusable item
			if (focusedItemIndex == numberOfFocusableItems - 1) {
				// first item can no longer be a tabindex=-1 item there is no problem with going to the first item
				focusableItems.get(0).focus();
				evt.preventDefault();
			} 
        }
    }
}	

// adding listeners to the hidden button, when focused it becomes visible 
$('.hiddenCloseButton').live('focus', function(event) {
	$('.hiddenCloseButton').fadeTo(0, 1);
});
// when the button loses focus it becomes hidden, this is to assure it is only seen when hovered
$('.hiddenCloseButton').live('blur', function(event) {
	$('.hiddenCloseButton').fadeTo(0, 0);
});

// this is a listener for the modal window trigger, the open modal window button or link
$('.rbc-modalwindow-trigger').live('click', function(event) {
	
	// this should force hide the hidden close button if it was clicked and was stuck
	$('.hiddenCloseButton').fadeTo(0, 0);
	
	// setting variables of the various elements needed throughout the modals activities
	var triggerelement = $(this);
	var targetelement = $(triggerelement).metadata().targetelement;
	var closebutton = $(targetelement+' .rbc-modalwindow-close');
	var closebuttonhidden = $(targetelement+' .rbc-modalwindow-close-hidden');
	var modalWindow = $(targetelement);
	
	// listener for tab events, tabbing and shift tabbing through the modal
	$(targetelement).keydown(function(event) {
	 	trapTabKey($(this), event);
	});
	
	// Show modal functionality		
	function showModalWindow() {
		$(targetelement).fadeIn(200);
	
		// this is creating the grey zone that covers the screen behind the modal window
		$('body').prepend('<div class="rbc-modalwindow-mask">&nbsp;</div>');
		$(".rbc-modalwindow-mask").stop().animate({
			opacity: .5
			}, 100, function() {
		});
		
		// making the modal aria hidden false - to be shown.
		$(targetelement).attr('aria-hidden', 'false');
		
		// making the rest of the page hidden - so its not read	
		if($('.aria-wrapper'))			
			$('.aria-wrapper').attr('aria-hidden', 'true');
		
		// this is a timer to slow the focus being set to the start of the modal, this is done so that the browsers
		// has time to load up the page before focus is set to an element to read.
    	setTimeout(function(){
    		$(targetelement+" #start-dialog-window").focus();
    	},600);
	 }
	 
	 function hideModalWindow() {
		// this is removing the grey behind the modal
		$(".rbc-modalwindow-mask").stop().animate({
			opacity: 0
			}, 100, function() {
			$(".rbc-modalwindow-mask").remove();
		});
		
		// making the modal aria hidden
		$(targetelement).attr('aria-hidden', 'true');
		
		// making the rest of the page aria non-hidden
		if($('.aria-wrapper'))			
			$('.aria-wrapper').attr('aria-hidden', 'false');
		
		// fading out the modal and giving focus back to the trigger (modal open button).
		$(targetelement).fadeOut(200);
		$(triggerelement).focus();			
	}
	
	// If modal is showing hide it.
	if ($(targetelement).css('display') == 'block') {
		hideModalWindow();
		return false;
	}
	
	// if modal his hidden show it.
	if ($(targetelement).css('display') == 'none') {
		showModalWindow();
	}
	
	// this is a selector to enable or disable clicking on the grey to close the modal window.
	if(triggerelement.hasClass("greyClose")) {	
		// adding the ability to close the modal when the grey is clicked	
		$('body').click(function(event) {
			if ((!$(event.target).closest('.rbc-modalwindow-inner2').length) && ($(targetelement).css('display') == 'block')) {
				hideModalWindow();
			};
		});
	}
	
	// if frenchModal class is in the trigger it will replace the start dialog and end dialog text with french text
	if(triggerelement.hasClass("frenchModal")) {
		$('#start-dialog-window').html("D&eacute;but du contenu de la fen&ecirc;tre contextuelle - Vous pouvez fermer cette fen&ecirc;tre au moyen de la touche &Eacute;chap ou des liens Fermer qui sont affich&eacute;s, afin de retourner &agrave; la fen&ecirc;tre principale.");
		$('#end-dialog-window').html("Fin du contenu de la fen&ecirc;tre contextuelle - Vous pouvez fermer cette fen&ecirc;tre au moyen de la touche &Eacute;chap ou des liens Fermer qui sont affich&eacute;s, afin de retourner &agrave; la fen&ecirc;tre principale.");
	}
	
	// click close button, hide modal
	$(closebutton).click(function(){
		hideModalWindow();
		return false;
	});
	
	// close the modal when clicking the hidden close button (shows when tabbed)
	$(".hiddenCloseButton").click(function(){
		hideModalWindow();	
		return false;
	});
	
	// this makes the escape key close the modal window when its open
	$(modalWindow).keydown(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		// escape key pressed
		if (keycode == 27) {
			hideModalWindow();	
			return false;
		}
	});
	
	return false;
	
});