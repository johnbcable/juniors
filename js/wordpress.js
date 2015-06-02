/* Configuration: */

var tabs = {
	"Wordpress"	: {
		"feed"		: "http://hamptontennis.wordpress.com/rss",
		"function"	: rss
	}

}

var totalTabs = 1;
$(document).ready(function(){

	var wpheaderHTML = '';
	var wploadingHTML = '';
	wpheaderHTML += '<a href="http://hamptontennis.wordpress.com/" ><img src="./img/wordpress-logo-small.png" width="34" height="28" style="float:left;padding:3px 12px 0px 6px" alt="wordpress logo" /></a>';
	wpheaderHTML += '<div class="blogtext">'
	wploadingHTML += '<div id="loading-container"><img src="img/ajax-loader.gif" width="32" height="32" alt="tweet loader" /></div>';
	
	$('#blogposts').html(wpheaderHTML + wploadingHTML);

	/* This code is executed after the DOM has been completely loaded */
	
	showPosts('Wordpress');
	
});


function showPosts(key)
{
	var obj = tabs[key];
	if(!obj) return false;
	
	var theheaderHTML = '<a href="http://hamptontennis.wordpress.com/" ><img src="./img/wordpress-logo-small.png" alt="wordpress logo" /></a>';
	theheaderHTML += '<div class="blogtext">'

	var stage = $('#blogposts');
	
	/* Forming the query: */
	var query = "select * from feed where url='"+obj.feed+"' LIMIT 2";
	
	/* Forming the URL to YQL: */
	var url = "http://query.yahooapis.com/v1/public/yql?q="+encodeURIComponent(query)+"&format=json&callback=?";
	
	$.getJSON(url,function(data){

		stage.empty();
		stage.append(theheaderHTML);

		/* item exists in RSS and entry in ATOM feeds: */
		$.each(data.query.results.item || data.query.results.entry,function(){
			try{
				/* Trying to call the user provided function, "this" the rest of the feed data: */
				stage.append(obj['function'](this));
				
			}
			catch(e){
				/* Notifying users if there are any problems with their handler functions: */
				var f_name =obj['function'].toString().match(/function\s+(\w+)\(/i);
				if(f_name) f_name = f_name[1];
				
				stage.append('<div>There is a problem with your '+f_name+ ' function</div>');
				return false;
			}
		})    //end of $.each loop
		stage.append('</div>')
	});
	
	// $('#activeTab').text(key);
}

function twitter(item)
{
	/* Formats the tweets, by turning hashtags, mentions an URLS into proper hyperlinks: */
	return $('<div>').html(
			formatString(item.description || item.title)+
			' <a href="'+(item.link || item.origLink)+'" target="_blank">[tweet]</a>'
	);
}

function rss(item)
{
	var dateArr = item.pubDate.split(" ");
	var displayDate = new String(dateArr[0]+" "+dateArr[1]+" "+dateArr[2]+" "+dateArr[3]).toString();
	return $('<div class="blogitem">').html(
			'<p class="blogpostdate">'+displayDate+'</p>'+
			'<h6 class="blogitemtitle">'+formatString(item.title.content || item.title)+'</h6><p class="blogitemtext">'+item.description+'</p>'+
			' <a href="'+(item.origLink || item.link[0].href || item.link)+'" target="_blank">[read]</a><hr />'
	);
}
function buzz(item)
{
	return $('<div>').html(
			formatString(item.content[0].content || item.title.content || item.title)+
			' <a href="'+(item.origLink || item.link[0].href || item.link)+'" target="_blank">[read]</a>'
	);
}

function formatString(str)
{
	/* This function was taken from our Twitter Ticker tutorial - http://tutorialzine.com/2009/10/jquery-twitter-ticker/ */
	str = str.replace(/<[^>]+>/ig,'');
	str=' '+str;
	str = str.replace(/((ftp|https?):\/\/([-\w\.]+)+(:\d+)?(\/([\w/_\.]*(\?\S+)?)?)?)/gm,'<a href="$1" target="_blank">$1</a>');
	str = str.replace(/([^\w])\@([\w\-]+)/gm,'$1@<a href="http://twitter.com/$2" target="_blank">$2</a>');
	str = str.replace(/([^\w])\#([\w\-]+)/gm,'$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>');
	return str;
}