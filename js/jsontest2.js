
$(document).ready(function() {
	
	var jsonstring = new String("");
	var url = "http://hamptontennis.org.uk/JSONTest2.asp";
	$.getJSON(url,function(data){

		jsonstring = JSON.stringify(data);
		$("#receivedjson").html('JSON received back from JSONTEST.asp is <br /><br />'+jsonstring+'<br /><hr />');
	});
})
