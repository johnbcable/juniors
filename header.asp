<%@language="JScript"%>
<!--#include file="functions.asp" -->
<!--#include file="strings.asp" -->
<!--#include file="emailfuncs.asp" -->
<%
// First variables that need to be set for each page
var strtime, strdate;
var clubname = new String("Hampton-In-Arden Tennis Club");
var pagetitle = new String("<<pagetitle >>");
// Now for any variables local to this page
var debugging=false;
var ConnObj, RS, RS2, SQL1, SQL2, SQL3;
var myname, displaydate;
// Set up default greeting strings
strdate = datestring();
strtime = timestring();
myname = new String("").toString();
if (signedin())
	myname = getUserName();
var displaydate = dateasstring(Date());
var debugging=current_debug_status();
// End of page start up coding
%>
