$(document).ready(function() {
	
	var jsonstring = new String("");
	var url = "https://hamptontennis.org.uk/juniors/fetchJSON.asp?id=2&localid="+theid;
	$.getJSON(url,function(data){

		var jsonstring = JSON.stringify(data);

		jsonstring = new String("{allEvents:"+jsonstring+"}");

		// var eventdata = $.parseJSON(jsonstring);
		var eventdata = eval("(" + jsonstring + ")");
		//Get the HTML from the template   in the script tag
	    var theTemplateScript = $("#eventlist-template").html(); 

	   //Compile the template
	    var theTemplate = Handlebars.compile (theTemplateScript); 
		// Handlebars.registerPartial("description", $("#shoe-description").html());    
		$("#events").append (theTemplate(eventdata)); 
		// jsonstring = JSON.stringify(data);
		$("#receivedjson").html('JSON received back from fetchJSON.asp?id=2 is <br /><br />'+jsonstring+'<br /><hr />');
	});  // end of function(data)
})  // end of document.ready

