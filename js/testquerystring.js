//
//   querystring.js
//
//   Client-side processing of querystring values
//

function getArgs() {
	var args = new Object();
	var query = location.search.substring(1); 
	var pairs = query.split("&"); 
	for(var i = 0; i < pairs.length; i++) {
		var pos = pairs[i].indexOf('='); 
		if (pos == -1) continue; 
		var argname = pairs[i].substring(0,pos); 
		var value = pairs[i].substring(pos+1);
		args[argname] = unescape(value); 
	}
	return args; 
}


$(document).ready(function() {
	
	var args = getArgs();
	var targethtml = new String("");

	if (args.a) console.log("The value of a = ["+args.a+"]");
	if (args.b) console.log("The value of b = ["+args.b+"]");
	if (args.c) console.log("The value of c = ["+args.c+"]");
	// $('#myquerystring').html(targethtml);

});    //    /document.ready    //

