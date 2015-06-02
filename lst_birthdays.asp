<%@language="JScript"%>
<!--#include file="functions.asp" -->
<!--#include file="strings.asp" -->
<!--#include file="emailfuncs.asp" -->
<!--#include file="memberfuncs.asp" -->
<%
// First variables that need to be set for each page
var strtime, strdate;
var clubname = new String("Hampton-In-Arden Sports Club");
var pagetitle = new String("Birthday Search Results");
// Now for any variables local to this page
var debugging=false;
var dbconnect=Application("hamptonsportsdb");
var myjoining, myleaving, joiningstr, leavingstr;
var myid, mMailing, mailline;
var mystrdob,mydob,dobstr;
var mUnique;
var myaccess, theiraccess;
var callinguser;
var editline, dataline;
var toclick;
var therealname, themembername, searchtype;
var thesearchtext, thesorttext, thetypetext;
var thememberquery, thesortorder;
var thelayout, thelayouttext;
var ConnObj, RS, StnObj;
var ConnObj2, RS2, StnObj2;
var SQL1, SQL2, SQLaudit;
var SQLStart, SQLMidlle, SQLEnd, SQLStmt;
var startdate, enddate, dateoffset, diffobj;
var seasonend, thedob, days, dummyDate;
var memberknt = 0;
var v_memberid = new String("");
var line1, line2;
var membernames = new Array();
var birthdays = new Array();
var ages = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
var birthdaylinks = ["","","","","","set_5.asp","","","set_8.asp","set_10.asp","set_11.asp","set_12.asp","","set_14.asp","","","","set_18.asp"];
var linktext = ["","","","","","5th Birthday Greeting","","","8th Birthday Greeting","10th Birthday Greeting","11th Birthday Greeting","12th Birthday Greeting","","14th Birthday Greeting","","","","18th Birthday Greeting"];
// Set up default greeting strings
strdate = datestring();
strtime = timestring();
// start of page processing
if (!signedin())
	Response.Redirect("login.asp");
if (!isCommittee())
	Response.Redirect("index.asp");
v_memberid = getUserID();
memberknt=0;
toclick=0;
myaccess=0;
theiraccess=0;
callinguser=new String("NONE");
// Set up database connection
ConnObj=Server.CreateObject("ADODB.Connection");
RS=Server.CreateObject("ADODB.Recordset");
ConnObj.Open(dbconnect);
// Now process querystring/form parameters
var bPeriod = new String(Request.QueryString("BirthdayPeriod")).toString();
if (bPeriod == "" || bPeriod == "null" || bPeriod == "undefined")
{
	bPeriod = new String(Request.Form("BirthdayPeriod")).toString();
	if (bPeriod == "" || bPeriod == "null" || bPeriod == "undefined")
	{
		bPeriod = new String("week")
	}	
}
var bAge = new String(Request.QueryString("BirthdayAge")).toString();
if (bAge == "" || bAge == "null" || bAge == "undefined")
{
	bAge = new String(Request.Form("BirthdayAge")).toString();
	if (bAge == "" || bAge == "null" || bAge == "undefined")
	{
		bAge = new String("ANY")
	}	
}
todaysdate = new Date();
dateoffset = 7;   // defaults to one week.
// Set up other date offsets for other periods
if (bPeriod == "month")
	dateoffset = 30;
if (bPeriod == "3months")
	dateoffset = 90;
if (bPeriod == "season")
{
	// Calculate no. of days to end of season (31 March)
	dummy1 = new Number(currentSeason())+1;
	seasonend = new Date(dummy1, 2, 31, 0, 0, 0);    // 31 March date with no time elements
	diffObj = daysBetween(todaysdate, seasonend);
	dateoffset = diffObj.days;
}

SQLStmt = new String("SELECT uniqueref, dob FROM allmembers ORDER BY surname, forename1").toString();
displaydate = dateasstring(Date());
// End of page start up coding
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW, NOARCHIVE">
	<title>Hampton-In-Arden Tennis Club - <%= pagetitle %></title>
	<link rel="stylesheet" media="screen" type="text/css" href="layout.css" />
	<link rel="stylesheet" media="screen" type="text/css" href="colours.css" />
	<link rel="stylesheet" media="screen" type="text/css" href="typography.css" /> 
	<link rel="stylesheet" media="print" type="text/css" href="print3col.css" /> 
	<!-- Comment out the next style sheet if runniung in production -->
<%
if (debugging)
{
%>
<link rel="stylesheet" media="screen" type="text/css" href="borders.css" />
<%
}
%>
<style>
td.maillink a {
	display: inline-block;
	background-color: #c9785a;
  	font-size: 110%;
  	font-weight: bold;
	padding: 5px 10px 6px; 
	color: #fff; 
	text-decoration: none;
	text-shadow: 0 -1px 1px rgba(0,0,0,0.25);
	position: relative;
	cursor: pointer;
	text-align: center;
}
td.maillink a:hover {
	background-color: #111; 
	color: #fff; 
}
</style>
<!--#include file="checkall.js" -->
</head>
<body>
<!--   1.  Branding   -->
<div id="branding">
	<a href="index.asp" id="homelink"><img id="clublogo" src="images/logo.gif" alt="Hampton-In-Arden Sports Club logo" /></a>
	<h1>Hampton-In-Arden Sports Club</h1>
	<h2>Tennis Section</h2>

<!--   2.  Navigation   -->
	<div id="nav_main">
		<ul id="topmenu">
			<li id="nav_ourclub"><a href="aboutus.asp">Our Club</a></li>
			<li id="nav_coaching"><a href="coaching.asp">Coaching</a></li>
			<li id="nav_playing"><a href="playing.asp">Playing</a></li>
			<li id="nav_links"><a href="juniors.asp">Juniors</a></li>
			<li id="nav_members"><a href="members.asp">Members</a></li>
		</ul>
		<p id="today">
			<%= displaydate %>&nbsp;<%= strtime %>
		</p>
	</div>
	
</div>

<div id="wrapper">

<!--   3. Content    -->
	<div id="content">
		<h1>Administration:&nbsp;<b>Birthday Search Results</h1>
<%
if (debugging)
{
Response.Write("    SQL statement = ["+SQL1+"]<br />\r\n");
Response.Write("    SQL statement = ["+SQLStmt+"]<br />\r\n");
Response.Write("    seasonend = ["+ddmmyyyy(seasonend)+"]<br />\r\n");
Response.Write("    dateoffset = ["+dateoffset+"]<br />\r\n");
Response.Write("    dummy1 = ["+dummy1+"]<br />\r\n");
}
%>
		<form name="birthdayform" id="birthdayform" action="upd_unpaid.asp" action="GET">
		<table id="birthdaylist">
			<caption><%= pagetitle %></caption>
			<thead>
				<th>
					Member Name:
				</th>
				<th>
					Next Birthday
				</th>
				<th>
					Age Next<br />Birthday
				</th>
				<th width="15%">
					&nbsp;
				</th>
				</thead>
				<tbody>
<%

	memberknt = 0;
	RS = ConnObj.Execute(SQLStmt);
	while (! RS.EOF) 
	{
		thedob = new Date(RS("dob"));
		dummyDate = nextBirthday(thedob);
		thetargetage = currentAge(ddmmyyyy(thedob)) + 1;
		daysObj = daysBetween(todaysdate, dummyDate);
		memberObj = getMember(RS("uniqueref"));
//
//if (debugging)
//{
//Response.Write("    thedob = ["+ddmmyyyy(thedob)+"]<br />\r\n");
//Response.Write("    dummyDate = ["+ddmmyyyy(dummyDate)+"]<br />\r\n");
//Response.Write("    days = ["+daysObj.days+"]<br />\r\n");
//Response.Write("    dateoffset = ["+dateoffset+"]<br />\r\n");
//}
		doinsert = false;
		if (daysObj.days > 0 && daysObj.days < dateoffset) 
		{
			// Now if there is an age requirement, check that this fits as well
			if (! (bAge == "ANY"))
			{
				numAge = new Number(bAge);
				if (numAge == thetargetage) 
				{
					doinsert = true;
				}
			} 
			else 
			{
				doinsert = true;
			}
			if (doinsert)
			{
				membernames.push(memberObj.surname+" "+memberObj.forename1);
				birthdays.push(asSortableDate(dummyDate));

				// part of the solution set to write out line
				memberknt++;   

				// Now determine compnents of the greeting column
				mlink = new String("").toString();
				mlinktext  = new String("").toString();
				classtext = new String("").toString();
				iAge = (new Number(thetargetage).valueOf())-1; // JSarrays start at zero
				mlink = new String(birthdaylinks[ages[iAge]]).toString();
				mlinktext = new String(linktext[ages[iAge]]).toString();
				if (mlink == "undefined")
					mlink = new String("").toString();
				if (mlinktext == "undefined")
					mlinktext = new String("").toString();
				if (! (mlink == "")) {
					classtext += 'class="maillink"';
				}
%>
				<tr>
					<td>
						<%= memberObj.surname %>&nbsp;<%= memberObj.forename1 %>
					</td>
					<td>
						<%= ddmmyyyy(dummyDate) %>
					</td>
					<td>
						<%= thetargetage %>
					</td>
					<td <%= classtext %>>
						<a href="<%= mlink %>?id=<%= memberObj.uniqueref %>"><%= mlinktext %></a>
					</td>
				</tr>
<%
			}    // end doinsert check
			
		}
		RS.MoveNext();
	}

%>
			</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<p class="centered" style="color:white;">
						<%= memberknt %> members match the birthday search request
						<br />
<%
if (memberknt>0)
{
%>
<%
}	  // end of memberknt test
%>
					</p>
				</td>
			</tr>

			<tr>
				<td colspan="4">
					<p class="centered">
						<a href="chk_birthdays.asp">New birthday search</a>
					</p>
				</td>

			</tr>
		</tfoot>		
	</table>
<!--	
	<div style="float: left; text-align: left; margin-right: 50px; width: 50%; display: inline-block;">
			 <input type="button" name="CheckAll" value="Check All"
			 	onClick="checkAll(document.birthdayform.paidbox)">
			 <input type="button" name="UnCheckAll" value="Uncheck All"
			 onClick="uncheckAll(document.birthdayform.paidbox)">
	</div>

	<div style="float: right; text-align: left; margin-right: 50px;">
			 <button type="submit" value="Submit">Fetch</button>
	</div>
-->
		</form>
	</div>
	
<!--     4.      Supplementary navigation    -->
	<div id="leftcolumn">
		<!--#include file="home_nav.asp" -->
		<!--#include file="memb_nav.asp" -->
	</div>

<!--    5.   Supplementary content     -->	
	<div id="rightcolumn">
		<!--#include file="searchpanel.asp" -->
		<!--#include file="addresspanel.asp" -->
		<!--#include file="bookingpanel.asp" -->
		<!--#include file="newspanel.asp" -->
		<!--#include file="emailpanel.asp" -->
	</div>
</div>

<!--     6.    Site info     -->
<!--#include file="footer.asp" -->

</body>
</html>
<%
%>


