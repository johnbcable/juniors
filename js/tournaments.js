
function getFutureTournaments() {

	// Displays all upcoming tournaments

	var jsonstring = new String("");
	var url = "https://hamptontennis.org.uk/juniors/fetchJSON.asp?id=8";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		var jsonstring = JSON.stringify(data);

		jsonstring = new String("{futureTournaments:"+jsonstring+"}");

		// var eventdata = $.parseJSON(jsonstring);
		var tourdata = eval("(" + jsonstring + ")");

		// Set the boolean if we have data
		// if (eventdata.length > 1)
		//	eventsfound = true;

		//Get the HTML from the template   in the script tag
	    var theTemplateScript = $("#futuretourlist-template").html(); 

	   //Compile the template
	    var theTemplate = Handlebars.compile (theTemplateScript); 
		// Handlebars.registerPartial("description", $("#shoe-description").html());    
		$("#futuretournaments").append (theTemplate(tourdata)); 
		// jsonstring = JSON.stringify(data);
		// $("#receivedjson").html('JSON received back from fetchJSON.asp?id=2 is <br /><br />'+jsonstring+'<br /><hr />');
	});  // end of function(data)

}

function getPastTournaments() {

	// Displays past tournaments from this year

	var jsonstring = new String("");
	var url = "https://hamptontennis.org.uk/juniors/fetchJSON.asp?id=10";
	// var eventsfound = false;
	$.getJSON(url,function(data){

		var jsonstring = JSON.stringify(data);

		jsonstring = new String("{pastTournaments:"+jsonstring+"}");

		// var eventdata = $.parseJSON(jsonstring);
		var tourdata = eval("(" + jsonstring + ")");

		// Set the boolean if we have data
		// if (eventdata.length > 1)
		//	eventsfound = true;

		//Get the HTML from the template   in the script tag
	    var theTemplateScript = $("#pasttourlist-template").html(); 

	   //Compile the template
	    var theTemplate = Handlebars.compile (theTemplateScript); 
		// Handlebars.registerPartial("description", $("#shoe-description").html());    
		$("#pasttournaments").append (theTemplate(tourdata)); 

	    //  Now up collapsible management
	    $('.collapsible').collapsible({
	    });

		// jsonstring = JSON.stringify(data);
		// $("#receivedjson").html('JSON received back from fetchJSON.asp?id=2 is <br /><br />'+jsonstring+'<br /><hr />');
	});  // end of function(data)

}
// Now the document.ready bit
$(document).ready(function() {

		getPastTournaments();

	    // Deal with Open/Close All links
	    // First - assign collapsible routines to functions
	    function openAll() {
	    	$('.collapsible').collapsible('openAll');
	    }
	    function closeAll() {
	    	$('.collapsible').collapsible('closeAll');
	    }
	    // Now, listen for user clicking Open/Close All
	    $('#closeAll').click(function() {
	    	event.preventDefault();
	    	closeAll();
	    });
	    $('#openAll').click(function() {
	    	event.preventDefault();
	    	openAll();
	    });
	    $('#closeAll2').click(function() {
	        event.preventDefault();
	        closeAll();
	    });
	    $('#openAll2').click(function() {
	        event.preventDefault();
	        openAll();
	    });

	    getFutureTournaments();

})  // end of document.ready

