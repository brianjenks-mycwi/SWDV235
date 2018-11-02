/* Set date as a Date object, storing the current date/time. */
var date = new Date();

/* Use days with getDate function to return the current day */
var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
var months = ["January", "February", "March", "April", "May", "June", "July", "August",
		"September", "October", "November", "December"]

/* Show our date in our decided format, use the days/months arrays to get the right names */
document.write("<p>" + days[date.getDay()] + ", " + months[date.getMonth()] + " " + date.getDate()
		+ ", " + date.getFullYear() + "</p>");