var UOS = UOS || {};

/**
 * Toggle Modal.
 */
var toggleModal = function(e) {
	var $modal = $($(this).attr('href')).eq(0);

	$modal.toggleClass('uos-visible');
	
	setTimeout(function() { 
		$("#modal-inner-content").focus();
	}, 250);
	
	setTimeout(function() { 
		$modal.toggleClass('uos-visible');
		$("#loading-message").focus();
	}, 10000);
	

	e.preventDefault();
	
	return false;
};

$(function() {
	if($.fn.on) {
		$(document).on('click', '.uos-msg-loading-toggle', toggleModal);
	} else {
		$('.uos-msg-loading-toggle').live('click', toggleModal);
	}
});

$("#loading-modal").keydown(function(event) {
	 	trapTabKey($(this), event);
	});

var focusableElementsString = "a[href], area[href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), iframe, object, embed, *[tabindex], *[contenteditable]";

function trapTabKey(obj, evt) {

    // if tab or shift-tab pressed
    if (evt.which == 9) {

        // get list of all children elements in given object
        var o = obj.find('*');

        // get list of focusable items
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