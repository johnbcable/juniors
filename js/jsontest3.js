
$(document).ready(function() {
	
	var jsonstring = new String("");
	var url = "http://hamptontennis.org.uk/juniors/JSONTest3.asp";
	$.getJSON(url,function(data){

		jsonstring = JSON.stringify(data);
		$("#receivedjson").html('JSON received back from JSONTest3.asp is <br /><br />'+jsonstring+'<br /><hr />');
	});
})
