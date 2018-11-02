var $ = function(id) {
    return document.getElementById(id);
};

/* Use this to replace our entries' warnings! */
function replace(id, quote) {
    $(id).nextElementSibling.firstChild.nodeValue = quote;
}

function verify() {
	var fName = $("fName").value;
	var lName = $("lName").value;
	var email = $("email").value;
	var phone = $("phone").value;
	var reason = $("contact-reason").value;
	var isValid = true;
	
	/* Validate the entries */
	if (fName == "") {
    	replace("fName", "First name required");
        $("fName").focus();
        isValid = false;
    } else {
        replace("fName", "*");
    }
        
    if (lName == "") {
        replace("lName", "Last name required");
    	$("lName").focus();
        isValid = false;
    } else {
        replace("lName", "*");
    }
    
    /* Verify our email has an entry */
    if (email == "") {
        replace("email", "Email address entry required");
    	$("email").focus();
        isValid = false;
    } else {
        /* Our two email verifications */
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
        } else { /* If it's missing an @ or a . after the @*/
            replace("email", "Ensure your email contains an '@' and a '.' after the '@'");
            isValid = false;
        }
    }
    
    if (phone == "") {
        replace("phone", "Phone number required");
    	$("phone").focus();
        isValid = false;
    } else {
        replace("phone", "*");
    }
    
    if (reason == "default"){
        replace("contact-reason", "Select a reason!");
		$("contact-reason").focus();
        isValid = false;
	} else {
        replace("contact-reason", "*");
    }
	
    /* Ensure everything is good to go */
	if (isValid) {
		alert("We have received the information below:\n"
		+ "First name: " + fName + "\n"
		+ "Last name: " + lName + "\n"
		+ "Email: " + email + "\n"
		+ "Phone: " + phone + "\n"
		+ "Reason: " + reason + "\n"
		+ "Your comments have also been saved.");
		$("contact").submit();
	}
}