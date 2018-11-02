var $ = function(id) {
    return document.getElementById(id);
};

/* It was hard to do this while avoiding jquery as much as possible. */
function toggleMe(item) {
	var change = "math" + item;
	/* If our thing to change is already hiding, display it
	 * attributes[1] should always be the class */
	if ($(change).attributes[1].value == "hiding"){
		$(change).attributes[1].value = "";
	}
	/* If our item is visible, hide it */
	else {
		$(change).attributes[1].value = "hiding";
	}
}