//
// gettournament.js   - to test tournament retrieval
//

$(document).ready(function() {
	
	var args = getArgs();
	var url = "https://hamptontennis.org.uk/juniors/fetchJSON.asp?id=9";
	var tourid;

	if (args.id)
		tourid = args.id;
	else
		tourid = -1;

	url += "&p1="+tourid

	console.log(url);

	// Now inititate JSON retrieval of tournament
	$.getJSON(url,function(data){

		var jsonstring = JSON.stringify(data);

		jsonstring = new String("{tournament:"+jsonstring+"}");

		// var eventdata = $.parseJSON(jsonstring);
		var tournamentdata = eval("(" + jsonstring + ")");

		// Set the boolean if we have data
		// if (eventdata.length > 1)
		//	eventsfound = true;

		$("#receivedjson").html('JSON received back from fetchJSON.asp?id=9 is <br /><br />'+jsonstring+'<br /><hr />');

	});

});    //    /document.ready    //
