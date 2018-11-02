/* Call this function with an onClick trigger */
function TestScoresCalc() {
			/* Get all of our scores from the textboxes */
			var score1 = parseFloat(document.getElementById("score1").value);
			var score2 = parseFloat(document.getElementById("score2").value);
			var score3 = parseFloat(document.getElementById("score3").value);
			var score4 = parseFloat(document.getElementById("score4").value);
			var score5 = parseFloat(document.getElementById("score5").value);
			
			/* Add up and average the scores */
			var total = (score1 + score2 + score3 + score4 + score5) / 5;
			
			/* Change the score to a whole number */
			total = parseInt(total);
			
			/* Output the score in the proper area */
			document.getElementById("test-calc-output").innerHTML = (total + "%");
		}