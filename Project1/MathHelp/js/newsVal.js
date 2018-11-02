
var $ = function (id) {
    return document.getElementById(id);
};

/* Use this to replace our entries' warnings! 
 * ... and to not require so much typing. */
function replace(id, quote) {
    $(id).nextElementSibling.firstChild.nodeValue = quote;
}

function verifyEmail() {
	var email = $("email").value;
	var valEmail = $("confirm-email").value;
	var isValid = true; /* Determines whether to send the info */
    
    /* Check whether the first email is blank */
	if (email == "") {
        replace("email", "Email address entry required");
        $("email").focus();
        isValid = false;
    } else {
        /* Set up our email-type verification */
        var containsAt = false;
        var containsDot = false;
        
        /* Ensure it looks like an email address */
        for (var i = 0; i < email.length; i++) {
            /* Check for @ symbol */
            if (email[i] == '@') {
                containsAt = true;
            }
            /* Check for . after the @ symbol */
            if (containsAt && email[i] == '.') {
                containsDot = true;
            }
        } /* end for */
        
        /* If the email checks out */
        if (containsAt && containsDot) {
            replace("email", "*");
        } else { /* If it's missing an @ or a . after the @ */
            replace("email", "Ensure your email contains an '@' and a '.' after the '@'");
            isValid = false;
        }
    }/* end check for original email */
    
    /* Verify if the validation email checks out */
    if (valEmail == "") {
        replace("confirm-email", "Confirmation email address entry required");
        $("confirm-email").focus();
        isValid = false;
	} else if (email !== valEmail) { /* Check whether emails are the same*/
        replace("confirm-email", "Email addresses don't match!");
		$("email").focus();
        isValid = false;
	} else {
        replace("confirm-email", "*");
    }
    
	if (isValid) {
        $("contact").submit(); 
    }
} /* end verifyEmail */