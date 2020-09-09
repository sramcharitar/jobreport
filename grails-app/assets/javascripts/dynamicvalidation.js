var uos_dpw_passIsValid = false;
var uos_dpw_passMinLen = 8;
var uos_dpw_passMaxLen = 24;
var uos_dpw_passRules = {
	'hasCap': /[A-Z]/g,
	'hasLow': /[a-z]/g,
	'hasNum': /[0-9]/g,
	'hasSym': /[-!$%@#^&*()_+|~=`{}\[\]:";'<>?,.\/]/g
};

function uos_dpw_positionTooltip($tooltip, $target){
	var top = $target.position().top,
		left = $target.position().left;

	$tooltip.css({
		'top': parseInt(top) - 14 + 'px',
		'left': parseInt(left) + parseInt($target.width()) + 15 + 'px'
	});
}

function uos_dpw_checkMatch($el, el2ID) {
	var el2 = $('#' + el2ID),
		isMatch = false;

	if (el2.length > 0) {
		isMatch = ($el.val() == el2.val());
	}

	return isMatch;
}

function uos_dpw_checkLength(str, minLen, maxLen) {
	var len = str.length;

	return (len >= minLen && len <= maxLen);
}

function uos_dpw_validateField($el, validCriteria) {
	var errors = new Array(),
		fieldVal = $el.val(),
		isEmpty = fieldVal.length === 0;

	if (!isEmpty) {
		var matchElID;
		if (validCriteria.indexOf('isMatch') >= 0) {
			matchElID = validCriteria.replace(/^.*\bmatch-(\S+)\b.*$/, '$1');
			validCriteria = validCriteria.replace(/\bmatch-(\S+)\b/, '');
		}
		var criteria = $.trim(validCriteria).split(' ');

		for (var i in criteria) {
			switch (criteria[i]) {
				case 'isMatch':
					if (!uos_dpw_checkMatch($el, matchElID)) { errors.push('isMatch') }
					break;
				case 'hasMix':
					if (fieldVal.search(uos_dpw_passRules['hasCap']) < 0 || fieldVal.search(uos_dpw_passRules['hasLow']) < 0) { errors.push('hasMix') }
					break;
				case 'hasCap':
					if (fieldVal.search(uos_dpw_passRules['hasCap']) < 0) { errors.push('hasCap') }
					break;
				case 'hasLow':
					if (fieldVal.search(uos_dpw_passRules['hasLow']) < 0) { errors.push('hasLow') }
					break;
				case 'hasNum':
					if (fieldVal.search(uos_dpw_passRules['hasNum']) < 0) { errors.push('hasNum') }
					break;
				case 'hasSym':
					if (fieldVal.search(uos_dpw_passRules['hasSym']) < 0) { errors.push('hasSym') }
					break;
				case 'hasLen':
					if (!uos_dpw_checkLength(fieldVal, uos_dpw_passMinLen, uos_dpw_passMaxLen)) { errors.push('hasLen') };
					break;
			}
		}

		if ($el.hasClass('has-tooltip')) {
			if (errors.length > 0) {
				uos_dpw_toggleTooltipFeedback($el, errors);
			} else {
				uos_dpw_toggleTooltipFeedback($el, errors, 'correct');
			}
		}
	} else {
		uos_dpw_toggleTooltipFeedback($el, errors, 'none');
	}

	if ($el.attr('id') == 'newpassword') {
		uos_dpw_passIsValid = (errors.length == 0 && !isEmpty);
	}

	if (errors.length == 0) {
		$el.addClass('has-error');
		$el.attr('aria-invalid', 'false');
	} else {
		$el.removeClass('has-error');
		$el.attr('aria-invalid', 'true');
	}
	
	return (errors.length == 0);
}

function uos_dpw_calculateScore($el) {
	var fieldVal = $el.val(),
		score = 0;

	if (fieldVal.match(uos_dpw_passRules['hasNum'])) {
		score += (fieldVal.match(uos_dpw_passRules['hasNum']).length > 0) ? 10 : 0;
	}
	if (fieldVal.match(uos_dpw_passRules['hasCap'])) {
		score += (fieldVal.match(uos_dpw_passRules['hasCap']).length > 0) ? 10 : 0;
	}
	if (fieldVal.match(uos_dpw_passRules['hasSym'])) {
		score += (fieldVal.match(uos_dpw_passRules['hasSym']).length > 0) ? 10 : 0;
	}
	if (fieldVal.length >= uos_dpw_passMinLen) {
		var scoreLength = (fieldVal.length - uos_dpw_passMinLen < 8) ? fieldVal.length - uos_dpw_passMinLen : 8;
		score += (scoreLength / 8) * 70;
	}
	return score;
}

function uos_dpw_validateForm($formToCheck, checkMandatory) {
	var valid = true,
		thisField;

	// Validate values
	$('.validate', $formToCheck).each(function() {
		var $this = $(this);
		thisField = uos_dpw_validateField($this, $this.attr('criteria'));
		uos_dpw_toggleFieldError($this, !thisField);
		valid = valid && thisField;
	});
	if (checkMandatory) {
		$('.mandatory', $formToCheck).each(function() {
			var $this = $(this);
			thisField = uos_dpw_checkMandatoryField($this);
			var hasError = $this.hasClass('has-error');
			if (hasError) {
				uos_dpw_toggleFieldError($this, !thisField);
			}
			valid = valid && thisField;
		});
	}
	return valid;
}

function uos_dpw_checkMandatoryField($el) {
	var isEmpty = ($.trim($el.val()).length == 0);

	if ($el.attr('id') == 'newpassword' && isEmpty) {
		uos_dpw_passIsValid = false;
	}

	return !isEmpty;
}

function uos_dpw_toggleTooltipFeedback($el, errors, force) {
	var $tooltip = $('#tooltip-' + $el.attr('id'));

	if ($tooltip.length > 0) {
		if (errors.length > 0 && !force) {
			$($tooltip).find('.requirements li').each(function() {
				var $this = $(this);
				var requirement = $.trim($this.attr('class').replace(/correct|error|no-divider/g,''));
				var correct = ($.inArray(requirement, errors) < 0);
				$this.toggleClass('correct', correct);
				$this.toggleClass('error', !correct);
			});
		} else {
			if (force == 'correct') {
				$tooltip.find('.requirements li').removeClass('error').addClass('correct');
			} else if (force == 'error') {
				$tooltip.find('.requirements li').removeClass('correct').addClass('error');
			} else {
				$tooltip.find('.requirements li').removeClass('correct error');
			}
		}
	}
}

function uos_dpw_toggleFieldError($el, error) {
	var $row = $el.closest('tr');

	$row.find('ul.contentframework-required-description').toggle(error);
	$row.toggleClass("contentframework-required-cellhighlight", error);
	$el.toggleClass("contentframework-required-highlight", error);
}

function uos_dpw_toggleFormError($formToCheck, validForm) {
	$('#errors').toggle(!validForm);
	$('#error-list li').each(function() {
		var $this = $(this);
		var inputID = $this.attr('id').replace('error-','');
		$this.toggle($formToCheck.find('#' + inputID).closest('tr').hasClass('contentframework-required-cellhighlight'));
	});
	if (!validForm) {
		$('#errors h5').focus();
	}
}

function uos_dpw_updateStrengthIndicator() {
	var $this = $(this),
		score = uos_dpw_calculateScore($this),
		$tooltip = $('#tooltip-' + $this.attr('id')),
		minStrengths = {
			'weak': 0,
			'strong': 33,
			'very-strong': 66
		};

	if ($tooltip.length > 0) {
		var passwordEntered = $this.val().length > 0,
			$passwordStrengthIndicatorBar = $tooltip.find('#passwordStrengthIndicatorBar');

		$passwordStrengthIndicatorBar.toggleClass('valid-pass', passwordEntered);
		barMidWidth = parseInt(145 * (score / 100));
		$passwordStrengthIndicatorBar.find('.bar-mid').css('width', barMidWidth + 'px');

		var passwordStrengthIndicatorText = 'Invalid';
		$passwordStrengthIndicatorBar.removeClass('yellow green');

		if (uos_dpw_passIsValid) {
			if (score > minStrengths['very-strong']) {
				$passwordStrengthIndicatorBar.removeClass('yellow');
				$passwordStrengthIndicatorBar.addClass('green');
				passwordStrengthIndicatorText = 'Very Strong';
			} else if (score > minStrengths['strong']) {
				$passwordStrengthIndicatorBar.removeClass('yellow');
				$passwordStrengthIndicatorBar.addClass('green');
				passwordStrengthIndicatorText = 'Strong';
			} else {
				$passwordStrengthIndicatorBar.removeClass('green');
				$passwordStrengthIndicatorBar.addClass('yellow');
				passwordStrengthIndicatorText = 'Weak';
			}
		}

		$('#passwordStrengthIndicatorText').text(passwordStrengthIndicatorText).toggleClass('hidden', !passwordEntered);
	}
}

$(document).ready(function() {
	$('.has-tooltip').bind({
		focus: function() {
			var $this = $(this);
			var $tooltip = $('#tooltip-' + $this.attr('id'));
			uos_dpw_positionTooltip($tooltip, $this);
			$tooltip.show();
		},
		blur: function() {
			$('#tooltip-' + $(this).attr('id')).hide();
		}
	});

	$('.validate').bind('focus blur', function() {
		var $this = $(this),
			valid = uos_dpw_validateForm($this.closest('form'), $("#errors").is(':visible'));
	});

	$('.has-tooltip.validate').bind({
		keyup: function(e) {
			var $this = $(this);
			uos_dpw_validateField($this, $this.attr('criteria'));
		}
	});

	$('#newpassword').bind('focus keyup change', uos_dpw_updateStrengthIndicator);

	$('#error-list a').bind('click', function() {
		var $errorInput = $(this.getAttribute('href').replace('anchor-', ''));
		if ($errorInput) {
			$errorInput.focus();
		}
	});

	$('form').bind('submit', function() {
		var $this = $(this),
			validForm = uos_dpw_validateForm($this, true);
		uos_dpw_toggleFormError($this, validForm)
		return validForm;
	});
});