/*
 * jQuery validate.password plug-in 1.0
 *
 * http://bassistance.de/jquery-plugins/jquery-plugin-validate.password/
 *
 * Copyright (c) 2009 Jörn Zaefferer
 *
 * $Id$
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
(function($) {
	
	var LOWER = /[a-z]/,
		UPPER = /[A-Z]/,
		DIGIT = /[0-9]/,
		DIGITS = /[0-9].*[0-9]/,
		SPECIAL = /[^a-zA-Z0-9]/,
		SAME = /^(.)\1+$/;
		
	function rating(rate, message) {
		return {
			rate: rate,
			messageKey: message
		};
	}
	
	function uncapitalize(str) {
		return str.substring(0, 1).toLowerCase() + str.substring(1);
	}
	
	$.validator.passwordRating = function(password, username) {
		if (!password || password.length < 8)
			return rating(0, "too-short");
		if (username && password.toLowerCase().match(username.toLowerCase()))
			return rating(0, "similar-to-username");
		if (SAME.test(password))
			return rating(1, "very-weak");
		
		var lower = LOWER.test(password),
			upper = UPPER.test(uncapitalize(password)),
			digit = DIGIT.test(password),
			digits = DIGITS.test(password),
			special = SPECIAL.test(password);
		
		if (lower && upper && digit || lower && digits || upper && digits || special)
			return rating(4, "strong");
		if (lower && upper || lower && digit || upper && digit)
			return rating(3, "good");
		return rating(2, "weak");
	};
	
	$.validator.passwordRating.messages = {
		"similar-to-username": "Too similar to username",
		"too-short": "Too short",
		"very-weak": "Very weak",
		"weak": "Weak",
		"good": "Good",
		"strong": "Strong"
	};
	
	$.validator.addMethod("password", function(value, element, usernameField) {
		// use untrimmed value
		var password = element.value,
		// get username for comparison, if specified
			username = $(typeof usernameField != "boolean" ? usernameField : []);
			
		var rating = $.validator.passwordRating(password, username.val());
		// update message for this field
		
		var meter = $(".password-meter", element.form);
		
		meter.find(".password-meter-bar").removeClass().addClass("password-meter-bar").addClass("password-meter-" + rating.messageKey);
		meter.find(".password-meter-message")
		.removeClass()
		.addClass("password-meter-message")
		.addClass("password-meter-message-" + rating.messageKey)
		.text($.validator.passwordRating.messages[rating.messageKey]);
		// display process bar instead of error message
		
		return rating.rate > 2;
	}, "&nbsp;");
	// manually add class rule, to make username param optional
	$.validator.classRuleSettings.password = { password: true };
	
})(jQuery);

$(document).ready(function () {
    // validate signup form on keyup and submit
    $("#change_account_password_form").validate({
        errorClass: 'jqueryError',
        rules: {
            "change_password[password]": {
                required: true,
                minlength: 8,
                password: false
            },
            "change_password[new_password]": {
                required: true,
                minlength: 8,
                password: true
            },
            "change_password[password_confirm]": {
                required: true,
                equalTo: "#new_password",
                password: false
            }
        },
        messages: {
            "change_password[password]": {
                required: "Enter your current password",
                minlength: "Enter at least {0} characters"
            },
            "change_password[new_password]": {
                required: "Enter your new password",
                minlength: "Enter at least {0} characters"
            },
            "change_password[password_confirm]": {
                required: "Repeat your password",
                equalTo: "Enter the same password as above"
            }
        },
        // the errorPlacement has to take the table layout into account
        errorPlacement: function (error, element) {
            error.prependTo(element.parent().next());
        },
        // specifying a submitHandler prevents the default submit, good for the demo
        submitHandler: function (form) {
            alert("submitted!");
            return false;
        },
        // set this class to error-labels to indicate valid fields
        success: function (label) {
            // set &nbsp; as text for IE
            label.html("&nbsp;").addClass("jqueryChecked");
        }
    });
});
